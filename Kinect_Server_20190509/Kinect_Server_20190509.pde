/*
Author:YANG Mingcong
*/

import KinectPV2.KJoint;
import KinectPV2.*;

import processing.net.*;

KinectPV2 kinect;

Server s;

void setup() {
  size(1920, 1080, P3D);
  kinect = new KinectPV2(this);
  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);
  kinect.enableSkeleton3DMap(true);
  kinect.init();
  
  frameRate(60);
  s = new Server(this, 12345); // Start a simple server on a port
}

void draw() {
  background(0);
  fill(255, 0, 0);
  textSize(40);
  image(kinect.getColorImage(), 0, 0, width, height);

  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();
  ArrayList<KSkeleton> skeletonArrayZ =  kinect.getSkeleton3d();          //for getZ()

  //individual JOINTS
  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    KSkeleton skeletonZ = (KSkeleton) skeletonArrayZ.get(i);              //for getZ()
    if (skeleton.isTracked()) {
      text("skeleton is tracked", 50, 90);
      KJoint[] joints = skeleton.getJoints();
      KJoint[] jointsZ = skeletonZ.getJoints();                           //for getZ()

      color col  = skeleton.getIndexColor();
      
      int sid=1;
      
      int a = (col >> 24) & 0xFF;
      int r = (col >> 16) & 0xFF;  // Faster way of getting red(argb)
      int g = (col >> 8) & 0xFF;   // Faster way of getting green(argb)
      int b = col & 0xFF;          // Faster way of getting blue(argb)
      
      if(col==color(0, 0, 255)){sid = 0;}
      if(col==color(0, 255, 0)){sid = 1;}
      if(col==color(255, 0, 0)){sid = 2;}
      if(col==color(255, 255, 0)){sid = 3;}
      if(col==color(255, 0, 255)){sid = 4;}
      if(col==color(0, 255, 255)){sid = 5;}
      
      
      
      
      fill(col);
      stroke(col);
      text("skeleton color: " + a +"-"+ r +"-"+ g +"-"+ b +"  ID:" + sid , 50, 120);
      drawBody(joints);

      //draw different color for each hand state
      drawHandState(joints[KinectPV2.JointType_HandRight]);
      drawHandState(joints[KinectPV2.JointType_HandLeft]);
     
//changing float to int value
      /**--
      float x1,y1,z1,x2,y2,z2,hSize,rhHeight;
      
      x1 = joints[KinectPV2.JointType_HandLeft].getX();
      y1 = joints[KinectPV2.JointType_HandLeft].getY();
      z1 = joints[KinectPV2.JointType_HandLeft].getZ();
      
      x2 = joints[KinectPV2.JointType_HandRight].getX();
      y2 = joints[KinectPV2.JointType_HandRight].getY();
      z2 = joints[KinectPV2.JointType_HandRight].getZ();
      
      //hSize means the distance from middle of body to middle of shoulder, which present the distance from people to kinect.
      hSize = abs(joints[KinectPV2.JointType_SpineShoulder].getY()-joints[KinectPV2.JointType_SpineMid].getY());
      //rhHeight means the distance from right hand to middle of body in Y-axis
      rhHeight =  abs(joints[KinectPV2.JointType_HandRight].getY()-joints[KinectPV2.JointType_SpineMid].getY())/ abs(joints[KinectPV2.JointType_Head].getY()-joints[KinectPV2.JointType_SpineMid].getY());
      --**/
      int x1,y1,z1,x2,y2,z2,hSize,rhHeight;
      
      x1 = int(joints[KinectPV2.JointType_HandLeft].getX());
      y1 = int(joints[KinectPV2.JointType_HandLeft].getY());
      z1 = int(jointsZ[KinectPV2.JointType_HandLeft].getZ()*1000.0);
      
      x2 = int(joints[KinectPV2.JointType_HandRight].getX());
      y2 = int(joints[KinectPV2.JointType_HandRight].getY());
      z2 = int(jointsZ[KinectPV2.JointType_HandRight].getZ()*1000.0);
      
      int wSize = int(100.0*abs(joints[KinectPV2.JointType_HandRight].getX()-joints[KinectPV2.JointType_HandLeft].getX()) / abs(joints[KinectPV2.JointType_ShoulderRight].getX()-joints[KinectPV2.JointType_ShoulderLeft].getX()));
      //hSize means the distance from middle of body to middle of shoulder, which present the distance from people to kinect.
      //hSize = int(abs(joints[KinectPV2.JointType_SpineShoulder].getY()-joints[KinectPV2.JointType_SpineMid].getY()));
      //rhHeight means the distance from right hand to middle of body in Y-axis
      rhHeight =  int(abs(joints[KinectPV2.JointType_HandRight].getY()-joints[KinectPV2.JointType_SpineBase].getY())/ abs(joints[KinectPV2.JointType_SpineShoulder].getY()-joints[KinectPV2.JointType_SpineBase].getY())*100);
//END of change     
      
      
      s.write(x1 + " " + y1 + " " + z1 + " " + x2 + " " + y2 + " " + z2 + " " + wSize + " " + sid + " " + rhHeight + "\n");
      println(x1 + " " + y1 + " " + z1 + " " + x2 + " " + y2 + " " + z2 + " " + wSize + " " + sid + " " + rhHeight + "\n");
    }
    s.write("\\");  //server dataset end 
  }
  
  
  text(skeletonArray.size(), 50, 50);
  
}

//DRAW BODY
void drawBody(KJoint[] joints) {
  text("start drawing the skeleton", 50, 150);
  drawBone(joints, KinectPV2.JointType_Head, KinectPV2.JointType_Neck);
  drawBone(joints, KinectPV2.JointType_Neck, KinectPV2.JointType_SpineShoulder);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_SpineMid);
  drawBone(joints, KinectPV2.JointType_SpineMid, KinectPV2.JointType_SpineBase);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderRight);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderLeft);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipRight);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipLeft);

  // Right Arm
  drawBone(joints, KinectPV2.JointType_ShoulderRight, KinectPV2.JointType_ElbowRight);
  drawBone(joints, KinectPV2.JointType_ElbowRight, KinectPV2.JointType_WristRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_HandRight);
  drawBone(joints, KinectPV2.JointType_HandRight, KinectPV2.JointType_HandTipRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_ThumbRight);

  // Left Arm
  drawBone(joints, KinectPV2.JointType_ShoulderLeft, KinectPV2.JointType_ElbowLeft);
  drawBone(joints, KinectPV2.JointType_ElbowLeft, KinectPV2.JointType_WristLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_HandLeft);
  drawBone(joints, KinectPV2.JointType_HandLeft, KinectPV2.JointType_HandTipLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_ThumbLeft);

  // Right Leg
  drawBone(joints, KinectPV2.JointType_HipRight, KinectPV2.JointType_KneeRight);
  drawBone(joints, KinectPV2.JointType_KneeRight, KinectPV2.JointType_AnkleRight);
  drawBone(joints, KinectPV2.JointType_AnkleRight, KinectPV2.JointType_FootRight);

  // Left Leg
  drawBone(joints, KinectPV2.JointType_HipLeft, KinectPV2.JointType_KneeLeft);
  drawBone(joints, KinectPV2.JointType_KneeLeft, KinectPV2.JointType_AnkleLeft);
  drawBone(joints, KinectPV2.JointType_AnkleLeft, KinectPV2.JointType_FootLeft);

  drawJoint(joints, KinectPV2.JointType_HandTipLeft);
  drawJoint(joints, KinectPV2.JointType_HandTipRight);
  drawJoint(joints, KinectPV2.JointType_FootLeft);
  drawJoint(joints, KinectPV2.JointType_FootRight);

  drawJoint(joints, KinectPV2.JointType_ThumbLeft);
  drawJoint(joints, KinectPV2.JointType_ThumbRight);

  drawJoint(joints, KinectPV2.JointType_Head);
  
}

//draw joint
void drawJoint(KJoint[] joints, int jointType) {
  pushMatrix();
  translate(joints[jointType].getX(), joints[jointType].getY(), joints[jointType].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
}


//draw bone
void drawBone(KJoint[] joints, int jointType1, int jointType2) {
  pushMatrix();
  translate(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
  line(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ(), joints[jointType2].getX(), joints[jointType2].getY(), joints[jointType2].getZ());
}

//draw hand state
void drawHandState(KJoint joint) {
  noStroke();
  handState(joint.getState());
  pushMatrix();
  translate(joint.getX(), joint.getY(), joint.getZ());
  ellipse(0, 0, 70, 70);
  popMatrix();
}

/*
Different hand state
 KinectPV2.HandState_Open
 KinectPV2.HandState_Closed
 KinectPV2.HandState_Lasso
 KinectPV2.HandState_NotTracked
 */
void handState(int handState) {
  switch(handState) {
  case KinectPV2.HandState_Open:
    fill(0, 255, 0);
    break;
  case KinectPV2.HandState_Closed:
    fill(255, 0, 0);
    break;
  case KinectPV2.HandState_Lasso:
    fill(0, 0, 255);
    break;
  case KinectPV2.HandState_NotTracked:
    fill(255, 255, 255);
    break;
  }
}
