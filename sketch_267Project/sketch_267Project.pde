/*IAT 267 Final Project
  M.O.S.S Group - D102
  November 15, 2021
  

*/

//Window size
final int windowWidth = 1400;
final int windowHeight = 800;

//Game classes, 
accelerometerGame acGame = new accelerometerGame();
lightGame liGame = new lightGame();
potGame poGame = new potGame();

//Gamestate Controls
int state = 1  ;
final int MENU = 0;
final int GAMEPLAY = 1;
final int END = 2;

int currGame = 0;
final int LIGHT = 0;
final int ACCEL = 1;
final int POT = 2;

void setup(){
  size(1400,800);
  loadImages();
}

//Main
void draw(){
  background(50);
    
  switch(state){
    case MENU:
      mainMenu();
      break;
    case GAMEPLAY:
      if(currGame == LIGHT) liGame.gameplay();
      else if(currGame == ACCEL) acGame.gameplay();
      else if(currGame == POT) poGame.gameplay();
      break;
    case END:
      endScreen();
      break;
    default:
    //.... redundant
  }

}


//For testing only
void mouseClicked(){
  if(currGame<2) currGame++;
  else if(currGame == 2) currGame = 0;
}


//--------------------------------------- Loading Var-----------------------------------------------
//For loading images used for UI and Interface
void loadImages(){
  //...
}

//For loading buttons 
void loadButtons(){
  //...
}
