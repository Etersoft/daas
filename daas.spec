Name: daas
Summary: Devops As A Service
Version: 0.1
Release: alt0.1

Group: System/Utilities
License: MIT
Url: https://github.com/Etersoft/daas

# Source-url: https://github.com/Etersoft/daas/archive/%version.tar.gz
Source: %name-%version.tar
Source1: README.md

Packager: Pavel Vainerman <pv@altlinux.org>

BuildArch: noarch

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
cp docker-compose-gen/daas-docker-compose-gen.py %buildroot%_bindir/
cp example-project.yml %buildroot%_datadir/%name/

mkdir -p -m755 %buildroot%_datadir/%name/addons
mkdir -p -m755 %buildroot%_datadir/%name/templates
cp -r docker-compose-gen/addons %buildroot%_datadir/%name/
cp -r docker-compose-gen/templates %buildroot%_datadir/%name


%files
%_bindir/daas*
%dir %_datadir/%name/
%_datadir/%name/*

# %doc README.md

%changelog
