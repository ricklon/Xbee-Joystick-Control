void setup() {
  Serial.begin(9600);
  Serial.println("Begin Serial Echo");

}

void loop() {
  if (Serial.available() > 0) {
    Serial.print(Serial.read() );
  }
  
}
