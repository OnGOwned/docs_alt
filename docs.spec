%define _documentationdir %_defaultdocdir/documentation

%define variants docs-office-server docs-backup-server docs-desktop docs-school-master docs-school-junior docs-school-lite docs-school-server

Name: docs-VARIANT
Version: 5.0
Release: alt1

Summary: VARIANT documentation
License: %fdl
Group: Documentation

Packager: ALT Docs Team <docs@packages.altlinux.org>
BuildArch: noarch

Source: %name-%version-%release.tar

Conflicts: %(for n in %variants ; do [ "$n" = %name ] || echo -n "$n "; done)

BuildRequires(pre):rpm-build-licenses
BuildRequires: asciidoc-a2x

%description
VARIANT documentation.

%prep
%setup -n %name-%version-%release

%build
%make_build

%install
%make_install DESTDIR=%buildroot docdir=%_defaultdocdir/%name install
ln -s $(relative %_defaultdocdir/%name %_documentationdir) %buildroot%_documentationdir

%files
%_defaultdocdir/%name
%_documentationdir

%changelog
