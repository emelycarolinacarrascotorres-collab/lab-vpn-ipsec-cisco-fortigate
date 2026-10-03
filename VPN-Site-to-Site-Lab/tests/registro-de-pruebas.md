# Registro de pruebas realizadas

| ID | Prueba | Condición | Resultado observado | Evidencia |
|---|---|---|---|---|
| T1 | `show ip` en PC1 | DHCP | 10.25.6.10/25, GW 10.25.6.1, DNS 8.8.8.8 | [captura](../evidence/cisco-usuarios/01_PC1_show_ip_dhcp.png) |
| T2 | Estado del túnel | VPN activa | Fase 1 ↑ / Fase 2 ↑ | [captura](../evidence/vpn-activa/01_estado_tunel_activo_fortigate.png) |
| T2b | Propuestas IPsec del FortiGate | Configuración | Fase 1: DES/SHA1/DH14/86400 s. Fase 2: DES/SHA1, PFS off, 3600 s | [Fase 1](../evidence/vpn/02_fase1_propuesta_fortigate.png), [Fase 2](../evidence/vpn/03_fase2_propuesta_fortigate.png) |
| T2c | Monitor IPsec tras reiniciar estadísticas | VPN activa | Fase 1 ↑ / Fase 2 ↑, 0 B / 0 B | [captura](../evidence/vpn-activa/04_monitor_ipsec_tunel_activo_estadisticas_en_0.png) |
| T3 | `ping 10.25.97.2` desde PC1 | VPN activa | 5/5 respuestas, ttl=62 | [captura](../evidence/vpn-activa/02_ping_PC1_a_servidor_exitoso.png) |
| T4 | Captura Wireshark | VPN activa | ESP 20.25.6.2 ⇄ 20.25.97.2 | [captura](../evidence/vpn-activa/03_wireshark_trafico_ESP_cifrado.png) |
| T5 | Navegador a 10.25.97.2 | VPN no indicada | Página Apache2 «It works!» | [captura](../evidence/web-server/01_prueba_1_navegador_apache_10.25.97.2.png) |
| T6 | Navegador con `https://10.25.97.2/` | VPN no indicada | URL escrita; sin carga HTTPS confirmada | [captura](../evidence/web-server/02_prueba_2_navegador_barra_https.png) |
| T7 | Estado del túnel | VPN inactiva | Fase 1 ↑ / Fase 2 ↓ | [captura](../evidence/vpn-inactiva/01_estado_tunel_inactivo_fortigate.png) |
| T8 | `ping 10.25.97.2` desde PC1 | VPN inactiva | 5/5 timeout | [captura](../evidence/vpn-inactiva/02_ping_PC1_a_servidor_timeout.png) |
| T9 | `trace 10.25.97.2` desde PC1 | VPN activa (inferido: llega al servidor) | 3 saltos: 10.25.6.1, `* * *`, 10.25.97.2 (35.191 ms) | [captura](../evidence/vpn-activa/05_traceroute_PC1_a_servidor.png) |
