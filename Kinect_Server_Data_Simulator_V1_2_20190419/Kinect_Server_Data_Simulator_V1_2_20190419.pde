import processing.net.*;
int maxData = 10;
Server s;
Client c;
String input;
int[] dataSend=new int[maxData];

//int x1,y1,z1,x2,y2,z2,hSize,channel,rhHeight,d;
int[] x1=new int[maxData],y1=new int[maxData],z1=new int[maxData],x2=new int[maxData],y2=new int[maxData],z2=new int[maxData],hSize=new int[maxData],channel=new int[maxData],rhHeight=new int[maxData],d=new int[maxData];
//int totalUser; //Globle int for person number
boolean[] isEnable=new boolean[maxData];
boolean[] isSelect=new boolean[maxData];

void setup() 
{
  size(1280, 720);
  stroke(0);
  frameRate(30); // Slow it down a little
  s = new Server(this, 12345); // Start a simple server on a port
  
  
  for(int i=0;i<maxData;i++){
    
      x1[i] = 200+50*i;
      y1[i] = 200+50*i;
      z1[i] = 0;
      
      x2[i] = 600+50*i;
      y2[i] = 200+50*i;
      z2[i] = 0;
      
      hSize[i] = 110;
      channel[i] = -1;
      rhHeight[i] = 96;
            
      d[i]=20;
  }
  

  
}

void draw() 
{
  background(204);
  
  rectMode(RADIUS);
  textSize(40);
  strokeWeight(4);
  
  
  
  
  //basic interface
  for(int i=0;i<maxData;i++){
    if(isEnable[i]==true){
      fill(#AFFF95);
      channel[i] = i;
    }else{
      fill(#FF9597);
      channel[i] = -1;//disable
    }
  
    if(isSelect[i]==true){
      stroke(#FCE10D);
    }else{
      stroke(0);
    }
    
    rect(50*i+50,50,20,20);
    
    fill(50);
    text(i,50*i+38,65);
  }
  
  textSize(10);
  text("Data Channel:",30,15);
  //See mouseRelease
  
  
  
  for(int i=0;i<maxData;i++){
      if(isSelect[i]==true){
        stroke(#FCE10D);
      }else{
        stroke(0);
      }  
    
      fill(0,0,255);
      rect(x1[i], y1[i], d[i], d[i]);
      fill(255,0,0);
      rect(x2[i], y2[i], d[i], d[i]);
      line(x1[i], y1[i], x2[i], y2[i]);
  }
  
  
  
  
    for(int i=0;i<maxData;i++){
        if(isEnable[i]){
            dataSend[0] = x1[i];
            dataSend[1] = y1[i];
            dataSend[2] = z1[i];
            
            dataSend[3] = x2[i];
            dataSend[4] = y2[i];
            dataSend[5] = z2[i];
            
            dataSend[6] = hSize[i]; //distance from middle of shoulder to middle of body, present the distance from people to KINECT.
            
            dataSend[7] = i;//id of KINECT skeleton, present the different instruments.
            
            dataSend[8] = rhHeight[i];//distance from right hand to middle of body in Y-axis, present the volume.
            
            sendData(i);
            //s.write(pmouseX + " " + pmouseY + " " + mouseX + " " + mouseY + "\n");
        }
    }
    s.write("\\");
    
    println(frameRate);
}

void sendData(int k){
  for(int i=0;i<=8;i++){
      if(i<8) {  s.write(dataSend[i] + " ");
        } else {  s.write(dataSend[i] +"\n");}
    }
println("Sent"+k);

}

void mouseClicked(){
  //mouseClicked Function of box Select % Enable
  for(int i=0;i<maxData;i++){
     //LEFT Button for Select
      if(mouseX> 50*i+30 && mouseX < 50*i+80 && mouseY > 30 && mouseY < 80 && mouseButton==LEFT){
          isSelect[i]=!isSelect[i];
      }
     //END Select if
      
     //RIGHT Button for Enable
      if(mouseX> 50*i+30 && mouseX < 50*i+80 && mouseY > 30 && mouseY < 80 && mouseButton==RIGHT){ 
          isEnable[i]=!isEnable[i];
      }
     //END Enable if
  }
  //END mouseClicked Function of box Select & Enable
}

void mouseDragged(){
  
  for(int i=0;i<maxData;i++){

        if(mouseX> x1[i] - d[i] && mouseX < x1[i] + d[i] && mouseY > y1[i] - d[i] && mouseY < y1[i] + d[i] && isSelect[i]){
          x1[i]=mouseX;
          y1[i]=mouseY;
        }
        
        
        if(mouseX> x2[i] - d[i] && mouseX < x2[i] + d[i] && mouseY > y2[i] - d[i] && mouseY < y2[i] + d[i] && isSelect[i]){
          x2[i]=mouseX;
          y2[i]=mouseY;
        }
  }
}
