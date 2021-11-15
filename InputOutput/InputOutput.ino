

int lightPin = A0;
int potPin = A1;

int lightVal = 0;
int potVal = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  lightVal = analogRead(A0);
  potVal = analogRead(A1);

  Serial.print("light val: ");
  Serial.println(lightVal);
  Serial.print("potentio val: ");
  Serial.println(potVal);
  delay(1000);
}
