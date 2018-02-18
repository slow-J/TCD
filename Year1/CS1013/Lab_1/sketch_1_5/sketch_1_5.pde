float a;
float b;
float c;
float d;
int amplitude = 100;
void setup()
{ 
  size(500, 500); 
  noStroke();
  fill(255, 04, 110); 
  a=000;
  b=200;
  c=5500;
  d=5500;
  
} 
void draw()
{ 
  background(255); 
  rect(a, b, 20, 20); 
  rect(c, d, 20, 20);
  a=a+1;
  b = sin(a*0.1)*amplitude+200;
  c=c+1;
  d = sin(c*0.1)*amplitude+200;
  if(a==450)
  {
    c=-50;
    d=200;
  }

  if(c==450)
  {
    a=-50;
    b=200;
  }
  if(b>=299.95)
  {
    fill(random(255), random(255), random(255)); 
  }
  if(b<=100.05)
  {
    fill(random(255), random(255), random(255)); 
  }
  if(d>=299.95)
  {
    fill(random(255), random(255), random(255)); 
  }
  if(d<=100.05)
  {
    fill(random(255), random(255), random(255)); 
  }

  
  
  frameRate(50);
}