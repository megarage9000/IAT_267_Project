#include <Wire.h>                 // Must include Wire library for I2C
#include <Servo.h>
#include "SparkFun_MMA8452Q.h"    // Click here to get the library: http://librarymanager/All#SparkFun_MMA8452Q

MMA8452Q accel;                   // create instance of the MMA8452 class
Servo ticker;
char trigger;

// analog pins
int potenioPin = A0;
int forcePin = A1;
int servoPin = A2;

// digital
int greenLed = 8;

// divider
char divider = '|';

void setup() {
  ticker.attach(servoPin);
  accel.init();
  Serial.begin(9600);
}


void loop() { 
  if(Serial.available()) {
    trigger = Serial.read();
    Serial.flush();
  }
  if(trigger == '1'){
    output();
    trigger = '0';
  }
  if (trigger == '0'){
    String inputVals = packageInputVals();
    Serial.println(inputVals);
  }

  Serial.println(trigger);
}

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
  return inputPackageVals;
}

void output() {
  digitalWrite(greenLed, HIGH);
  delay(500);
  digitalWrite(greenLed, LOW);
  delay(500);
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
    //delay(100);
  }
  else {
    return "None";
  }
}
