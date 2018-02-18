import processing.core.PImage;

class Alien 
{
  boolean alive = true;
  boolean exploding = false;
  int count = 0;
  int x; int y;  
  int direction = A_FORWARD;
  int status = 0;
  PImage alienImage;
  PImage explodingImage;
 
  
 Alien(int xpos, int ypos, PImage okImage,  PImage exImage)
 {
   x = xpos;
   y = ypos;
   xpos=MARGIN+5; 
   ypos=MARGIN;
   alienImage = loadImage("spacerOne.gif");
   explodingImage = loadImage("exploding.GIF");
   okImage = alienImage;
   exImage = explodingImage;
 }

 void move()
 {
    if (x>=SCREENX - MARGIN)
    {
      direction =A_DOWN_R;
      
    }
     if (x<=0)
    {
      direction =A_DOWN_L;
    }
     if (count == MARGIN)
    {
      direction = A_BACKWARD;
      count = 0;
    }
     if (count == -MARGIN)
    {
      direction = A_FORWARD;
      count = 0;
    }
   
   switch(direction) 
   {
    case 0: 
      x = x+1;
      break;
    case 1: 
      x = x-1;
      break;
    case 2:
      y = y+1;
      count++;
      break;
    case 3:
      y = y+1;
      count--;
      break;
    }
 }
  void exploding()
  {
    exploding=true; 
     
     
   }
  int x()
  {
    return x;
  }
  int y()
  {
    return y;
  }
    int width(){
    return alienImage.width;
  }
  int height(){
    return alienImage.height;
  }
  boolean notDead()
  {
    if(alive==true)
    {
      return true;
    }
    return false;
  }
  void draw()
  {
    
   if (status<15) /* Draw the alien when alive using the image() method demonstrated in class */
    {
      image(alienImage, x, y);
      
      if(exploding&&status<15)
      {
        image(explodingImage, x, y); 
        status++;
        alive=false;
       
      }
   
    }
  }
}

  
  