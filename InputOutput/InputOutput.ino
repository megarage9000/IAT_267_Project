#include <Wire.h>                 // Must include Wire library for I2C
#include <Servo.h>
#include "SparkFun_MMA8452Q.h"    // Click here to get the library: http://librarymanager/All#SparkFun_MMA8452Q

MMA8452Q accel;                   // create instance of the MMA8452 class
Servo ticker;
char trigger;
boolean test;

// analog pins
int potenioPin = A0;
int forcePin = A1;
int servoPin = A2;

// digital
int greenLed = 8;
int redLed =  13;
int buzzer = 12;

// divider
char divider = '|';

// Values
String inputVals = "";

void setup() {
  ticker.attach(servoPin);
  accel.init();
  Serial.begin(9600);
}


void loop() { 
  Serial.flush();
  inputVals = packageInputVals();
  Serial.println(inputVals);
  delay(1000/60);
}

// --- Sensor Input to Processing --- 
String packageInputVals() {
  // sensor values
  String inputPackageVals = "";
  
  // -- Read Accelerometer
  inputPackageVals = accelerometerRead();
  inputPackageVals += divider;
  
  // -- Read Poteniometer
  inputPackageVals += analogRead(potenioPin);
  inputPackageVals += divider;
  
  // -- Read Light / Force Sensor
  inputPackageVals += analogRead(forcePin);
  inputPackageVals += divider;
  
  return inputPackageVals;
}

String accelerometerRead() {
  if (accel.available()) {      // Wait for new data from accelerometer
    // Orientation of board (Right, Left, Down, Up);
    if (accel.isRight() == true) {
      return "Right";
    }
    else if (accel.isLeft() == true) {
      return "Left";
    }
    else if (accel.isUp() == true) {
      return "Up";
    }
    else if (accel.isDown() == true) {
      return "Down";
    }
    else if (accel.isFlat() == true) {
      return "Flat";
    }
    else {
      return "None";
    }
  }
  else {
    return "None";
  }
}

// Calls everytime there is available information from Processing
// https://www.arduino.cc/reference/en/language/functions/communication/serial/serialevent/

const int WIN = 1;
const int LOSE = 0;

void serialEvent() {
  while(Serial.available() > 0) {
    int outputState = Serial.read();
    if(outputState == WIN) {
      win();
    }
    else if(outputState == LOSE){
      lose();
    }
  }
}

// --- Output from Processing to Arduino --- 
const int ROTATION = 180 / 3;
int numRotations = 0;

void output() {
  digitalWrite(greenLed, HIGH);
  delay(500);
  digitalWrite(greenLed, LOW);
  delay(500);
}

void win() {
  digitalWrite(greenLed, HIGH);
  tone(buzzer, 1000);
  delay(500);
  tone(buzzer, 1500);
  digitalWrite(greenLed, LOW);
  tick();
  delay(500);
  noTone(buzzer);
}

void lose() {
  digitalWrite(redLed, HIGH);
  tone(buzzer, 1500);
  delay(500);
  tone(buzzer, 1000);
  digitalWrite(redLed, LOW);
  resetServo();
  delay(500);
  noTone(buzzer);
}

void tick() {
  numRotations++;
  ticker.write(ROTATION * numRotations);
}

void resetServo() {
  ticker.write(-numRotations * ROTATION);
  numRotations = 0;
}
