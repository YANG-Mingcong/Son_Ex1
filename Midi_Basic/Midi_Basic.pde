import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus

int [] m = {36,38,40,41,43,45,47,  48,50,52,53,55,57,59,  60,62,64,65,67,69,71,  72,74,76,77,79,81,83};

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
  int w=7;
  int h=4;
  
  for(int i=0;i<w;i++){       //rows
    for(int j=0;j<h;j++){     //col
      fill(255);
      stroke(0);
      rect(i*width/w,  j*height/h,(i+1)*width/w,  (j+1)*height/h );
      
      int k=i+j*w;
      
      fill(0, 102, 153);
      text(m[k],i*width/w+10,  j*height/h+10);
    
    }
  
  }
  
  
/*  int channel = 0;
  int pitch = 64;
  int velocity = 127;

  myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
  delay(200);
  myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff
*/

}
