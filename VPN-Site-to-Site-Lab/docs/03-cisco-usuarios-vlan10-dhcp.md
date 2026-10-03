# Cisco: router CISCO-SRV, switch SW-1 y red de Usuarios (VLAN 10, /25, DHCP)

## Router CISCO-SRV (aparece como «R1» en GNS3)
**Qué se configuró.** Router de la sede de Usuarios: WAN hacia el ISP, subinterfaz VLAN 10, DHCP, NAT y extremo IPsec.
**Evidencia.** [CISCO-SRV_config.txt](../configs/cisco-router-usuarios/CISCO-SRV_config.txt) (conservado tal cual).

| Función | Configuración real |
|---|---|
| WAN | g1/0 `20.25.6.2/30`, ruta por defecto vía 20.25.6.1 |
| VLAN 10 | `g2/0.10`, `encapsulation dot1Q 10`, `10.25.6.1/25` |
| DHCP | pool `USUARIOS` 10.25.6.0/25, gateway 10.25.6.1, DNS 8.8.8.8, exclusiones .1–.9 y .101–.126 |
| NAT | ACL `NAT-ACL`: `deny` 10.25.6.0/25 → 10.25.97.0/28 (excluye el tráfico VPN), `permit` el resto; `overload` en g1/0 (outside); g2/0.10 inside |
| VPN | Ver [05-vpn-ipsec.md](05-vpn-ipsec.md) |

## Switch SW-1
**Evidencia.** [SW-1_config.txt](../configs/cisco-switch-usuarios/SW-1_config.txt): `vlan 10`; Gi0/1 en modo acceso VLAN 10 (hacia PC1); Gi0/0 trunk dot1q con VLAN 10 permitida (hacia el router).

## PC1 – resultado DHCP
![PC1 show ip](../evidence/cisco-usuarios/01_PC1_show_ip_dhcp.png)

PC1 muestra IP/MASK `10.25.6.10/25`, GATEWAY `10.25.6.1`, DNS `8.8.8.8`, DHCP SERVER `10.25.6.1`. **Resultado: PASS** para «Usuarios /25, VLAN 10, DHCP».

**NAT del router:** solo hay configuración; no se entregó `show ip nat translations`, por lo que el requisito queda **PARTIAL**.
