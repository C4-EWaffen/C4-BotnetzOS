import serial
import time

# Verbindung zum ESP8266 herstellen
ser = serial.Serial('/dev/ttyUSB0', 115200)  # Passen Sie den Port und die Baudrate an

def send_command(command):
    ser.write(command.encode())
    time.sleep(1)
    response = ser.read_all().decode()
    return response

if __name__ == "__main__":
    response = send_command("AT+GMR")  # Beispiel-Befehl
    print("ESP8266 Antwort:", response)
