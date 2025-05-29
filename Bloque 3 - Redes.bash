OBTENER LA IP DEL EQUIPO
hostname -I

OBTENER LA IP DEL EQUIPO
ifconfig

OBTENER LA IP DEL EQUIPO
ip address show

OBTENER IP DE ENRRUTAMIENTO
ip route show

OBTENER LA PUERTA DE ENLACE ATRAVES DE UNA RED
ip route get [address]
	ejemplo:
	ip route get 8.8.8.8

DESABILITAR UNA ADAPTADOR DE RED
ip link set [interface] down
	ejemplo:
	ip link set enp0s3 down

HABILITAR UN ADAPTADOR DE RED
ip link set [interface] up
	ejemplo:
	ip link set enp0s3 up

OBTENER LA TABLA ARP
ip neigh show

VER LAS ESTADÍSTICAS DEL ADAPTADOR DE RED
ip -s link

VER LOS PUERTOS LISTENER
ss -ltpan


CAMBIAR LA IP A ESTÁTICA
	MÉTODO 1: ARCHIVO INTERFACES
			1. PRIMERO IDENTIFICAR LA INTERFAZ DE RED
			ifconfig

				Obteniendo:

				enp0s3    Link encap:Ethernet  HWaddr 08:00:27:26:ea:60
				  inet addr:192.168.2.111  Bcast:192.168.2.255  Mask:255.255.255.0

				DE MODO QUE COMO OBSERVAMOS LA INTERFAZ ES "enp0s3"

			2. REALIZAR OTRA VERIFICACIÓN PARA IDENTIFICAR SI LA INTERFAZ NO TIENE IP SECUNDARIA
			ip addr show enp0s3

				Obteniendo:

				2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
				link/ether 08:00:27:26:ea:60 brd ff:ff:ff:ff:ff:ff
				inet 192.168.2.111/24 brd 192.168.2.255 scope global dynamic enp0s3
				   valid_lft 85216sec preferred_lft 85216sec
				inet 192.168.2.112/24 brd 192.168.2.255 scope global secondary enp0s3
				   valid_lft forever preferred_lft forever
				inet6 fe80::6ca4:2061:2726:1dd4/64 scope link 
				   valid_lft forever preferred_lft forever

				COMO VEMOS SE TIENE 2 IP LAS CUALES SON: 192.168.2.111/24 Y 192.168.2.112/24


			3. SUPONGAMOS QUE ÚNICAMENTE QUEREMOS LA IP 192.168.2.112/24 COMO ESTÁTICA PRINCIPAL

				No dirigmos a: /etc/network
				y ejecutamos: sudo nano interfaces

				El archivo debería quedar de la siguiente manera:

					# loopback interface
					auto lo
					iface lo inet loopback

					# red cableada con IP fija
					auto enp0s3
					iface enp0s3 inet static
						address 192.168.2.112
						netmask 255.255.255.0
						gateway 192.168.2.1
						dns-nameservers 8.8.8.8 1.1.1.1

				Guardamos los cambios Ctrl O, Enter y Ctrl X


			4. ELIMINAMOS LA IP DINAMICA ACTUAL, EN ESTE CASO LA 192.168.2.11/24
			sudo ip addr del 192.168.2.111/24 dev enp0s3

			5. REINICIAMOS EL SERVICIO DE RED
			sudo systemctl restart networking

			6. VERIFICAMOS QUE YA TENGAMOS LA IP CORRECTA
			ip a show enp0s3

				Obteniendo:
				inet 192.168.2.112/24 brd 192.168.2.255 scope global enp0s3


	MÉTODO 2: NETWORK MANAGER

		1. VERIFICAMOS SI EL EQUIPO ESTÁ CORRIENDO EL GESTOR DE REDES NETWORKMANAGER:
		systemctl is-active NetworkManager

			Obtenemos:
			active

		1. LISTAR LAS CONEXIONES ADMINISTRADAS POR NETWORK MANAGER
		nmcli connection show

			Obtendremos:
			NAME                UUID                                  TYPE            DEVICE 
			Wired connection 1  a22284f7-b1dd-3bfc-b5c2-0cf9339916f6  802-3-ethernet  enp0s3

		2. UNA VEZ IDENTIFICADA EL NOMBRE DE LA CONEXIÓN "Wired connection 1" SE EJECUTA LO SIGUIENTE EN CASO
		   QUE SE DESEE ASIGNAR LA IP ESTÁTICA 192.168.2.112/24:
		sudo nmcli connection modify "Wired connection 1" ipv4.addresses 192.168.2.112/24
		sudo nmcli connection modify "Wired connection 1" ipv4.gateway 192.168.2.1
		sudo nmcli connection modify "Wired connection 1" ipv4.dns "8.8.8.8 1.1.1.1"
		sudo nmcli connection modify "Wired connection 1" ipv4.method manual

		3. REINICIAMOS LA CONEXIÓN PARA APLICAR CAMBIOS:
		sudo nmcli connection down "Wired connection 1" && sudo nmcli connection up "Wired connection 1"

		4. VERIFICAMOS QUE YA TENGAMOS LA IP CORRECTA:
		ip a show enp0s3

			Obtenemos: inet 192.168.2.112/24 brd 192.168.2.255 scope global enp0s3


	3. MÉTODO 3: NETPLAN

		1. NOS DIRIGIMOS A LA DIRECCIÓN DEL ARCHIVO DE MODIFICACIÓN
		cd /etc/netplan/

		2. MODIFICAMOS EL ARCHIVO
		sudo nano 01-network-manager-all.yaml

		3. APLICAMOS LA CONFIGURACIÓN:
		network:
		  version: 2
		  renderer: network
		  ethernets:
			enp0s3:
			  dhcp4: no
			  addresses:
				- 192.168.2.112/24
			  gateway4: 192.168.2.1
			  nameservers:
				addresses: [8.8.8.8,8.8.4.4]

		4. APLICAMOS LOS CAMBIOS
		sudo netplan apply