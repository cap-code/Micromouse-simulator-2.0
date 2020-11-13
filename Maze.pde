class Maze {
  float space;
  float rows;
  float cols; 
  Maze() {
    space=40;
    rows=640/space;
    cols=640/space;
  }
  void render() {
    noStroke();
//    pushMatrix();
//    popMatrix();
    int x=0;
    for (int j=0; j<rows; j++) {
      for (int i=0; i<=cols; i++) {
        walls[x].change(i*space, j*space, i*space, (j+1)*space);
        x++;
      }
    }
    for (int j=0; j<cols; j++) {
      for (int i=0; i<=rows; i++) {
        walls[x].change(j*space, i*space, (j+1)*space, i*space);
        x++;
      }
    }
    for (int i=0; i<544; i++) {
      if (walls[i].show!=false)
        walls[i].render();
    }
  }
  void update() {
    if (mousePressed==true) {
      for (int i=0; i<544; i++) {
        if (mouseY>walls[i].y1&&mouseY<walls[i].y2) {
          if (mouseX>walls[i].x1-6&&mouseX<walls[i].x1+6) {
            walls[i].show=false;
          }
        }
        if (mouseX>walls[i].x1&&mouseX<walls[i].x2) {
          if (mouseY>walls[i].y1-6&&mouseY<walls[i].y1+6) {
             walls[i].show=false;
          }
        }
      }
    }
  }
}

