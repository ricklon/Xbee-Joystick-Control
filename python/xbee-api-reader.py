"""
Continuously read the serial port and process IO data received from a remote XBee.
"""

from xbee import XBee
import serial


#ser = serial.Serial('/dev/ttyUSB0', 9600)
#ser = serial.Serial('/dev/tty.usbserial-FTT3JNCK', 9600)
ser = serial.Serial('/dev/tty.SLAB_USBtoUART', 9600)

xbee = XBee(ser)

# Continuously read and print packets
while True:
    try:
        response = xbee.wait_read_frame()
        print response
    except KeyboardInterrupt:
        break
        
ser.close()
