import themidibus.*; //Import the library
int timeStamp = 0;

MidiBus myBus;
    

void setup(){
  frameRate(30);
  myBus = new MidiBus(this, -1, "Java Sound Synthesizer"); 
}

void draw(){
  println(frameRate);
  Test t1;
  t1 = new Test();
  //t1.delaying(1000);
  //t1.d2(1000);
  //t1.d3(1000);
  myBus.sendNoteOn(1, 64, 96);
  MyThread M1;
  M1 = new MyThread();
  M1.start();
}


public class MyThread extends Thread{
  public volatile boolean exit = false; 
  void run(){
    while (!exit){
      myBus.sendNoteOn(1, 64, 96);
      println(millis()+" n1");
      delay(1000);
      myBus.sendNoteOn(1, 66, 96);
      println(millis()+" n2");
    }
  }

}



public class Test {
  void delaying(int delaySec){
    myBus.sendNoteOn(1, 64, 96);
    delay(delaySec);
    myBus.sendNoteOn(1, 66, 96);
  }
  void d2(int delaySec){
    //millis() = 1;    
    long pm = millis();
    long dm = pm +delaySec;
    
    println(pm);
    println("delaying");
    
    if (millis()>=pm+delaySec){
      println("do in"+dm+"\n");
    }else{
      //println("waiting\n");    
    }

  }
  void d3(int delaySec){
    //millis() = 1;    
    //println(timeStamp + "  delaying...");
    if (millis()-timeStamp >= delaySec){
      timeStamp = millis();
      println(millis() + "  doing \n");
    }else{
      if(millis()-timeStamp <0){timeStamp = millis();println("rolling");}
      //println(millis() + "  waiting \n");
    }
  }
}
