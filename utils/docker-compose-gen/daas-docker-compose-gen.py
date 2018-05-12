#!/usr/bin/env python
# -*- coding: utf-8 -*-

from jinja2 import Environment, FileSystemLoader
import yaml

from itertools import groupby
import sys
import os
import socket
import shutil

sources_dirs = ['./', '.daas', '/usr/share/daas']
FORMAT_VERSION = '0.2'

DEFAULT_LOGDB_SERVICE_IP = 250


def check_arg_param(param):
    plist = list()
    if isinstance(param, list):
        plist = param
    else:
        plist.append(param)

    for i in range(0, len(sys.argv)):
        if sys.argv[i] in plist:
            return True

    return False


def get_arg_param(param, defval=""):
    plist = list()
    if isinstance(param, list):
        plist = param
    else:
        plist.append(param)

    for i in range(0, len(sys.argv)):
        if sys.argv[i] in plist:
            if i + 1 < len(sys.argv):
                return sys.argv[i + 1]
            else:
                break

    return defval


def make_ip(subnet, ip):
    return "%s.%s" % (subnet, ip)


def make_host_item(nodename, ip):
    h = dict()
    h['node_name'] = nodename
    h['ip'] = ip
    return h


def sorted_networks(project):
    netlist = list()
    klist = sorted(project['networks'].keys())
    networks = project['networks']
    for n in klist:

        if 'subnet' not in networks[n]:
            print "ERROR: Unknown subnet for %s" % str(n)
            exit(1)

        net = dict()
        net['name'] = n
        net['subnet'] = networks[n]['subnet']
        if 'gateway' in networks[n]:
            net['gateway'] = networks[n]['gateway']

            netlist.append(net)

    return netlist


def add_host(project, name, ip):
    hosts = list()
    num = 1
    for net in project['sorted_networks']:
        if num == 1:
            hosts.append(make_host_item("%s r1_%s" % (name, name), make_ip(net['subnet'], ip)))
        else:
            hosts.append(make_host_item("r%d_%s" % (num, name), make_ip(net['subnet'], ip)))
        num = num + 1

    return hosts


def make_hosts(project):
    hosts_list = list()

    for groupname, group in project['groups'].items():

        if 'nodes' not in group:
            continue

        for nodename, node in group['nodes'].items():
            hosts_list = hosts_list + add_host(project, nodename, node['ip'])

    # if 'logdb' in project:
    #     ip = DEFAULT_LOGDB_SERVICE_IP
    #     if 'ip' in project['logdb']:
    #         ip = project['logdb']['ip']
    #     hosts_list = hosts_list + add_host(project, 'logdb', ip)

    hosts_list.sort()
    return hosts_list


def get_list(src, name):
    if name in src and len(src[name]) > 0:
        return src[name]

    return list()


def get_apt_param(params, name):
    if not params:
        return list()

    if 'apt' not in params:
        return list()

    if name not in params['apt']:
        return list()

    if not params['apt'][name]:
        return list()

    return params['apt'][name]


def get_param(project, group, node, name):
    if node and name in node:
        return node[name]

    if group and name in group:
        return group[name]

    if project and name in project:
        return project[name]

    return None


def make_copy_params(src):
    """
    split 'copy' format '[mode]src:dest' to param['src'],param['dest'],param['chmod']
    :param src: list of string 'copy'
    :return: list of {'src':.., 'dest':..., 'chmod':..}
    """

    if not src or len(src) == 0:
        return

    res = list()
    for s in src:
        chmod = None
        if s.startswith('['):
            pos = str(s).find(']', 1)
            if pos:
                chmod = s[1:pos]
            s = s[pos + 1:]

        tmp = s.split(':')
        if len(tmp) > 1:
            p = dict()
            p['src'] = tmp[0]
            p['dest'] = tmp[1]
            if chmod:
                p['chmod'] = chmod
            res.append(p)

    return res


def make_unique_list(srclist):
    # с сохранением порядка
    return [el for el, _ in groupby(srclist)]

    # без сохранения порядка
    # return list(set(srclist))


def get_vnc_ports(node):
    ret = list()
    if 'vnc_port' in node:
        p = '%s:%s' % (node['vnc_port'], node['vnc_port'])
        ret.append(p)
    return ret


def get_vnc_environment(node):
    ret = list()
    if 'vnc_port' in node:
        p = 'VNC_PORT=%s' % node['vnc_port']
        ret.append(p)
    return ret


def create_node(project, group, node):
    c = dict(node)
    for net in project['sorted_networks']:
        c[net['name']] = make_ip(net['subnet'], node['ip'])

    imagename = get_param(project, group, node, 'image')
    if not imagename:
        imagename = 'default'

    c['Dockerfile.tpl'] = 'Dockerfile.%s.tpl' % imagename
    c['image'] = imagename
    c['image_name'] = make_image_name(project, imagename)
    c['start_command'] = get_param(project, group, node, 'start_command')
    c['apt'] = dict()
    c['apt']['sources'] = list()
    c['apt']['packages'] = list()
    c['apt']['sources_list_filename'] = None

    if 'skip_compose' in group:
        c['skip_compose'] = 'yes'

    c['devices'] = make_unique_list(get_list(project, 'devices')
                                    + get_list(group, 'devices')
                                    + get_list(node, 'devices'))

    c['volumes'] = make_unique_list(get_list(project, 'volumes')
                                    + get_list(group, 'volumes')
                                    + get_list(node, 'volumes'))

    c['ports'] = make_unique_list(get_list(project, 'ports')
                                  + get_list(group, 'ports')
                                  + get_list(node, 'ports')
                                  + get_vnc_ports(node))

    c['environment'] = make_unique_list(get_list(project, 'environment')
                                        + get_list(group, 'environment')
                                        + get_list(node, 'environment')
                                        + get_vnc_environment(node))

    c['env_file'] = make_unique_list(get_list(project, 'env_file')
                                     + get_list(group, 'env_file')
                                     + get_list(node, 'env_file'))

    copy_list = make_unique_list(get_list(project, 'copy')
                                 + get_list(group, 'copy')
                                 + get_list(node, 'copy'))

    c['before_command'] = make_unique_list(get_list(project, 'before_command')
                                           + get_list(group, 'before_command')
                                           + get_list(node, 'before_command'))

    c['copy'] = make_copy_params(copy_list)

    # global + parameters for type + local
    c['apt']['sources'] = make_unique_list(get_apt_param(project, 'sources')
                                           + get_apt_param(group, 'sources')
                                           + get_apt_param(node, 'sources'))

    if len(c['apt']['sources']) > 0:
        c['apt']['sources_list_filename'] = 'sources.list'

    c['apt']['packages'] = make_unique_list(get_apt_param(project, 'packages')
                                            + get_apt_param(group, 'packages')
                                            + get_apt_param(node, 'packages'))

    return c


def make_project_nodes(project):
    nodes = list()

    for name, group in project['groups'].items():
        group['group_name'] = name
        nodes = nodes + make_nodes(project, group)

    return nodes


def make_nodes(project, group):
    nlist = list()

    if 'nodes' in group and len(group['nodes']) > 0:
        for name, node in group['nodes'].items():
            node['node_name'] = name
            c = create_node(project, group, node)
            nlist.append(c)

    nlist.sort()
    return nlist


def make_image_name(project, imgname):
    name = "%s-%s" % (project['name'], imgname)
    if len(project['image-registry']) > 0:
        name = "%s/%s" % (project['image-registry'], name)
    if len(project['image-postfix']) > 0:
        name = "%s%s" % (name, project['image-postfix'])

    return name


def make_dockerfile(dirname, node, project):
    if not os.path.exists(dirname):
        os.mkdir(dirname)

    dockerfile = os.path.join(dirname, 'Dockerfile')
    with open(dockerfile, 'w') as wfile:
        wfile.write(env.get_template(node['Dockerfile.tpl']).render(node=node, project=project))


def make_novnc_dockerfile(dirname, node, project):
    if 'vnc_port' not in node:
        return

    if not os.path.exists(dirname):
        os.mkdir(dirname)

    dockerfile = os.path.join(dirname, 'Dockerfile.novnc')
    with open(dockerfile, 'w') as wfile:
        wfile.write(env.get_template('Dockerfile.novnc.tpl').render(node=node, project=project))


def create_apt_configs(node):
    if 'apt' not in node:
        node['apt'] = dict()

    if 'packages' not in node['apt']:
        node['apt']['packages'] = list()

    if 'sources' not in node['apt']:
        node['apt']['sources'] = list()

    node['apt']['sources_list_filename'] = None


def make_nginx_node(dirname, project):
    if not os.path.exists(dirname):
        os.mkdir(dirname)

    if 'nginx' not in project:
        return

    nginx = project['nginx']
    create_apt_configs(nginx)

    if len(nginx['apt']['sources']) > 0:
        nginx['apt']['sources_list_filename'] = 'nginx-sources.list'

    dockerfile = os.path.join(dirname, 'Dockerfile')
    with open(dockerfile, 'w') as wfile:
        wfile.write(env.get_template('Dockerfile.nginx.tpl').render(project=project))

    confile = os.path.join(dirname, '%s-nginx.conf' % project['name'])
    with open(confile, 'w') as wfile:
        wfile.write(env.get_template('nginx.conf.tpl').render(project=project))

    # gen sources list
    if nginx['apt']['sources_list_filename']:
        apt_sourcefile = os.path.join(dirname, nginx['apt']['sources_list_filename'])
        make_apt_sources_list(nginx, apt_sourcefile)

    # make logdb configs
    logdbconfdir = os.path.join(dirname, 'logdb.d')
    if not os.path.exists(logdbconfdir):
        os.mkdir(logdbconfdir)

    if project['required_logdb']:
        logdb_upstream = os.path.join(logdbconfdir, '%s-logdb-upstream.conf' % project['name'])
        with open(logdb_upstream, 'w') as wfile:
            wfile.write(env.get_template('logdb-upstream.conf.tpl').render(project=project))

        logdb_locations = os.path.join(logdbconfdir, '%s-logdb-locations.conf' % project['name'])
        with open(logdb_locations, 'w') as wfile:
            wfile.write(env.get_template('logdb-locations.conf.tpl').render(project=project))

    # copy addons
    copy_addons('addons', dirname)


def make_logdb_node(dirname, project):
    if 'logdb' not in project:
        return

    logdb = project['logdb']

    if not os.path.exists(dirname):
        os.mkdir(dirname)

    create_apt_configs(logdb)

    if len(logdb['apt']['sources']) > 0:
        logdb['apt']['sources_list_filename'] = 'logdb-sources.list'

    if 'ip' not in logdb:
        logdb['ip'] = DEFAULT_LOGDB_SERVICE_IP

    for net in project['sorted_networks']:
        logdb[net['name']] = make_ip(net['subnet'], logdb['ip'])

    dockerfile = os.path.join(dirname, 'Dockerfile')
    with open(dockerfile, 'w') as wfile:
        wfile.write(env.get_template('Dockerfile.logdb.tpl').render(project=project))

    # gen sources list
    if logdb['apt']['sources_list_filename']:
        apt_sourcefile = os.path.join(dirname, logdb['apt']['sources_list_filename'])
        make_apt_sources_list(logdb, apt_sourcefile)

    # make logdb-conf.xml
    confile = os.path.join(dirname, '%s-logdb-conf.xml' % project['name'])
    with open(confile, 'w') as wfile:
        wfile.write(env.get_template('logdb-conf.xml.tpl').render(project=project).encode('utf-8'))

    # copy addons
    copy_addons('addons', dirname)

    # create logdb directory
    dbdir = os.path.join(dirname, 'logdb')
    if not os.path.exists(dbdir):
        os.mkdir(dbdir)


def make_config_for_nginx(basedirname, node, project):
    if 'novnc_port' not in node:
        return

    confdir = os.path.join(basedirname, 'vnc.d')

    if not os.path.exists(confdir):
        os.mkdir(confdir)

    loc_confname = '%s-locations.conf' % node['node_name']

    loc_outfile = os.path.join(confdir, loc_confname)
    with open(loc_outfile, 'w') as wfile:
        wfile.write(env.get_template('novnc-locations.conf.tpl').render(node=node, project=project))

    upstream_confname = '%s-upstream.conf' % node['node_name']
    upstream_outfile = os.path.join(confdir, upstream_confname)
    with open(upstream_outfile, 'w') as wfile:
        wfile.write(env.get_template('novnc-upstream.conf.tpl').render(node=node, project=project))


def make_apt_sources_list(node, filename, tplname='sources.list.tpl'):
    with open(filename, 'w') as wfile:
        wfile.write(env.get_template(tplname).render(node=node))


def get_source_dir(name):
    for d in sources_dirs:
        fpath = os.path.join(d, name)
        if os.path.exists(fpath):
            return fpath

    return name


def copy_addons(fromdir, todirname):
    # copy from all addons dirs
    for d in sources_dirs:
        addonsdir = os.path.join(d, fromdir)
        if os.path.exists(addonsdir):
            for f in os.listdir(addonsdir):
                src = os.path.join(addonsdir, f)
                dest = os.path.join(todirname, f)
                if not os.path.exists(dest):
                    shutil.copy(src, dest)


def usage():
    print "daas compose command [-c|--confile] project.yml [options]"
    print "Commands:"
    print "---------"
    print "gen              - Generate files for docker-compose"
    print "image-list       - Print list of images (bash format)"
    print "image-name node  - Print image name for node"
    print "docker-add-host  - Print extra hosts for docker (--add-host format)"
    print
    print "Options:"
    print "---------"
    print "--image-registry name     - docker registry name to use in image name ([registry-name]/image-name)"
    print "--image-postfix name      - postfix for use in image name (image-name[postfix])"


if __name__ == "__main__":

    if check_arg_param(['--help', '-h']):
        usage()
        exit(0)

    if len(sys.argv) < 2:
        usage()
        exit(-1)

    cmd = sys.argv[1]

    tpldirs = list()
    for d in sources_dirs:
        tpldirs.append(os.path.join(d, 'templates'))

    env = Environment(
        loader=FileSystemLoader(tpldirs)
    )

    confile = get_arg_param(['--confile', '-c'], '')
    if len(confile) == 0:
        print "ERROR: Unknown confile. Use [-c|--confile] filename"
        exit(1)

    conf = None
    with open(confile) as stream:
        try:
            conf = yaml.load(stream)
        except yaml.YAMLError as ex:
            print(ex)
            exit(1)

    if 'version' not in conf:
        print "ERROR: Unknown config file format. Supported by %s" % FORMAT_VERSION
        exit(1)

    if str(conf['version']) != str(FORMAT_VERSION):
        print "ERROR: Unsupported file format '%s'. Must be '%s'" % (conf['version'], FORMAT_VERSION)
        exit(1)

    project = conf

    project['image-registry'] = get_arg_param(['--image-registry'], '')
    project['image-postfix'] = get_arg_param(['--image-postfix'], '')
    project['sorted_networks'] = sorted_networks(project)
    project['extra_hosts'] = make_hosts(project)
    project['nodes'] = make_project_nodes(project)
    if 'VSTAND_HOSTNAME' in os.environ:
        project['stand_hostname'] = os.environ['VSTAND_HOSTNAME']
    else:
        project['stand_hostname'] = socket.gethostbyaddr(socket.gethostname())[0]

    # check require 'nginx'
    project['required_nginx'] = False
    for node in project['nodes']:
        if 'novnc_port' in node:
            project['required_nginx'] = True
            break

    # check require 'logdb'
    project['required_logdb'] = False
    if 'logdb' in project and 'disable' not in project['logdb']:
        for node in project['nodes']:
            if 'logservers' in node and len(node['logservers']) > 0:
                project['required_logdb'] = True
                break

    if project['required_logdb']:
        project['required_nginx'] = True

    if project['required_nginx'] and 'nginx' not in project:
        project['nginx'] = dict()

    if project['required_logdb'] and 'logdb' not in project:
        project['logdb'] = dict()

    if project['required_logdb'] and 'port' not in project['logdb']:
        project['logdb']['port'] = 42000  # <-- просто какое-то число

    # [command]: docker-add-host
    if cmd == 'docker-add-host':
        ret = ''
        for h in project['extra_hosts']:

            # split if nodename="node1 node2 node3"
            hh = h['node_name'].split(' ')
            if len(hh) > 1:
                for n in hh:
                    ret = '--add-host %s:%s %s' % (n, h['ip'], ret)
            else:
                ret = '--add-host %s:%s %s' % (h['node_name'], h['ip'], ret)
        print ret.strip()
        exit(0)

    # [command]: image-list
    if cmd == 'image-list':
        img_list = list()
        s = ''
        for node in project['nodes']:
            img_list.append(node['image_name'])

        uniq_list = make_unique_list(img_list)
        for n in uniq_list:
            s = '%s %s' % (s, n)

        print s.strip()
        exit(0)

    # [command]: image-name
    if cmd == 'image-name':
        nodename = get_arg_param(['image-name'])
        if len(nodename) == 0:
            print "(image-name): Unknown node name. Use -h for help"
            exit(1)

        for n in project['nodes']:
            if n['node_name'] == nodename:
                print n['image_name']
                exit(0)

        print "(image-name): ERROR: Not found node '%s'" % nodename
        exit(1)

    # [command]: gen
    if not check_arg_param(['gen']):
        print "Unknown command. Use -h for help"
        exit(1)

    outdir = '%s-compose' % project['name']

    if not os.path.exists(outdir):
        os.mkdir(outdir)

    if get_arg_param(['gen']):
        print "Unknown command. Use -h for help"
        exit(1)

    # make logdb container
    if project['required_logdb']:
        logdbdir = os.path.join(outdir, 'logdb')
        make_logdb_node(logdbdir, project)

    # make nginx container
    nginxdir = os.path.join(outdir, 'nginx')
    if project['required_nginx']:
        make_nginx_node(nginxdir, project)

    # make docker-compose.yml
    dc_file = os.path.join(outdir, 'docker-compose.yml')
    with open(dc_file, 'w') as wfile:
        wfile.write(env.get_template('docker-compose.yml.tpl').render(project=project))

    # make directories and configs
    for n in project['nodes']:
        dirname = os.path.join(outdir, n['node_name'])
        if not os.path.exists(dirname):
            os.mkdir(dirname)

        # make conf for nginx
        make_config_for_nginx(nginxdir, n, project)

        # gen sources list
        if n['apt']['sources_list_filename']:
            apt_sourcefile = os.path.join(dirname, n['apt']['sources_list_filename'])
            make_apt_sources_list(n, apt_sourcefile)

        # make Dockerfile
        make_dockerfile(dirname, n, project)

        # make Dockerfile.novnc
        make_novnc_dockerfile(dirname, n, project)

        # copy addons
        copy_addons('addons', dirname)
