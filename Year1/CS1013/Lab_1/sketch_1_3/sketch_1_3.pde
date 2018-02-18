int i;
int a;
void setup()
{ 
  size(200, 200); 
  noStroke();
  fill(255, 04, 110); 
  i=0;
} 
void draw()
{ 
  background(255); 
  rect(i, 70, 50, 50); 
  rect(a, 70, 50, 50);
  i++;
  a++;
  if(i==150)
  {
    a=-50;
  } 
  if(a==150)
  {
    i=-50;
  }
  
  
  
  frameRate(100);
}