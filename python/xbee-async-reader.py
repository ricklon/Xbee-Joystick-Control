import serial
import time 
from xbee import XBee

serial_port = serial.Serial("/dev/tty.usbserial-FTT3JNCK", 9600)

"""
This method is called whenever data is received from the associated XBee device. Its first and
only argument is the data contained within the frame. 
""" 

def print_data(data): 
	print data

xbee = XBee(serial_port, callback=print_data) 
while True:
	try: 
		time.sleep(0.001)
	except KeyboardInterrupt:
		break
xbee.halt() 
serial_port.close()
