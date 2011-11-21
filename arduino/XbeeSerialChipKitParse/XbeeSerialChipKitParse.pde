/*
* ChipKit second serial port echo for Xbee
 
 */
#define debugLED 13
int analogValue;

void setup() 
{
  pinMode(debugLED,OUTPUT);
  Serial.begin(9600);
  Serial1.begin(9600);
  Serial.println("Begin Serial Echo");

}

/*
// read the variables that we're not using out of the buffer for (int i = 0; i<18; i++) {
 byte discard = Serial.read();
 } int analogHigh = Serial.read(); int analogLow = Serial.read(); analogValue = analogLow + (analogHigh * 256);
 */


void loop() {
  if (Serial1.available() >= 21) 
  {
    // look for the start byte 
    if (Serial1.read() == 0x7E) {
      //blink debug LED to indicate when data is received 
      digitalWrite(debugLED, HIGH); 
      delay(10); 
      digitalWrite(debugLED, LOW);

      // read the variables that we're not using out of the buffer 
      for (int ii = 0; ii<=11; ii++) {
        byte discard = Serial1.read();
      } 
      
      for (int ii = 12; ii < 22; ii += 2)
     { 
      int analogHigh = Serial1.read(); 
      int analogLow = Serial1.read(); 
      analogValue = analogLow + (analogHigh * 256);
      Serial.print("PN:");
      Serial.print(ii);
      Serial.print(" ");
      Serial.println(analogValue );
      delay(250);
     }
    }
  }


}


