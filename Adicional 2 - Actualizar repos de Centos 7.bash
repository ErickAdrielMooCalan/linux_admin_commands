MODICAR EL ARCHIVO
    sudo nano /etc/yum.repos.d/CentOS-Base.repo

BORRAR TODO EL CONTENIDO Y AGREGAR LO SIGUIENTE:
    [base]
    name=CentOS-$releasever - Base
    baseurl=https://vault.centos.org/7.9.2009/os/$basearch/
    gpgcheck=1
    gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
    enabled=1

    [updates]
    name=CentOS-$releasever - Updates
    baseurl=https://vault.centos.org/7.9.2009/updates/$basearch/
    gpgcheck=1
    gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
    enabled=1

    [extras]
    name=CentOS-$releasever - Extras
    baseurl=https://vault.centos.org/7.9.2009/extras/$basearch/
    gpgcheck=1
    gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
    enabled=1

    [centosplus]
    name=CentOS-$releasever - CentOSPlus
    baseurl=https://vault.centos.org/7.9.2009/centosplus/$basearch/
    gpgcheck=1
    gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
    enabled=0


EJECUTAR LO SIGUIENTE:
    sudo yum clean all
    sudo yum makecache
    sudo yum update