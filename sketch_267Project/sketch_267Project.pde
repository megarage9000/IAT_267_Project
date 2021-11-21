/*IAT 267 Final Project
  M.O.S.S Group - D102
  November 15, 2021
  

*/

import processing.serial.*;

Serial myPort;
String accelOrientation;

//Window size
final int windowWidth = 1400;
final int windowHeight = 800;

//Game classes, 
AccelerometerGame acGame = new AccelerometerGame();
LightGame liGame = new LightGame();
PotGame poGame = new PotGame();

//Gamestate Controls
int state = 0;
final int MENU = 0;
final int GAMEPLAY = 1;
final int END = 2;

int currGame = 0;
final int LIGHT = 0;
final int ACCEL = 1;
final int POT = 2;

//Buttons
Button start;

//Images
PImage accelerometerBackground;
PImage bugImg;

void setup(){
  size(1400,800);
  
  //loading Images and buttons *DOES NOTHING YET*
  loadImages();
  loadButtons();
  
  //Port
  String portName = Serial.list()[0]; //List all ports to find correct one
  myPort = new Serial(this,portName,9600);
  
  start = new Button(700,800,100,100);
}

//Main
void draw(){
  background(50); //Placeholder since we dont have image background yet
  
  buttons(); //important for interaction, *REFRESHES ALL BUTTONS TO CHECK IF THEYRE CLICKED*
    
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



//--------------------------------------- Loading Var-----------------------------------------------
//For loading images used for UI and Interface
void loadImages(){
  //accelerometerBackground = loadImage("accelerometerBackground.jpg");
  //bugImg = loadImage("bugImg.png");
}

//For loading buttons 
void loadButtons(){
  //...
}
