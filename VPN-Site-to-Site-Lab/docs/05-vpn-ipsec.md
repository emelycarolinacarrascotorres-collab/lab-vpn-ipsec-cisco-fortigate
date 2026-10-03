# VPN IPsec Site-to-Site

**Qué se configuró.** Un túnel IPsec IKEv1 entre CISCO-SRV (20.25.6.2) y el FortiGate (20.25.97.2) que protege el tráfico entre 10.25.6.0/25 (Usuarios) y 10.25.97.0/28 (Servidor).
**Para qué sirve.** Permite que Usuarios y Servidor se comuniquen a través del ISP con el tráfico cifrado (ESP).

## Parámetros y su correspondencia entre extremos
| Parámetro | CISCO-SRV (config) | FortiGate (captura) | ¿Coincide? |
|---|---|---|---|
| Peer | `set peer 20.25.97.2` | Remote Gateway 20.25.6.2, interfaz port1 | Sí (cruzado) |
| IKE | `isakmp policy 10`, PSK | IKE v1, Main (ID protection), Pre-shared Key | Sí |
| Fase 1 | DES, SHA, DH 14, lifetime 86400 | DES / SHA1, DH 14, lifetime 86400 s | Sí |
| Fase 2 | `esp-des esp-sha-hmac`, modo tunnel, sin PFS | DES / SHA1, PFS desactivado, lifetime 3600 s | Sí (el lifetime de Fase 2 no está en el config Cisco; se asume el valor por defecto de IOS, 3600 s) |
| Selectores | `10.25.6.0/25 → 10.25.97.0/28` (`VPN-TRAFFIC`) | Local 10.25.97.0/28, Remoto 10.25.6.0/25 | Sí (espejo) |
| XAUTH | – | Disabled | – |

Evidencias: [CISCO-SRV_config](../configs/cisco-router-usuarios/CISCO-SRV_config.txt) · [config del túnel en FortiGate](../evidence/vpn/01_config_tunel_ipsec_fortigate.png)

![Config túnel FortiGate](../evidence/vpn/01_config_tunel_ipsec_fortigate.png)

### Propuestas en el FortiGate (GUI, 02/10/2026, hora según el nombre original de cada archivo)
| Fase 1 (22:01:13) | Fase 2 (22:01:30) |
|---|---|
| ![Fase 1](../evidence/vpn/02_fase1_propuesta_fortigate.png) | ![Fase 2](../evidence/vpn/03_fase2_propuesta_fortigate.png) |

Notas de configuración visibles: en Fase 2 «Auto-negotiate» está desmarcado y «Autokey Keep Alive» marcado; «Local/Remote Port» y «Protocol» en All.

El NAT del router excluye el tráfico VPN (`deny` en `NAT-ACL`) y las políticas VPN del FortiGate tienen NAT deshabilitado.

**Resultado.** Configuración VPN en ambos extremos, con Fase 1 y Fase 2 verificadas contra el config de Cisco: **PASS**. El funcionamiento se demuestra en [VPN activa](07-vpn-activa-vs-inactiva.md).
