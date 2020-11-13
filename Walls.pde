class Walls {
  float x1;
  float x2;
  float y1;
  float y2;
  boolean show;
  Walls(float x1,float y1,float  x2,float y2) {
    x1=x1;
    y1=y1;
    x2=x2;
    y2=y2;
    show=true;
  }
  void render() {
    strokeWeight(5);
    stroke(0, 100);
    line(x1, y1, x2, y2);
  }
  void change(float x1,float  y1,float  x2,float y2) {
    this.x1=x1;
    this.y1=y1;
    this.x2=x2;
    this.y2=y2;
  }
}
