# ISP

**Qué se configuró.** Router Cisco que simula el proveedor: dos enlaces /30 con IP públicas hacia cada sitio y una salida a Internet con NAT overload.
**Para qué sirve.** Interconecta CISCO-SRV (20.25.6.2) y FortiGate (20.25.97.2) para que el túnel IPsec se establezca sobre una red «pública».
**Qué se hizo** (según [ISP_config.txt](../configs/isp/ISP_config.txt)):

| Elemento | Valor |
|---|---|
| Hostname / acceso | `ISP`, SSH v2, usuario `Admin`, dominio `redlocal.com` |
| g1/0 | 20.25.6.1/30 – `HACIA-CISCO-USR` – `ip nat inside` |
| g2/0 | 20.25.97.1/30 – `HACIA-FORTIGATE` – `ip nat inside` |
| g3/0 | `hacia el internet`, `ip dhcp`, `ip nat outside` |
| Ruta | `ip route 0.0.0.0 0.0.0.0 192.168.42.1` |
| NAT | ACL `NAT_ACL` (permit 20.25.97.0/30 y 20.25.6.0/30) → `overload` en g3/0 |

**Evidencia.** Solo el archivo de configuración; no se entregó `show ip interface brief` ni `show ip nat translations`. La conectividad entre ambos sitios se corrobora indirectamente con el tráfico ESP entre 20.25.6.2 y 20.25.97.2 ([Wireshark](../evidence/vpn-activa/03_wireshark_trafico_ESP_cifrado.png)).
**Resultado.** Configuración de IP públicas: **PASS**. Observaciones sobre `ip dhcp` y `no shutdown` en [AUDIT.md](../AUDIT.md).
