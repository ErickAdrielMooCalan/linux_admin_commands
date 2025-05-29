INSTALAR EL SERVICIO DE DHCP
sudo apt install isc-dhcp-server

ABRIMOS EL ARCHIVO DE CONFIGURACIÓN
sudo nano /etc/default/isc-dhcp-server

AL FINAL DEL ARCHIVOS AGREGAMOS EL ADAPTADOR DE RED
    Obteniendo:
        # On what interfaces should the DHCP server (dhcpd) serve DHCP requests?
        #Separate multiple interfaces with spaces, e.g. "eth0 eth1".
        INTERFACES="enp0s3"

    GUARDAMOS CON CTRL O, ENTER Y CTRL X

NOS DIRIGIMOS AL ARCHIVO
sudo nano /etc/dhcp/dhcpd.conf

