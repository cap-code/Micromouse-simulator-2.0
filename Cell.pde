class Cell {
  float x;
  float y;
  int value;
  boolean traversed;
  boolean blue;
  float[] wall= new float[] {
    0, 0, 0, 0
  };
  float[] newWall= new float[] {
    0, 0, 0, 0
  };
  Cell(float a, float b) {
    x=a;
    y=b;
    traversed=false;
    blue=false;
  }
  void render() {
    rectMode(CENTER);
    noStroke();
    if (traversed == true) {
      fill(0, 255, 0);
    } else {
      fill(255);
    }
    rect(x, y, 40, 40);
  }
  void showValue() {
    textSize(16);
    fill(0);
    textAlign(CENTER, CENTER);
    text(this.value, this.x, this.y);
  } 
  boolean detectWalls() {
    int f=0;
    int i= (int(this.x/20)-1)/2;
    int j= (int(this.y/20)-1)/2;
    int wi=(272+j)+(i*17);
    int wj=(0+i)+(j*17);
    if (walls[wi].show ==false) {//top
      this.wall[0]=0.0;
      if (i<=15&&i>=0&&j-1<=15&&j-1>=0) {
        cells[i][j-1].wall[1]=0.0;
      }
    } else {
      this.wall[0]=1.0;
      f=1;
      if (i<=15&&i>=0&&j-1<=15&&j-1>=0) {
        cells[i][j-1].wall[1]=1.0;
      }
    }
    if (walls[wi+1].show ==false) {//bottom
      this.wall[1]=0.0;
      if (i<=15&&i>=0&&j+1<=15&&j+1>=0) {
        cells[i][j+1].wall[0]=0.0;
      }
    } else {
      this.wall[1]=1.0;
      f=1;
      if (i<=15&&i>=0&&j+1<=15&&j+1>=0) {
        cells[i][j+1].wall[0]=1.0;
      }
    }
    if (walls[wj].show ==false) {//left
      this.wall[2]=0.0;
      if (i-1<=15&&i-1>=0&&j<=15&&j>=0) {
        cells[i-1][j].wall[3]=0.0;
      }
    } else {
      this.wall[2]=1.0;
      f=1;
      if (i-1<=15&&i-1>=0&&j<=15&&j>=0) {
        cells[i-1][j].wall[3]=0.0;
      }
    }
    if (walls[wj+1].show ==false) {//right
      this.wall[3]=0.0;
      if (i+1<=15&&i+1>=0&&j<=15&&j>=0) {
        cells[i+1][j].wall[2]=0.0;
      }
    } else {
      this.wall[3]=1.0;
      f=1;
      if (i+1<=15&&i+1>=0&&j<=15&&j>=0) {
        cells[i+1][j].wall[2]=1.0;
      }
    }

    //    println("cell x y", this.x, this.y);
    //    println(wi, wj);
    if (f==0) {
      return false;
    } else {
      return true;
    }
  }
}

