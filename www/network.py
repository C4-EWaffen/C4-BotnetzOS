import os
import socket
import subprocess
import re

def get_ip_info():
    # Linux: ip a
    # Windows: ipconfig /all
    try:
        result = subprocess.check_output(['ip', 'a']).decode()
        ip_info = re.findall(r'inet\s+(\d+\.\d+\.\d+\.\d+)', result)
        return ip_info
    except Exception as e:
        print(f"Fehler beim Abrufen der IP-Informationen: {e}")
        return []

def get_network_info(ip):
    # Zum Beispiel IP: 192.168.2.3/24
    network_prefix = ip.rsplit('.', 1)[0] + '.'
    return f"{network_prefix}0/24"

def perform_scan(ip_range):
    # Dummy-Funktion für Port-Scan
    print(f"Scanne IP-Bereich: {ip_range}")

def main():
    ip_addresses = get_ip_info()
    if ip_addresses:
        for ip in ip_addresses:
            print(f"Gefundene IP: {ip}")
            network_info = get_network_info(ip)
            perform_scan(network_info)

if __name__ == "__main__":
    main()
