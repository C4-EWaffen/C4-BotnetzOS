import tkinter as tk
from tkinter import messagebox
import subprocess

def start_service(service_name):
    try:
        subprocess.run(["sudo", "systemctl", "start", service_name])
        messagebox.showinfo("Erfolg", f"{service_name} wurde gestartet.")
    except Exception as e:
        messagebox.showerror("Fehler", f"Fehler beim Starten von {service_name}: {e}")

def stop_service(service_name):
    try:
        subprocess.run(["sudo", "systemctl", "stop", service_name])
        messagebox.showinfo("Erfolg", f"{service_name} wurde gestoppt.")
    except Exception as e:
        messagebox.showerror("Fehler", f"Fehler beim Stoppen von {service_name}: {e}")

def main():
    root = tk.Tk()
    root.title("C4-Server Admin")
    root.configure(bg="#202020")

    header = tk.Frame(root, bg="#333333", padx=20, pady=10)
    header.pack(fill="x")
    logo = tk.Label(header, text="C4-Server", fg="#1A73E8", bg="#333333", font=("Arial", 24))
    logo.pack()

    nav = tk.Frame(root, bg="#1A73E8", padx=10, pady=10)
    nav.pack(fill="x")
    tk.Button(nav, text="Start Webserver", command=lambda: start_service("apache2"), bg="#1A73E8", fg="white").pack(side="left", padx=10)
    tk.Button(nav, text="Stop Webserver", command=lambda: stop_service("apache2"), bg="#1A73E8", fg="white").pack(side="left", padx=10)
    tk.Button(nav, text="Start Database", command=lambda: start_service("mysql"), bg="#1A73E8", fg="white").pack(side="left", padx=10)
    tk.Button(nav, text="Stop Database", command=lambda: stop_service("mysql"), bg="#1A73E8", fg="white").pack(side="left", padx=10)

    content = tk.Frame(root, bg="#2D2D2D", padx=20, pady=20)
    content.pack(expand=True, fill="both")

    status_label = tk.Label(content, text="Status: OK", bg="#2D2D2D", fg="white", font=("Arial", 14))
    status_label.pack()

    root.mainloop()

if __name__ == "__main__":
    main()
