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
Button advanceButton;
Button menuButton;
boolean exit = false;

//Images
PImage mainMenuBG;
PImage startButtonIMG, helpButtonIMG, advanceButtonImg, menuButtonImg;
PImage accelerometerBackground, advanceGameBG, forceBG, loseGameBG, victoryBG;
PImage bugImg, controlPanelImg, controlPanelImg2, resistorImg;
PImage redButtonImg, redButtonCImg, blueButtonImg, blueButtonCImg, greenButtonImg, greenButtonCImg;

//Potentiometer Items
ArrayList<WordItem> wordItems = new ArrayList<WordItem>();

//Accelerometer
boolean inputReady = true;


void setup(){
  size(1400,800);
  
  //loading Images
  loadImages();
  // --- Initalizes Serial stuff, see ArduinoHelpers --- 
  initializeSerial();
  //Buttons
  startButton = new Button(startButtonIMG, 300, 600, startButtonIMG);
  helpButton = new Button(helpButtonIMG, 750, 600, helpButtonIMG);
  advanceButton = new Button(advanceButtonImg, 700,600, advanceButtonImg);
  menuButton = new Button(menuButtonImg,700,600,menuButtonImg);
  
}

//Main
void draw(){
  depackageValues();
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
//---------------------------------------pass or fail Game
void passGame(){
  //show pass screen
  if(currGame == POT){
    imgRender(victoryBG, width/2,height/2);
    menuButton.render();
    exit = true;
  }
  else {
    imgRender(advanceGameBG, width/2, height/2);
    advanceButton.render();
  }
  win();
  
  for(int i = 0; i<3; i++){
    strokeWeight(3);
    stroke(4,151,2);
    if(i<=currGame) fill(4,151,2);
    else fill(0);
    rect(775+i*110, 300, 100,50);
  }
}

void failGame(){
  //show fail screen
  imgRender(loseGameBG, width/2, height/2);
  // -- Uncomment for sensors
  lose();
  menuButton.render();
  exit = true;
}

void imgRender(PImage img, float x, float y){
  //Center coordinates to image
    pushMatrix();
    translate(x,y);
    image(img, -img.width/2, -img.height/2, img.width, img.height);
    popMatrix();  
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
  advanceGameBG = loadImage("advanceGameBG.png");
  loseGameBG = loadImage("loseGameBG.png");
  advanceButtonImg = loadImage("advanceButton.png");
  victoryBG = loadImage("victoryScreen.png");
  menuButtonImg = loadImage("menuButton.png");
  forceBG = loadImage("forceBG2.png");
  resistorImg = loadImage("resistor.png");
}


//-----------------Potentiometer Game Itmes-------------------
void addNewLetter(float xPos, float yPos, float zPos, int letter){
  wordItems.add(new WordItem(new PVector(xPos, yPos), zPos, letter));
}
