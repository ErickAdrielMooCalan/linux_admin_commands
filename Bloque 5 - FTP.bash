1. INSTALAR EL SERVICIO
    sudo yum install vsftpd -y #Ubuntu/Debian
    sudo apt install vsftpd -y #CentOS

2. INICIAR EL SERVICIO
    sudo systemctl start vsftpd

3. HABILITAR EL SERVICIO PARA QUE ARRANQUE CON EL SISTEMA
    sudo systemctl enable vsftpd

4. VERIFICAR EL ESTADO DEL SERVICIO
    sudo systemctl status vsftpd

5. CONFIGURA EL FIREWALL PARA FTP
    sudo firewall-cmd --permanent --add-service=ftp | CentOS
    sudo firewall-cmd --reload                      |

    sudo ufw allow ftp                              | Ubuntu/Debian
    sudo ufw reload                                 |

6. CREAR LA CARPETA RAÍZ PARA FTP Y DAR PERMISOS
    sudo mkdir -p /home/mainserver/FTPFolder
    sudo chmod 755 /home/mainserver/FTPFolder

7. CREAR LAS CARPETAS PARA CADA USUARIO VIRTUAL, EJEMPLO PARA EL USUARIO "adminftp"
    sudo mkdir -p /home/mainserver/FTPFolder/adminftp/files #Carpeta usuario adminftp
    sudo mkdir -p /home/mainserver/FTPFolder/userftp/files #Carpeta para el usuario userftp

8. ASIGNAR LOS PERMISOS CORRECTOS PARA EVITAR EL ERROR 500
    #Usuario adminftp
    sudo chown ftpvirtual:ftpvirtual /home/mainserver/FTPFolder/adminftp
    sudo chmod 555 /home/mainserver/FTPFolder/adminftp

    #Usuario userftp
    sudo chown ftpvirtual:ftpvirtual /home/mainserver/FTPFolder/userftp
    sudo chmod 555 /home/mainserver/FTPFolder/userftp

9. ASIGNAR PERMISOS DE ESCRITURA A LAS SUBCARPETAS DE CADA USUARIO
    #Usuario adminftp
    sudo chown -R ftpvirtual:ftpvirtual /home/mainserver/FTPFolder/adminftp/files
    sudo chmod 755 /home/mainserver/FTPFolder/adminftp/files

    #Usuario userftp
    sudo chown -R ftpvirtual:ftpvirtual /home/mainserver/FTPFolder/userftp/files
    sudo chmod 755 /home/mainserver/FTPFolder/userftp/files

10. CREAR EL USUARIO DEL SISTEMA QUE ACTUARÁ COMO CONTENEDOR DE LOS USUARIOS VIRTUALES
    sudo useradd -d /home/ftp_virtual -s /sbin/nologin ftpvirtual
    sudo mkdir -p /home/ftp_virtual
    sudo chown ftpvirtual:ftpvirtual /home/ftp_virtual

11. DAR PROPIEDAD AL USUARIO CONTENEDOR SOBRE LA CARPETA FTP
    sudo chown -R ftpvirtual:ftpvirtual /home/mainserver/FTPFolder

12. CREAR EL ARCHIVO DE USUARIOS VIRTUALES Y CONTRASEÑAS
    sudo touch /etc/vsftpd/virtual_users.txt
    sudo nano /etc/vsftpd/virtual_users.txt

        EL CONTENIDO DEL ARCHIVO DEBE SER EL SIGUIENTE (EJEMPLO):
            adminftp
            123456
            userftp
            123456

13. CONVIERTE EL ARCHIVO TXT A DB PARA PAM
    sudo db_load -T -t hash -f /etc/vsftpd/virtual_users.txt /etc/vsftpd/virtual_users.db
    sudo chmod 600 /etc/vsftpd/virtual_users.*

14. CONFIGURA PAM PARA USUARIOS VIRTUALES
    sudo nano /etc/pam.d/vsftpd #CentOS
    sudo nano /etc/pam.d/vsftpd-virtual #Ubuntu/Debian

        AGREGAMOS (BORRAR TODO LO DEMÁS, SOLO DEBE QUEDAR ESTO):
            auth required pam_userdb.so db=/etc/vsftpd/virtual_users
            account required pam_userdb.so db=/etc/vsftpd/virtual_users

15. CONFIGURAMOS EL ARCHIVO VSFTPD.CONF
    sudo nano /etc/vsftpd/vsftpd.conf

        DEBE QUEDAR DE LA SIGUIENTE MANERA:
            listen=YES
            anonymous_enable=NO
            local_enable=YES
            write_enable=YES
            local_umask=022
            dirmessage_enable=YES
            xferlog_enable=YES
            connect_from_port_20=YES
            xferlog_std_format=YES
            chroot_local_user=YES

            # Usuarios virtuales
            guest_enable=YES
            guest_username=ftpvirtual
            virtual_use_local_privs=YES
            pam_service_name=vsftpd

            user_sub_token=$USER
            local_root=/home/mainserver/FTPFolder/$USER

            # Seguridad
            hide_ids=YES

            # Lista de usuarios permitidos
            userlist_enable=YES

16. INSTALAR EL CLIENTE FPT PARA PRUEBAS
    sudo yum install ftp -y # CentOS
    sudo apt install ftp -y  # Ubuntu/Debian

17 DESDE OTRO EQUIPO (LINUX) DESDE LA TERMINAL PROBAMOS LA CONEXIÓN
    ftp 192.168.2.2

        RESULTADO:
            Connected to 192.168.2.2.
            220 (vsFTPd 3.0.2)
            Name (192.168.2.2:usuario): adminftp
            331 Please specify the password.
            Password:
            230 Login successful.
            ftp> ls -l


NOTA: SI APARECE ESTE ERROR:
500 OOPS: vsftpd: refusing to run with writable root inside chroot()

significa que la carpeta raíz del usuario es escribible.
Solución: cambiar permisos a chmod 555 /home/mainserver/FTPFolder/<usuario>

El directorio raíz del usuario virtual no debe ser escribible, pero las subcarpetas donde se cargan archivos sí deben serlo y deben pertenecer al usuario contenedor (ftpvirtual).
