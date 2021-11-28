class LightGame{
  float pot;
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
  
  LightGame(){
    //---------------------------------There are some values that will need to change depending on how sensitive the sensor is, I've marked them with --------
  }
  
  void gameplay(){
    if (goalPosition == 0){  //Randomises position of goal during startup
      goalPosition = int(random(20, 255));  //----------------------
      ratioPos = int((float(goalPosition)/255)*windowHeight);//----------------------------
    }
    
    heightPos = int((float(valP_light)/255)*windowHeight);//------------------------
    
    fakePot();//Takes input
    fill(100, 200, 200);
    if(count < 5){
      rect(windowWidth/1.5 - 20, ratioPos + 30, 240, -60);} //draw goal if not finished
    fill(255, 0 ,0);
    rect(windowWidth/1.5, 0, 200, heightPos); //displays sensor position
    
    
    fill(150,150,150);
    rect(190, 190, 230, 40);//background of bar
    rect(190, 250, 230, 150);//text background
    fill(255,255,255);
    rect(200, 200, (float(timer)/float(timerLength)) * 200, 20);  //Loading bar
    fill(0,0,0);
    textSize(25);
    text("Search Count:  /5", 200, 290);
    text(count, 370, 290);
    if(valP_light < goalPosition + 10 && valP_light > goalPosition - 10 && count < 5){ //If sensor is within range of the goal
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
    }
  }
  
  void fakePot(){
   //fake potentiometer using mouseY
   float wHeight = windowHeight;
   pot = (mouseY/wHeight)*255;  //To control with sensor just comment out this line of code (ie do not remove it)
   
   // --- Using Light / Force Sensor Values --- 
   float lightValue = getForceSensor();
   if(lightValue != ERR_ANALOG) {
     // --- Values here will need to be changed if using force sensor ---
     pot = lightValue;
     pot = map(pot, 512, 890, 0, 255);
   }
   
   valP_light = int(pot);
  }
}
