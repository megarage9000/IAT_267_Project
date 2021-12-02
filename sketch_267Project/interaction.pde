//All mouse/keyboard interaction code here


void mouseClicked(){
  if(startButton.Hit) {
     state = GAMEPLAY;
  }
  
  if(advanceButton.Hit){
    currGame++;
  }
}


void mouseReleased(){
  inputReady = true;
}

//Checks if mouse is over button, a hit detection function

void buttons(){
  if(overImg(startButton)) startButton.Hit = true;
  else startButton.Hit = false;
  
  if(overImg(helpButton)) helpButton.Hit = true;
  else helpButton.Hit = false;
  
  if(overImg(advanceButton)) advanceButton.Hit = true;
  else advanceButton.Hit = false;
}
