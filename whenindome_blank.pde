/*
/ "When in Dome", a geodesic dome filled with LEDs
/ 
/ Uses Fadecandy and OPC to map 4378 LEDs
/ 
*/

import org.openkinect.freenect.*;
import org.openkinect.processing.*;

// Fadecandy server
OPC opc;

// Counting how many LEDs are in each section of strip, there are several different types of triangle so they have different lengths
int[][] isoCounts;
int[][] equiCounts;
int[][] isoLongFirst;       

// Uh this is kind of nonsense but I mapped all the pixels on a high resolution monitor 
// and then just scaled it down so I can see what I'm doing on smaller monitors instead of redoing it all
float scale = 0.7;

void setup() {
  
  size(1765,1360);
  background(0);

  colorMode(HSB, 360);
  frameRate(30);
  
  isoCounts = new int[2][7];
  equiCounts = new int[2][12];  
  isoLongFirst = new int[2][7];
  
  // fadecandy line counts
  isoLongFirst[0][0] = 0;
  isoLongFirst[0][1] = 28;
  isoLongFirst[0][2] = 64;
  isoLongFirst[0][3] = 83;
  isoLongFirst[0][4] = 98;
  isoLongFirst[0][5] = 109;
  isoLongFirst[0][6] = 116;   
  
  // in strip
  isoLongFirst[1][0] = 28;
  isoLongFirst[1][1] = 23;
  isoLongFirst[1][2] = 19;
  isoLongFirst[1][3] = 15;
  isoLongFirst[1][4] = 11;
  isoLongFirst[1][5] = 7;
  isoLongFirst[1][6] = 3;
  
  
  //fc count
  isoCounts[0][0] = 0;
  isoCounts[0][1] = 3;
  isoCounts[0][2] = 10;
  isoCounts[0][3] = 21;
  isoCounts[0][4] = 36;
  isoCounts[0][5] = 64;
  isoCounts[0][6] = 87;   
  
  // in strip
  isoCounts[1][0] = 3;
  isoCounts[1][1] = 7;
  isoCounts[1][2] = 11;
  isoCounts[1][3] = 15;
  isoCounts[1][4] = 19;
  isoCounts[1][5] = 23;
  isoCounts[1][6] = 28;
  
  // fc count
  equiCounts[0][0] = 0;
  equiCounts[0][1] = 30;
  equiCounts[0][2] = 64;
  equiCounts[0][3] = 94;
  equiCounts[0][4] = 128;
  equiCounts[0][5] = 150;
  equiCounts[0][6] = 172;
  equiCounts[0][7] = 192;
  equiCounts[0][8] = 206;
  equiCounts[0][9] = 220;
  equiCounts[0][10] = 226;
  equiCounts[0][11] = 232;
  
  // in strip
  equiCounts[1][0] = 30;
  equiCounts[1][1] = 30;
  equiCounts[1][2] = 30;
  equiCounts[1][3] = 22;
  equiCounts[1][4] = 22;
  equiCounts[1][5] = 22;
  equiCounts[1][6] = 14;
  equiCounts[1][7] = 14;
  equiCounts[1][8] = 14;
  equiCounts[1][9] = 6;
  equiCounts[1][10] = 6;
  equiCounts[1][11] = 6;
  
  // Connect to the local instance of fadecandy server. 
  opc = new OPC(this, "127.0.0.1", 7890);
  opc.showLocations(false);
 
  // Mapping the LEDs 
 
  // void [variousisoscelestrianglefunctions)(int index, float x, float y, float angle){
  // index: start of the triangle on fadecandy
  // x: centre of pentagon
  // y: centre of pentagon
  // angle: angle of triangle from centre to base, in degrees to avoid destroying my brain
  // side 1 is base, clockwise from there. 
 
  // bottom left pentagon
  opc.isoShortFirstLeft(0, 330, 1060, 90);        // 1A
  opc.isoShortFirstLeft(128, 330, 1060, 162);      // 1B
  opc.isoShortFirstRight(256, 330, 1060, 234);     // 1C
  opc.isoLongFirstLeft(3456, 330, 1060, 306);    // 7C
  opc.isoLongFirstRight(3328, 330, 1060, 18);    // 7B
  
  // top left pentagon
  opc.isoLongFirstRight(3968, 520, 390, 90);      // 8C
  opc.isoLongFirstLeft(768, 520, 390, 162);       // 2B 
  opc.isoLongFirstRight(896, 520, 390, 234);      // 2C
  opc.isoLongFirstLeft(1024, 520, 390,306);     // 3A
  opc.isoLongFirstRight(4096, 520, 390, 18);     // 9A  
  
  // top right pentagon
  opc.isoLongFirstLeft(4608, width-520, 390, 90);      // 10A
  opc.isoLongFirstLeft(4480, width-520, 390, 162);      // 9C 
  opc.isoLongFirstRight(1408, width-520, 390, 234);     // 3C
  opc.isoLongFirstLeft(1536, width-520, 390, 306);     // 4A
  opc.isoLongFirstRight(1664, width-520, 390, 18);     // 4B    
  
  // bottom right pentagon
  opc.isoShortFirstRight(2304, width-330, 1060, 90);   // 5C
  opc.isoLongFirstLeft(2816, width-330, 1060, 162);   // 6B
  opc.isoLongFirstRight(2944, width-330, 1060, 234);  // 6C
  opc.isoShortFirstLeft(2048, width-330, 1060, 306);  // 5A
  opc.isoShortFirstLeft(2176, width-330, 1060, 18);  // 5B 
  
  // centre pentagon
  opc.isoShortFirstRight(5248, width/2, 878, 126);   // 11B
  opc.isoLongFirstLeft(3584, width/2, 878, 198);   // 8A
  opc.isoShortFirstLeft(5376, width/2, 878, 270);  // 11C
  opc.isoLongFirstRight(4992, width/2, 878, 342);  // 10C
  opc.isoShortFirstLeft(5120, width/2, 878, 54);  // 11A  
  
  
  //void ledEquilateral(int index, float x, float y, float angle){
  // index: start of the triangle on fadecandy
  // x: centre of triangle
  // y: centre of triangle
  // angle: angle of triangle from centre to base, in degrees to avoid destroying my brain
  // side 1 is base, clockwise from there.
  
  // top pair
  opc.ledEquilateral(1152, width/2, 125, 150); // 3B 
  opc.ledEquilateral(4224, width/2, 513, 330);  // 9B  
  
  // right pair
  opc.ledEquilateral(1792, 1595, 641, 342); // 4C 
  opc.ledEquilateral(4736, 1225, 759, 282);  // 10B    
  
  // left pair
  opc.ledEquilateral(512, width-1595, 641, 318); // 2A
  opc.ledEquilateral(3712, width-1225, 759, 18);  // 8B   
  
  // bottom pair (left first)
  opc.ledEquilateral(3072, 685, 1182, 305); // 7A
  opc.ledEquilateral(2560, width-685, 1182, 355);  // 6A   
  
  
  // Connect to the local instance of fcserver. You can change this line to connect to another computer's fcserver
  opc = new OPC(this, "127.0.0.1", 7890);
  opc.showLocations(false);
  
  noStroke();
}

void draw() {
 
  //background(0);
  
  fill(100,50,100);
  noStroke();
  ellipse(mouseX, mouseY, 100,100);
 
}
