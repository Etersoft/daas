Name: daas
Summary: Devops As A Service
Version: 0.2
Release: alt1

Group: System/Utilities
License: MIT
Url: https://github.com/Etersoft/daas

# Source-url: https://github.com/Etersoft/daas/archive/%version.tar.gz
Source: %name-%version.tar
Source1: README.md

Packager: Pavel Vainerman <pv@altlinux.org>

BuildArch: noarch

%add_findreq_skiplist %_datadir/%name/addons/* %_datadir/%name/bash_modules.d/* %_bindir/daas

%py_requires yaml jinja2

%description
daas - 'Devops As A Service'. 
Group of utilities for the organization of the devops

%prep
%setup

%build


%install
mkdir -p -m755 %buildroot%_datadir/%name
mkdir -p -m755 %buildroot%_bindir
cp daas %buildroot%_bindir/
subst 's|datadir=.|datadir=%_datadir/%name|g' %buildroot%_bindir/daas

cp daas-project/daas-project %buildroot%_bindir/
cp example-project.yml %buildroot%_datadir/%name/

mkdir -p -m755 %buildroot%_datadir/%name/addons
mkdir -p -m755 %buildroot%_datadir/%name/templates
cp -r daas-project/addons %buildroot%_datadir/%name/
cp -r daas-project/templates %buildroot%_datadir/%name

mkdir -p -m755 %buildroot%_datadir/%name/bash_modules.d
cp -r bash_modules.d %buildroot%_datadir/%name/


%files
%_bindir/daas*
%dir %_datadir/%name/
%_datadir/%name/*

# %doc README.md

%changelog
* Fri May 25 2018 Pavel Vainerman <pv@altlinux.ru> 0.2-alt1
- supported 'no network section' (no ip, no subnet)

* Sun May 20 2018 Pavel Vainerman <pv@altlinux.ru> 0.1-alt3
- nginx: supported user configs (any.d)

* Sun May 20 2018 Pavel Vainerman <pv@altlinux.ru> 0.1-alt2
- supported 'cap_add'

* Sun May 13 2018 Pavel Vainerman <pv@altlinux.ru> 0.1-alt1
- refactoring: use modules

* Sat May 12 2018 Pavel Vainerman <pv@altlinux.ru> 0.1-alt0.8
- added 'ssh_port' for ssh access

* Thu May 10 2018 Pavel Vainerman <pv@altlinux.ru> 0.1-alt0.7
- added set ip for logdb and nginx containers

* Thu May 10 2018 Pavel Vainerman <pv@altlinux.ru> 0.1-alt0.6
- added logdb container

* Tue May 08 2018 Pavel Vainerman <pv@altlinux.ru> 0.1-alt0.5
- added nginx container

* Mon May 07 2018 Pavel Vainerman <pv@altlinux.ru> 0.1-alt0.4
- added generate 'novnc' services

* Sat May 05 2018 Pavel Vainerman <pv@altlinux.ru> 0.1-alt0.3
- change format config file to 0.2

* Sat May 05 2018 Pavel Vainerman <pv@altlinux.ru> 0.1-alt0.2
- initial release

