# Matriz de cumplimiento de requisitos

Estados: **PASS**, **FAIL**, **PARTIAL**, **NOT EVIDENCED**; asignados solo con base en lo entregado.

| # | Requisito | Evidencia | Archivo(s) | Estado | Nota |
|---|---|---|---|---|---|
| 1 | FortiGate – configuración de red | Interfaces, objetos, rutas | [interfaces](../evidence/fortigate/01_interfaces_fortigate.png), [rutas](../evidence/fortigate/03_rutas_estaticas.png), [SERVER-NET](../evidence/fortigate/04_objeto_direccion_SERVER-NET.png), [USERS.NET](../evidence/fortigate/05_objeto_direccion_USERS.NET.png) | PASS | Solo vistas GUI |
| 2 | FortiGate – NAT | Política LAN-to-WAN con NAT Enabled | [políticas](../evidence/fortigate/02_politicas_firewall.png) | PARTIAL | 0 B de tráfico; sin prueba funcional |
| 3 | FortiGate – VPN Site-to-Site | Configuración y estado del túnel | [config](../evidence/vpn/01_config_tunel_ipsec_fortigate.png), [activo](../evidence/vpn-activa/01_estado_tunel_activo_fortigate.png), [F1](../evidence/vpn/02_fase1_propuesta_fortigate.png), [F2](../evidence/vpn/03_fase2_propuesta_fortigate.png) | PASS | Fase 1 y Fase 2 verificadas ([F1](../evidence/vpn/02_fase1_propuesta_fortigate.png), [F2](../evidence/vpn/03_fase2_propuesta_fortigate.png)) |
| 4 | Segundo equipo – configuración de red | CISCO-SRV + SW-1 | [router](../configs/cisco-router-usuarios/CISCO-SRV_config.txt), [switch](../configs/cisco-switch-usuarios/SW-1_config.txt) | PASS | Scripts, no `show run` |
| 5 | Segundo equipo – NAT | `NAT-ACL` + overload | [router](../configs/cisco-router-usuarios/CISCO-SRV_config.txt) | PARTIAL | Sin `show ip nat translations` |
| 6 | Segundo equipo – VPN Site-to-Site | Crypto map CMAP; peer arriba en FortiGate; ESP | [router](../configs/cisco-router-usuarios/CISCO-SRV_config.txt), [ESP](../evidence/vpn-activa/03_wireshark_trafico_ESP_cifrado.png) | PASS | Sin `show crypto isakmp/ipsec sa` |
| 7 | ISP con IP públicas | 20.25.6.1/30 y 20.25.97.1/30 | [ISP](../configs/isp/ISP_config.txt) | PASS | Ver observaciones en AUDIT |
| 8 | Web Server /28 | 10.25.97.2/28, gw 10.25.97.1 | [server](../configs/web-server/web-server_config.txt), [interfaces](../evidence/fortigate/01_interfaces_fortigate.png) | PASS | Direccionamiento |
| 8b | Web Server HTTPS | Páginas Apache | [prueba 1](../evidence/web-server/01_prueba_1_navegador_apache_10.25.97.2.png), [prueba 2](../evidence/web-server/02_prueba_2_navegador_barra_https.png) | PARTIAL | Sin prueba de TLS |
| 9 | Usuarios /25, VLAN 10, DHCP | PC1 10.25.6.10/25 por DHCP | [PC1](../evidence/cisco-usuarios/01_PC1_show_ip_dhcp.png), [router](../configs/cisco-router-usuarios/CISCO-SRV_config.txt), [switch](../configs/cisco-switch-usuarios/SW-1_config.txt) | PASS | |
| 10 | Traceroute hacia el servidor | `trace` de PC1: 10.25.6.1 → `* * *` → 10.25.97.2 | [captura](../evidence/vpn-activa/05_traceroute_PC1_a_servidor.png) | PASS | Sin hora ni estado de la VPN en la captura; sin traceroute con VPN inactiva |
| 11 | Comunicación con VPN activa | Ping 5/5, túnel ↑, ESP | [carpeta](../evidence/vpn-activa/) | PASS | ICMP; HTTPS no probado desde Usuarios |
| 12 | Sin comunicación con VPN inactiva | Fase 2 ↓, ping timeout | [carpeta](../evidence/vpn-inactiva/) | PARTIAL | Método de apagado no documentado |
| 13 | Running-configs | Bloques de comandos Cisco/servidor | [configs](../configs/) | PARTIAL | Sin salidas `show running-config`; FortiGate sin CLI |
| 14 | Scripts utilizados | Bloques CLI en configs | [scripts/README](../scripts/README.md) | PARTIAL | Sin scripts independientes |
| 15 | Imágenes | 15 capturas | [evidence](../evidence/INDEX.md) | PASS | |
| 16 | Diagramas | SVG propio + captura GNS3 | [diagrama](../diagrams/network-topology.svg) | PASS | |
| 17 | Documentación del propósito | README y docs | [README](../README.md) | PASS | |
| 18 | Video demostrativo | – | [videos](../videos/LEEME.md) | NOT EVIDENCED | No entregado |
| 19 | FortiGate: configuración y demostración por GUI | Todas las capturas del FortiGate son de la interfaz web | [fortigate](../evidence/fortigate/), [vpn](../evidence/vpn/) | PASS | El `diagnose sniffer` de `web-server_config.txt` es CLI y no se usa como evidencia |

## Requisitos del repositorio

| Requisito | Estado | Detalle |
|---|---|---|
| Crear un repositorio de GitHub | PENDIENTE | Lo crea la autora; guía en [09-publicar-en-github.md](09-publicar-en-github.md) |
| Documentación profesional | PASS | [README](../README.md) y `docs/` |
| Video al principio del repositorio | NOT EVIDENCED | Espacio reservado al inicio del README; video no entregado |
| Documentación con imágenes | PASS | 18 capturas incrustadas |
| Documentación con diagramas | PASS | [diagrama SVG](../diagrams/network-topology.svg) |
| Propósito del laboratorio | PASS | [README](../README.md) |
| Scripts utilizados | PARTIAL | Bloques CLI en [configs/](../configs/) |
| Running-configs | PARTIAL | Scripts de configuración; sin salidas `show running-config` |
