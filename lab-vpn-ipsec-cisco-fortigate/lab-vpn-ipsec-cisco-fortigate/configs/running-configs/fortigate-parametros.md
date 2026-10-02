# FortiGate 7.0.9 (VM) - Parámetros de configuración

No se dispone del `show full-configuration` exportado; los valores siguientes se extrajeron de las capturas en `docs/images/`.
**Pendiente (recomendado):** exportar la configuración por CLI, anonimizar y guardarla como `FortiGate.conf` en esta carpeta.

## Interfaces (imagen 02)
| Interfaz | Alias | IP / Máscara | Acceso administrativo |
|---|---|---|---|
| port1 | WAN | 20.25.97.2/255.255.255.252 | PING, HTTPS, SSH, HTTP, FMG-Access |
| port2 | LAN-SERVER | 10.25.97.1/255.255.255.240 | PING, HTTPS |
| port3 | (gestión) | 192.168.99.1/255.255.255.0 | PING, HTTPS, SSH, HTTP |
| port4 | - | sin usar | - |

## Objetos de dirección (imágenes 05 y 06)
| Nombre | Subred |
|---|---|
| USERS.NET | 10.25.6.0/255.255.255.128 |
| SERVER-NET | 10.25.97.0/255.255.255.240 |

## VPN IPsec `VPN-B-to-A` (imagen 07)
| Parámetro | Valor |
|---|---|
| Gateway remoto | 20.25.6.2 (estático), interfaz port1 |
| Autenticación | Pre-shared key `<PSK_VPN>` (debe coincidir con R1) |
| IKE | Versión 1, modo Main (ID protection) |
| Fase 1 | DES-SHA1, DH grupo 14 |
| XAUTH | Deshabilitado |
| Selector Fase 2 | Local 10.25.97.0/28, Remoto 10.25.6.0/25 |

## Rutas estáticas (imagen 03)
| Destino | Gateway | Interfaz |
|---|---|---|
| 10.25.6.0/25 | - | Blackhole |
| 10.25.6.0/25 | 20.25.6.2 | VPN-B-to-A |
| 0.0.0.0/0 | 20.25.97.1 | WAN (port1) |

## Políticas de firewall (imagen 04)
| Nombre | Origen → Destino | Src / Dst | Acción | NAT |
|---|---|---|---|---|
| LAN-to-VPN | port2 → VPN-B-to-A | SERVER-NET / USERS.NET | ACCEPT | Deshabilitado |
| VPN-to-LAN | VPN-B-to-A → port2 | USERS.NET / SERVER-NET | ACCEPT | Deshabilitado |
| LAN-to-WAN | port2 → port1 | all / all | ACCEPT | Habilitado |
| Implicit Deny | any → any | all / all | DENY | - |

Todas con inspección SSL `no-inspection` y log habilitado.
