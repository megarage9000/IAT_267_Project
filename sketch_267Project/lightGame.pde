class LightGame{
  float forceVal;
  int count;
  int timer;
  int maxTimer;
  boolean cleared = false;
  int goalPosition = 0;
  int prevGoal;
  int ratioPos;
  int heightPos;
  int timerLength = 60;
  boolean complete = false;
  
  
  //Timer
  boolean start;
  int timeLimit = 30000;
  int currTime;
  int passedTime;
  int timeLeft = 30;
  
  LightGame(){
    //---------------------------------There are some values that will need to change depending on how sensitive the sensor is, I've marked them with --------
  }
  
  void gameplay(){
    
    background(forceBG);
    //Timer
    if(!start) {
      startTimer();
      start = true;
    }
    
    noStroke();
    //Goal 
    if (goalPosition == 0){  //Randomises position of goal during startup
      goalPosition = int(random(20, 205));  //----------------------
      ratioPos = int((float(goalPosition)/255)*windowHeight);//----------------------------
    }
    
    heightPos = int((forceVal/255)*windowHeight);//------------------------
    
    //Goal
    fakePot();//Takes input
    fill(227, 176, 0);
    if(count < 5){
      image(resistorImg, windowWidth/1.5-20 - resistorImg.width + 3, ratioPos + 30 - resistorImg.height + 101 );    //resistor img
      rect(windowWidth/1.5 - 20, ratioPos + 30, 240, -60);
    } //draw goal if not finished
    fill(255, 0 ,0, 150);
    rect(windowWidth/1.5, 0, 200, heightPos); //displays sensor position
    
    //Text Ui
    fill(150,150,150);
    rect(120, 190, 230, 40);//background of bar
    rect(120, 250, 230, 100);//text background
    fill(100,255,0);
    rect(130, 200, (float(timer)/float(timerLength)) * 200, 20);  //Loading bar
    fill(0,0,0);
    textSize(25);

    fill(255,255,255);
    text("Resistors:   /5", 145, 305);
    text(count, 270, 305);
    if(forceVal < goalPosition + 10 && forceVal > goalPosition - 10 && count < 5){ //If sensor is within range of the goal
      timer = timer + 1;
      if(timer > timerLength){
        cleared = true;
      }
    }
    else{
      if(timer > 0 && count < 5){  //Else reduce bar if not in range
        timer = timer - 2;
      }
    }
    
      //Timer UI
    textSize(30);
    fill(255,255,255);
    text("TIME LEFT:", 125, 465);
    text(timeLeft-passedTime/1000, 295, 465);
    
    if(cleared){
      if(count < 5){
        count = count + 1;
        prevGoal = goalPosition;
        while(prevGoal + 20 > goalPosition && prevGoal - 20 < goalPosition){  //Randomises if new goal is exactly the same as previous
          goalPosition = int(random(20, 255));
          ratioPos = int((float(goalPosition)/255)*windowHeight);
        }
        timer = 0;
        cleared = false;
      }
    }
    if(count > 4){
        //The level is cleared if this text is read, Code that controls gamestate to inform level is complete goes here.
        //------------------------------------------
        fill(0,0,0);
        text("(level clear text)", 200, 350);
        passGame();
    }
    //Check if time limit is up
    if(passedTime < timeLimit && count < 5) passedTime = millis() - currTime;
    else if(passedTime > timeLimit){
      failGame();
    }
    
 
    
  }
  
  void fakePot(){
   //fake potentiometer using mouseY
   //float wHeight = windowHeight;
   //forceVal = (mouseY/wHeight)*255;  //To control with sensor just comment out this line of code (ie do not remove it)
   
   // --- Using Light / Force Sensor Values ---
   // -- Uncomment for sensors
   float sensorValue = getForceSensor();
   if(sensorValue != ERR_ANALOG) {
     // --- Values here will need to be changed if using force sensor ---
     forceVal = sensorValue;
     forceVal =  map(forceVal, 50, 1023, 0, 255);
   }
  }
  
  //Resets game
  void reset(){
    start = false;
    count = 0;
    passedTime = 0;
  }
  
  void startTimer(){
    currTime = millis();
  }
}
