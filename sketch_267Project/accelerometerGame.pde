

class AccelerometerGame {
  PVector vel;
  PVector bugPos;
  String orientation = "a";
  
  AccelerometerGame(){
    bugPos = new PVector(0,0);
    vel = new PVector(0,0);
  }
  
  void gameplay(){
    //Background
    background(accelerometerBackground);
    
    //Bug
    render();
    accelerate();
    update();
    
    //Goal box
    fill(0,0);
    rect(windowWidth/2-28, windowHeight/2-60, 192,120);
    
    //Check if game is passed
    if(goalCheck()) currGame++;
    
    println(up);
  }
  
  void update(){
    bugPos.add(vel);
  }
  
  void render(){
    pushMatrix();
    translate(bugPos.x, bugPos.y);
    image(bugImg, -bugImg.width/2, -bugImg.height/2);
    popMatrix(); 
  }
  
  void accelerate(){
    //Check port for input
    
   
    //accelOrientation = myPort.readStringUntil('\n');
    //if(accelOrientation != null) orientation = accelOrientation;
    //orientation = trim(orientation);
    
    // --- Using Acceleromter Sensor Values --- 
    accelOrientation = getAccelerometer();
    if(accelOrientation != ERR_ACCEL) {
      orientation = accelOrientation;
    }
    
    if     (orientation.equals("Down"))   {vel.x = 0; vel.y = -1.5;}
    else if(orientation.equals("Up"))     {vel.x = 0; vel.y = 1.5;}
    else if(orientation.equals("Left"))   {vel.x = -1.5; vel.y = 0;}
    else if(orientation.equals("Right"))  {vel.x = 1.5; vel.y = 0;}
    else    {vel.x = 0; vel.y = 0;};
    
    //Temporary
    if(up){vel.x = 0; vel.y = -1.5;}
    if(down){vel.x = 0; vel.y = 1.5;}
    if(left){vel.x = -1.5; vel.y = 0;}
    if(right){vel.x = 1.5; vel.y = 0;}
    
  }
  
  //Crude check will be replaced by better measurement later
  boolean goalCheck(){
    if(bugPos.x > 672 && bugPos.x <864 &&
       bugPos.y > 340 && bugPos.y <460) return true;
    else return false;
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
  
