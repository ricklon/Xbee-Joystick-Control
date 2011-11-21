/*
* ChipKit second serial port echo for Xbee

*/
void setup() 
{
  Serial.begin(9600);
  Serial1.begin(9600);
  Serial.println("Begin Serial Echo");

}

void loop() {
  if (Serial1.available() > 0) 
  {
    Serial.print(Serial1.read() );
  }

  
}
