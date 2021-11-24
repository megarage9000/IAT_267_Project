#include <Wire.h>                 // Must include Wire library for I2C
#include "SparkFun_MMA8452Q.h"    // Click here to get the library: http://librarymanager/All#SparkFun_MMA8452Q

MMA8452Q accel;                   // create instance of the MMA8452 class

// Set Analog inputs (Any analog inputs)
int lightPin = A0;
int potPin = A1;
int accelPin = A2;
int noInput = -1;
int pinToRead = noInput;

// Initialize sensor values
int inputVal = 0;

// Need to install Dictionary Library
//Dictionary * inputKeys = new Dictionary();
//inputKeys("forceInput", lightPin);
//inputKeys("potInput", potPin);
//inputKeys("accelPin", accelPin);
//inputKeys("noRead", noInput);
// 

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);

  //accelerometer setup
  if (accel.begin() == false) {
    Serial.println("Not Connected. Please check connections and read the hookup guide.");
    while (1);
  } 
}

void readSensor(int pin, int waitTime = 0) {
  int returnVal = analogRead(pin);
  Serial.println(returnVal);
  delay(waitTime);
}

void loop() {
  // put your main code here, to run repeatedly:
  if(Serial.available() > 0) {
    inputVal = Serial.read();
    if(inputVal != -1) {
      readSensor(inputVal);
    }
  }

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
