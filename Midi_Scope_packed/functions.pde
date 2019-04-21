//--Begin of my Class MAccords -- for send notes in my defined chords.
class MAccords{
    
  //private int bassNote;
  void chord(int bassNote, int midNote, int endNote){
    int channel = 1;        //temporate
    int velocity = 96;      //temporate
    
    
    myBus.sendNoteOn(channel, bassNote, velocity); // Send a Midi noteOn
    delay(100);
    myBus.sendNoteOn(channel, bassNote+midNote, velocity); // Send a Midi noteOn
    delay(100);
    myBus.sendNoteOn(channel, midNote+endNote, velocity); // Send a Midi noteOn
    
    delay(200);
    myBus.sendNoteOff(channel, bassNote, velocity); // Send a Midi nodeOff
    myBus.sendNoteOff(channel, bassNote+midNote, velocity); // Send a Midi nodeOff
    myBus.sendNoteOff(channel, midNote+endNote, velocity); // Send a Midi nodeOff
    
  }
  
  
  void M3(int n){ //n for base note in major 3 chords
    chord(n,4,3);
  }
  void m3(int n){ //n for base note in minor 3 chords   
    chord(n,3,4);
  }
  void MM3(int n){ //n for base note in major plus 3 chords
    chord(n,4,4);
  }
  void mm3(int n){ //n for base note in minor minuse 3 chords   
    chord(n,3,3);
  }
  void m6(int n){ //n for base note in major 6 chords   
    chord(n,3,5);
  }
  void M46(int n){ //n for base note in major 4/6 chords   
    chord(n,5,4);
  }
  
  
}
//--END of Class MAccords


//--Begin of my Class FindGrid -- for find the detail grid on scope.
class FindGrid{ //declare new class
  
  private float Vx, Vy;   //globle value in the class
  private int gridX, gridY;
    
    FindGrid(float x, float y){  //declare the 2 value in class
    //find import x.y position 
      Vx=x;
      Vy=y;
    }
    
    public int x(){
      gridX = (int)(Vx-Vx%(width/w))/(width/w); //start from 0
      return gridX;
    }
    
    public int y(){
      gridY = (int)(Vy-Vy%(height/h))/(height/h); //start from 0
      return gridY;
    
    //println(gridX+","+gridY+" "+gridXY+" "+m[gridXY]);
    }
}
//--end of claas FindGrid.

void drawGrid(int wBox, int hBox){
  //draw Grids for easy debug
  //no need to show in final
  
  int w=wBox;
  int h=hBox;
  
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
}
