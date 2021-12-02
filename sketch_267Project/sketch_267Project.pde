/*IAT 267 Final Project
  M.O.S.S Group - D102
  November 15, 2021
  

*/

import processing.serial.*;

Serial myPort;
String accelOrientation;

int valP_light; // Data received from the serial port - variable to store the light sensor reading
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
int state = 0;
final int MENU = 0;
final int GAMEPLAY = 1;
final int END = 2;

int currGame = 0;
final int LIGHT = 0;
final int ACCEL = 1;
final int POT = 2;

//Buttons
Button startButton;
Button helpButton;

//Images
PImage mainMenuBG, startButtonIMG, helpButtonIMG;
PImage accelerometerBackground;
PImage bugImg, controlPanelImg, controlPanelImg2;
PImage redButtonImg, redButtonCImg, blueButtonImg, blueButtonCImg, greenButtonImg, greenButtonCImg;

//Potentiometer Items
ArrayList<WordItem> wordItems = new ArrayList<WordItem>();

//Accelerometer
boolean inputReady = true;


void setup(){
  size(1400,800);
  
  //loading Images
  loadImages();
  
  //Port
  String portName = Serial.list()[0]; //List all ports to find correct one
  myPort = new Serial(this, Serial.list()[0], 9600);

  //Buttons
  startButton = new Button(startButtonIMG, 300, 600, startButtonIMG);
  helpButton = new Button(helpButtonIMG, 750, 600, helpButtonIMG);
  
  setSensor();
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

//---------------------------------------Processing to Arduino--------------------------------------
void setSensor(){
  
  switch (currGame){
    case LIGHT:
      myPort.write("forceSet");
      break;
    case ACCEL:
      myPort.write("accelSet");
      break;
    case POT:
      myPort.write("potentioSet");
      break;
    default:
    break;
  }
      
}


//--------------------------------------- Loading Var-----------------------------------------------
//For loading images used for UI and Interface
void loadImages(){
  accelerometerBackground = loadImage("accelerometerBackground.jpg");
  bugImg = loadImage("bugImg.png");
  blueButtonImg = loadImage("blueButton.png");
  blueButtonCImg = loadImage("blueButtonClick.png");
  redButtonImg = loadImage("redButton.png");
  redButtonCImg = loadImage("redButtonClick.png");
  greenButtonImg = loadImage("greenButton.png");
  greenButtonCImg = loadImage("greenButtonClick.png");
  controlPanelImg = loadImage("controlPanel.png");
  controlPanelImg2= loadImage("controlPanel2.png");
  mainMenuBG = loadImage("background.png");
  startButtonIMG = loadImage("startButton.png");
  helpButtonIMG = loadImage("helpButton.png");
  
}


//-----------------Potentiometer Game Itmes-------------------
void addNewLetter(float xPos, float yPos, float zPos, int letter){
  wordItems.add(new WordItem(new PVector(xPos, yPos), zPos, letter));
}
