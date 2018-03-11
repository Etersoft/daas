#!/usr/bin/env python
# -*- coding: utf-8 -*-

from jinja2 import Environment, FileSystemLoader
import yaml

import sys
import os
import shutil


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


def make_hosts(project):
    hosts_list = list()
    for k, v in project['controllers'].items():
        num = 1
        for net in project['sorted_networks']:
            if num == 1:
                hosts_list.append(make_host_item("%s r1_%s" % (k, k), make_ip(net['subnet'], v['ip'])))
            else:
                hosts_list.append(make_host_item("r%d_%s" % (num, k), make_ip(net['subnet'], v['ip'])))
            num = num + 1

    for k, v in project['gui'].items():
        num = 1
        for net in project['sorted_networks']:
            if num == 1:
                hosts_list.append(make_host_item("%s r1_%s" % (k, k), make_ip(net['subnet'], v['ip'])))
            else:
                hosts_list.append(make_host_item("r%d_%s" % (num, k), make_ip(net['subnet'], v['ip'])))
            num = num + 1

    # builder
    num = 1
    for net in project['sorted_networks']:
        if num == 1:
            hosts_list.append(make_host_item("builder r1_builder", make_ip(net['subnet'], project['builder']['ip'])))
        else:
            hosts_list.append(make_host_item("r%d_builder" % num, make_ip(net['subnet'], project['builder']['ip'])))
        num = num + 1

    hosts_list.sort()
    return hosts_list


def make_nodes(project, ctype, image):
    nlist = list()
    for k, v in project[ctype].items():
        c = dict()
        for net in project['sorted_networks']:
            c[net['name']] = make_ip(net['subnet'], v['ip'])

        c['nodename'] = k
        c['Dockerfile.tpl'] = 'Dockerfile.%s.tpl' % image
        c['image'] = image
        nlist.append(c)

    nlist.sort()
    return nlist


def usage():
    print "[-c|--confile] project.yml  - Config file for project"


if __name__ == "__main__":

    if check_arg_param(['--help', '-h']):
        usage()
        exit(0)

    env = Environment(
        loader=FileSystemLoader('./templates')
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

    # print conf
    project = conf['project']

    outdir = project['name']

    if not os.path.exists(outdir):
        os.mkdir(outdir)

    project['sorted_networks'] = sorted_networks(project)

    project['extra_hosts'] = make_hosts(project)
    project['nodes'] = make_nodes(project, 'controllers', project['image']['controller']) \
                       + make_nodes(project, 'gui', project['image']['gui'])

    # make docker-compose.yml
    dc_file = os.path.join(outdir, 'docker-compose.yml')
    with open(dc_file, 'w') as wfile:
        wfile.write(env.get_template('docker-compose.yml.tpl').render(project=project))

    # make directories
    for n in project['nodes']:
        dirname = os.path.join(outdir, n['nodename'])
        if not os.path.exists(dirname):
            os.mkdir(dirname)

        # make Dockerfile
        dockerfile = os.path.join(dirname, 'Dockerfile')
        with open(dockerfile, 'w') as wfile:
            wfile.write(env.get_template(n['Dockerfile.tpl']).render(project=project))

        # copy addons
        addonsdir = 'addons'
        if os.path.exists(addonsdir):
            for f in os.listdir(addonsdir):
                src = os.path.join(addonsdir, f)
                dest = os.path.join(dirname, f)
                shutil.copy(src, dest)
