class Player 
{ 
  

  int xpos; int ypos;  

  color paddlecolor = color(191, 128, 137); 
  Player(int screen_y) 
  { 
    xpos=SCREENX/2; 
    ypos=screen_y; 
  } 
  int x()
  {
    return xpos;
  }

  int y()
  {
    return ypos;
  }

  void move(int x)
  { 
    if(x>SCREENX-PADDLEWIDTH) xpos = SCREENX-PADDLEWIDTH; 
    else xpos=x; 
  } 
  
  void draw() 
  { 
    fill(paddlecolor); 
    rect(xpos, ypos, PADDLEWIDTH, PADDLEHEIGHT); 
  } 

} 