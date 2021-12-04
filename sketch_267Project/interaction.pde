//All mouse/keyboard interaction code here


void mouseClicked(){
  if(startButton.Hit) {
     state = GAMEPLAY;
  }
  
  if(advanceButton.Hit){
    currGame++;
    setToOutput(true);
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


    // Variable to store text currently being typed
  String typing = "";
  
  // Variable to store saved text when return is hit
  String saved = "";
  
  boolean checkAnswer;

//Picks up keyboard for pot game
void keyPressed() {
 if(currGame == 2){   
   //If the return key is pressed, save the String and clear it
  if (key == '\n' ) {
    saved = typing;
    checkAnswer = true;
    // A String can be cleared by setting it equal to ""
    typing = ""; 
  } else if(key == BACKSPACE){
      if(typing.length() > 0){
      typing = typing.substring( 0, typing.length()-1 );
      }
  }
  else {
    // Otherwise, concatenate the String
    // Each character typed by the user is added to the end of the String variable.
    if(str(key).matches("-?[0-9]+")){
      typing = typing + key; 
   }
    }
   }
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
