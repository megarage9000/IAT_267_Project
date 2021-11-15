/*IAT 267 Final Project
  M.O.S.S Group - D102
  November 15, 2021
  

*/

//Gamestate Controls
int state = 0;
final int MENU = 0;
final int GAMEPLAY = 1;
final int END = 2;

void setup(){
  size(600,600);
  loadImages();
}

//Main
void draw(){
  
  switch(state){
    case MENU:
      mainMenu();
      break;
    case GAMEPLAY:
      gamePlay();
      break;
    case END:
      endScreen();
      break;
    default:
    //.... redundant
  }

}


//For loading images used for UI and Interface
void loadImages(){
}
