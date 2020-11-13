class Mouse {
  float x;
  float y;
  float r;
  float theta;
  Mouse() {
    x=20;
    y=620;
    r=5;
    theta=0;
  }
  void render() {
    pushMatrix();
    translate(x, y);
    rotate(theta);
    noStroke();
    fill(255, 0, 0);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r*1.2, r*2);
    vertex(r*1.2, r*2);
    endShape();
    popMatrix();
  }
  void senseWall() {
    boolean flag;
    int ix = ((int(this.x)/20)-1)/2 ;
    int jy = ((int(this.y)/20)-1)/2 ;
    if (ix!=7||jy!=8 ) {
      if ( ix!=7||jy!=7) {
        if (ix!=8||jy!=8) {
          if ( ix!=8||jy!=7 ) {// if the current cell is on of the center cell
//            println("------------------------------------------------------");
//            println("current cell x y", ix, jy);


            flag=cells[ix][jy].detectWalls();//detect walls

              run(ix, jy);      //go to neighbouring cell with least value
              backpath.add(new Backpath(ix,jy,this.theta));


            //run the update distance algorithm
            if (path.size()==0) {//make sure path is empty
              if (flag==true) {//if there is new walls discovered
                path.add(new Path(ix, jy)); // push the current cell and the cells adjacent to the new walls
                if (cells[ix][jy].wall[0]==1&&cells[ix][jy].newWall[0]==0) {//top
                   cells[ix][jy].newWall[0]=1;
                  if ((ix<=15&&ix>=0)&&(jy-1<=15&&jy-1>=0)) {
                    if (ix!=7||jy-1!=8) {
                      if (ix!=7||jy-1!=7) {
                        if (ix!=8||jy-1!=7) {
                          if (ix!=8||jy-1!=8) {
                            path.add(new Path(ix, jy-1));
                          }
                        }
                      }
                    }
                  }
                }
                if (cells[ix][jy].wall[3]==1&&cells[ix][jy].newWall[3]==0) {//right
                    cells[ix][jy].newWall[3]=1;
                  if ((ix+1<=15&&ix+1>=0)&&(jy<=15&&jy>=0)) {
                    if (ix+1!=7||jy!=8) {
                      if (ix+1!=7||jy!=7) {
                        if (ix+1!=8||jy!=7) {
                          if (ix+1!=8||jy!=8) {
                            path.add(new Path(ix+1, jy));
                          }
                        }
                      }
                    }
                  }
                }
                if (cells[ix][jy].wall[2]==1&&cells[ix][jy].newWall[2]==0) {//left
                   cells[ix][jy].newWall[2]=1;
                  if ((ix-1<=15&&ix-1>=0)&&(jy<=15&&jy>=0)) {
                    if (ix-1!=7||jy!=8) {
                      if (ix-1!=7||jy!=7) {
                        if (ix-1!=8||jy!=7) {
                          if (ix-1!=8||jy!=8) {
                            path.add(new Path(ix-1, jy));
                          }
                        }
                      }
                    }
                  }
                }
                if (cells[ix][jy].wall[1]==1&&cells[ix][jy].newWall[1]==0) {//bottom
                   cells[ix][jy].newWall[1]=1;
                  if ((ix<=15&&ix>=0)&&(jy+1<=15&&jy+1>=0)) {
                    if (ix!=7||jy+1!=8) {
                      if (ix!=7||jy+1!=7) {
                        if (ix!=8||jy+1!=7) {
                          if (ix!=8||jy+1!=8) {
                            path.add(new Path(ix, jy+1));
                          }
                        }
                      }
                    }
                  }
                }
              }

              while (path.size ()>0) {//while stack is not empty
                int pi=path.get(path.size()-1).x;
                int pj=path.get(path.size()-1).y;
                path.remove(path.size()-1);//pop the top of the stack
                int currentValue = cells[pi][pj].value;
                int smallValue= open_nei(pi, pj);
                if (currentValue!=smallValue+1) {
                  cells[pi][pj].value = smallValue+1;//set value to smallValue+1 and push all open neighbours to stack
                  //if (cells[pi][pj].wall[0]==0) {//top
                    if (pi<=15&&pi>=0&&pj-1<=15&&pj-1>=0) {
                      if (pi!=7||pj-1!=8) {
                        if ( pi!=7||pj-1!=7) {
                          if ( pi!=8||pj-1!=8 ) {
                            if ( pi!=8||pj-1!=7 ) {
                              path.add(new Path(pi, pj-1));
                            //}
                          }
                        }
                      }
                    }
                  }
                  //if (cells[pi][pj].wall[3]==0) {//right
                    if (pi+1<=15&&pi+1>=0&&pj-1<=15&&pj-1>=0) {
                      if (pi+1!=7||pj!=8) {
                        if ( pi+1!=7||pj!=7) {
                          if ( pi+1!=8||pj!=8) {
                            if ( pi+1!=8||pj!=7 ) {
                              path.add(new Path(pi+1, pj));
                           // }
                          }
                        }
                      }
                    }
                  }
                 // if (cells[pi][pj].wall[2]==0) {//left
                    if (pi-1<=15&&pi-1>=0&&pj<=15&&pj>=0) {
                      if (pi-1!=7||pj!=8 ) {
                        if ( pi-1!=7||pj!=7 ) {
                          if ( pi-1!=8||pj!=8 ) {
                            if ( pi-1!=8||pj!=7 ) {
                              path.add(new Path(pi-1, pj));
                           // }
                          }
                        }
                      }
                    }
                  }
                  //if (cells[pi][pj].wall[1]==0) {//bottom
                    if (pi<=15&&pi>=0&&pj+1<=15&&pj+1>=0) {
                      if (pi!=7||pj+1!=8 ) {
                        if ( pi!=7||pj+1!=7 ) {
                          if ( pi!=8||pj+1!=8) {
                            if ( pi!=8||pj+1!=7 ) {
                              path.add(new Path(pi, pj+1));
                            //}
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    cells[ix][jy].traversed =true;//setting cell if it is traversed or not
  }
  int  findSmallestValue( int x, int y) {
    int px=x;
    int py=y;
    int[] svl=new int[] {
      100, 100, 100, 100
    };
    if (cells[px][py].wall[0]==0.0) {
      if ((px<=15&&px>=0)&&(py-1<=15&&py-1>=0)) {
        svl[0]=cells[px][py-1].value;
      }
    }
    if (cells[px][py].wall[1]==0.0) {
      if ((px<=15&&px>=0)&&(py+1<=15&&py+1>=0)) {
        svl[1]=cells[px][py+1].value;
      }
    }
    if (cells[px][py].wall[2]==0.0) {
      if ((px-1<=15&&px-1>=0)&&(py<=15&&py>=0)) {
        svl[2]=cells[px-1][py].value;
      }
    }
    if (cells[px][py].wall[3]==0.0) {
      if ((px+1<=15&&px+1>=0)&&(py<=15&&py>=0)) {
        svl[3]=cells[px+1][py].value;
      }
    }
    svl = sort(svl);
    return svl[0];
  }
  void move() {
    if (this.theta >= two_pi||this.theta <= -two_pi) {
      this.theta = 0.0;
    }
    if (this.theta == 0.0|| this.theta ==two_pi|| this.theta == -two_pi) {
      this.y-=40;
    }
    if (this.theta == pi/2 || this.theta == -(two_pi-pi/2)) {
      this.x+=40;
    } else if (this.theta == pi || this.theta == -pi) { //|| this.theta == 3.1415925) {
      this.y+=40;
    } else if (this.theta == (two_pi-pi/2) || this.theta  == -pi/2) {
      this.x-=40;
    }
  }
  void moveRight(float a) {
    if (a == 4.71) {
      this.theta =0.0;
    } else if (a == 3.14) {
      this.theta = 4.71;
    } else if (a == 1.57) {
      this.theta = 3.14;
    } else if (a == 0.0) {
      this.theta = 1.57;
    }

    if (this.theta >= two_pi||this.theta <= -two_pi) {
      this.theta = 0.0;
    } 
    move();
  }
  void moveLeft(float a) {
    if (a == 4.71) {
      this.theta =3.14;
    } else if (a == 3.14) {
      this.theta = 1.57;
    } else if (a == 1.57) {
      this.theta = 0.0;
    } else if (a == 0.0) {
      this.theta = 4.71;
    }

    if (this.theta >= two_pi|| this.theta <= -two_pi) {
      this.theta = 0.0;
    }
    move();
  }

  int open_nei(int a, int b) {
    int[] s=new int[] {
      100, 100, 100, 100
    };
    if (cells[a][b].wall[0]==0.0) {//top
      if (a<=15&&a>=0&&b-1<=15&&b-1>=0) {
        s[0]=cells[a][b-1].value;
      }
    }
    if (cells[a][b].wall[1]==0.0) {//bottom
      if (a<=15&&a>=0&&b+1<=15&&b+1>=0) {
        s[1]=cells[a][b+1].value;
      }
    }
    if (cells[a][b].wall[3]==0.0) {//right
      if (a+1<=15&&a+1>=0&&b<=15&&b>=0) {
        s[2]=cells[a+1][b].value;
      }
    }
    if (cells[a][b].wall[2]==0.0) {//left
      if (a-1<=15&&a-1>=0&&b<=15&&b>=0) {
        s[3]=cells[a-1][b].value;
      }
    }
    s=sort(s);
    return s[0];
  }

  void run(int ix, int jy) {
    float[] nextValue= new float[] {
      100, 100, 100
    };
    if (this.theta >= two_pi||this.theta <= -two_pi) {
      this.theta =0.0;
    }
    if (this.theta == 0.0 || this.theta == two_pi || this.theta == -two_pi) {
      if (cells[ix][jy].wall[0]==0.0) {
        nextValue[0]=cells[ix][jy-1].value;//top
      }
      if (cells[ix][jy].wall[3]==0.0) {
        nextValue[1] = cells[ix+1][jy].value;//right
      }
      if (cells[ix][jy].wall[2]==0.0) {
        nextValue[2] = cells[ix-1][jy].value;//left
      }
    } else if (this.theta==pi/2|| this.theta ==-(two_pi-pi/2) ) {
      if (cells[ix][jy].wall[3]==0.0) {
        nextValue[0]=cells[ix+1][jy].value;//top
      }
      if (cells[ix][jy].wall[1]==0.0) {
        nextValue[1] = cells[ix][jy+1].value;//right
      }
      if (cells[ix][jy].wall[0]==0.0) {
        nextValue[2] = cells[ix][jy-1].value;//left
      }
    } else if (this.theta == pi|| this.theta == -pi) {
      if (cells[ix][jy].wall[1]==0.0) {
        nextValue[0]=cells[ix][jy+1].value;//top
      }
      if (cells[ix][jy].wall[2]==0.0) {
        nextValue[1] = cells[ix-1][jy].value;//right
      }
      if (cells[ix][jy].wall[3]==0.0) {
        nextValue[2] = cells[ix+1][jy].value;//left
      }
     // println("this bug worked");
    } else if (this.theta == (two_pi-pi/2)|| this.theta==- pi/2) {
      if (cells[ix][jy].wall[2]==0.0) {
        nextValue[0]=cells[ix-1][jy].value;//top
      }
      if (cells[ix][jy].wall[0]==0.0) {
        nextValue[1] = cells[ix][jy-1].value;//right
      }
      if (cells[ix][jy].wall[1]==0.0) {
        nextValue[2] = cells[ix][jy+1].value;//left
      }
    }
    //println("cell wall ", cells[ix][jy].wall[0], cells[ix][jy].wall[1], cells[ix][jy].wall[2], cells[ix][jy].wall[3]);
    //println(nextValue[0], nextValue[1], nextValue[2], this.theta);
    if (nextValue[0]<=nextValue[1]) {
      if (nextValue[0]<=nextValue[2]) {
        if (nextValue[0]==100 && nextValue[1]==100 && nextValue[2]==100) {
          if (this.theta == 0.0|| this.theta == TAU || this.theta ==-TAU) {
            this.theta = 3.14;
          } else if (this.theta == pi||this.theta == -pi) {
            this.theta = 0.0;
          } else if (this.theta == pi/2 || this.theta == -(two_pi-pi/2)) {
            this.theta = 4.71;
          } else if (this.theta == -pi/2 || this.theta == (two_pi-pi/2)) {
            this.theta = 1.57;
          }
          //move();
         // println(this.theta, "stuck theta value");
        } else {
          move();
          //println("straight because i like it!!!!");
        }
      } else {
        moveLeft(this.theta);
        //println("turned left");
      }
    } else {
      if (nextValue[1]<=nextValue[2]) {
        moveRight(this.theta);
       // println("turned right");
      } else {
        moveLeft(this.theta);
        //println("turned left");
      }
    }
  }
  void backHome(){
    int n = backpath.size()-1;
    if(backpath.size()>0){
      int x = ((backpath.get(n).x*2)+1)*20;
      int y = ((backpath.get(n).y*2)+1)*20; 
       if(x == this.x+40){
        this.theta  = 1.57;
       }else if(x == this.x-40){
        this.theta = 4.71;
       }else if(y == this.y+40){
        this.theta = 3.14;
       }else if(y == this.y-40){
        this.theta = 0.0;
       }
       this.x = x;
       this.y = y;
     //backpath.get(n).display();
     backpath.remove(n);
    }
  }
//  void backHome() {
//    boolean flag;
//    int ix = ((int(this.x)/20)-1)/2 ;
//    int jy = ((int(this.y)/20)-1)/2 ;
//    flag = cells[ix][jy].detectWalls();
//    if (ix!=0||jy!=15 ) { // if the current cell is on of the start cell
//      println("current cell x y", ix, jy);
//      flag=cells[ix][jy].detectWalls();//detect walls
//
//        runHome(ix, jy);      //go to neighbouring cell with least value and do not goto the center cell
//
//
//
//      //run the update distance algorithm
//      if (path.size()==0) {//make sure path is empty
//       // if (cells[ix][jy].traversed==false) {
//          if (ix!=7||jy!=8) {
//            if (ix!=7||jy!=7) {
//              if (ix!=8||jy!=8) {
//                if (ix!=8||jy!=7) {
//                  if (flag==true) {//if there is new walls discovered
//                    path.add(new Path(ix, jy)); // push the current cell and the cells adjacent to the new walls
//                    if (cells[ix][jy].wall[0]==1&&cells[ix][jy].newWall[0]==0) {//top
//                      if ((ix<=15&&ix>=0)&&(jy-1<=15&&jy-1>=0)) {
//                        if (ix!=7||jy-1!=8) {
//                          if (ix!=7||jy-1!=7) {
//                            if (ix!=8||jy-1!=7) {
//                              if (ix!=8||jy-1!=8) {
//                                path.add(new Path(ix, jy-1));
//                              }
//                            }
//                          }
//                        }
//                      }
//                    }
//                    if (cells[ix][jy].wall[3]==1&&cells[ix][jy].newWall[3]==0) {//right
//                      if ((ix+1<=15&&ix+1>=0)&&(jy<=15&&jy>=0)) {
//                        if (ix+1!=7||jy!=8) {
//                          if (ix+1!=7||jy!=7) {
//                            if (ix+1!=8||jy!=7) {
//                              if (ix+1!=8||jy!=8) {
//                                path.add(new Path(ix+1, jy));
//                              }
//                            }
//                          }
//                        }
//                      }
//                    }
//                    if (cells[ix][jy].wall[2]==1&&cells[ix][jy].newWall[2]==0) {//left
//                      if ((ix-1<=15&&ix-1>=0)&&(jy<=15&&jy>=0)) {
//                        if (ix-1!=7||jy!=8) {
//                          if (ix-1!=7||jy!=7) {
//                            if (ix-1!=8||jy!=7) {
//                              if (ix-1!=8||jy!=8) {
//                                path.add(new Path(ix-1, jy));
//                              }
//                            }
//                          }
//                        }
//                      }
//                    }
//                    if (cells[ix][jy].wall[1]==1&&cells[ix][jy].newWall[1]==0) {//bottom
//                      if ((ix<=15&&ix>=0)&&(jy+1<=15&&jy+1>=0)) {
//                        if (ix!=7||jy+1!=8) {
//                          if (ix!=7||jy+1!=7) {
//                            if (ix!=8||jy+1!=7) {
//                              if (ix!=8||jy+1!=8) {
//                                path.add(new Path(ix, jy+1));
//                              }
//                            }
//                          }
//                        }
//                      }
//                    }
//                  }
//
//                  while (path.size ()>0) {//while stack is not empty
//                    int pi=path.get(path.size()-1).x;
//                    int pj=path.get(path.size()-1).y;
//                    path.remove(path.size()-1);//pop the top of the stack
//                    int currentValue = cells[pi][pj].value;
//                    int smallValue= open_nei(pi, pj);
//                    if (currentValue!=smallValue+1) {
//                      cells[pi][pj].value = smallValue+1;//set value to smallValue+1 and push all open neighbours to stack
//                      // if (cells[pi][pj].wall[0]==0) {//top
//                      if (pi<=15&&pi>=0&&pj-1<=15&&pj-1>=0) {
//                        if (pi!=7||pj-1!=8) {
//                          if ( pi!=7||pj-1!=7) {
//                            if ( pi!=8||pj-1!=8 ) {
//                              if ( pi!=8||pj-1!=7 ) {
//                                path.add(new Path(pi, pj-1));
//                                //}
//                              }
//                            }
//                          }
//                        }
//                      }
//                      //if (cells[pi][pj].wall[3]==0) {//right
//                      if (pi+1<=15&&pi+1>=0&&pj-1<=15&&pj-1>=0) {
//                        if (pi+1!=7||pj!=8) {
//                          if ( pi+1!=7||pj!=7) {
//                            if ( pi+1!=8||pj!=8) {
//                              if ( pi+1!=8||pj!=7 ) {
//                                path.add(new Path(pi+1, pj));
//                                //}
//                              }
//                            }
//                          }
//                        }
//                      }
//                      // if (cells[pi][pj].wall[2]==0) {//left
//                      if (pi-1<=15&&pi-1>=0&&pj<=15&&pj>=0) {
//                        if (pi-1!=7||pj!=8 ) {
//                          if ( pi-1!=7||pj!=7 ) {
//                            if ( pi-1!=8||pj!=8 ) {
//                              if ( pi-1!=8||pj!=7 ) {
//                                path.add(new Path(pi-1, pj));
//                                //}
//                              }
//                            }
//                          }
//                        }
//                      }
//                      // if (cells[pi][pj].wall[1]==0) {//bottom
//                      if (pi<=15&&pi>=0&&pj+1<=15&&pj+1>=0) {
//                        if (pi!=7||pj+1!=8 ) {
//                          if ( pi!=7||pj+1!=7 ) {
//                            if ( pi!=8||pj+1!=8) {
//                              if ( pi!=8||pj+1!=7 ) {
//                                path.add(new Path(pi, pj+1));
//                                //}
//                              }
//                            }
//                          }
//                        }
//                      }
//                    }
//                  }
//                }
//              }
//            }
//          }
//        //}
//      }
//
//
//      println("----------------------------------");
//    }
//    cells[ix][jy].traversed =true;//setting cell if it is traversed or not
//    cells[ix][jy].blue =true;// setting the path to return home
//  }
//  void runHome(int ix, int jy) {
//    float[] nextValue= new float[] {
//      -1, -1, -1
//    };
//    boolean[] bluehome = new boolean[] {
//      true, true, true
//    };
//    if (this.theta >= two_pi||this.theta <= -two_pi) {
//      this.theta =0.0;
//    }
//    if (this.theta == 0.0 || this.theta == two_pi || this.theta == -two_pi) {
//      if (cells[ix][jy].wall[0]==0.0) {
//        nextValue[0]=cells[ix][jy-1].value;//top
//        bluehome[0]=cells[ix][jy-1].blue;
//      }
//      if (cells[ix][jy].wall[3]==0.0) {
//        nextValue[1] = cells[ix+1][jy].value;//right
//        bluehome[1]=cells[ix+1][jy].blue;
//      }
//      if (cells[ix][jy].wall[2]==0.0) {
//        nextValue[2] = cells[ix-1][jy].value;//left
//        bluehome[2]=cells[ix-1][jy].blue;
//      }
//    } else if (this.theta==pi/2|| this.theta ==-(3*pi)/2 ) {
//      if (cells[ix][jy].wall[3]==0.0) {
//        nextValue[0]=cells[ix+1][jy].value;//top
//        bluehome[0]=cells[ix+1][jy].blue;
//      }
//      if (cells[ix][jy].wall[1]==0.0) {
//        nextValue[1] = cells[ix][jy+1].value;//right
//        bluehome[1]=cells[ix][jy+1].blue;
//      }
//      if (cells[ix][jy].wall[0]==0.0) {
//        nextValue[2] = cells[ix][jy-1].value;//left
//        bluehome[2]=cells[ix][jy-1].blue;
//      }
//    } else if (this.theta == pi|| this.theta == -pi) {
//      if (cells[ix][jy].wall[1]==0.0) {
//        nextValue[0]=cells[ix][jy+1].value;//top
//        bluehome[0]=cells[ix][jy+1].blue;
//      }
//      if (cells[ix][jy].wall[2]==0.0) {
//        nextValue[1] = cells[ix-1][jy].value;//right
//        bluehome[1]=cells[ix-1][jy].blue;
//      }
//      if (cells[ix][jy].wall[3]==0.0) {
//        nextValue[2] = cells[ix+1][jy].value;//left
//        bluehome[2]=cells[ix+1][jy].blue;
//      }
//      println("this bug worked");
//    } else if (this.theta == (3*pi)/2|| this.theta==- pi/2) {
//      if (cells[ix][jy].wall[2]==0.0) {
//        nextValue[0]=cells[ix-1][jy].value;//top
//        bluehome[0]=cells[ix-1][jy].blue;
//      }
//      if (cells[ix][jy].wall[0]==0.0) {
//        nextValue[1] = cells[ix][jy-1].value;//right
//        bluehome[1] = cells[ix][jy-1].blue;
//      }
//      if (cells[ix][jy].wall[1]==0.0) {
//        nextValue[2] = cells[ix][jy+1].value;//left
//        bluehome[2] = cells[ix][jy+1].blue;
//      }
//    }
//    println(nextValue[0], nextValue[1], nextValue[2], this.theta);
//    println("---------------------------------------------");
//  if(bluehome[0]==false){
//  move();
//  }else if(bluehome[1]==false){
//  moveRight(this.theta);
//  }else if(bluehome[2]==false){
//  moveLeft(this.theta);
//  }else{
//       if (nextValue[0]>=nextValue[1]) {
//      if (nextValue[0]>=nextValue[2]) {
//        if (nextValue[0]==-1 && nextValue[1]==-1 && nextValue[2]==-1) {
//
//          if (this.theta == 0.0|| this.theta == two_pi || this.theta ==-two_pi) {
//            this.theta = 3.14;
//          } else if (this.theta == pi||this.theta == -pi) {
//            this.theta = 0.0;
//          } else if (this.theta == 1.57 || this.theta == -4.71) {
//            this.theta = 4.71;
//          } else if (this.theta == -1.57 || this.theta == 4.71 ) {
//            this.theta = 1.57;
//          }
//        } else {
//          move();
//        }
//      } else {
//        moveLeft(this.theta);
//      }
//    } else {
//      if (nextValue[1]>=nextValue[2]) {
//        moveRight(this.theta);
//      } else {
//        moveLeft(this.theta);
//      }
//    }
//  
//  
//  
//  
//  }
//
//
//
//
//
//
// 
//  }
}

