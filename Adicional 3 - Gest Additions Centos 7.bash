INSTALAMOS ACTUALIZACIONES
    sudo yum update

INSTALAR LOS PAQUETES
    ~$ sudo yum install -y bzip2 gcc make perl kernel-devel kernel-headers

INSERTAR GUEST ADDITIONS DESDE VIRTUAL BOX

MONTAR LA UNIDAD CD
    mount /dev/sr0 /media

COPIAR EL ARCHIVO VBOXLINUXADDITIONS DESDE LA UNIDAD CD A LA DIRECICÓN DE TRABAJO
    cp /media/VBoxLinuxAdditions.run .

DESMONTAR LA UNIDAD CD
    umount /media/

EJECUTAR EL ARCHIVO QUE SE ACABA DE COPIAR
    sudo ./VBoxLinuxAdditions.run