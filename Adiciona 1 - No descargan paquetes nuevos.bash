1. Editar el archivo
sudo nano /etc/apt/sources.list

2. Al abrir el archivo borrar todo el contenido y poner:
deb http://mirrors.kernel.org/ubuntu xenial main restricted universe multiverse
deb http://mirrors.kernel.org/ubuntu xenial-updates main restricted universe multiverse
deb http://mirrors.kernel.org/ubuntu xenial-backports main restricted universe multiverse
deb http://mirrors.kernel.org/ubuntu xenial-security main restricted universe multiverse

# Pre-released updates (optional, puedes comentarlos si no los necesitas)
# deb http://mirrors.kernel.org/ubuntu xenial-proposed main restricted universe multiverse

3. Elimina cualquier archivo de repositorios adicionales (como el de Shiftkey):
sudo rm /etc/apt/sources.list.d/* -f

4. Limpia la caché de paquetes (por si hay corrupción):
sudo rm -rf /var/lib/apt/lists/*
sudo apt clean

5. Intenta actualizar de nuevo
sudo apt clean
sudo apt update
sudo apt upgrade