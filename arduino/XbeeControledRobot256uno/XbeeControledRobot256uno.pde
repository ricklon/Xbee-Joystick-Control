
#define motor1Dir 7
#define motor2Dir 8
#define motor1PWM 9
#define motor2PWM 10
#define motor1Enable 11
#define motor2Enable 12

#define DEADZONE 25

const int packetLength = 22;	// XBee data messages will be 22 bytes long 
int dataPacket[packetLength]; //arraytoholdtheXBeedata 
int byteCounter = 0;	// counter for bytes received from the XBee

struct Position {
  int    xx;
  int    yy;
  boolean dirty;
};

int rl; //right left motion
int fb; //forwad back motion

void initMotorDriver()
{
  pinMode(motor1Dir, OUTPUT);
  pinMode(motor2Dir, OUTPUT);

  pinMode(motor1Enable, OUTPUT);
  pinMode(motor2Enable, OUTPUT);
  digitalWrite(motor1Enable,HIGH);
  digitalWrite(motor2Enable,HIGH);
  setLeftMotorSpeed(0); // make sure the motors are stopped
  setRightMotorSpeed(0);
}



void setMotorVel(int dirPin, int pwmPin, int velocity)
{
  if (velocity >= 255) velocity = 255;
  if (velocity <= -255) velocity = -255;

  if (velocity == 0)
  {
    digitalWrite(dirPin, HIGH);
    digitalWrite(pwmPin, HIGH);
  }
  else if(velocity <0){ // Reverse
    digitalWrite(dirPin, HIGH);
    analogWrite(pwmPin, 255+velocity);
  }
  else if(velocity >0){ // Forward
    digitalWrite(dirPin,LOW);
    analogWrite(pwmPin, velocity);
  }

}


void setLeftMotorSpeed(int velocity)
{
  //Serial.print("Set Left: ");
  //Serial.println(velocity);
  setMotorVel(motor1Dir, motor1PWM, -velocity);

}

void setRightMotorSpeed(int velocity)
{
  //Serial.print("Set Right: ");
  //Serial.println(velocity);
  setMotorVel(motor2Dir, motor2PWM, -velocity);
}

void getJoystickData( struct Position& xxyy) 
{ 
  int inByte;
  // read incoming byte: 
  int byte_cnt = 0;

  xxyy.dirty = true;
  while (Serial.available() > 0)
  {

    inByte = Serial.read();


    // beginning of a new packet is 0x7E: 
    if (inByte == 0x7E ) 
    {
      dataPacket[0]= inByte; 
      for (byte_cnt = 1; byte_cnt < 22; byte_cnt++)
      {
        while (Serial.available() == 0)
        {
        } 
        dataPacket[byte_cnt] = Serial.read();
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


void setup()
{
  // start serial communications: 
  Serial.begin(9600);
  //Serial1.begin(9600);

  // prints title with ending line break
  /*
  Serial.println("Line Sensor boar Sensor test");
   Serial.println("Enter to show sensor value: 0=Sensor0, 1=Sensor1, 2=Sensor2, 3=Sensor3, 4=Sensor4, 5=Sensor5");
   Serial.println("Enter to move: s= stop, f = forward, r = right, l = left");
   */
  initMotorDriver();
  
    
  setRightMotorSpeed(255); 
  setLeftMotorSpeed(-255);
  delay(500);
  setRightMotorSpeed(-255); 
  setLeftMotorSpeed(255);
  delay(500);
  setRightMotorSpeed(0); 
  setLeftMotorSpeed(0); 
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

    //calibrate the range so the resting position is 0 movement
    fb = map(xxyy.xx + 43, 0, 1023, -255, 255) ;
    rl = map(xxyy.yy + 43, 0, 1023, -255, 255) ;
    
    //horizontal band
    //Check if in fb deadzone
    if (rl < DEADZONE && rl > -DEADZONE) 
    {
      //Check if in rl deadzone
      if (fb < DEADZONE && fb > -DEADZONE)
      {
        setRightMotorSpeed(0); 
        setLeftMotorSpeed(0);
      }
      else //Go forward or back
      {
        Serial.println("Full Forward or Back");
        setRightMotorSpeed(fb); 
        setLeftMotorSpeed(fb);
        delay(100);
      }
    }
    else
    {
      Serial.println("Else condition"); 
      if(rl>DEADZONE)
      {
        if (fb > DEADZONE)
        {
          setRightMotorSpeed(fb); 
          setLeftMotorSpeed(0); 
        }
        if  (fb < -DEADZONE)
        {
          setRightMotorSpeed(0); 
          setLeftMotorSpeed(fb); 
        }
      }
      else
      {
        if (fb > DEADZONE)
        {
          setRightMotorSpeed(fb); 
          setLeftMotorSpeed(0); 
        }
        if  (fb < -DEADZONE)
        {
          setRightMotorSpeed(0); 
          setLeftMotorSpeed(fb); 
        }
      }        
      if (fb < DEADZONE && fb > -DEADZONE)
      {
        setRightMotorSpeed(rl); 
        setLeftMotorSpeed(-rl); 
       }
    
    }
   
 

    Serial.print("fbX: ");
    Serial.print(fb);
    Serial.print(" : ");
    Serial.print(xxyy.xx);
    Serial.print(" rlY: ");
    Serial.print(rl);
    Serial.print(" : ");
    Serial.println(xxyy.yy);
 /*   
    Serial.print ("setRightMotorSpeed: ");
    Serial.print (map(xx, -2,4, -255,255)); 
     Serial.print(" setLeftMotorSpeed: ");
     Serial.println(map(yy,-2, 4, -255, 255)); 
    */

    delay(10);
  }
}



