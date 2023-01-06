class Tile {
  int iX, iY;
  int x, y;
  int bombCount;
  boolean bomb, revealed, flagged;
  boolean dead, falseFlag, redBomb;

  Tile(int ixT, int iyT) {
    iX = ixT;
    iY = iyT;
    x = iX*squareWidth;
    y = iY*squareHeight;

    bombCount = 0;

    bomb = false;
    revealed = false;
    flagged = false;
  }
  void render() {
    // cover
    image(colour[9], this.x, this.y, squareWidth, squareHeight); // put here the defult image

    if (!redBomb) {
      if (!falseFlag) {
        if (!flagged) {
          // actual value
          if (this.revealed) {
            if (this.bomb) {
              image(colour[10], this.x, this.y, squareWidth, squareHeight);
            } else {
              // use bombCount
              image(colour[bombCount], this.x, this.y, squareWidth, squareHeight);
            }
          }
        } else {
          image(colour[12], this.x, this.y, squareWidth, squareHeight);
        }
      } else {
        image(colour[12], this.x, this.y, squareWidth, squareHeight);

        tint(0,0,0);
        image(xFlag, this.x, this.y, squareWidth, squareHeight);
        tint(255);
      }
    } else {
      tint(255, 0, 0);
      image(colour[10], this.x, this.y, squareWidth, squareHeight);
      tint(255);
    }
  }
  void checkBombs() {
    // counting bombs near this tile
    int total = 0;

    // ignor it if its a bomb
    if (this.bomb) {
      total = -1;
    } else {
      // checks the 3*3 square around the tile
      for (int iX = -1; iX <= 1; iX++) {
        for (int iY = -1; iY <= 1; iY++) {
          int i = this.iX + iX;
          int j = this.iY + iY;

          // if tile is outside of array - no reason to check it
          if (i > -1 && i < columns && j > -1 && j < rows) {
            Tile neighbor = tiles[i][j];
            if (neighbor.bomb) {
              total++;
            }
          }
        }
      }
    }

    this.bombCount = total;
  }
  void reavealNeighbors() {
    // reveal all empty spaces
    for (int iX = -1; iX <= 1; iX++) {
      for (int iY = -1; iY <= 1; iY++) {
        int i = this.iX + iX;
        int j = this.iY + iY;

        // if tile is outside of array - no reason to check it
        if (i > -1 && i < columns && j > -1 && j < rows) {
          Tile neighbor = tiles[i][j];
          if (!neighbor.bomb && !neighbor.revealed) {
            neighbor.reveal();
          }
        }
      }
    }
  }

  void reveal() {
    // reveal this tile or unflag it
    if (!flagged) {
      this.revealed = true;

      if (this.bombCount == 0) {
        this.reavealNeighbors();
      }

      if (this.bomb) {
        redBomb = true;
        gameOver = true;
        died = true;
        keyCode=UP;
      }
    } else {
      flagged = false;
    }
  }
  boolean contains(float x, float y) {
    // is that point inside that box?
    return (rectCollision(x, y, this.x, this.y, squareWidth, squareHeight));
  }
}
