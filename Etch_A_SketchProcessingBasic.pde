import processing.serial.*;
Serial myPort;
int[] serialArray = new int[2];
int serialCount = 0;
int xpos;
int ypos;
boolean firstContact = false;

void setup(){
  size(256,256);
  background(255);
  noStroke();
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}

void serialEvent(Serial myPort){
  int inByte = myPort.read();
  //println(inByte);
  if(firstContact == false){
    if(inByte == 'A'){
      myPort.clear();
      firstContact = true;
      myPort.write('A');
      println('A');
    }
  }else{
    serialArray[serialCount] = inByte;
    serialCount++;
    if(serialCount > 1){
      xpos = serialArray[0];
      ypos = serialArray[1];
      
      println(xpos + "x " + ypos + "y");
      delay(10);
      
      myPort.write('A');
      serialCount = 0;
    }
  }
}

void draw(){
  fill(255,0,0);
  ellipse(xpos, ypos, 10, 10);
}
