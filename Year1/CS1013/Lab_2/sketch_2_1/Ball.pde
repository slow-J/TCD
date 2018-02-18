class Ball 
{ 
  float x; float y; 
  float dx; float dy; 
  int radius; 
  color ballColor = color(random(250), 150, random(250)); 
  Ball()
  { 
    x = random(SCREENX/4, SCREENX/2);  
    y = random(SCREENY/4, SCREENY/2); 
    dx = random(1, 2); dy = random(1, 2); 
    radius=5;  
  }
  void move()
  { 
    x = x+dx; y = y+dy; 
  } 
  float x()
  {
    return x;
  }
  float y()
  {
    return y;
  }
  void collide(Player humanPlayer, Player computerPlayer)
  { 
    if(x-radius <=0) 
    {
      dx=-dx; 
    }
    else if(x+radius>=SCREENX) 
    {
      dx=-dx; 
    }
    if(y+radius >= computerPlayer.ypos && y-radius<computerPlayer.ypos+PADDLEHEIGHT
    && x >=computerPlayer.xpos && x <= computerPlayer.xpos
    +PADDLEWIDTH)
    { 
      println("collided!"); 
      dy=-dy; 
    } 
     if(y+radius >= humanPlayer.ypos && y-radius<humanPlayer.ypos+PADDLEHEIGHT
    && x >=humanPlayer.xpos && x <= humanPlayer.xpos
    +PADDLEWIDTH)
    { 
      println("collided!"); 
      dy=-dy; 
    }
  } 
  void reset()
  {
    x = random(SCREENX/4, SCREENX/2);  
    y = random(SCREENY/4, SCREENY/2); 
    dx = random(1, 2);
    dy = random(1, 2); 
  }
  boolean outOfScreen()
  {
    boolean a=false;
    if (y>SCREENY||y<0)
    {
      a=true;
     
    }
    return a;
  }

  void draw()
  { 
    fill(ballColor); 
    ellipse(int(x), int(y), radius, radius); 
  } 
} 