PVector GRAVITY = new PVector(0,0.2);
PVector WIND = new PVector(random(-2,2),random(-2,2));
float DAMPING = 0.98;
int row = 28;
int column = 20;
int len = 20;

class Particle {
  PVector pos;
  PVector prepos;
  boolean locked = false;
  Particle(int x, int y){
    pos = new PVector(x,y);
    prepos = pos.copy();
  }
  void display(){
    fill(255);
    circle(pos.x,pos.y,5);
  }
  void update(){
    if(!locked){
      PVector dif = PVector.sub(pos, prepos);
      dif.mult(DAMPING);
      prepos.set(pos);
      pos.add(dif);
      pos.add(GRAVITY);
    }
  }
}

class Spring{
  Particle p1;
  Particle p2;
  Spring(Particle p1, Particle p2){
    this.p1=p1;
    this.p2=p2;
  }
  void display(){
    stroke(255);
    line(p1.pos.x,p1.pos.y,p2.pos.x,p2.pos.y);
  }
  void update(){
     PVector delta = PVector.sub(p1.pos,p2.pos);
     float dis = PVector.dist(p1.pos,p2.pos);
     delta.mult(0.5*(dis-len)/dis);
     if(!p1.locked) p1.pos.sub(delta);
     if(!p2.locked) p2.pos.add(delta);
     
  }
}

Particle p[][] = new Particle[row][column];
ArrayList<Spring> s = new ArrayList<Spring>();

void setup(){
  size(600,600);
  for(int i=0;i<row;i++){
    for(int j=0;j<column;j++){
      p[i][j] = new Particle((i+1)*len,(j+1)*len);
      if(j==0) p[i][j].locked = true;
    }
  }
  for(int i=0;i<row;i++){
    for(int j=0;j<column;j++){
        if(i<row-1) s.add(new Spring(p[i][j],p[i+1][j]));
        if(j<column-1) s.add(new Spring(p[i][j],p[i][j+1]));
    }
  }
}

void draw(){
  background(50);
  for(Spring i : s){
    i.display();
    i.update();
  }
  for(int i=0;i<row;i++){
    for(int j=0;j<column;j++){
      p[i][j].display();
      p[i][j].update();
    }
  }
}

void mousePressed() {
  PVector mouse = new PVector(mouseX, mouseY);
  ArrayList<Spring> toRemove = new ArrayList<Spring>();
  for (Spring sp : s) {
    if (PVector.dist(sp.p1.pos, mouse) < 15 || PVector.dist(sp.p2.pos, mouse) < 15) {
      toRemove.add(sp);
    }
  }
  s.removeAll(toRemove);
}

void keyPressed(){
  if(key=='w'){
    for(int i=0;i<row;i++){
      for(int j=0;j<column;j++){
        if(!p[i][j].locked) p[i][j].pos.add(WIND);
      }
    } 
  }
}

void keyReleased(){
  if(key=='w') WIND = new PVector(random(-2,2),random(-2,2));
}
