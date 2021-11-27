

class AccelerometerGame {
  //Movement
  PVector vel;
  PVector bugPos;
  PVector upForce =new PVector(0, -0.75);
  PVector downForce =new PVector(0, 0.75);
  PVector leftForce =new PVector(-0.75, 0);
  PVector rightForce =new PVector(0.75, 0);
  String orientation = "a";
  color bc = color(0,0);
  float damp = 0.8;
  
  //Timer
  boolean start;
  int timeLimit = 10000;
  int currTime;
  int passedTime;
  int timeLeft = 60;
  
  AccelerometerGame(){
    bugPos = new PVector(0,0);
    vel = new PVector(0,0);
  }
  
  void gameplay(){
    //Background
    background(accelerometerBackground);
    
    //Timer
    if(!start) {
      startTimer();
      start = true;
    }
    textSize(100);
    text(timeLeft-passedTime/1000, 400,100);
    
    //Goal box
    fill(bc);
    rect(windowWidth/2-28, windowHeight/2-60, 192,120);
    
    //Bug
    render();
    accelerate();
    update();
    
    //Check if game is passed
    if(goalCheck()){
      bc = color(255,0,0);
      myPort.write('1');
    }else{
      bc = color(0,0,0);
      myPort.write('0');
    }
    
    //Check if game failed
    if(passedTime < timeLimit) passedTime = millis() - currTime;
    if(passedTime > timeLimit){
      
       //currTime = millis();
       //println("run");
     }
     
     //println(passedTime/1000);
    
  }
  
  void update(){
    bugPos.add(vel);
    vel.mult(damp);
  }
  
  void render(){
    pushMatrix();
    translate(bugPos.x, bugPos.y);
    image(bugImg, -bugImg.width/2, -bugImg.height/2);
    popMatrix(); 
  }
  
  //void accelerate(){
  //  vel.a
  //}
  
  void accelerate(){
    //Check port for input
    if(myPort.available()>0){
    accelOrientation = myPort.readStringUntil('\n');
    println(accelOrientation);
    }
    //println(myPort.readStringUntil('\n'));
    if(accelOrientation != null) {
      orientation = accelOrientation;
      orientation = trim(orientation);
    }
    
    
    if(orientation.equals("Down")) vel.add(upForce);
    if(orientation.equals("Up"))   vel.add(downForce);
    if(orientation.equals("Left"))   vel.add(leftForce);
    if(orientation.equals("Right"))  vel.add(rightForce);
    
    //Temporary
    if(up) vel.add(upForce);
    if(down) vel.add(downForce);
    if(left) vel.add(leftForce);
    if(right) vel.add(rightForce);
  }
  
  //Crude check will be replaced by better measurement later
  boolean goalCheck(){
    if(bugPos.x > 672 && bugPos.x <864 &&
       bugPos.y > 340 && bugPos.y <460) return true;
    else return false;
  }
  
  void startTimer(){
    currTime = millis();
  }
  
  //Call when player passes game
  void advanceGame(){
    start = false;  //Reset Timer
    currGame++;
    
  }
  
  //Call when player loses game
  void failGame(){
    start = false;  //Reset Timer
  }
  
}

//TEMPORARY KEYBOARD MOVEMENT
boolean up, down, left ,right;

void keyPressed(){
  if(key == 'W' || key == 'w') up = true;
  if(key == 'S' || key == 's') down = true;
  if(key == 'A' || key == 'a') left = true;
  if(key == 'D' || key == 'd') right = true;
}

void keyReleased(){
  if(key == 'W' || key == 'w') up = false;
  if(key == 'S' || key == 's') down = false;
  if(key == 'A' || key == 'a') left = false;
  if(key == 'D' || key == 'd') right = false;
}
  
