Name:		gperiodic
Summary:	A graphical application for browsing the periodic table
Version:	3.0.2
Release:	%mkrel 1
URL:		https://sourceforge.net/p/gperiodic
Group:		Sciences/Chemistry
License:	GPLv2+
Source0:	https://sourceforge.net/projects/gperiodic/files/%{name}-%{version}.tar.gz
BuildRequires:	gtk2-devel
BuildRequires:	intltool

%description
Gperiodic displays a periodic table of the elements, allowing you to
browse through the elements, and view detailed information about each
element. This program also features a non-graphical interface.

%prep
%setup -q

%build
%make_build \
	LDFLAGS="%{ldflags}"

%install
%make_install

%find_lang %{name}

%files -f %{name}.lang
%doc AUTHORS ChangeLog README
%{_bindir}/*
%{_iconsdir}/hicolor/*/apps/*.png
%{_datadir}/applications/*.desktop
%{_datadir}/pixmaps/*.png
%{_datadir}/pixmaps/*.xpm
%{_mandir}/man1/*.1*
