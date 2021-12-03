//All mouse/keyboard interaction code here


void mouseClicked(){
  if(startButton.Hit) {
     state = GAMEPLAY;
  }
  
  if(advanceButton.Hit){
    currGame++;
  }
  
  //Main menu and resets all game states
  if(menuButton.Hit && exit){
    state = MENU;
    currGame = LIGHT;
    exit = false;
    
    liGame.reset();
    acGame.reset();
    //-----------Add potgame.reset() here
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
  
  if(overImg(menuButton)) menuButton.Hit = true;
  else menuButton.Hit = false;
}
