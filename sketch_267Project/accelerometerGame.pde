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
  
  //Buttons
  Button redButton;
  Button greenButton;
  Button blueButton;
  
  //Random answer sequence
  int sequenceCounter = 0;
  color[] colorSequence = new color[3];
  int[] numCSequence = new int[3];
  boolean answers[] = new boolean[3];
  int currAnswer = 0;
  

  
  AccelerometerGame(){
    //Bug vectors
    bugPos = new PVector(0,0);
    vel = new PVector(0,0);
    
    //Generate unique answer set  1=Red 2=Green 3=Blue
    for(int i = 0; i<3; i++){
      int generator = (int)random(1,3);
      numCSequence[i] = generator;
      if(generator == 1) colorSequence[i] = color(255,0,0);
      else if(generator == 2) colorSequence[i] = color(0,255,0);
      else if(generator == 3) colorSequence[i] = color(0,100,255);
    }
    
  }
  
  //What gets called in main
  void gameplay(){
    //Background
    background(accelerometerBackground);
    
    //Goal box
    fill(bc);
    rect(windowWidth/2-28, windowHeight/2-60, 192,120);
    
    //Bug
    render();
    accelerate();
    update();
    
    //Timer
    if(!start) {
      startTimer();
      start = true;
      loadButtons();
    }
    textSize(100);
    text(timeLeft-passedTime/1000, 400,100);
    
    //Buttons
    image(controlPanelImg, 0,100);
    redButton.render();
    greenButton.render();
    blueButton.render();
    
    //Check mouse
    buttonCheck();
    checkClick();
    
    println("1" +answers[0]);
    println("2" +answers[1]);
    println("3" +answers[2]);
    
    /* ---------------GAME STATES ------------------------------*/
    //Check if bug is over box
    if(goalCheck()){
      //Show sequence of colour
      showSequence();
      //myPort.write('1');
    }else{
      sequenceCounter = 0;
    }
    currAnswerAdvance();
    
    //Check if game passed
    if(answers[0] && answers[1] && answers[2]) advanceGame();
    
    //Check if game failed
    if(passedTime < timeLimit) passedTime = millis() - currTime;
    if(passedTime > timeLimit){
      
       //currTime = millis();
       //println("run");
    }
    
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
  
  void loadButtons(){
    redButton = new Button(redButtonImg, 50, 150, redButtonCImg);
    greenButton = new Button(greenButtonImg, 50, 300, greenButtonCImg);
    blueButton = new Button(blueButtonImg, 50, 450, blueButtonCImg);
  }
  
  void accelerate(){
    //Check port for input
    if(myPort.available()>100){
      myPort.clear();
    }
    accelOrientation = myPort.readStringUntil('\n');
    //println(accelOrientation);
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
  
  //Display sequence of colour
  void showSequence(){
    if(frameCount%30 == 0){
      if(sequenceCounter == 0){
        bc = colorSequence[0];
        sequenceCounter++;
      }else if(sequenceCounter == 1){
        bc = color(0,0);
        sequenceCounter++;
      }else if(sequenceCounter == 2){
        bc = colorSequence[1];
        sequenceCounter++;
      }else if(sequenceCounter == 3){
        bc = color(0,0);
        sequenceCounter++;
      }else if(sequenceCounter == 4){
        bc = colorSequence[2];
        sequenceCounter++;
      }else bc = color(0,0);
    }
  }
  
  void startTimer(){
    currTime = millis();
  }
  
  //Call when player passes game
  void advanceGame(){
    start = false;  //Reset Timer
    println("all answers correct, game passed");
    //currGame++; will uncomment on final version
  }
  
  //Call when player loses game
  void failGame(){
    start = false;  //Reset Timer
  }
  
  //Checks if mouse is over button
  void buttonCheck(){
    if(overImg(redButton)) redButton.Hit = true;
    else redButton.Hit = false; 
    
    if(overImg(greenButton)) greenButton.Hit = true;
    else greenButton.Hit = false;
    
    if(overImg(blueButton)) blueButton.Hit = true;
    else blueButton.Hit = false;
  }
  
  //Checks for mouseClicks
  void checkClick(){
    if(mousePressed && redButton.Hit) {
      redButton.clicked(1);  //red button animation
      if(inputReady){
        if(numCSequence[currAnswer] == 1) {
          answers[currAnswer] = true;
        }
        inputReady = false;
      }
    }
    else redButton.clicked(0);
    
    if(mousePressed && greenButton.Hit) {
      greenButton.clicked(1); //green button animation
      if(inputReady){
        if(numCSequence[currAnswer] == 2) {
          answers[currAnswer] = true;
        }
        inputReady = false;
      }
    }
    else greenButton.clicked(0);
    
    if(mousePressed && blueButton.Hit) {
      blueButton.clicked(1); //blue button animation
      if(inputReady){
        if(numCSequence[currAnswer] == 3) {
          answers[currAnswer] = true;
        }
        inputReady = false;
      }
    }
    else blueButton.clicked(0);
  }
  
  
  //because mousePressed is stupid and mouseClicked cannot be called as a bool
  void currAnswerAdvance(){
     if(answers[0] == true) currAnswer = 1;
     if(answers[0] == true && answers[1] == true) currAnswer = 2;
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


  
