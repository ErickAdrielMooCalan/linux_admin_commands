INSTALAR SAMBA
	sudo apt-get install samba #Ubuntu/Debian
	sudo yum install samba #CentOS

COMPROBAR QUE SAMBA ESTÁ CORRIENDO
	sudo systemctl status nmbd #Ubuntu/Debian
	o también
	sudo systemctl status smbd #Ubuntu/Debian
	sudo systemctl status smb #CentOS


REINICIAR EL SERVICIO DE SAMBA
	sudo systemctl restart smbd #Ubuntu/Debian
	sudo systemctl restart smb nmb #CentOS

CREAR CARPETA PARA CONFIGURACIONES DE SAMBA
	sudo mkdir samba

ACCEDER AL ARCHIVO DE CONFIGURACIÓN DE SAMBA
	sudo nano /etc/samba/smb.conf

DENTRO DEL ARCHIVO DE CONFIGURACIÓN AL FINAL SE AGREGA:
	[samba-share]
	comment = Samba on Ubuntu
	path = /home/erickmoo/samba
	read only = no
	browsable = yes
		Nota: Para salir y guardar los cambios: Ctrl O, luego ENTER y Ctrl X

AGREGAMOS NUESTRO USUARIO AL SERVIDOR SAMBA
sudo smbpasswd -a erickmoo

HABILITAMOS EL SEVICIO
	sudo systemctl enable smb nmb

REINICIAR EL SERVICIO DE SAMBA
	sudo systemctl restart smbd #Ubuntu/Debian
	sudo systemctl restart smb nmb #CentOS

COMPROBAR QUE SAMBA ESTÁ CORRIENDO
	sudo systemctl status nmbd #Ubuntu/Debian
	o también
	sudo systemctl status smbd #Ubuntu/Debian
	sudo systemctl status smb #CentOS

DAR LOS PERMISOS A LA CARPETA COMPARTIDA DESDE EL SERVIDOR CON SUPERUSUARIO
chmod 777 SambaShared

PARA ACCEDER DESDE WINDOWS
\\192.168.2.2\samba-share

PARA ACCEDER DESDE EL FILE EXPLORER DE LINUX
smb://192.168.2.2/samba-share

PARA ACEEDER DESDE LA TERMINAL DE UNIX
smbclient //192.168.2.2/samba-share -U mainserver