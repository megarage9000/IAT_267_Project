import processing.serial.*;

Serial port;
char divider = '|';

// Error symbols (Values are arbitrary)
// - Used to indicate if the port is unable to fetch sensor values
// - Check the sensor vals against these error symbols
// before using them
final float ERR_ANALOG = -1;
final String ERR_ACCEL = "ERR";
final int ERR_DIGITAL = -2;


// Depackaging Symbols (Values are arbitrary)
final int ERR_DEPACK = -909;
final int SUCCESS_DEPACK = 909;

String[] inputVals;
byte[] inputBuffer = new byte[255];

// Call this method to start the port
void initializeSerial() {
  // String portName = Serial.list()[0];
  
  // --- Change port name if needed --- //
  String portName = "COM8";
  println("Using port = " + portName);
  port = new Serial(this, portName, 9600);
}

boolean canRead = false;

// Depackages the incoming bytes, returns a success/error symbol
void depackageValues() {
  if(port.available() > 0) {
    port.readBytesUntil('\n', inputBuffer);
    if(inputBuffer != null) {
      String input = new String(inputBuffer);
      inputVals = split(input, divider);
      // Catch the case where an empty buffer is passed.
      if(inputVals.length <= 1) {
        port.clear();
        canRead = false;
        return;
      }
      canRead = true;
      return;
    }
  }
  port.clear();
  canRead = false;
}

String accelerometer = ERR_ACCEL;
float forceSensor = ERR_ANALOG;
float poteniometer = ERR_ANALOG;
/*
  --- Input byte structure
  [Accelerometer String]|[Potentiometer Value]|[Force Value]|[Button 1...2...3...n values]
  
  - When depacking, we access these tokens like an array. I.e, for Accelerometer we do inputVals[0] and for 
  Poteniometer we do float(inputVals[1])/int(inputVals[1])
  
  - Functions below will handle that
*/

// --- Getting sensor input ---
String getAccelerometer() {
  if(!canRead){
    return ERR_ACCEL;
  }
  accelerometer = inputVals[0];
  return accelerometer;
}

float getPotentiometer() {
  if(!canRead){
    return ERR_ANALOG;
  }
  poteniometer = float(inputVals[1]);
  float value = checkForNaN(poteniometer);
  println("Potentiometer value = " + str(value));
  return value;
}

float getForceSensor() {
  if(!canRead) {
    return ERR_ANALOG;
  }
  forceSensor = float(inputVals[2]);
  float value = checkForNaN(forceSensor);
  println("Force Value = " + str(value));
  return value;
}

float checkForNaN(float value) {
  if(Float.isNaN(value)) {
    println("NaN detected");
    return ERR_ANALOG;
  }
  return value;
}


// --- Outputting to Arduino --- 
boolean setOutput = true;
int prevWins = 0;
int currentWins = 0;

void outputToPort(int val) {
  if(setOutput) {
    println("Sending output " + str(val));
    port.write(val);
    setToOutput(false);
  }
}

void win() {
  currentWins++;
  if(currentWins != prevWins) {
      printWins();
      outputToPort(1);
      prevWins = currentWins;
  };
}

void lose() {
  currentWins = 0;
  if(currentWins != prevWins) {
      printWins();
      outputToPort(0);
      prevWins = currentWins;
  } 
}

void printWins() {
  println("current wins = " + str(currentWins));
  println("previous wins = " + str(prevWins));
}

void setToOutput(boolean value) {
  setOutput = value;
}
