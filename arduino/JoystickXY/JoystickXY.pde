int xPin = 9;    // LED connected to digital pin 9
int yPin = 11;   // LED connected to digital pin 11

int photoPin = 0;
int xPot = 1;
int yPot = 2;

int photoVal = -1;
int xx, yy = -1;
int minmax, ymax, xmax = 0;

void setup() {
  Serial.begin(9600);
  Serial.println("Start");
  
  pinMode(xPin, OUTPUT);     
  pinMode(yPin, OUTPUT);     
  digitalWrite(xPin, HIGH);
  digitalWrite(yPin, HIGH);

  digitalWrite(xPin, LOW);
  delay(500);
  xmax = analogRead(photoPin);
  digitalWrite(xPin, HIGH);

  digitalWrite(yPin, LOW);
  delay(500);
  ymax = analogRead(photoPin);
  digitalWrite(yPin, HIGH);
  
   sendMax();
   minmax = min(xmax, ymax);
   setXY(255, 255);
}

void setXY(int xx, int yy) 
{
  xx = map(xx, 0, minmax, 255, 0);
  yy = map(yy, 0, minmax,  255, 0);
  
  //For some reason some values were mapping negative
  constrain(xx, 0, 255);
  constrain(yy, 0, 255);
  
  analogWrite(xPin, xx);
  analogWrite(yPin, yy);
  sendXY(xx, yy);
}

void sendXY(int xx, int yy) 
{
      Serial.print(" { \"xx\" : ");
      Serial.print(xx);
      Serial.print(", \"yy\" : ");
      Serial.print(yy);
      Serial.println("}");
}

void sendMax()
{

    Serial.print(" { \"xmax\" : ");
    Serial.print(xmax);
    Serial.print(", \"ymax\" : ");
    Serial.print(ymax);
    Serial.println("}");
}



void loop() 
{
  xx = analogRead(xPot);
  yy = analogRead(yPot);
  setXY(xx, yy);
  
}
