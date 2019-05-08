Update memo of Son Project

-----------------------Data Define----------------------------
/*
data[0] = x1;
data[1] = y1;
data[2] = z1;

data[3] = x2;
data[4] = y2;
data[5] = z2;

data[6] = hSize; //distance from middle of shoulder to middle of body, present the distance from people to KINECT.

data[7] = channel;//id of KINECT skeleton, present the different instruments.

data[8] = rhHeight;//distance from right hand to middle of body in Y-axis, present the volume.
*/
----------------------------END-------------------------------

----------------------2019-99-99-UPDATE-----------------------

Server Part：


Client Part:


Data Simulator:

----------------------------END-------------------------------


----------------------2019-05-07-UPDATE-----------------------

Server Part：
1. Add Skeleton ID instead of i sent in data[7]

Client Part:
1. Recieve Skeleton ID, But not so good. Except MIDIChannel 0， others Tempo is to fast. To Be Check...

Data Simulator:
Null

----------------------------END-------------------------------









----------------------2019-04-21-UPDATE-----------------------

Server Part：
1. Using ’skeletonArrayZ' get right Z value for meter


Client Part:
1. Using keyPressed 'P'control the 'sendMIDI'

Data Simulator:
Null

----------------------------END-------------------------------





----------------------2019-04-19-UPDATE-----------------------

Server Part：
Null

Client Part:
1. Re-construction the all code for support 10 people using.
2. Globle int maxData for instead of maxBox or int[9]

Data Simulator:
1. Re-construction the all code for support 10 people tesing.
2. Globle int maxData for instead of maxBox or int[9]


----------------------------END-------------------------------





----------------------2019-04-18-UPDATE-----------------------

Server Part：
Null

Client Part:
1. Re-Construction class using the Thread for play note and delays.
2. Run test for 46002437 ms.

Data Simulator:
Null

----------------------------END-------------------------------





----------------------2019-04-15-UPDATE-----------------------
IMPORTANT: DATA MODE CHANGE

Server Part：
Null

Client Part:
1. Change DATAMODE using input -> line -> data for multipel data
2. Adding Input/line/data complitment Checking

Data Simulator:
1. Change DATAMODE using \n for different line and \\ for different data group

----------------------------END-------------------------------






----------------------2019-04-14-UPDATE-----------------------
Client ERR:StringIndexOutOfBoundsException: String index out of range: -1 -----Solved

Server Part：
Null

Client Part:
1. Add pData for Previous data in case of data transmit uncompelitment.
2. Add pInput for Previous input in case of data transmit uncompelitment. With 1,solve the 
	problem of Array or String out When server Framerate lower than Client Framerate
	
Data Simulator:
1. Creating control boxes with mouseClicked Function of box Select & Enable
2. Created 5 pairs of control boxes for LHand and RHand.
3. Enable to Sent multiple data

----------------------------END-------------------------------







----------------------2019-04-02-UPDATE-----------------------
Server Part：
1. Change col text display to a-r-g-b;
2. Add notes for hSize , rhHeight;
3. Change Sent value from float to int;


Client Part:
1. Change receive value from float to int;
2. Fix the problem of show line;
3. Fix the functino FindGrid, reture value always abs();

Data Simulator:
1. Creating the Server Data Simulator for Local test for one person's data.

----------------------------END-------------------------------