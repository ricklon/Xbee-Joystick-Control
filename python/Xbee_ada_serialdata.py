"""
Adafruit example from Tweet a watt code Continuously read the serial port and process IO data received from a remote XBee.
"""
from xbee import XBee
import serial

SERIALPORT = "/dev/tty.usbserial-FTT3JNCK"    # the com/serial port the XBee is connected to
BAUDRATE = 9600      # the baud rate we talk to the xbee

# open up the FTDI serial port to get data transmitted to xbee
ser = serial.Serial(SERIALPORT, BAUDRATE)
ser.open()

while True:
    # grab one packet from the xbee, or timeout
    packet = xbee.find_packet(ser)
    if packet:
        xb = xbee(packet)

        print xb

