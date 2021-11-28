class PotGame{
  boolean doOnce = true;
  float pot;
  float distance;
  float opacity;
  float searchArea = 70;
  IntList potPasscode;
  boolean overlap;
  float randX;
  float randY;
  float randZ;
  float prevZ;
  boolean rerun = false;
  
  PotGame(){
    int potVal = 0;
    
  }
  
  void gameplay(){
    //I am doing this wrong but I just want to initialise the list of words
    if(doOnce){begin();}
    
    
    //update text items
    for(int i=0; i<wordItems.size(); i++){
      WordItem currItem = wordItems.get(i);
      distance = pot - currItem.zPos;
      //scuffed maths
      if(distance < 0){
        distance = distance * -1;
      }
      distance = (distance - searchArea) * -1;
      opacity = (distance/searchArea)*255;
      if(opacity > 255){opacity = 0;}
      fill(255, opacity);
      currItem.updateLetter();
    }
    fakePot();
  }
  
  //this is totally wrong i know
  void begin(){
    //list of numbers
    //Generates 5 pairs of numbers, each pair has everything random except the number
    for(int i=0; i<5; i++){
      
      //I AM AWARE THAT I HAVE REPEATED THE EXACT SAME BLOCK OF CODE THREE TIMES, BUT I CANNOT BE FUCKED TO CHANGE IT BECAUSE IT IS SUCH A SMALL PROJECT CODING WISE
      
      
      int randLetter = int(random(200));
      overlap = true;
      while(overlap){
        randX = random(20, windowWidth - 150);
        randY = random(50, windowHeight - 50);
        randZ = random(80, 300);
        rerun = false;
        for(int j=0; j<wordItems.size(); j++){
          WordItem currItem = wordItems.get(j);
          //Reruns if visually overlapping a number in the same search area
          if(randX > currItem.position.x && randX < currItem.position.x + 50 &&
             randY > currItem.position.y && randY < currItem.position.y + 50 &&
             randZ > currItem.zPos - searchArea && randZ < currItem.zPos + searchArea 
             )
            rerun = true;
          }
        prevZ = randZ;
        if(rerun == false || wordItems.size() == 0){
          overlap = false;
        }
      }
      addNewLetter(randX, randY, randZ, randLetter);
      overlap = true;
      while(overlap){
        randX = random(20, windowWidth - 150);
        randY = random(50, windowHeight - 50);
        randZ = random(-40, 300);
        rerun = false;
        for(int j=0; j<wordItems.size(); j++){
          WordItem currItem = wordItems.get(j);
          if(randX > currItem.position.x && randX < currItem.position.x + 50 &&
             randY > currItem.position.y && randY < currItem.position.y + 50 &&
             randZ > currItem.zPos - searchArea && randZ < currItem.zPos + searchArea 
             ){
               rerun = true;
             }
             //Reruns if number pair is in the same search area
             if(randZ > prevZ - searchArea && randZ < prevZ + searchArea){
                rerun = true;
             }
          }
        if(rerun == false || wordItems.size() == 0){
          overlap = false;
        }
      }
      
      //Prevents direct overlap of area between identical numbers
      
      addNewLetter(randX, randY, randZ, randLetter);
    }
    
    //Generates 5 numbers that have no pair, saves their value as an intlist
    potPasscode = new IntList();
    for(int i=0; i<5; i++){
      int randLetter = int(random(200));
      potPasscode.append(randLetter);
      overlap = true;
      while(overlap){
        randX = random(20, windowWidth - 150);
        randY = random(50, windowHeight - 50);
        randZ = random(-40, 300);
        rerun = false;
        for(int j=0; j<wordItems.size(); j++){
          WordItem currItem = wordItems.get(j);
          if(randX > currItem.position.x && randX < currItem.position.x + 50 &&
             randY > currItem.position.y && randY < currItem.position.y + 50 &&
             randZ > currItem.zPos - searchArea && randZ < currItem.zPos + searchArea 
             )
            rerun = true;
          }
        
        if(rerun == false || wordItems.size() == 0){
          overlap = false;
        }
      }
      addNewLetter(randX, randY, randZ, randLetter);
    }
    println(potPasscode);
    doOnce = false;
  }
  
  void fakePot(){
   //fake potentiometer using mouseY
   float wHeight = windowHeight;
   //pot = (mouseY/wHeight)*255;
   //pot = valP_slider;
   
   // --- Using Poteniometer Sensor Values ---
   float potValue = getPotentiometer();
   if(potValue != ERR_ANALOG) {
     pot = potValue;
     pot = map(pot, 32, 1024, 0, 255);
   }
  }
  
  void overlap(){
    
  }
  
}
