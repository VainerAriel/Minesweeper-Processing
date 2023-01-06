PImage[] red = new PImage[13];
PImage[] purple = new PImage[13];
PImage[] orange = new PImage[13];
PImage[] yellow = new PImage[13];
PImage[] blue = new PImage[13];
PImage[] green = new PImage[13];
PImage[] colour = new PImage[13];

PImage xFlag;

boolean Red, Purple, Orange, Yellow, Blue = true, Green;

void loadSprites() {
  for (int i = 0; i < red.length; i++) {
    red[i] = loadImage("red\\red ("+i+").png");
  }
  for (int i = 0; i < green.length; i++) {
    green[i] = loadImage("green\\green("+i+").png");
  }
  for (int i = 0; i < blue.length; i++) {
    blue[i] = loadImage("blue\\blue("+i+").png");
  }
  for (int i = 0; i < purple.length; i++) {
    purple[i] = loadImage("purple\\purple("+i+").png");
  }
  for (int i = 0; i < yellow.length; i++) {
    yellow[i] = loadImage("yellow\\yellow("+i+").png");
  }
  for (int i = 0; i < orange.length; i++) {
    orange[i] = loadImage("orange\\orange("+i+").png");
  }

  xFlag = loadImage("x.png");
  
  f = createFont("TASTY DONUTS.otf",15);

  checkAllColors();
}
