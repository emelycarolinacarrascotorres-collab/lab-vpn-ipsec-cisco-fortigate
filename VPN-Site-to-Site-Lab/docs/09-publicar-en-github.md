# Publicar el repositorio en GitHub

Este repositorio está listo para subir; la creación en GitHub la hace la propietaria de la cuenta.

## 1. Antes de subir
- Los configs tienen contraseñas y la PSK en texto plano. Decida si el repositorio será **privado** o si redacta esos valores en las copias.
- Si el video pesa menos de 100 MB, cópielo en `videos/` (por ejemplo `demo-vpn-site-to-site.mp4`).

## 2. Crear y subir
```bash
cd VPN-Site-to-Site-Lab
git init
git add .
git commit -m "Laboratorio VPN Site-to-Site: documentación y evidencias"
git branch -M main
git remote add origin https://github.com/<usuario>/VPN-Site-to-Site-Lab.git
git push -u origin main
```
Cree antes el repositorio vacío en https://github.com/new, sin README ni .gitignore.

## 3. Poner el video al inicio del README
Elija una opción y reemplace el bloque «Video demostrativo» del README:
- **Archivo subido a GitHub:** arrastre el `.mp4` al editor del README en la web; GitHub genera un enlace que se reproduce incrustado.
- **YouTube (no listado):** `[![Video](https://img.youtube.com/vi/ID/maxresdefault.jpg)](https://www.youtube.com/watch?v=ID)`
- **Archivo del repositorio:** `[Ver video](videos/NOMBRE-DEL-VIDEO.mp4)` (ajuste el nombre al archivo real)
