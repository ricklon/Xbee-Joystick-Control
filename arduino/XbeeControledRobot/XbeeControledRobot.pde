
#define motor1Dir 7
#define motor2Dir 8
#define motor1PWM 9
#define motor2PWM 10
#define motor1Enable 11
#define motor2Enable 12

const int packetLength = 22;	// XBee data messages will be 22 bytes long 
int dataPacket[packetLength]; //arraytoholdtheXBeedata 
int byteCounter = 0;	// counter for bytes received from the XBee

struct Position {
  int    xx;
  int    yy;
  boolean dirty;
};

int xx;
int yy;

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
  Serial.print("Set Left: ");
  Serial.println(velocity);
  setMotorVel(motor1Dir, motor1PWM, -velocity);

}

void setRightMotorSpeed(int velocity)
{
  Serial.print("Set Right: ");
  Serial.println(velocity);
  setMotorVel(motor2Dir, motor2PWM, -velocity);
}




void goBack()
{
  Serial.println("Go Forward!");
  setLeftMotorSpeed(-255);
  setRightMotorSpeed(-255);
}

void goForward()
{
  Serial.println("Go Forward!");
  setLeftMotorSpeed(255);
  setRightMotorSpeed(255);
}

void goRight()
{
  Serial.println("Go Right!");
  setLeftMotorSpeed(255);
  setRightMotorSpeed(-255);
}

void goLeft()
{
  Serial.println("Go Left!");
  setLeftMotorSpeed(-255);
  setRightMotorSpeed(255);
}

void stop()
{
  Serial.println("Stop.");
  setLeftMotorSpeed(0);
  setRightMotorSpeed(0);
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


void setup()
{
  // start serial communications: 
  Serial.begin(9600);
  Serial1.begin(9600);

  // prints title with ending line break
  /*
  Serial.println("Line Sensor boar Sensor test");
   Serial.println("Enter to show sensor value: 0=Sensor0, 1=Sensor1, 2=Sensor2, 3=Sensor3, 4=Sensor4, 5=Sensor5");
   Serial.println("Enter to move: s= stop, f = forward, r = right, l = left");
   */
  initMotorDriver();
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
    xx = map(xxyy.xx, 0, 1023, -2, 4);
    yy = map(xxyy.yy, 0, 1023, -2, 4);
 

    Serial.print("HorX: ");
    Serial.println(xx);
    Serial.print(" : ");
    Serial.println(xxyy.xx);
    Serial.print(" VerY: ");
    Serial.println(yy);
    Serial.print(" : ");
    Serial.println(xxyy.yy);
    
    Serial.print ("setRightMotorSpeed: ");
    Serial.print (map(xx, -2,4, -255,255)); 
     Serial.print(" setLeftMotorSpeed: ");
     Serial.println(map(yy,-2, 4, -255, 255)); 
    
    //setRightMotorSpeed(0); 
    //setLeftMotorSpeed(0); 
  }
}



