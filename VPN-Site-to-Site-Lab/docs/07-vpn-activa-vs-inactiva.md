# Comparativa: VPN ACTIVA vs VPN INACTIVA

Mismo origen (PC1, 10.25.6.10) y mismo destino (servidor 10.25.97.2) en ambos escenarios.

## VPN ACTIVA
| # | Evidencia | Qué demuestra |
|---|---|---|
| 1 | [Estado del túnel](../evidence/vpn-activa/01_estado_tunel_activo_fortigate.png) | `VPN-B-to-A`, remoto 20.25.6.2: Fase 1 ↑ y Fase 2 ↑ (verde). Incoming 38.26 kB / Outgoing 37.66 kB |
| 2 | [Ping PC1 → servidor](../evidence/vpn-activa/02_ping_PC1_a_servidor_exitoso.png) | 5/5 respuestas desde 10.25.97.2, ttl=62, 35–71 ms |
| 3 | [Wireshark](../evidence/vpn-activa/03_wireshark_trafico_ESP_cifrado.png) | Paquetes ESP entre 20.25.6.2 y 20.25.97.2 (SPI 0xb24b846a / 0x33bc4aa8): el tráfico viaja cifrado por el ISP |
| 4 | [Políticas FortiGate](../evidence/fortigate/02_politicas_firewall.png) | VPN-to-LAN con 46.57 kB acumulados |
| 5 | [Pruebas web](06-web-server.md) | Página Apache del servidor (estado de la VPN no visible en las capturas) |
| 6 | [Monitor IPsec con estadísticas en 0](../evidence/vpn-activa/04_monitor_ipsec_tunel_activo_estadisticas_en_0.png) | `VPN-B-to-A` con Fase 1 ↑ y Fase 2 ↑ e Incoming/Outgoing en 0 B (22:02:10, 02/10/2026): se reinició el contador y el túnel siguió arriba |
| 7 | [Traceroute PC1 → servidor](../evidence/vpn-activa/05_traceroute_PC1_a_servidor.png) | Salto 1: 10.25.6.1 (≈10–13 ms); salto 2: `* * *`; salto 3: 10.25.97.2 (35.191 ms, ICMP type 3 code 3, «Destination port unreachable») |

![Túnel activo](../evidence/vpn-activa/01_estado_tunel_activo_fortigate.png)
![Ping exitoso](../evidence/vpn-activa/02_ping_PC1_a_servidor_exitoso.png)
![ESP](../evidence/vpn-activa/03_wireshark_trafico_ESP_cifrado.png)
![Traceroute](../evidence/vpn-activa/05_traceroute_PC1_a_servidor.png)

*Interpretación (no es evidencia directa):* un ttl=62 y el traceroute son coherentes con dos saltos de capa 3 para el paquete interno (CISCO-SRV y FortiGate); el ISP no aparece porque solo procesa el paquete ESP externo. El salto 2 sin respuesta (`* * *`) es compatible con que el FortiGate no conteste cuando el TTL expira en él, pero la captura no lo demuestra. El «port unreachable» del salto 3 es la respuesta normal del servidor a la sonda UDP de `trace` y confirma que el paquete llegó.

## VPN INACTIVA
| # | Evidencia | Qué demuestra |
|---|---|---|
| 1 | [Estado del túnel](../evidence/vpn-inactiva/01_estado_tunel_inactivo_fortigate.png) | `VPN-B-to-A`: Fase 1 ↑ pero **Fase 2 ↓** (rojo). Incoming 39.10 kB / Outgoing 37.66 kB |
| 2 | [Ping PC1 → servidor](../evidence/vpn-inactiva/02_ping_PC1_a_servidor_timeout.png) | 5/5 `timeout` hacia 10.25.97.2 |

![Túnel inactivo](../evidence/vpn-inactiva/01_estado_tunel_inactivo_fortigate.png)
![Ping timeout](../evidence/vpn-inactiva/02_ping_PC1_a_servidor_timeout.png)

## Comparación
| | VPN activa | VPN inactiva |
|---|---|---|
| Fase 1 / Fase 2 | ↑ / ↑ | ↑ / ↓ |
| `ping 10.25.97.2` desde PC1 | 5/5 respuestas | 5/5 timeout |

**Resultado.** Activa: **PASS**. Inactiva: **PARTIAL**: el comportamiento se observa, pero no se documenta cómo se apagó la VPN, qué equipo se tocó ni la hora de cada captura. Traceroute con VPN activa: **PASS** (llega al servidor). No hay traceroute con la VPN inactiva.
