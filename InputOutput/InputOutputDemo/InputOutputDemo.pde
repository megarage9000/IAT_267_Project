

void setup() {
  initializeSerial();
  size(1024, 720);
  background(204, 255, 204);
  frameRate(120);
}

float circleA = 0;
float circleB = 0;
float circleC = 0;
float circleRadius = 50;
boolean readMode = false;

void draw() {
  background(204, 255, 204);
  
  if(readMode == false) {
    String accelVal = getAccelerometer();
    float potentioVal = getPotentiometer();
    float forceVal = getForceSensor();
    
    if(accelVal != ERR_ACCEL) {
      println("Accelerometer = " + accelVal);
      setCircleAColour(accelVal);
    }
    if(potentioVal != ERR_ANALOG) {
      println("Poteniometer = " + str(potentioVal));
      circleB = map(potentioVal, 0, 1023, 0, 255);  
      circleRadius = map(potentioVal, 0, 1023, 50, 100);
    }
    if(forceVal != ERR_ANALOG) {
      println("Force Sensor = " + str(forceVal));
      circleC = map(forceVal, 200, 700, 0, 255); 
    }
    outputToPort('0');
  }
  else {
    outputToPort('1');
  }
  
  fill(circleA);
  circle(circleRadius, circleRadius, circleRadius);
  
  fill(circleB);
  circle(width/2, height/2, circleRadius);
  
  fill(circleC);
  circle(width - circleRadius, height - circleRadius, circleRadius);
}

void keyPressed() {
  if(key == 'a'){
     readMode = !readMode;
  }
}


void setCircleAColour(String direction) {
  if(direction == "None") {
    circleA = 0;
  }
  else if(direction == "Left") {
    circleA = 0;
  }
  else if(direction == "Right") {
    circleA = 100;
  }
  else if(direction == "Up") {
    circleA = 50;
  }
  else if(direction == "Down") {
    circleA = 125;
  }
  else if(direction == "Flat") {
    circleA = 200;
  }
}
