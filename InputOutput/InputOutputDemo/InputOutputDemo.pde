

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

void draw() {
  background(204, 255, 204);
  
 
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
  
  fill(circleA);
  circle(circleRadius, circleRadius, circleRadius);
  
  fill(circleB);
  circle(width/2, height/2, circleRadius);
  
  fill(circleC);
  circle(width - circleRadius, height - circleRadius, circleRadius);
}

void keyPressed() {
  if(key == 'a') {
    win();
  }
  else if(key == 'd') {
    lose();
  }
}

void setCircleAColour(String direction) {
  if(direction.equals("None")) {
    circleA = 163;
  }
  else if(direction.equals("Left")) {
    circleA = 25;
  }
  else if(direction.equals("Right")) {
    circleA = 100;
  }
  else if(direction.equals("Up")) {
    circleA = 50;
  }
  else if(direction.equals("Down")) {
    circleA = 125;
  }
  else if(direction.equals("Flat")) {
    circleA = 200;
  }
}
