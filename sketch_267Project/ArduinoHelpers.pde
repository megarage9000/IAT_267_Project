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
boolean sendMode = false;

// Call this method to start the port
void initializeSerial() {
  // String portName = Serial.list()[0];
  String portName = "COM8";
  println("Using port = " + portName);
  port = new Serial(this, portName, 9600);
}

// Depackages the incoming bytes, returns a success/error symbol
int depackageValues() {
  if(port.available() > 0) {
    port.readBytesUntil('\n', inputBuffer);
    if(inputBuffer != null) {
      String input = new String(inputBuffer);
      inputVals = split(input, divider);
      // Catch the case where an empty buffer is passed.
      if(inputVals.length <= 1) {
        return ERR_DEPACK;
      }
      return SUCCESS_DEPACK;
    }
  }
  port.clear();
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
  println("Accelerometer Value = " + inputVals[0]);
  return inputVals[0];
}

float getPotentiometer() {
  if(depackageValues() == ERR_DEPACK) {
    return ERR_ANALOG;
  } 
  float value = checkForNaN(float(inputVals[1]));
  println("Potentiometer value = " + str(value));
  return value;
}

float getForceSensor() {
  if(depackageValues() == ERR_DEPACK) {
    return ERR_ANALOG;
  } 
  float value = checkForNaN(float(inputVals[2]));
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
void outputToPort(int val) {
  println("Sending output " + str(val));
  port.write(val);
}

void win() {
  outputToPort(1);
}

void lose() {
  outputToPort(0);
}
