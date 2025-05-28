"HOME" ES EL DIRECTORIO DONDE ESTÁN AGUARADO LOS USUARIOS
/home/erickmoo

IMPRIME EL DIRECCION DONDE ME ENCUENTRO
pwd

LISTADO DE DIRECTORIOS Y ARCHIVOS VISIBLES
ls
ls -l (FORMATO LISTA)

LISTADO DE TODOS LOS DIRECTORIO Y ARCHIVOS VISIBLES Y OCULTOS
	NOTA: TODOS LOS ARCHIVOS QUE INICIEN CON "." SON OCULTOS POR EJEMPLO: .bash_history
ls -a
ls -al (FORMATO LISTA)

MOVERNOS A DIRECTORIOS
cd Downloads (RUTAS RELATIVAS)
cd /home/erickmoo/Downloads (RUTAS ABSOLUTAS)

REGRESAR A DIRECTORIO ANTERIOR
cd ..

CREAR ARCHIVO COMPLETAMENTE VACIO O CAMBIAR LA FECHA DE MODIFICACION DEL ARCHIVO
touch archivo.txt
touch archivo.txt (SE ACTUALIZA LA FECHA DE MODIFICACIÓN DEL ARCHIVO)

SACAR COPIA DE UN ARCHIVO
cp archivo.txt archivo-copia.txt

SACAR COPIA A UN DIRECTORIO COMPLETO
cp -r Downloads/ Downloads_Copy

RENOMBRAR UN ARCHIVO
mv -v archivo1.txt archivo1_renamed.txt

RENOMBRAR UN DIRECTORIO
mv -v Downloads_Copy/ Downloads_Copied/

MOVER UN ARCHIVO A UN DIRECTORIO DIFERENTE
mv archivo1-copia.txt Documents/

MOVER UN DIRECTORIO A OTRO DIRECTORIO
mv Downloads_Copied/ Downloads/

CREAR NUEVO DIRECTORIO
mkdir Programs

ELIMINAR UN DIRECTORIO "SI ESTÁ VACÍO"
rmdir Programs

ELIMINAR UN DIRECTORIO QUE CONTENGA ARCHIVOS
rm -r Downloads_Copied/

ELIMINAR UN ARCHIVO
rm archivo1_renamed.txt

-----------------------------------------------------------
- rwx rwx rwx
│ │   │   └─ Otros (otros usuarios)
│ │   └──── Grupo del archivo
│ └──────── Propietario (usuario que lo creó)
└────────── Tipo: "-" archivo, "d" directorio

LETRAS DE PERMISOS:

r: lectura (read)
w: escritura (write)
x: ejecución (execute)

NOTACIÓN NUMÉRICA

Permiso    Valor
r (read)    4
w (write)   2
x (execute) 1

Permisos  Cálculo   Valor Numérico
rwx       4+2+1     7
rw-       4+2       6
r--       4         4
r-x       4+1       5
--x       1         1
---       0         0

-----------------------------------------------------------

QUITAR TODOS LOS PERMISOS A UN DIRECTORIO (Se usa sudo al inicio si otro propietario cambia los permisos)
chmod 000 Test
	Como resultado se obtiene: d--------- 2 erickmoo erickmoo 4096 may 25 20:52 Test

PONER PERMISOS DE EJECUCIÓN AL DIRECTORIO "Test" SOLO AL PROPIETARIO (EJEMPLO 1)
chmod 100 Test/
	Obteniendo: d--x------ 2 erickmoo erickmoo 4096 may 25 20:52 Test

PONER PERMISOS DE LECTURA Y ESCRITURA SOLO AL GRUPO (EJEMPLO 2)
chmod 060 Test/
	Obteniendo: d---rw---- 2 erickmoo erickmoo 4096 may 25 20:52 Test