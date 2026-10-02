# Depuración y checklist de publicación

## Hallazgos corregidos en los archivos fuente
- Los comentarios de las configs Cisco usaban `=====` sin `!`, lo que IOS interpreta como comandos inválidos. Se convirtieron a `!`.
- Contraseñas y PSK de la VPN estaban en texto claro: sustituidas por `<ADMIN_PASSWORD>`, `<ENABLE_PASSWORD>` y `<PSK_VPN>`.
- El banner contenía nombre y matrícula: sustituido por `[NOMBRE] [MATRICULA]`.
- Se añadieron descripciones a las interfaces del switch y `!` como separadores.
- Se retiró la captura `prueba_2` (ver abajo).

## Pendientes antes de publicar
- [ ] Completar `[NOMBRE DEL AUTOR]`, `[NOMBRE]`, `[MATRICULA]`, `[ENLACE DEL VIDEO]`.
- [ ] Recapturar la evidencia de HTTPS: la captura original solo muestra la barra de direcciones con `https://10.25.97.2/` y el historial del navegador (incluye URLs internas y marcadores personales). Además, el servidor mostró la página por **HTTP**; Apache por defecto no sirve HTTPS. Para demostrar HTTPS, habilitar `a2enmod ssl` y un certificado autofirmado.
- [ ] Recortar `11-servidor-web-apache.png` para ocultar barra de tareas, marcadores y reloj.
- [ ] Exportar la configuración del FortiGate por CLI y añadirla en `configs/running-configs/` (sin PSK ni contraseñas).
- [ ] Decidir si se renombra el hostname `CISCO-SRV` de R1: es el router del lado de **usuarios**, el nombre induce a error (el ISP lo describe como `CISCO-USR`). Se mantuvo para coincidir con la evidencia.
- [ ] Grabar el video y subir el enlace.
- [ ] Opcional: subir el proyecto de GNS3 en `docs/diagrams/` para reproducibilidad completa.
- [ ] Abrir el README en GitHub y comprobar que imágenes, Mermaid y enlaces se ven.

## Checklist final
- [ ] Nombre del repositorio descriptivo
- [ ] README completo con video al inicio
- [ ] Imágenes con nombre descriptivo, sin duplicados ni datos sensibles
- [ ] Diagrama coherente con las configuraciones
- [ ] Scripts documentados
- [ ] Running configs de todos los dispositivos (ISP, SW-1, R1, FortiGate, servidor)
- [ ] Sin contraseñas, PSK, tokens ni datos personales
- [ ] Ortografía y nombres unificados
- [ ] Enlaces verificados
