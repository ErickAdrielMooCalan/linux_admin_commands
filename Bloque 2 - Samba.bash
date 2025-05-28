INSTALAR SAMBA
sudo apt-get install samba

COMPROBAR QUE SAMBA ESTÁ CORRIENDO
sudo systemctl status nmbd
o también
sudo systemctl status smbd

REINICIAR EL SERVICIO DE SAMBA
sudo systemctl restart smbd

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

PARA ACCEDER DESDE WINDOWS
\\192.168.2.111\samba-share