/* XBee message reader Context: Arduino
 */
const int packetLength = 22;	// XBee data messages will be 22 bytes long 
int dataPacket[packetLength]; //arraytoholdtheXBeedata 
int byteCounter = 0;	// counter for bytes received from the XBee

struct Position {
  int    xx;
  int    yy;
  boolean dirty;
};

void setup() 
{ 
  // start serial communications: 
  Serial.begin(9600);
  Serial1.begin(9600);
}

void loop() 
{ 
  struct Position xxyy = 
  {
    0 , 0 , true   
  };
  getJoystickData(xxyy);
  if (xxyy.dirty == false)
  {
  Serial.print("HorX: ");
  Serial.println(xxyy.xx);
  Serial.print("VerY: ");
  Serial.println(xxyy.yy);
  }
}

void getJoystickData( struct Position& xxyy) 
{ 
  int inByte;
  // read incoming byte: 
  int byte_cnt = 0;

  xxyy.dirty = true;
  while (Serial1.available() > 0)
  {

    inByte = Serial1.read();


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
      //-Serial.print("VertY Dec: ");
      xxyy.xx = dataPacket[11] *256 + dataPacket[12]; 
      //-Serial.print(xxyy.xx); 
      //-Serial.print(" ");
      //-Serial.print("HorX Dec: ");
      xxyy.yy = dataPacket[13] *256 + dataPacket[14]; 
      //-Serial.print(xxyy.yy); 
      //-Serial.println();
      xxyy.dirty = false;
    }
  }

}



