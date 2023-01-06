void setupTileValues() {
  // creating the grid
  for (int i = 0; i<columns; i++) {
    for (int j = 0; j<rows; j++) {
      tiles[i][j] = new Tile(i, j);
    }
  }

  // placing bombs
  for (int i = 0; i<bombs; i++) {
    int indexx = floor(random(columns));
    int indexy = floor(random(rows));
    if (!tiles[indexx][indexy].bomb) {
      tiles[indexx][indexy].bomb = true;
    } else {
      i--;
    }
  }

  // counting bombs near mel
  for (int i = 0; i<columns; i++) {
    for (int j = 0; j<rows; j++) {
      tiles[i][j].checkBombs();
    }
  }

  textFont(f);
  stopShaking = true;
  died = false;
  gameOver = false;
  won = false;
  first = true;
  keyCode = UP;
  key = 0;
}
void winning() {
  if (!died) {
    key=0;
    int count = 0;
    for (int i = 0; i<columns; i++) {
      for (int j = 0; j<rows; j++) {
        if (tiles[i][j].revealed) {
          count++;
        }
      }
    }
    println(rows*columns-bombs);
    println(count);
    if (count==(rows*columns)-bombs) {
      won = true;
      textSize(150);
      textAlign(CENTER);
      
      int lineWidth = 5;
      
      outline(color(0),"You Won!", width/2, 2*width/5, lineWidth);
      fill(255);
      text("You Won!", width/2, 2*height/5);

      textSize(100);
      outline(color(0),"Press ENTER to\nPlay Again", width/2, 7*height/10, lineWidth);
      fill(255);
      text("Press ENTER to\nPlay Again", width/2, 7*height/10);

      colorMode(HSB, 360, 100, 100);
      tint((3*frameCount)%360, 100, 100);
      colorMode(RGB, 255, 255, 255);

      if (keyCode==ENTER) {
        setupTileValues();
        tint(255);
        won = false;
      }
    }
  }
}
void gameOver() {
  // ending the game
breakWholeLoop:
  for (int i = 0; i<columns; i++) {
    for (int j = 0; j<rows; j++) {
      if (!tiles[j][i].dead && !tiles[j][i].revealed) {
        if (tiles[j][i].flagged) {
          if (!tiles[j][i].bomb) {
            tiles[j][i].falseFlag = true;
          }
        }

        tiles[j][i].revealed = true;
        tiles[j][i].dead = true;

        break breakWholeLoop;
      }
      if (i==columns-1 && j == columns-1) {
        stopShaking = false;
      }
    }
  }
  
  
  textSize(150);
  textAlign(CENTER);
  
  int lineWidth = 5;
  
  outline(color(0),"You Lost!",width/2,2*height/5,lineWidth);
  fill(255);
  text("You Lost!", width/2, 2*height/5);
  
  textSize(100);
  outline(color(0),"Press ENTER to\nPlay Again",width/2,7*height/10,lineWidth);
  fill(255);
  text("Press ENTER to\nPlay Again", width/2, 7*height/10);

  if (keyCode==ENTER) {
    setupTileValues();
    tint(255);
    gameOver = false;
  }
}

void outline(color c, String s, float x, float y, int size){
  fill(c);
  text(s, x+size, y+size);
  text(s, x-size, y-size);
  text(s, x+size, y-size);
  text(s, x-size, y+size);
  text(s, x+size, y);
  text(s, x-size, y);
  text(s, x, y+size);
  text(s, x, y-size);
}

void changeColor(boolean a, PImage[] b) {
  // change different themes
  if (a) {
    for (int i = 0; i<colour.length; i++) {
      colour[i] = b[i];
    }
  }
}
void turnTrue(boolean a, boolean b, boolean c, boolean d, boolean e, boolean f) {
  // turn between themes
  Red=a; 
  Purple=b; 
  Orange=c; 
  Yellow=d; 
  Green=e; 
  Blue=f;
}

void checkAllColors() {
  changeColor(Red, red);
  changeColor(Purple, purple);
  changeColor(Orange, orange);
  changeColor(Yellow, yellow);
  changeColor(Green, green);
  changeColor(Blue, blue);
}

boolean rectCollision(float pointX, float pointY, float boxX, float boxY, float boxW, float boxH) {
  return(pointX > boxX && pointX < boxX + boxW && pointY > boxY && pointY < boxY + boxH);
}
