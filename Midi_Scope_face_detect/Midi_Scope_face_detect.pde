import themidibus.*; //Import the library

import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;

MidiBus myBus; // The MidiBus

int [] m = {36,38,40,41,43,45,47,  48,50,52,53,55,57,59,  60,62,64,65,67,69,71,  72,74,76,77,79,81,83};

void setup() {
  size(640, 640);
  background(255);
  
  video = new Capture(this, 640, 480);
  opencv = new OpenCV(this, 640, 480);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  video.start();
  

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
  
  opencv.loadImage(video);

  image(video, 0, 0 );

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();
  println(faces.length);

  for (int i = 0; i < faces.length; i++) {
    println(faces[i].x + "," + faces[i].y);
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
  
  
  
  
  
  int w=4;
  int h=64;
  
  for(int i=0;i<w;i++){       //rows
    for(int j=0;j<h;j++){     //col
      fill(255);
      stroke(0);
      rect(i*width/w,  j*height/h,(i+1)*width/w,  (j+1)*height/h );
      
      int k=i+j*w;
      
      fill(0, 102, 153);
      text(j,i*width/w+10,  j*height/h+10);
    
    }
  
  }
  
  //find mouse position and grid
  float Vx=mouseX;
  float Vy=mouseY;
  
  int gridX = (int)(Vx-Vx%(width/w))/(width/w); //start from 0
  int gridY = (int)(Vy-Vy%(height/h))/(height/h); //start from 0
  
  int gridXY = gridX + gridY*w;

//println(gridX+","+gridY+" "+gridXY+" "+m[gridXY]);
  
  
  
  int channel = gridX;
  int pitch = gridY+20;
  //int pitch = m[gridXY];
  //int pitch = gridXY*2+30;
  int velocity = 96;

  myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
  delay(200);
  myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff
  
  if(pmouseX==mouseX&&pmouseY==mouseY){
  delay(2000);
  }
}
