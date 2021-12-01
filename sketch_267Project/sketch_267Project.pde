/*IAT 267 Final Project
  M.O.S.S Group - D102
  November 15, 2021
  

*/

import processing.serial.*;

Serial myPort;
String accelOrientation;

float valP_light; // Data received from the serial port - variable to store the light sensor reading
int valP_slider; // Data received from the serial port - variable to store the slider sensor reading
int valP_button;


//Window size
final float windowWidth = 1400;
final float windowHeight = 800;

//Game classes, 
AccelerometerGame acGame = new AccelerometerGame();
LightGame liGame = new LightGame();
PotGame poGame = new PotGame();

//Gamestate Controls
int state = 1;
final int MENU = 0;
final int GAMEPLAY = 1;
final int END = 2;

int currGame = 1;
final int LIGHT = 0;
final int ACCEL = 1;
final int POT = 2;

//Buttons
Button start;

//Images
PImage accelerometerBackground;
PImage bugImg;
//Potentiometer Items
ArrayList<WordItem> wordItems = new ArrayList<WordItem>();


void setup(){
  size(1400,800);
  
  //loading Images and buttons *DOES NOTHING YET*
  loadImages();
  loadButtons();
  // --- Initalizes Serial stuff, see ArduinoHelpers --- 
  initializeSerial();
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
  accelerometerBackground = loadImage("accelerometerBackground.jpg");
  bugImg = loadImage("bugImg.png");
}

//For loading buttons 
void loadButtons(){
  //...
}



//-----------------Potentiometer Game Itmes-------------------
void addNewLetter(float xPos, float yPos, float zPos, int letter){
  wordItems.add(new WordItem(new PVector(xPos, yPos), zPos, letter));
}
