import ipaddress
import socket
import os
import sqlite3
import subprocess

def get_local_ip():
    # Automatische Ermittlung der lokalen IP-Adresse
    hostname = socket.gethostname()
    local_ip = socket.gethostbyname(hostname)
    return local_ip

def subnet_calculations(ip):
    # Subnetz Berechnungen
    ip_network = ipaddress.IPv4Network(ip, strict=False)
    subnet_info = {
        'network_address': str(ip_network.network_address),
        'broadcast_address': str(ip_network.broadcast_address),
        'smallest_host': str(ip_network[1]),
        'largest_host': str(ip_network[-2]),
        'total_hosts': ip_network.num_addresses - 2
    }
    return subnet_info

def scan_network(ip_range):
    # Ping-Scan im Subnetz
    result = subprocess.run(['nmap', '-sn', ip_range], stdout=subprocess.PIPE)
    return result.stdout.decode()

# Beispielnutzung:
local_ip = get_local_ip()
print(f"Lokale IP-Adresse: {local_ip}")

subnet_info = subnet_calculations(f'{local_ip}/24')
print("Subnetz-Informationen:", subnet_info)

scan_result = scan_network(f'{subnet_info["network_address"]}/24')
print("Netzwerk Scan Resultate:", scan_result)

def get_public_ip():
    # Ermittlung der öffentlichen IP-Adresse
    public_ip = socket.gethostbyname('example.com')
    return public_ip

public_ip = get_public_ip()
print(f"Öffentliche IP-Adresse: {public_ip}")

def create_db():
    conn = sqlite3.connect('network_data.db')
    cursor = conn.cursor()

    # Tabelle für Netzwerk-Scans erstellen
    cursor.execute('''CREATE TABLE IF NOT EXISTS Network_Scans (
                        scan_id INTEGER PRIMARY KEY AUTOINCREMENT,
                        ip_address TEXT NOT NULL,
                        hostname TEXT,
                        mac_address TEXT,
                        is_gateway BOOLEAN,
                        is_online BOOLEAN,
                        open_ports TEXT,
                        scan_time DATETIME DEFAULT CURRENT_TIMESTAMP
                      )''')

    # Tabelle für Subnetze erstellen
    cursor.execute('''CREATE TABLE IF NOT EXISTS Subnets (
                        subnet_id INTEGER PRIMARY KEY AUTOINCREMENT,
                        ip_range TEXT NOT NULL,
                        network_address TEXT,
                        broadcast_address TEXT,
                        smallest_host TEXT,
                        largest_host TEXT,
                        total_hosts INTEGER,
                        free_hosts INTEGER,
                        used_hosts INTEGER,
                        scan_time DATETIME DEFAULT CURRENT_TIMESTAMP
                      )''')

    conn.commit()
    conn.close()

create_db()


def save_subnet_info(subnet_info):
    conn = sqlite3.connect('network_data.db')
    cursor = conn.cursor()

    cursor.execute('''INSERT INTO Subnets (ip_range, network_address, broadcast_address, smallest_host, largest_host, total_hosts)
                      VALUES (?, ?, ?, ?, ?, ?)''',
                   (subnet_info['network_address'], subnet_info['network_address'],
                    subnet_info['broadcast_address'], subnet_info['smallest_host'],
                    subnet_info['largest_host'], subnet_info['total_hosts']))

    conn.commit()
    conn.close()

save_subnet_info(subnet_info)

def cve_scan(ip):
    # Hier könnte ein CVE-Scan durchgeführt werden
    # z.B. durch OpenVAS oder Nessus
    pass

