Name: daas
Summary: Devops As A Service
Version: 0.4
Release: alt2

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

Requires: sshpass

# Requires: jq

%description
daas - 'Devops As A Service'. 
Group of utilities for the organization of the devops

%package admin
Summary: Utilities for stands administation
Group: System/Utilities
Requires: %name = %EVR
Requires: ansible
%description admin
Utilities for stands administation

%prep
%setup

%build

%install
mkdir -p -m755 %buildroot%_datadir/%name
mkdir -p -m755 %buildroot%_datadir/%name/addons.d
mkdir -p -m755 %buildroot%_datadir/%name/templates.d
mkdir -p -m755 %buildroot%_bindir
cp daas %buildroot%_bindir/
subst 's|datadir=.|datadir=%_datadir/%name|g' %buildroot%_bindir/daas

cp daas-project/daas-project %buildroot%_bindir/
cp daas-config/daas-config %buildroot%_bindir/

cp example-project.yml %buildroot%_datadir/%name/

mkdir -p -m755 %buildroot%_datadir/%name/addons
mkdir -p -m755 %buildroot%_datadir/%name/templates
cp -r daas-project/addons %buildroot%_datadir/%name/
cp -r daas-project/templates %buildroot%_datadir/%name

mkdir -p -m755 %buildroot%_datadir/%name/modules.d
cp -r modules.d %buildroot%_datadir/%name/

mkdir -p -m755 %buildroot%_datadir/%name/ansible.d
cp -r ansible.d %buildroot%_datadir/%name/

mkdir -p -m755 %buildroot%_datadir/%name/tools
cp -r tools %buildroot%_datadir/%name/

mkdir -p -m755 %buildroot%_datadir/%name/repository.d
cp -r repository.d %buildroot%_datadir/%name/

%files
%_bindir/daas*
%dir %_datadir/%name
%_datadir/%name/*

%exclude %_datadir/%name/modules.d/vstand
%exclude %_datadir/%name/ansible.d
%exclude %_datadir/%name/repository.d
%exclude %_datadir/%name/repository.d/*
# %doc README.md

%files admin
%_datadir/%name/modules.d/vstand

%dir %_datadir/%name/ansible.d
%_datadir/%name/ansible.d/*

%dir %_datadir/%name/repository.d
%_datadir/%name/repository.d/*

%changelog
* Thu Aug 02 2018 Pavel Vainerman <pv@altlinux.ru> 0.4-alt2
- minor fixes

* Sat Jul 28 2018 Pavel Vainerman <pv@altlinux.ru> 0.4-alt1
- added daas-admin package
- added new modules (vstand)
- supported hostname

* Sat Jul 21 2018 Pavel Vainerman <pv@altlinux.ru> 0.3-alt5
- added repository.d
- refactoring modules

* Tue Jul 17 2018 Pavel Vainerman <pv@altlinux.ru> 0.3-alt4
- structure refactring (added 'admin' package) 

* Mon Jul 09 2018 Pavel Vainerman <pv@altlinux.ru> 0.3-alt3
- added use ccache for rpmbuild module

* Mon Jul 09 2018 Pavel Vainerman <pv@altlinux.ru> 0.3-alt2
- separated special tools

* Sun Jul 08 2018 Pavel Vainerman <pv@altlinux.ru> 0.3-alt1
- added modules build,rpmbuild,up,down

* Thu Jul 05 2018 Pavel Vainerman <pv@altlinux.ru> 0.2-alt5
- added 'get gitlab artifacts'

* Wed Jun 20 2018 Pavel Vainerman <pv@altlinux.ru> 0.2-alt4
- supported 'test_name' (eterbug #12964)

* Thu Jun 14 2018 Pavel Vainerman <pv@altlinux.ru> 0.2-alt3
- remove "pip install docker" (because upgrade p8)

* Fri May 25 2018 Pavel Vainerman <pv@altlinux.ru> 0.2-alt2
- supported templates.d, addons.d

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

