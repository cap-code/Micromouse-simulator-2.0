class Backpath{
int x;
int y;
float theta;
float ori;
Backpath(int a,int b,float omega){
x=a;
y=b;
ori = omega;
if(omega == 0.0 || omega == TAU || omega == -TAU){
 theta = 3.14;
}else if(omega == 1.57 || omega == -4.71){
 theta  = 4.71;
}else if(omega == 3.14|| omega == -3.14){
theta = 0.0;
}else if(omega == 4.71|| omega == -1.57){
 theta = 1.57;
 }
}
void display(){
println("path followed",this.x,this.y,this.theta,"original theta",this.ori);
}
}
