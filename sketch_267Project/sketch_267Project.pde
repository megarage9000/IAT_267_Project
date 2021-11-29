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
PImage bugImg, controlPanelImg;
PImage redButtonImg, redButtonCImg, blueButtonImg, greenButtonImg;
//Potentiometer Items
ArrayList<WordItem> wordItems = new ArrayList<WordItem>();


void setup(){
  size(1400,800);
  
  //loading Images
  loadImages();
  
  //Port
  String portName = Serial.list()[0]; //List all ports to find correct one
  myPort = new Serial(this, Serial.list()[0], 9600);

  
  start = new Button(700,800,100,100);
  
  setSensor();
}

//Main
void draw(){


  //if (0 < port.available()) { // If data is available to read,
    
  //  println(" ");
    
  //  port.readBytesUntil('&', inBuffer);  //read in all data until '&' is encountered
    
  //  if (inBuffer != null) {
  //    String myString = new String(inBuffer);
  //    //println(myString);  //for testing only
      
      
  //    //p is all sensor data (with a's and b's) ('&' is eliminated) ///////////////
      
  //    String[] p = splitTokens(myString, "&");  
  //    if (p.length < 2) return;  //exit this function if packet is broken
  //    //println(p[0]);   //for testing only
      
      
  //    //get light sensor reading //////////////////////////////////////////////////
      
  //    String[] light_sensor = splitTokens(p[0], "a");  //get light sensor reading 
  //    if (light_sensor.length != 3) return;  //exit this function if packet is broken
  //    //println(light_sensor[1]);
  //    valP_light = int(light_sensor[1]);
      
  //    print("light sensor:");
  //    print(valP_light);
  //    println(" ");  


  //    //get slider sensor reading //////////////////////////////////////////////////
      
  //    String[] slider_sensor = splitTokens(p[0], "b");  //get slider sensor reading 
  //    if (slider_sensor.length != 3) return;  //exit this function if packet is broken
  //    //println(slider_sensor[1]);
  //    valP_slider = int(slider_sensor[1]);

  //    print("slider sensor:");
  //    print(valP_slider);
  //    println(" "); 
      
      
      
      
  //    String[] button_sensor = splitTokens(p[0], "c");  //get light sensor reading 
  //    if (button_sensor.length != 3) return;  //exit this function if packet is broken
  //    valP_light = int(button_sensor[1]);
      
  //  }
  //}
  
  
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
  redButtonImg = loadImage("redButton.png");
  redButtonCImg = loadImage("redButtonClick.png");
  greenButtonImg = loadImage("greenButton.png");
  controlPanelImg = loadImage("controlPanel.png");
  
}


//-----------------Potentiometer Game Itmes-------------------
void addNewLetter(float xPos, float yPos, float zPos, int letter){
  wordItems.add(new WordItem(new PVector(xPos, yPos), zPos, letter));
}
