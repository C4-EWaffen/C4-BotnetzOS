import subprocess

def install_dependencies():
    dependencies = ["apache2", "mysql-server", "python3-pip"]
    for dep in dependencies:
        subprocess.run(["sudo", "apt-get", "install", "-y", dep])

def configure_services():
    subprocess.run(["sudo", "systemctl", "start", "apache2"])
    subprocess.run(["sudo", "systemctl", "start", "mysql"])

def main():
    install_dependencies()
    configure_services()
    print("Installation und Konfiguration abgeschlossen.")

if __name__ == "__main__":
    main()
