#!/usr/bin/env python
# -*- coding: utf-8 -*-

from jinja2 import Environment, FileSystemLoader
import yaml

import sys
import os
import shutil

sources_dirs = ['./', '.daas', '/usr/share/daas']


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
    h['nodename'] = nodename
    h['ip'] = ip
    return h


def sorted_networks(project):
    networks = list()
    klist = sorted(project['networks'].keys())
    for n in klist:
        net = dict()
        net['name'] = n
        net['subnet'] = project['networks'][n]
        networks.append(net)

    return networks


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

    # controllers
    if 'controllers' in project and 'nodes' in project['controllers'] and len(project['controllers']['nodes']) > 0:
        for k, v in project['controllers']['nodes'].items():
            hosts_list = hosts_list + add_host(project, k, v['ip'])

    # gui
    if 'gui' in project and 'nodes' in project['gui'] and len(project['gui']['nodes']) > 0:
        for k, v in project['gui']['nodes'].items():
            hosts_list = hosts_list + add_host(project, k, v['ip'])

    # builder
    hosts_list = hosts_list + add_host(project, 'builder', project['builder']['ip'])

    # tester
    hosts_list = hosts_list + add_host(project, 'tester', project['tester']['ip'])

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


def create_node(project, typenode, name, node, image):
    c = dict()
    for net in project['sorted_networks']:
        c[net['name']] = make_ip(net['subnet'], node['ip'])

    c['nodename'] = name
    c['Dockerfile.tpl'] = 'Dockerfile.%s.tpl' % image
    c['image'] = image
    c['image-name'] = get_image_name(project, image)
    c['apt'] = dict()
    c['apt']['sources'] = list()
    c['apt']['packages'] = list()
    c['apt']['sources_list_filename'] = None
    c['volumes'] = list()
    c['devices'] = list()

    # global + parameters for type + local
    c['apt']['sources'] = get_apt_param(project, 'sources') \
                          + get_apt_param(typenode, 'sources') \
                          + get_apt_param(node, 'sources')

    if len(c['apt']['sources']) > 0:
        c['apt']['sources_list_filename'] = 'sources.list'

    c['apt']['packages'] = get_apt_param(project, 'packages') \
                           + get_apt_param(typenode, 'packages') \
                           + get_apt_param(node, 'packages')

    c['volumes'] = get_list(project, 'volumes') + get_list(typenode, 'volumes') + get_list(node, 'volumes')
    c['devices'] = get_list(project, 'devices') + get_list(typenode, 'devices') + get_list(node, 'devices')

    return c


def make_nodes(project, ctype, image):
    nlist = list()

    if ctype in project and 'nodes' in project[ctype] and len(project[ctype]['nodes']) > 0:
        for k, v in project[ctype]['nodes'].items():
            c = create_node(project, project[ctype], k, v, image)
            nlist.append(c)

    nlist.sort()
    return nlist


def get_image_name(project, image):
    name = "%s-%s" % (project['name'], image)
    if len(project['image-registry']) > 0:
        name = "%s/%s" % (project['image-registry'], name)
    if len(project['image-postfix']) > 0:
        name = "%s%s" % (name, project['image-postfix'])

    return name


def make_dockerfile(dirname, node):
    if not os.path.exists(dirname):
        os.mkdir(dirname)

    dockerfile = os.path.join(dirname, 'Dockerfile')
    with open(dockerfile, 'w') as wfile:
        wfile.write(env.get_template(node['Dockerfile.tpl']).render(node=node))
        wfile.write('\n')  # fix bug: jinja cuts off the last line feed


def make_apt_sources_list(node, filename, tplname='sources.list.tpl'):
    with open(filename, 'w') as wfile:
        wfile.write(env.get_template(tplname).render(node=node))
        wfile.write('\n')  # fix bug: jinja cuts off the last line feed


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
    print "daas compose [-c|--confile] project.yml [options] command"
    print "Commands:"
    print "---------"
    print "gen              - Generate files for docker-compose"
    print "image-list       - Print list of images (bash format)"
    print "image-name node  - Print image name for node"
    print "docker-add-host  - Print extra hosts in docker --add-host format"
    print
    print "Options:"
    print "---------"
    print "--image-registry name     - docker registry name to use in image name ([registry-name]/image-name)"
    print "--image-postfix name      - postfix for use in image name (image-name[postfix])"


if __name__ == "__main__":

    if check_arg_param(['--help', '-h']):
        usage()
        exit(0)

    tpldirs = list()
    for d in sources_dirs:
        tpldirs.append(os.path.join(d, 'templates'))

    env = Environment(
        loader=FileSystemLoader(tpldirs)
    )

    confile = get_arg_param(['--confile', '-c'], '')
    if len(confile) == 0:
        print "ERROR: Unknown confile. Use [-h|--confile] filename"
        exit(1)

    conf = None
    with open(confile) as stream:
        try:
            conf = yaml.load(stream)
        except yaml.YAMLError as ex:
            print(ex)
            exit(1)

    project = conf['project']

    # для узла tester
    # обязательно прокидывается /var/run/docker.sock:/var/run/docker.sock
    if 'volumes' in project['tester']:
        project['tester']['volumes'].append("/var/run/docker.sock:/var/run/docker.sock")
    else:
        project['tester']['volumes'] = {"/var/run/docker.sock:/var/run/docker.sock"}

    project['image-registry'] = get_arg_param(['--image-registry'], '')
    project['image-postfix'] = get_arg_param(['--image-postfix'], '')
    project['sorted_networks'] = sorted_networks(project)
    project['extra_hosts'] = make_hosts(project)
    project['nodes'] = make_nodes(project, 'controllers', project['image']['controller']) \
                       + make_nodes(project, 'gui', project['image']['gui']) \
                       + [create_node(project, project['tester'], 'tester', project['tester'],
                                      project['image']['tester'])]

    # [command]: docker-add-host
    if check_arg_param(['docker-add-host']):
        ret = ''
        for h in project['extra_hosts']:

            # split if nodename="node1 node2 node3"
            hh = h['nodename'].split(' ')
            if len(hh) > 1:
                for n in hh:
                    ret = '--add-host %s:%s %s' % (n, h['ip'], ret)
            else:
                ret = '--add-host %s:%s %s' % (h['nodename'], h['ip'], ret)
        print ret.strip()
        exit(0)

    # [command]: image-list
    if check_arg_param(['image-list']):
        s = ''
        for k, v in project['image'].items():
            s = '%s %s' % (s, get_image_name(project, project['image'][k]))

        print s.strip()
        exit(0)

    # [command]: image-name
    if check_arg_param(['image-name']):
        nodename = get_arg_param(['image-name'])
        if len(nodename) == 0:
            print "(image-name): Unknown nodename. Use -h for help"
            exit(1)
        if nodename == 'builder':
            print get_image_name(project, project['image']['builder'])
            exit(0)
        for n in project['nodes']:
            if n['nodename'] == nodename:
                print n['image-name']
                exit(0)

        print "(image-name): ERROR: Not found nodename '%s'" % nodename
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

    # make docker-compose.yml
    dc_file = os.path.join(outdir, 'docker-compose.yml')
    with open(dc_file, 'w') as wfile:
        wfile.write(env.get_template('docker-compose.yml.tpl').render(project=project))

    # Добавляем builder в список, только после генерирования docker-compose.yml, т.к. он туда не должен попасть
    builder = create_node(project, project['builder'], 'builder', project['builder'], project['image']['builder'])
    project['nodes'].append(builder)

    # make directories and configs
    for n in project['nodes']:
        dirname = os.path.join(outdir, n['nodename'])
        if not os.path.exists(dirname):
            os.mkdir(dirname)

        # make addons for gui (nginx, vnc config)
        # ....

        # gen sources list
        if n['apt']['sources_list_filename']:
            apt_sourcefile = os.path.join(dirname, n['apt']['sources_list_filename'])
            make_apt_sources_list(n, apt_sourcefile)

        # make Dockerfile
        make_dockerfile(dirname, n)

        # copy addons
        copy_addons('addons', dirname)
