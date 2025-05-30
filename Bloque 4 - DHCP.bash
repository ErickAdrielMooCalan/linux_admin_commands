1. INSTALAR EL SERVICIO DE DHCP
sudo apt install isc-dhcp-server #Ubuntu/Debian
sudo yum install dhcp #CentOS

2. ABRIMOS EL ARCHIVO DE CONFIGURACIÓN
sudo nano /etc/default/isc-dhcp-server #Ubuntu/Debian
sudo nano /etc/sysconfig/dhcpd #CentOS


AL FINAL DEL ARCHIVOS AGREGAMOS EL ADAPTADOR DE RED
    Obteniendo:
        # On what interfaces should the DHCP server (dhcpd) serve DHCP requests?
        #Separate multiple interfaces with spaces, e.g. "eth0 eth1".
        INTERFACES="enp0s3" #Ubuntu/Debian
        DHCPDARGS="enp0s3" #CentOS

    GUARDAMOS CON CTRL O, ENTER Y CTRL X

3. NOS DIRIGIMOS AL ARCHIVO
sudo nano /etc/dhcp/dhcpd.conf #Ubuntu/Debian
sudo nano /etc/dhcp/dhcpd.conf #CentOS

4. EN EL ARCHIVO VAMOS A ENCONTRAR ESTA SECCIÓN:
subnet 192.168.2.0 netmask 255.255.255.0 {
  range 192.168.2.50 192.168.2.200;
  option broadcast-address 192.168.2.255;
  option routers 192.168.2.1;
  option domain-name-servers 8.8.8.8, 1.1.1.1;
}

    SUPONGAMOS QUE EL SERVIDOR TIENE LA IP 192.168.2.1, ENTONCES LA SECCIÓN CONTIENE LA SIGUIENTE INFO:

        1. subnet: Es la dirección base (red) de la subred.
        2. netmask: Define la máscara de red que indica qué parte de la dirección IP corresponde a la red y cuál a los hosts.
        3. range: Define el rango de direcciones IP que el servidor DHCP puede asignar dinámicamente a los dispositivos clientes que solicitan IP.
        4. option broadcast-address: La dirección broadcast es siempre la última dirección del rango, en este caso 192.168.2.255. Es la dirección que representa “todos los hosts” en tu subred.
        5. option routers: Especifica la puerta de enlace (gateway) que los dispositivos deben usar para salir de la red local y comunicarse con otras redes o internet.
        6. option domain-name-servers: Indica las direcciones IP de los servidores DNS que los clientes usarán para resolver nombres de dominio (por ejemplo, convertir www.google.com en una IP).

5. INICIAMOS EL SERVICIO
sudo systemctl start isc-dhcp-server #Ubuntu/Debian
sudo systemctl start dhcpd #CentOS

6. VERIFICAMOS EL STATUS DEL SERVIDOR
sudo systemctl status isc-dhcp-server #Ubuntu/Debian
sudo systemctl status dhcpd #CentOS