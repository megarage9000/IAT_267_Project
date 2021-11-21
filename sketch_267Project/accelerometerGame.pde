

class AccelerometerGame {
  PVector pos, vel;
  PVector bugPos;
  
  AccelerometerGame(){
    pos = new PVector(700,400);
    bugPos = new PVector(500,500);
  }
  
  void gameplay(){
    //Background
    background(accelerometerBackground);
    
    //Bug
    render();
    update();
    move();
    
    //Goal box
    fill(0,0);
    rect(windowWidth/2-28, windowHeight/2-60, 192,120);
    
    //Check if game is passed
    //if(goalCheck()) currGame++;
  }
  
  void update(){
    accelerate();
  }
  
  void render(){
    pushMatrix();
    translate(pos.x, pos.y);
    image(bugImg, -bugImg.width/2, -bugImg.height/2);
    popMatrix(); 
  }
  
  void move(){
    pos.add(vel);
  }
  
  void accelerate(){
        //Check port for input
    accelOrientation = myPort.readStringUntil('\n');
    print(accelOrientation);
    if(accelOrientation == "UP") vel.add(new PVector (0, -1));
    delay(200);
  }
  
  boolean goalCheck(){
    int left = (int)bugPos.x - bugImg.width/2;
    int right = (int)bugPos.x + bugImg.width/2;
    int top = (int)bugPos.y - bugImg.height/2;
    int bot = (int)bugPos.y + bugImg.height/2;
    if(mouseX >= left && mouseX <= right &&
       mouseY >= top && mouseY <= bot) return true;
    else return false;
  }
  
  
  
}
