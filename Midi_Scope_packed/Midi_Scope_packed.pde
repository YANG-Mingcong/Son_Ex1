import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus
MAccords MA1 = new MAccords();

int [] m = {36,38,40,41,43,45,47,  48,50,52,53,55,57,59,  60,62,64,65,67,69,71,  72,74,76,77,79,81,83};

int w=4;
int h=64;


void setup() {
  size(640, 640);
  background(255);
  

  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.

  // Either you can
  //                   Parent In Out
  //                     |    |  |
  //myBus = new MidiBus(this, 0, 1); // Create a new MidiBus using the device index to select the Midi input and output devices respectively.

  // or you can ...
  //                   Parent         In                   Out
  //                     |            |                     |
  //myBus = new MidiBus(this, "IncomingDeviceName", "OutgoingDeviceName"); // Create a new MidiBus using the device names to select the Midi input and output devices respectively.

  // or for testing you could ...
  //                 Parent  In        Out
  //                   |     |          |
  myBus = new MidiBus(this, -1, "Java Sound Synthesizer"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.

  
}

void draw() {
  
FindGrid myFindGrid = new FindGrid(mouseX,mouseY);

  
  int w=4;
  int h=64;
  
  drawGrid(w,h); //see functions
  
  
  int channel = myFindGrid.x();
  int pitch = myFindGrid.y()+20;
  //int pitch = m[gridXY];
  //int pitch = gridXY*2+30;
  int velocity = 96;
  
  MA1.M3(pitch);
  delay(200);
  MA1.m3(pitch-5);

/**
  myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
  delay(200);
  myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff
**/
  


  if(pmouseX==mouseX&&pmouseY==mouseY){
  delay(2000);
  }
}
