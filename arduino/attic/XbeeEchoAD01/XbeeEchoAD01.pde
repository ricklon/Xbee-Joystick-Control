/* XBee message reader Context: Arduino
 */
const int packetLength = 22;	// XBee data messages will be 22 bytes long 
int dataPacket[packetLength]; //arraytoholdtheXBeedata 
int byteCounter = 0;	// counter for bytes received from the XBee
void setup() 
{ 
  // start serial communications: 
  Serial.begin(9600);
  Serial1.begin(9600);
}

void loop() 
{ 
  // listen for incoming serial data: 
  if (Serial1.available() > 0) 
  {
    listenToSerial();
  }
}

void listenToSerial() 
{ 
  // read incoming byte: 
  int inByte = Serial1.read();
  int byte_cnt = 0;
  int decval= 0;

  // beginning of a new packet is 0x7E: 
  if (inByte == 0x7E ) 
  {
    dataPacket[0]= inByte; 
    for (byte_cnt = 1; byte_cnt < 22; byte_cnt++)
    {
       while (Serial1.available() == 0)
      {
      } 
      dataPacket[byte_cnt] = Serial1.read();
    }
    Serial.print("VertY Dec: ");
    decval = dataPacket[11] *256 + dataPacket[12]; 
    Serial.print(decval); 
    Serial.print(" ");
    Serial.print("HorX Dec: ");
    decval = dataPacket[13] *256 + dataPacket[14]; 
    Serial.print(decval); 
    Serial.println();
  }
  
}



