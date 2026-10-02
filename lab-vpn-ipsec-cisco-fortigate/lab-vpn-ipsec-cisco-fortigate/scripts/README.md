# Scripts

| Script | Dispositivo | Descripción | Ejecución |
|---|---|---|---|
| `server/configure-server.sh` | web-server-lab (Ubuntu) | Asigna `10.25.97.2/28` a `eth0` y la ruta por defecto vía `10.25.97.1` (FortiGate port2). | `sudo ./configure-server.sh` |

Variables opcionales: `IFACE` (def. `eth0`), `IP_CIDR` (def. `10.25.97.2/28`), `GATEWAY` (def. `10.25.97.1`).
El servicio Apache2 se instaló con el paquete estándar de Ubuntu (`sudo apt install apache2`); no se modificó la página por defecto.
