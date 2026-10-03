# AUDIT – Revisión crítica (perfil de profesor exigente)

Alcance: solo lo entregado (4 configs y 15 capturas). No se inventan soluciones ni resultados; los puntos son observaciones para revisar.

## 1. Correctamente evidenciado
- Direccionamiento coherente en toda la ruta: ISP 20.25.6.1/30 ⇄ CISCO-SRV 20.25.6.2/30; ISP 20.25.97.1/30 ⇄ FortiGate 20.25.97.2/30; FortiGate 10.25.97.1/28 ⇄ servidor 10.25.97.2/28 (gw 10.25.97.1).
- Usuarios: VLAN 10 en SW-1 y subinterfaz dot1Q 10 en el router; PC1 recibió 10.25.6.10/25 con gateway/DHCP 10.25.6.1, dentro del rango no excluido del pool.
- VPN: peers cruzados correctamente (20.25.6.2 / 20.25.97.2), IKEv1 DES-SHA1 DH14 con PSK en ambos lados, selectores espejo (10.25.6.0/25 ⇄ 10.25.97.0/28). Los objetos `USERS.NET` y `SERVER-NET` coinciden con esas redes.
- NAT excluye el tráfico VPN en el router (`deny` en `NAT-ACL`) y las políticas VPN del FortiGate tienen NAT deshabilitado.
- Fase 1 y Fase 2 del FortiGate verificadas por GUI contra el Cisco: DES/SHA1, DH 14, lifetime 86400 s (Fase 1), sin PFS y 3600 s (Fase 2) frente a `esp-des esp-sha-hmac`.
- Traceroute de PC1 hacia 10.25.97.2 llega al servidor sin mostrar el ISP, coherente con el túnel y con el ttl=62 del ping.
- Contraste de escenarios: ping 5/5 con Fase 2 ↑ frente a 5/5 timeout con Fase 2 ↓; ESP visible en Wireshark.

## 2. Requisitos sin evidencia o con evidencia insuficiente
| Requisito | Qué falta |
|---|---|
| Traceroute con VPN inactiva | No hay captura; el traceroute entregado es solo del escenario activo |
| Video demostrativo | No entregado (NOT EVIDENCED) |
| HTTPS | Certificado/aviso TLS, carga confirmada con `https://`, configuración SSL de Apache |
| VPN inactiva | Cómo y dónde se apagó la VPN; capturas con hora que enlacen estado y ping |
| Running-configs | Salidas reales de `show running-config` (Cisco) y `show full-configuration` (FortiGate) |
| NAT (ambos equipos) | `show ip nat translations` y sesiones NAT; la política LAN-to-WAN muestra 0 B |
| VPN en Cisco | `show crypto isakmp sa` / `show crypto ipsec sa` |

## 3. Inconsistencias y puntos que generarían dudas
| # | Severidad | Hallazgo |
|---|---|---|
| 1 | Alta | `config_server.txt` contiene `diagnose sniffer packet any 'host 10.25.5.13 and port 443'`: es un comando de FortiOS, no de Linux, y 10.25.5.13 no existe en el laboratorio (PC1 es 10.25.6.10). |
| 2 | Alta | Las pruebas web se hicieron desde un navegador en Windows (barra de tareas visible), pero PC1 es un VPCS que no puede abrir un navegador y ese equipo no está en la topología. No se prueba que el acceso web pasara por la VPN. |
| 3 | Alta | «Prueba 2 HTTPS» solo muestra `https://10.25.97.2/` escrito en la barra con el desplegable abierto; la página de fondo es la anterior. Aparece «No seguro» y no hay certificado. Las pruebas no indican el estado de la VPN. |
| 4 | Media | Config del ISP: `interface g3/0` usa `ip dhcp` (el comando válido es `ip address dhcp`) y no tiene `no shutdown`; además hay ruta fija a 192.168.42.1 junto con DHCP. |
| 5 | Media | Los archivos de configuración incluyen líneas como `===== LAN: VLAN 10 =====` y `--- NAT ... ---` sin `!`, que IOS rechazaría si se pegan tal cual; no son salidas de `show run`. El archivo del servidor empieza con `config server`. |
| 6 | Media | «VPN apagada» muestra Fase 1 ↑ y solo Fase 2 ↓. Los contadores son incoherentes con una única captura continua: incoming sube (38.26 → 39.10 kB) y outgoing queda en 37.66 kB. El orden temporal no está documentado. |
| 7 | Media | Historial del navegador (Prueba 2) con `10.6.97.2`, `10.6.97.129` y `http://1092.168.99.1`: direcciones distintas a las del laboratorio, probablemente errores de tipeo o pruebas previas; un revisor puede preguntarlo. |
| 8 | Media | Nombres: hostname `CISCO-SRV` (equipo de Usuarios) vs «R1» en GNS3 vs «HACIA-CISCO-USR» en el ISP. Objetos `USERS.NET` (punto) vs `SERVER-NET` (guion). Túnel `VPN-B-to-A`. |
| 9 | Media | Seguridad en las capturas: HTTP habilitado (marcado en rojo) en WAN y port3; SSH/HTTPS/FMG-Access en la WAN; DES, SHA-1 y DH14 son algoritmos antiguos (consistentes en ambos extremos). |
| 10 | Media | Credenciales en texto plano en los configs (`Cisco@2025`, PSK `Lab@2025-0697`) y nombre/matrícula en el banner. **Recomendación: revisar antes de publicar el repositorio o hacerlo privado.** Los archivos se conservaron sin modificar. |
| 11 | Baja | Topología GNS3: sin rótulos de interfaz/IP y sin el enlace del ISP g3/0 hacia Internet. La correspondencia g2/0 ⇄ Gi0/0 se deduce de las configs. |
| 12 | Baja | Rutas FortiGate: dos rutas a 10.25.6.0/25 (Blackhole y túnel) sin distancia/prioridad visible; el gateway del túnel es la IP pública del peer (20.25.6.2). Que el blackhole descarte el tráfico con el túnel caído es una interpretación, no una evidencia. |
| 13 | Baja | Interfaces: la captura está recortada (6 interfaces indicadas, 4 visibles); port4 sin IP. LAN-to-VPN en 0 B puede ser coherente con tráfico iniciado solo desde Usuarios (las respuestas pertenecen a la sesión original); conviene confirmarlo. |
| 14 | Baja | Wireshark: no se indica interfaz capturada ni filtro; solo 4 paquetes ESP visibles, más una fila ajena a la VPN (protocolo Loop). El ping exitoso, el estado del túnel y Wireshark no llevan hora común. |
| 15 | Baja | Nueva captura del Monitor IPsec (22:02:10) con 0 B / 0 B y túnel arriba: confirma que se usó «Reset Statistics», lo que podría explicar contadores distintos entre capturas, pero no demuestra el orden de las anteriores. El lifetime de Fase 2 (3600 s) no figura en el config Cisco; se asume el valor por defecto de IOS. |
| 16 | Baja | Traceroute: la captura no muestra hora ni estado de la VPN (se infiere por llegar al servidor). El comando visible es `tracer 10.25.97.2` (abreviatura aceptada por VPCS). El salto 2 es `* * *` y en el salto 3 solo responde una sonda. La respuesta ICMP «port unreachable» es normal para el destino. |

## 4. Conclusión
Las pruebas respaldan de forma consistente el direccionamiento, la VPN y el contraste ping activo/inactivo. Queda sin evidencia el video, y débiles HTTPS, NAT, los running-configs y la demostración de «VPN inactiva». Nada de lo anterior fue corregido ni completado: se documenta lo que existe.
