
class Bomb
{
PFont myFont = loadFont("TimesNewRomanPSMT-16.vlw"); 
  int lives = 1;
  int x; int y; 
  color bombcolor = color(250, 0, 50);
  
  Bomb(int xpos, int ypos) 
  { 
    x = xpos;  
    y = ypos; 
  } 
  void reset(int xp, int yp)
  {
    x = xp;  
    y = yp; 

  }
  boolean collide(Player humanPlayer)
  { 
    if(x > humanPlayer.x() && x < humanPlayer.x()+PADDLEWIDTH
        && y > humanPlayer.y() && y < humanPlayer.y()+PADDLEHEIGHT)
    { 
       textFont(myFont); 
     text("GAME OVER", SCREENX/2-MARGIN*1.5, SCREENY/2);
      return true;
     
    }
    return false;
  }
  
  boolean outOfScreen()
  {
    if (y>SCREENY)
    {
      return true;
    }
    return false;
  }
  void move()
  { 
     y = y+1; 
  } 
  
  void draw() 
  { 
    fill(bombcolor); 
    rect(x, y, BOMBWIDTH, BOMBHEIGHT); 
  } 
  
  void win()
  {
     textFont(myFont); 
     text("YOU WIN", SCREENX/2-MARGIN*1.5, SCREENY/2);
  }
}