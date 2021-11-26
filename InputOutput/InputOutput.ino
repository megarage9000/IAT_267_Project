#include <Wire.h>                 // Must include Wire library for I2C
#include <Servo.h>
#include "SparkFun_MMA8452Q.h"    // Click here to get the library: http://librarymanager/All#SparkFun_MMA8452Q

MMA8452Q accel;                   // create instance of the MMA8452 class
Servo ticker;

// analog pins
int potenioPin = A0;
int forcePin = A1;
int servoPin = A2;

// divider
char divider = '|';

void setup() {
  ticker.attach(servoPin);
  accel.init();
  Serial.begin(9600);
}


void loop() { 
  if(Serial.available()) {
    Serial.println(Serial.readString());
  }
  else {
    String inputVals = packageInputVals();
    Serial.println(inputVals);
    delay(100);
  }
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
