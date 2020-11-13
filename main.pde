import g4p_controls.*;
Mouse mouse;
Cell[][] cells;
Maze maze;
Walls[] walls;
final float pi = 3.14;
final float two_pi= 6.28;

boolean runFlag=false;
boolean backFlag=false;
ArrayList<Path> path= new ArrayList<Path>();
ArrayList<Backpath> backpath= new ArrayList<Backpath>();
void setup() {
  size(700, 700);
  createGUI();
  customGUI();
  mouse = new Mouse();
  maze = new Maze();
  cells = new Cell[16][16];
  walls = new Walls[544];
  for (int i=0; i<16; i++) {
    for (int j=0; j<16; j++) {
      cells[i][j]=new Cell(20+(40*i), 20+(40*j));
    }
  }
  for (int i=0; i<544; i++) {
    walls[i]=new Walls(0, 0, 0, 0);
  }
  setValue();
}
void draw() {
  for (int i=0; i<16; i++) {
    for (int j=0; j<16; j++) {
      cells[i][j].render();
      cells[i][j].showValue();
    }
  }
  mouse.render();
  maze.render();
  maze.update();
  if (runFlag==true) {
    mouse.senseWall();
    //runFlag=false;
  }
  if(backFlag==true){
   mouse.backHome();
   //backFlag=false;
  }
}
void setValue() {
  int r=14;
  for (int i=0; i<16; i++) {
    int c=r;
    for (int j=0; j<16; j++) {
      cells[i][j].value=c;

      if (j>6) {
        if (j==7)
          continue;
        c++;
      } else { 

        c--;
      }
    }
    if (i>=7) {
      if (i==7)
        continue;
      r++;
    } else {
      r--;
    }
  }
}
public void customGUI() {
}

