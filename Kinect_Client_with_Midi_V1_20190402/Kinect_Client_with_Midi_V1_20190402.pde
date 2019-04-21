/**
 * Shared Drawing Canvas (Client) 
 * by Alexander R. Galloway. 
 * 
 * The Processing Client class is instantiated by specifying a remote 
 * address and port number to which the socket connection should be made. 
 * Once the connection is made, the client may read (or write) data to the server.
 * Before running this program, start the Shared Drawing Canvas (Server) program.
 */
import themidibus.*; //Import the library


import processing.net.*;

Client c;
String input;
//chang from float to int
int data[];
//END Change

MidiBus myBus; // The MidiBus
MAccords MA1 = new MAccords();

int [] m = {36,38,40,41,43,45,47,  48,50,52,53,55,57,59,  60,62,64,65,67,69,71,  72,74,76,77,79,81,83};

int w=4;
int h=64;

void setup() 
{
  size(1280, 720, P3D);
  frameRate(30);
  // Connect to the server's IP address and port
  c = new Client(this, "127.0.0.1", 12345); // Replace with your server's IP and port
  
  
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

void draw() 
{
  
  float kReSize = width / 1920.0;
  // Receive data from server
  if (c.available() > 0) {
    input = c.readString();
    input = input.substring(0, input.indexOf("\n")); // Only up to the newline

//change from folat to int
    //data = float(split(input, ' ')); // Split values into an array
    data = int(split(input, ' ')); // Split values into an array
//END Change
    // Draw line using received coords
    background(255,255,255,10);
    stroke(0);
    fill(0);
    line(data[0]*kReSize,data[1]*kReSize,data[3]*kReSize,data[4]*kReSize);
    
    println(kReSize);
    
    FindGrid myFindGrid = new FindGrid(1,data[1]);
    
    //------chord send for instrument 1
    int channel = myFindGrid.x();
    //int pitch = myFindGrid.y()+20;
    int pitch = m[myFindGrid.y()%(m.length-1)];
    
    //int pitch = m[gridXY];
    //int pitch = gridXY*2+30;
    int velocity = 96;
    
    
    
    MA1.changeNC(data[7]);//change Channel
    
    
    int hSize = data[6];
    
    int rhVol;
    float rhHiRec = data[8]/100;
    if (rhHiRec < 1){
      rhVol = int( rhHiRec * 66 ) + 30;
      }else{
        if (rhHiRec >= 1 && rhHiRec < 2){
          rhVol = int(( rhHiRec - 1 ) * 30 ) + 96;
        }else{
          rhVol=127;
        }
    }

//Part of Play--/

    if(hSize > 200)                 {MA1.changeNV(rhVol-30);MA1.MM3(pitch);}
    if(hSize < 200 && hSize > 100)  {MA1.changeNV(rhVol);MA1.M3(pitch);}
    if(hSize < 100 && hSize > 50)   {MA1.changeNV(rhVol);MA1.m3(pitch);}
    if(hSize < 50  && hSize > 10)   {MA1.changeNV(rhVol);MA1.mm3(pitch);}

//-- Part of play

    println(frameRate);
    println(data);
    
    
    
    
    //delay(200);
   //data=null;
  }
}
