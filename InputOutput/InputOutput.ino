#include <Wire.h>                 // Must include Wire library for I2C
#include "SparkFun_MMA8452Q.h"    // Click here to get the library: http://librarymanager/All#SparkFun_MMA8452Q

MMA8452Q accel;                   // create instance of the MMA8452 class

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

  //accelerometer setup
  if (accel.begin() == false) {
    Serial.println("Not Connected. Please check connections and read the hookup guide.");
    while (1);
  }
  
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

  //Accelerometer Code
//  if (accel.available()) {      // Wait for new data from accelerometer
//    // Orientation of board (Right, Left, Down, Up);
//    if (accel.isRight() == true) {
//      Serial.println("Right");
//    }
//    else if (accel.isLeft() == true) {
//      Serial.println("Left");
//    }
//    else if (accel.isUp() == true) {
//      Serial.println("Up");
//    }
//    else if (accel.isDown() == true) {
//      Serial.println("Down");
//    }
//    else if (accel.isFlat() == true) {
//      Serial.println("Flat");
//    }
//  }
//  delay(100);
}
