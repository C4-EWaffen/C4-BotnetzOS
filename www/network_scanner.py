import os
import socket
import subprocess
import re
import ipaddress

def get_ip_info():
    try:
        result = subprocess.check_output(['ip', 'a']).decode()
        ip_info = re.findall(r'inet\s+(\d+\.\d+\.\d+\.\d+)', result)
        return ip_info
    except Exception as e:
        print(f"Fehler beim Abrufen der IP-Informationen: {e}")
        return []

def get_network_info(ip):
    net = ipaddress.ip_network(ip, strict=False)
    return net.network_address, net.broadcast_address, net.num_addresses

def perform_scan(ip_range):
    print(f"Scanne IP-Bereich: {ip_range}")
    # Hier könnte ein Netzwerk-Scan mit nmap oder ähnlichem erfolgen

def main():
    ip_addresses = get_ip_info()
    if ip_addresses:
        for ip in ip_addresses:
            print(f"Gefundene IP: {ip}")
            network_address, broadcast_address, num_addresses = get_network_info(f"{ip}/24")
            print(f"Netzwerkadresse: {network_address}")
            print(f"Broadcast-Adresse: {broadcast_address}")
            print(f"Anzahl der möglichen IP-Adressen: {num_addresses}")
            perform_scan(f"{network_address}/24")

if __name__ == "__main__":
    main()
