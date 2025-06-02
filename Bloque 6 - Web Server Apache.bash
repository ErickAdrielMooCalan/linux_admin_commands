1. INSTALAR APACHE WEB SERVER
    sudo yum install httpd -y #CentOS
    sudo apt install apache2 -y #Ubuntu/Debian

2. INICIAR EL SEVICIO
    sudo systemctl start httpd #CentOS
    sudo systemctl start apache2 #Ubuntu/Debian

3. CONFIGURAR EL SERVICIO PARA ARRANCAR CON EL SISTEMA
    sudo systemctl enable httpd #CentOS
    sudo systemctl enable apache2 #Ubuntu/Debian

4. CONFIGURAR EL FIREWALL
    sudo firewall-cmd --permanent --add-service=http    |#CentOS
    sudo firewall-cmd --permanent --add-service=https   |
    sudo firewall-cmd --reload                          |

    sudo ufw allow 'Apache'                             |#Ubuntu/Debian
    sudo ufw reload                                     |

5. PROBAR ACCEDER EN OTRA MAQUINA EN LA MISMA RED
    http://192.168.2.2

        SE DEBE OBTENER UN MENSAJE:
            "Apache HTTP Server Test Page" (CentOS)

6. IR A LA CARPETA RAÍZ DEL SITIO WEB Y CREAR UN ARCHIVO INDEX.HTML DE PRUEBA
    cd /var/www/html

7. INICIAR SESIÓN CON EL SUPERUSUARIO Y CREAR EL ARCHIVO
    touch index.html

8. MODIFICAR EL ARCHIVO Y AGREGARLE UN CÓDIGO DE PRUEBA
    nano index.html

        EJEMPLO:
            <html>
                <head>
                    <title>Testing Web Sever</title>
                </head>
                <body>
                    <h1>Test Apache Web Server</h1>
                    <p>Hi, I'm Erick the Administrator </p>
                </body>
            </html>

    CTRL O, ENTER, CTRL X PARA GUARDAR LOS CAMBIOS

9. DAR LOS PERMISOS AL ARCHIVO HTML
    sudo chmod 644 /var/www/html/index.html

10. INGRESAR AL NAVEGADOR PARA VERIFICAR SI LA PÁGINA WEB YA SE VISUALIZA
    http://192.168.2.2