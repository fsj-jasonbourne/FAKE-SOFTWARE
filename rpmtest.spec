
Summary: test install package
Name:jasonbourne9
Version:1.0.0.0
Release:neokylin
License:GPL
Group:Applications
Source:a.tar
Buildroot:%{_tmppath}/%{name}-%{release}-root
URL:http://www.vrv.com.cn
Packager:vrv
Vendor:vrv
Prefix: %{_prefix}
Prefix: %{_sysconfdir}
Autoreq:0
BuildRequires:pkgconfig

%description
The Management of Hosts' Monitoring and Auditing for CEMS

%prep

%setup -c

%build

%install

%clean

%pre

%post

%preun

%postun

%files
