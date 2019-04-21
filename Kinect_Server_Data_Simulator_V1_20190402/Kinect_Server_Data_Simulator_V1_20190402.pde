import processing.net.*;

Server s;
Client c;
String input;
int[] dataSend=new int[9];

int x1,y1,z1,x2,y2,z2,hSize,channel,rhHeight,d;
  

void setup() 
{
  size(1280, 720);
  stroke(0);
  frameRate(30); // Slow it down a little
  s = new Server(this, 12345); // Start a simple server on a port
  
  
  
  x1 = 200;
  y1 = 200;
  z1 = 0;
  
  x2 = 600;
  y2 = 200;
  z2 = 0;
  
  hSize = 110;
  channel = 1;
  rhHeight = 96;
  
  
  d=20;
  
  
}

void draw() 
{
  background(204);
  rectMode(RADIUS);
  
  rect(x1, y1, d, d);
  rect(x2, y2, d, d);
  line(x1, y1, x2, y2);
  
  if(mouseX> x1 - d && mouseX < x1 + d && mouseY > y1 - d && mouseY < y1 + d && mousePressed){
    x1=mouseX;
    y1=mouseY;
  }
  
  
  if(mouseX> x2 - d && mouseX < x2 + d && mouseY > y2 - d && mouseY < y2 + d && mousePressed){
    x2=mouseX;
    y2=mouseY;
  }
  
  
  
  
    dataSend[0] = x1;
    dataSend[1] = y1;
    dataSend[2] = z1;
    
    dataSend[3] = x2;
    dataSend[4] = y2;
    dataSend[5] = z2;
    
    dataSend[6] = hSize; //distance from middle of shoulder to middle of body, present the distance from people to KINECT.
    
    dataSend[7] = channel;//id of KINECT skeleton, present the different instruments.
    
    dataSend[8] = rhHeight;//distance from right hand to middle of body in Y-axis, present the volume.
    
    thread("sendData");
    //s.write(pmouseX + " " + pmouseY + " " + mouseX + " " + mouseY + "\n");
    
 println(dataSend);
}

void sendData(){
  for(int i=0;i<=8;i++){
      if(i!=8) {  s.write(dataSend[i] + " ");
        } else {  s.write(dataSend[i] +"\n");}
    }
println("Sent");
}
