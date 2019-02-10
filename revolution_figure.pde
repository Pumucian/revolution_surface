private class Point{
  int x, y;
  public Point(int x, int y){
    this.x = x;
    this.y = y;
  }  
}

PShape figure;
ArrayList<Point> points;
boolean revolution;
float deltaTheta = 360 / 18;

void setup(){
  size(600, 600, P3D);
  setBackground();
  setText();
  points = new ArrayList<Point>();
  revolution = false;
}


int halfWidth;

void setBackground(){
  background(0);
  halfWidth = width/2;
  stroke(255, 0, 0);
  line(halfWidth, 0, halfWidth, height);
}

void drawLines(){
  if (points.size() > 1){
    Point p1, p2;
    p1 = points.get(0);
    p2 = points.get(1);
    line(p1.x, p1.y, p2.x, p2.y);
    p1 = p2;
    for (int i = 2; i < points.size(); i++){
      p2 = points.get(i);
      line(p1.x, p1.y, p2.x, p2.y);
      p1 = p2;
    }  
  }
}

void drawFutureLine(){
  if (points.size() > 0 && mouseX >= halfWidth){
    Point p = points.get(points.size() - 1);
    line(p.x, p.y, mouseX, mouseY);
  }
}

void setText(){
  textSize(11);
  text("Click any mouse button to select a vertex of the figure", 3, 225);
  text("Drawing is only allowed in the right half of the screen", 5, 275);
  text("Press BACKSPACE to restart drawing", 42, 325);
  text("Press ENTER to see the surface of revolution", 27, 375);
}

void setRevolutionText(){
  textSize(20);
  text("Press BACKSPACE to create a new figure", 110, 40);
  text("Move the mouse to move the figure", 130, 80);
}

void setRevolutionBackground(){
  background(0);
  stroke(127);
}

void drawRevolution(){
  Point p1, p2;
  figure = createShape();
  figure.beginShape(TRIANGLE_STRIP);
  figure.fill(255);
  figure.strokeWeight(2);
  for (int j = 0; j < points.size()-1; j++){
    p1 = points.get(j);
    p2 = points.get(j+1);
    for (int i = 0; i < 19; i++){    
      figure.vertex((p1.x-halfWidth)*cos(radians(deltaTheta*i)), p1.y, (p1.x-halfWidth)*sin(radians(deltaTheta*i)));
      figure.vertex((p2.x-halfWidth)*cos(radians(deltaTheta*i)), p2.y, (p2.x-halfWidth)*sin(radians(deltaTheta*i)));
    }    
  }  
  figure.endShape();
  
}

void mouseClicked(){
  if (!revolution && mouseX >= halfWidth) points.add(new Point(mouseX, mouseY));
}

void keyPressed(){
  if (keyCode == ENTER){
    setRevolutionBackground();
    drawRevolution();
    revolution = true;
  } else if (keyCode == BACKSPACE){
    revolution = false;
    setBackground();
    points.clear();
  }
}

void draw(){
  if (revolution){    
    setRevolutionBackground();
    setRevolutionText();
    translate(mouseX, mouseY-halfWidth);
    shape(figure);
  } else {
    setBackground();
    setText();
    drawLines();
    drawFutureLine();
  }  
}
