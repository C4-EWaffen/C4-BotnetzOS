-- Tabelle für die Geräte
CREATE TABLE Devices (
    device_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    ip_address TEXT NOT NULL,
    hostname TEXT,
    username TEXT,
    password TEXT, -- Erwäge die Speicherung verschlüsselter Passwörter
    vpn_address TEXT,
    type TEXT CHECK(type IN ('Server', 'VPN_Server', 'Agent', 'Subnet_Device')) NOT NULL,
    status TEXT CHECK(status IN ('Aktiv', 'Inaktiv')) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabelle für die Agenten Netzwerke
CREATE TABLE Agent_Networks (
    agent_network_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    vpn_server_id INTEGER,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (vpn_server_id) REFERENCES Devices(device_id)
);

-- Tabelle für die Befehle
CREATE TABLE Commands (
    command_id INTEGER PRIMARY KEY AUTOINCREMENT,
    command_text TEXT NOT NULL,
    server_id INTEGER,
    agent_network_id INTEGER,
    executed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (server_id) REFERENCES Devices(device_id),
    FOREIGN KEY (agent_network_id) REFERENCES Agent_Networks(agent_network_id)
);

-- Tabelle für die Ausgabe der Befehle
CREATE TABLE Outputs (
    output_id INTEGER PRIMARY KEY AUTOINCREMENT,
    command_id INTEGER,
    output_text TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (command_id) REFERENCES Commands(command_id)
);

-- Tabelle für die CVEs
CREATE TABLE CVEs (
    cve_id INTEGER PRIMARY KEY AUTOINCREMENT,
    cve_code TEXT NOT NULL,
    description TEXT NOT NULL,
    severity TEXT CHECK(severity IN ('Critical', 'High', 'Medium', 'Low')) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Verknüpfungstabelle für CVEs und Geräte
CREATE TABLE CVE_Devices (
    cve_id INTEGER,
    device_id INTEGER,
    FOREIGN KEY (cve_id) REFERENCES CVEs(cve_id),
    FOREIGN KEY (device_id) REFERENCES Devices(device_id),
    PRIMARY KEY (cve_id, device_id)
);

-- Tabelle für die Netzwerkscans
CREATE TABLE Network_Scans (
    scan_id INTEGER PRIMARY KEY AUTOINCREMENT,
    ip_address TEXT NOT NULL,
    hostname TEXT,
    mac_address TEXT,
    is_gateway BOOLEAN,
    is_online BOOLEAN,
    open_ports TEXT,  -- z.B. "22,80,443"
    scan_time DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabelle für die Subnetze
CREATE TABLE Subnets (
    subnet_id INTEGER PRIMARY KEY AUTOINCREMENT,
    ip_range TEXT NOT NULL,  -- z.B. "192.168.2.0/24"
    network_address TEXT,
    broadcast_address TEXT,
    smallest_host TEXT,
    largest_host TEXT,
    total_hosts INTEGER,
    free_hosts INTEGER,
    used_hosts INTEGER,
    scan_time DATETIME DEFAULT CURRENT_TIMESTAMP
);

