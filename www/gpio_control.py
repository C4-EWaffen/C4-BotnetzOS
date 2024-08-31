import RPi.GPIO as GPIO
import time

# Setup
GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)

# Definieren Sie die GPIO-Nummer für das Relais
RELAY_PIN = 18
GPIO.setup(RELAY_PIN, GPIO.OUT)

def activate_relay():
    GPIO.output(RELAY_PIN, GPIO.HIGH)
    time.sleep(5)
    GPIO.output(RELAY_PIN, GPIO.LOW)

if __name__ == "__main__":
    activate_relay()
    GPIO.cleanup()
