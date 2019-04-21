/**
 * Shared Drawing Canvas (Client) 
 * by Alexander R. Galloway. 
 * 
 * The Processing Client class is instantiated by specifying a remote 
 * address and port number to which the socket connection should be made. 
 * Once the connection is made, the client may read (or write) data to the server.
 * Before running this program, start the Shared Drawing Canvas (Server) program.
 */


import processing.net.*;

Client c;
String input;
float data[];

void setup() 
{
  size(1280, 720, P3D);
  frameRate(5);
  // Connect to the server's IP address and port
  c = new Client(this, "192.168.1.26", 12345); // Replace with your server's IP and port
}

void draw() 
{
  // Receive data from server
  if (c.available() > 0) {
    input = c.readString();
    input = input.substring(0, input.indexOf("\n")); // Only up to the newline
    data = float(split(input, ' ')); // Split values into an array
    // Draw line using received coords
    background(255);
    stroke(0);
    line(data[0]*1280/1920, data[1]*1280/1920, data[2]*1280/1920, data[3]*1280/1920,data[4]*1280/1920,data[5]*1280/1920);
    
    println(data[0]);
  }
}
