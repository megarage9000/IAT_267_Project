#include <Wire.h>                 // Must include Wire library for I2C
#include "SparkFun_MMA8452Q.h"    // Click here to get the library: http://librarymanager/All#SparkFun_MMA8452Q
MMA8452Q accel;                   // create instance of the MMA8452 class

// Set Analog inputs (Any analog inputs)
int forcePin = A0;
int potPin = A1;
int accelPin = -2;
int noInput = -1;

// Initialize sensor values
int inputPin = accelPin;
int inputVal = 0;
int delayTime = 0;


void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  //accelerometer setup
  accel.init();
//  while (accel.begin() == false) {
//    Serial.println("Not Connected. Please check connections and read the hookup guide.");
//    //while (1);
//  } 
}

void loop() {
//  Serial.println(inputPin);
  // put your main code here, to run repeatedly:
//  if(Serial.available() > 0) {
//    String keyToRead = Serial.readString();
//    if(inputPin != noInput) {
//      
//    }
//  }
  //Accelerometer Code
  sendSensorInput();
}

void readSensor(int pin) {
  int returnVal = analogRead(pin);
  Serial.println(returnVal);
  delay(delayTime);
}

void stringToAction(String message) {
  if(message == "potentioSet") {
    inputPin = potPin;
    delayTime = 100;
  }
  else if(message == "forceSet") {
    inputPin = forcePin;
    delayTime = 100;
  }
  else if(message == "accelSet") {
    inputPin = accelPin;
    delayTime = 100;
  }
  else if(message == "reset") {
    inputPin =  noInput;
    delayTime = 100;
  }
  else if(message == "gamePass") {
    // Need to figure out function for calling game pass
    inputPin =  noInput;    
  }
  else if(message == "gameFail") {
     // Need to figure out function for calling game fail
    inputPin =  noInput;  
  }
  else{
    inputPin = noInput;
  }
}

void sendSensorInput() {
  if(inputPin == accelPin) {
    accelerometerRead();
  }
  else {
    int val = analogRead(inputPin);
    Serial.println(val);
    delay(delayTime);
  }
}

void accelerometerRead() {
  if (accel.available()) {      // Wait for new data from accelerometer
    // Orientation of board (Right, Left, Down, Up);
    if (accel.isRight() == true) {
      Serial.println("Right");
    }
    else if (accel.isLeft() == true) {
      Serial.println("Left");
    }
    else if (accel.isUp() == true) {
      Serial.println("Up");
    }
    else if (accel.isDown() == true) {
      Serial.println("Down");
    }
    else if (accel.isFlat() == true) {
      Serial.println("Flat");
    }
  }
  delay(delayTime);
}
