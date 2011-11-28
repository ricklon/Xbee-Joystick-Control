// Arduino Language Reference
// http://arduino.cc/en/Reference/HomePage

#define motor1Dir 7
#define motor2Dir 8
#define motor1PWM 9
#define motor2PWM 10
#define motor1Enable 11
#define motor2Enable 12



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



int testSensor(int sensor){
      //grab adc value
     int val = analogRead(sensor);
     Serial.print("Reading Sensor: ");
     Serial.print(sensor);
     Serial.print(": ");
     Serial.println(val);
     return val;
}


void setup(){
  Serial.begin(115200); //Set the buad rate for the serial com.

  // prints title with ending line break
  Serial.println("Line Sensor boar Sensor test");
  Serial.println("Enter to show sensor value: 0=Sensor0, 1=Sensor1, 2=Sensor2, 3=Sensor3, 4=Sensor4, 5=Sensor5");
  Serial.println("Enter to move: s= stop, f = forward, r = right, l = left");
  initMotorDriver();
}

void loop()
{ 
     for (int i = -256; i < 256; i++)
     {
        setRightMotorSpeed(i); 
       delay(50);
       Serial.print("Motor Speed Right: ");
       Serial.println(i);
     }
      setRightMotorSpeed(0); 
     
      for (int i = -256; i < 256; i++)
     {
        setLeftMotorSpeed(i); 
       delay(50);
       Serial.print("Motor Speed Left: ");
       Serial.println(i);
     }
      setLeftMotorSpeed(0); 
}

