/*
Author : YANG Mingcong
*/

import themidibus.*; //Import the library for MIDI
import processing.net.*;//Import the library for Network

int maxData = 10;                    //define Maximum DataSet 

//Class MyThread is for creating sub-thread to deal with the problem of delay
MyThread thread;
//threadEnd is a flag in Class MyThread, present one person's Thread run once and End
//boolean[] threadEnd =  {true,true,true,true,true,true,true,true,true,true};
boolean threadEnd[] = new boolean[maxData];


//Class Client is for Network Client
Client c;
//Sevral value for Network Client Data Receiving and Triple-Check

String input;                        //directly input flow from server
String pInput;                       //previous input flow complitment in cas of error
String line[];                       //split input flow to lines, one line one person
String pLine[] = new String [maxData];     //previous lines complitment in cas of error
//chang from float to int
int data[];                          //split lines to individual data array
int pData[] = {1};                   //previous data complitment in cas of error


//Class MidiBus is for Midi Message Sent
MidiBus myBus; 
//MAccords MA1 = new MAccords();    //Old
//Define different Pitch number of Base note in MIDI
int [] m = {36,38,40,41,43,45,47,  48,50,52,53,55,57,59,  60,62,64,65,67,69,71,  72,74,76,77,79,81,83};
int [] mBase = {0,2,4,5,7,9,11}; //c.d.e.f.g.a.b. + 12*n
int [] mBaseCanon = {12,7,9,4,5,4,2,7};  //c,g,a,e,f,e,d,g, + 12*n

//Define grids
int w=4;
int h=64;

//Define boolean for Control Send or not Sent MIDI code.
boolean sendMIDI = true;


void setup() 
{
  size(1280, 720, P3D);
  frameRate(25);
  // Connect to the server's IP address and port
  //c = new Client(this, "192.168.111.164", 12345); // Replace with your server's IP and port
  c = new Client(this, "192.168.111.101", 12345); // Replace with your server's IP and port
  
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.

  // Either you can
  //                   Parent In Out
  //                     |    |  |
  //myBus = new MidiBus(this, 0, 1); // Create a new MidiBus using the device index to select the Midi input and output devices respectively.

  // or you can ...
  //                   Parent         In                   Out
  //                     |            |                     |
  //myBus = new MidiBus(this, "IncomingDeviceName", "OutgoingDeviceName"); // Create a new MidiBus using the device names to select the Midi input and output devices respectively.

   myBus = new MidiBus(this, -1, "Java Sound Synthesizer"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
    
  for(int i=0; i < maxData; i++){
    threadEnd[i] = true;
  }
}

void draw() 
{
   background(255,255,255,1);
   stroke(0);
   float kReSize = width / 1920.0; //1920.0 for Server, 1280.0 for Simulator

//-------------------------- Receive data from server
  if (c.available() > 0) {
    input = c.readString();
//change pInput for Previous input in case of data transmit uncompelitment.
  //println(input);              //DataMonitor
  if(input.indexOf(' ')!=-1){    //if there are people, do continue
    //if there are no previous Input and no \n\\for the END of availible data
    if(input.indexOf("\n\\")==-1 && pInput!=null){//if there are no previous Input and no \n\\for the END of availible data
      println("Input Data Incompeliment");
      input = pInput;//Using Previous input
    }else{
      input = input.substring(0, input.indexOf("\n\\")); // Only up to the newline
      println("Input Data Compeliment");
      pInput = input;
    }
//ENG Change

//END---------------END Receive data from server
    //split Input to 'line' array
    line = split(input, "\n");
    //println(input);              //DataMonitor
    
//--------------------------For loop for data set
    for(int i=0;i < line.length ; i++){
      //split line to data
      //change pData for Previous data in case of data transmit uncompelitment.
      if(countChar(line[i], ' ') == 8){
        print("Line " + i + " complite");
        pLine[i] = line[i];
      }else{
        line[i]=pLine[i];
        print("Use Previous LINE " + i + " Data");
      }
      
      data = int(split(line[i], ' ')); 
        
      
      
//change from folat to int             //OLD
    //data = float(split(input, ' ')); // Split values into an array  //OLD
    
      if(data.length==9){
          pData = data;
          println("  DATA Right  ");
       }else{
          data = pData; 
          println("  Using Previous DATA");
       }
    
  //END pData
//END Change
    // Draw line using received coords
   
    stroke(i*250/line.length, 50 , i*150/line.length);
    //for(int i = 0; i <=4; i++){
      //if(data[7]==i){  
        line(data[0]*kReSize,data[1]*kReSize,data[3]*kReSize,data[4]*kReSize);
      //}
    //}
    //println(kReSize);
    
    FindGrid myFindGrid = new FindGrid(1,data[1]);
    
    //------chord send for instrument 1
    //int channel = myFindGrid.x();
    //int pitch = myFindGrid.y()+20;
    int pitch = m[myFindGrid.y()%(m.length-1)];
    
    //int pitch = m[gridXY];
    //int pitch = gridXY*2+30;
    //int velocity = 96;
    
    
    
    //MA1.changeNC(data[7]);//change Channel
    
    
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
  
  //dataToNote(hSize,rhVol,pitch);
  if(threadEnd[i]){
  thread =new MyThread();
  thread.sendValue(hSize, rhVol,pitch,data[7]);
  println("Start Thread  " +i +"   Time "+millis());
  thread.start();
  }else{
  println("Runing Thread " + i );
  }

//Part of Play--/  //OLD
/*
    if(hSize > 200)                 {MA1.changeNV(rhVol-30);MA1.MM3(pitch);}
    if(hSize < 200 && hSize > 100)  {MA1.changeNV(rhVol);MA1.M3(pitch);}
    if(hSize < 100 && hSize > 50)   {MA1.changeNV(rhVol);MA1.m3(pitch);}
    if(hSize < 50  && hSize > 10)   {MA1.changeNV(rhVol);MA1.mm3(pitch);}
*/
//-- Part of play  //OLD
//println(threadEnd[i]);            //Data Monitor
}
//END--------------------------END For loop for data set

    
   //data=null;
  }else{
   println("no people");
  }
//END nopeole test  

  }
//END client available test  
  c.clear();
  println(frameRate + " Main Real Time " + millis() + "\n");
  
}

void keyPressed(){
  if (key == 'p' || key == 'P') {
      sendMIDI = !sendMIDI;
    }
}
