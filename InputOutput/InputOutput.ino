

// Set Analog inputs (Any analog inputs)
int lightPin = A0;
int potPin = A1;

// Initialize sensor values
int lightVal = 0;
int potVal = 0;

// For packaging purposes, set up "dividers"
char lightDivider = 'a';
char potDivider = 'b';

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void packageAndSend(int val, char divider, int waitTime=0) {
  Serial.print(divider);
  Serial.print(val);
  Serial.print(divider);
  Serial.println(); 
  delay(waitTime);
}

void loop() {
  // put your main code here, to run repeatedly:
  lightVal = analogRead(A0);
  potVal = analogRead(A1);

  packageAndSend(lightVal, lightDivider);
  packageAndSend(potVal, potDivider);
  delay(1000);
}
