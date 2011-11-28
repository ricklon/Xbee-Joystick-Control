/*
* Xbee interactive serial terminal
 */
char str[20]; 

void setup() 
{
  Serial.begin(9600);
  Serial1.begin(9600);
  Serial.println("Begin Serial Echo");


}

void loop() {
  int ii = 0;
  boolean keepgoing = true;
  Serial.print("xbee> ");
  while(keepgoing)
  {
    while(Serial.available())
    {
      str[ii] = Serial.read();
      //Echo the character as you type
      Serial.write(str[ii]);
      if (str[ii] == 0x0d )
      {
        keepgoing = false;
      }
      ii++;
    }
  }
  str[ii] =0;
  Serial.println();
  //local echo
  //Serial.println(str);
  send2Xbee(str);
  
  delay(10);

}

void send2Xbee(char* str)
{
  Serial.print("send2Xbee:");
  Serial.println(str);
    delay(10);
   
  Serial1.print(str);
    delay(10);
 while (Serial1.available() > 0) 
   {
   Serial.print(Serial1.read() );
   }
 Serial.println();
}
