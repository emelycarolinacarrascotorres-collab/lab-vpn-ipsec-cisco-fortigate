# Tabla de direccionamiento

Fuente: únicamente las configuraciones y capturas entregadas. Donde un dato no aparece en la evidencia se indica `N/D` (no disponible).

| Dispositivo | Interfaz | IP | Máscara / prefijo | Gateway | Función | Evidencia |
|---|---|---|---|---|---|---|
| ISP | g1/0 | 20.25.6.1 | /30 (255.255.255.252) | N/D | Enlace hacia CISCO-SRV («HACIA-CISCO-USR») | [ISP_config](../configs/isp/ISP_config.txt) |
| ISP | g2/0 | 20.25.97.1 | /30 | N/D | Enlace hacia FortiGate («HACIA-FORTIGATE») | [ISP_config](../configs/isp/ISP_config.txt) |
| ISP | g3/0 | DHCP | N/D | 192.168.42.1 (ruta estática por defecto) | Salida a Internet, NAT outside | [ISP_config](../configs/isp/ISP_config.txt) |
| CISCO-SRV (R1) | g1/0 | 20.25.6.2 | /30 | 20.25.6.1 | WAN-ISP, extremo VPN, NAT outside | [CISCO-SRV_config](../configs/cisco-router-usuarios/CISCO-SRV_config.txt) |
| CISCO-SRV (R1) | g2/0.10 (dot1Q 10) | 10.25.6.1 | /25 (255.255.255.128) | N/D | Gateway VLAN 10 y servidor DHCP, NAT inside | [CISCO-SRV_config](../configs/cisco-router-usuarios/CISCO-SRV_config.txt) |
| SW-1 | Gi0/0 | – | trunk, VLAN 10 permitida | – | Enlace hacia el router | [SW-1_config](../configs/cisco-switch-usuarios/SW-1_config.txt) |
| SW-1 | Gi0/1 | – | acceso VLAN 10 | – | Puerto de PC1 | [SW-1_config](../configs/cisco-switch-usuarios/SW-1_config.txt) |
| PC1 (VPCS) | – | 10.25.6.10 (DHCP) | /25 | 10.25.6.1 | Usuario; DNS 8.8.8.8; servidor DHCP 10.25.6.1 | [captura](../evidence/cisco-usuarios/01_PC1_show_ip_dhcp.png) |
| FortiGate | port1 (WAN) | 20.25.97.2 | /30 (255.255.255.252) | 20.25.97.1 (ruta 0.0.0.0/0) | WAN, extremo VPN | [interfaces](../evidence/fortigate/01_interfaces_fortigate.png), [rutas](../evidence/fortigate/03_rutas_estaticas.png) |
| FortiGate | port2 (LAN-SERVER) | 10.25.97.1 | /28 (255.255.255.240) | – | Gateway del servidor | [interfaces](../evidence/fortigate/01_interfaces_fortigate.png) |
| FortiGate | port3 | 192.168.99.1 | /24 (255.255.255.0) | N/D | Gestión (PING/HTTPS/SSH/HTTP) | [interfaces](../evidence/fortigate/01_interfaces_fortigate.png) |
| FortiGate | port4 | 0.0.0.0 | 0.0.0.0 | – | Sin configurar (estado rojo) | [interfaces](../evidence/fortigate/01_interfaces_fortigate.png) |
| FortiGate | VPN-B-to-A | N/D | – | 20.25.6.2 (ruta 10.25.6.0/25) | Interfaz de túnel IPsec | [rutas](../evidence/fortigate/03_rutas_estaticas.png) |
| web-server-lab-1 | eth0 | 10.25.97.2 | /28 | 10.25.97.1 | Servidor web Apache2 | [web-server_config](../configs/web-server/web-server_config.txt) |

## Redes

| Red | Prefijo | Uso | Evidencia |
|---|---|---|---|
| 20.25.6.0 | /30 | Enlace público ISP ⇄ CISCO-SRV | ISP_config, CISCO-SRV_config |
| 20.25.97.0 | /30 | Enlace público ISP ⇄ FortiGate | ISP_config, interfaces FortiGate |
| 10.25.6.0 | /25 | VLAN 10 Usuarios (objeto `USERS.NET`) | [captura](../evidence/fortigate/05_objeto_direccion_USERS.NET.png) |
| 10.25.97.0 | /28 | Red del servidor (objeto `SERVER-NET`) | [captura](../evidence/fortigate/04_objeto_direccion_SERVER-NET.png) |
| 192.168.99.0 | /24 | Gestión del FortiGate | interfaces FortiGate |

## DHCP (CISCO-SRV, pool `USUARIOS`)

- Red 10.25.6.0/25, default-router 10.25.6.1, DNS 8.8.8.8.
- Excluidas: 10.25.6.1–10.25.6.9 y 10.25.6.101–10.25.6.126 → rango entregable 10.25.6.10–10.25.6.100.
- Resultado real: PC1 recibió 10.25.6.10/25 (primera dirección libre del rango), lease 86400 s.
