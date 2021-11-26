import processing.serial.*;

Serial port;
String divider = "|";

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
  port = new Serial(this, Serial.list()[0], 9600);
}

// Depackages the incoming bytes, returns a success/error symbol
int depackageValues() {
  if(port.available() > 0) {
    port.readBytesUntil('\n', inputBuffer);
    if(inputBuffer != null) {
      String input = new String(inputBuffer);
      inputVals = splitTokens(input, divider);
      return SUCCESS_DEPACK;
    }
    else {
      return ERR_DEPACK;
    }
  }
  return ERR_DEPACK;
}
/*
  --- Input byte structure
  [Accelerometer String]|[Potentiometer Value]|[Force Value]|[Button 1...2...3...n values]
  
  - When depacking, we access these tokens like an array. I.e, for Accelerometer we do inputVals[0] and for 
  Poteniometer we do float(inputVals[1])/int(inputVals[1])
  
  - Functions below will handle that
*/

// --- Getting sensor input ---
String getAccelerometer() {
  if(depackageValues() == ERR_DEPACK) {
    return ERR_ACCEL;
  } 
  return inputVals[0];
}

float getPotentiometer() {
  if(depackageValues() == ERR_DEPACK) {
    return ERR_ANALOG;
  } 
  return float(inputVals[0]);
}

float getForceSensor() {
  if(depackageValues() == ERR_DEPACK) {
    return ERR_ANALOG;
  } 
  return float(inputVals[0]);
}
