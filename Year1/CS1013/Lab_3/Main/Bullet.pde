
class Bullet 
{
  // Insert the code for your Bullet class here.

  int x; int y; 
  color bulletcolor = color(0, 250, 50);
  
  Bullet(int xpos, int ypos) 
  { 
    x = xpos;  
    y = ypos; 
  } 
  
void collide(Alien theAliens[])
  { 
    for(int i=0; i<theAliens.length; i++)
    {
      if(x > theAliens[i].x() && x < theAliens[i].x()+theAliens[i].width() 
        && y > theAliens[i].y() && y < theAliens[i].y()+theAliens[i].height())
      {
        theAliens[i].exploding();
        return;
      }
    }
  } 
  void move()
  { 
     y = y-2; 
  } 
  
  void draw() 
  { 
    fill(bulletcolor); 
    rect(x, y, BULLETWIDTH, BULLETHEIGHT); 
  } 

}