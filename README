#Xbee Joystick Controled Robot

This project configures a set of Xbees that are plugged into a custom Joystick PCB, and wired on top of a line following Arduino based robot.
The robot project is here: http://ieee.rutgers.edu/content/line-following-kit

The current custom circuit boards for the project are kept in the Fritzing folder. In there there is a Fritzing for the Joystick, list of materials, and example etchable PCB files.

In order to wire the Xbee to the Arduino board you'll need to either use the custom circuit board in the Fritzing file, or you can bread board it on thop of the motor shield.


##Xbee programming for receiver, and sending

Note: This project currently uses Xbee series 1. They work fine and are well documented. 
I recommend using the Xbee Explorer (USB) or the Adafruit Xbee Adapter Kit (FTDI).




The configuration for the reciever Xbee should be:
+++
ATDL407B2C9A,DH0013A200,ID 2001,MY20, WR, CN

The configuraiton for the Joystick sender Xbee should be:
+++
ATDL407E10E6, DH0013A200, ID2001, MY10, D02, D12, D22, IR64, WR, CN

You can check the Xbee configuration with the following:
+++
ATDL, DH, ID, MY, D0, D1, D2, IR, CN


##Xbee robot receiver configuration
The bread boarding step requires the following parts:
Xbee breadboard adapter
4 wires
tiny breadboard

The Xbee adapter is wired in with the following pins:
Xbee --> Arduino
pin 1  -> 3.3v
pin 10 -> ground
pin 2 -> 0
pin 3 -> 1

It's easiest to do the wiring first. Then place the Xbee adapter on the tiny breadboard.


