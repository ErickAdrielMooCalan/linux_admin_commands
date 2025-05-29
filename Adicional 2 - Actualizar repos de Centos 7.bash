MODICAR EL ARCHIVO
    sudo nano /etc/yum.repos.d/CentOS-Base.repo

BORRAR TODO EL CONTENIDO Y AGREGAR LO SIGUIENTE:
    [base]
    name=CentOS-$releasever - Base - mirrors.aliyun.com
    baseurl=http://mirrors.aliyun.com/centos/$releasever/os/$basearch/
    gpgcheck=1
    gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7

    [updates]
    name=CentOS-$releasever - Updates - mirrors.aliyun.com
    baseurl=http://mirrors.aliyun.com/centos/$releasever/updates/$basearch/
    gpgcheck=1
    gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7

    [extras]
    name=CentOS-$releasever - Extras - mirrors.aliyun.com
    baseurl=http://mirrors.aliyun.com/centos/$releasever/extras/$basearch/
    gpgcheck=1
    gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7

    [centosplus]
    name=CentOS-$releasever - Plus - mirrors.aliyun.com
    baseurl=http://mirrors.aliyun.com/centos/$releasever/centosplus/$basearch/
    gpgcheck=1
    enabled=0
    gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7


EJECUTAR LO SIGUIENTE:
    sudo yum clean all
    sudo yum makecache
    sudo yum update