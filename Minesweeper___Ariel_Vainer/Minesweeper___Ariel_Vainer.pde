int columns = 9;
int rows = 9;

int WIDTH = 750;
int HEIGHT = 750;

int squareSize;
{
  if (columns<rows) {
    squareSize = WIDTH/columns;
  } else {
    squareSize = WIDTH/rows;
  }
}
int squareWidth = WIDTH/rows;
int squareHeight = HEIGHT/columns;

int bombs = 8, count;

boolean gameOver, died, stopShaking = true, won;

PFont f;

boolean first;

Tile[][] tiles = new Tile[columns][rows]; // making a grid

void setup() {
  frameRate(60);
  // setting up compatible size;
  surface.setSize(WIDTH, HEIGHT);
  surface.setLocation((displayWidth/2)-(WIDTH/2), (displayHeight/2)-(HEIGHT/2));

  loadSprites();

  if (bombs>=columns*rows) {
    bombs = (columns*rows)-1;
  }

  // placing bombs and numbers
  setupTileValues();
}

void draw() {
  background(0);

  if (died) {
    if (stopShaking) {
      translate(random(-7.5, 7.5), random(-7.5, 7.5));
    }
  } 

  checkAllColors();

  // rendering the board
  for (int i = 0; i<columns; i++) {
    for (int j = 0; j<rows; j++) {
      tiles[i][j].render();
    }
  }
  if (gameOver) {
    gameOver();
  }

  winning();
}
void keyPressed() {
  if (key=='1') {
    turnTrue(true, false, false, false, false, false);
  }
  if (key=='2') {
    turnTrue(false, true, false, false, false, false);
  }
  if (key=='3') {
    turnTrue(false, false, true, false, false, false);
  }
  if (key=='4') {
    turnTrue(false, false, false, true, false, false);
  }
  if (key=='5') {
    turnTrue(false, false, false, false, true, false);
  }
  if (key=='6') {
    turnTrue(false, false, false, false, false, true);
  }
}
void mousePressed() {
  if (!gameOver && !won) {
    if (mouseButton == LEFT) {
      // revealing stuff
      for (int i = 0; i<columns; i++) {
        for (int j = 0; j<rows; j++) {
          if (tiles[i][j].contains(mouseX, mouseY)) {
            int countEmpty = 0;
            int countNotBomb = 0;
            for (int a = 0; a<columns; a++) {
              for (int b = 0; b<rows; b++) {
                if (tiles[a][b].bombCount==0) {
                  countEmpty++;
                }
                if (!tiles[a][b].bomb) {
                  countNotBomb++;
                }
              }
            }
            // making sure the program always works
            if (countEmpty>0) {
              if (first) {
                // makes sure first tile is empty
                while (tiles[i][j].bomb || tiles[i][j].bombCount!=0) {
                  setupTileValues();
                }
                first = false;
              }
            } else if (countNotBomb>0) {
              if (first) {
                // makes sure that if there isnt empty one then a number
                while (tiles[i][j].bomb) {
                  setupTileValues();
                }
                first = false;
              }
            }
            tiles[i][j].reveal();
          }
        }
      }
    } else if ( mouseButton == RIGHT) {
      // flagging stuff
      for (int i = 0; i<columns; i++) {
        for (int j = 0; j<rows; j++) {
          if (tiles[i][j].contains(mouseX, mouseY)) {
            if (!tiles[i][j].revealed) {
              tiles[i][j].flagged = true;
            }
          }
        }
      }
    }
  }
}
