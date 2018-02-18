int i;
int a;
int b;
int c;
void setup()
{ 
  size(200, 200); 
  noStroke();

  i=0;
  b=150;
  c=-50;
} 
void draw()
{ 
  background(255); 
  fill(255, 04, 110); 
  rect(i, 70, 50, 50); 
  rect(a, 70, 50, 50);
  fill(25, 204, 190); 
  rect(b, 10, 50, 50); 
  rect(c, 10, 50, 50);
  i++;
  a++;
  b--;
  c--;
  if(i==150)
  {
    a=-50;
  } 
  if(a==150)
  {
    i=-50;
  }
  if(b==50)
  {
    c=250;
  } 
  if(c==50)
  {
    b=250;
  }
  
  
  frameRate(90);
}