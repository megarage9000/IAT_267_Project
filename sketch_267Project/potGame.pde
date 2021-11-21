class PotGame{
  boolean doOnce = true;
  float pot;
  float distance;
  float opacity;
  float searchArea = 70;
  IntList potPasscode;
  
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
      int randLetter = int(random(200));
      addNewLetter(random(20, windowWidth - 80), random(20, windowHeight - 80), random (255), randLetter, false);
      addNewLetter(random(20, windowWidth - 80), random(20, windowHeight - 80), random (255), randLetter, false);
    }
    //Generates 5 numbers that have no pair, saves their value as an intlist
    potPasscode = new IntList();
    for(int i=0; i<5; i++){
      int randLetter = int(random(200));
      potPasscode.append(randLetter);
      addNewLetter(random(50, windowWidth - 50), random(50, windowHeight - 50), random (255), randLetter, false);
    }
    println(potPasscode);
    doOnce = false;
 }
  
  void fakePot(){
   //fake potentiometer using mouseY
   float wHeight = windowHeight;
   pot = (mouseY/wHeight)*255;
  }
  
}
