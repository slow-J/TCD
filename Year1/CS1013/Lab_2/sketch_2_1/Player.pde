class Player 
{ 
  PFont myFont = loadFont("TimesNewRomanPSMT-16.vlw"); 
  
  int lives = 3;
  int enemyLives = 3;
  int xpos; int ypos;  
  int lastx;
  color paddlecolor = color(250, 0, 50); 
  Player(int screen_y) 
  { 
    xpos=SCREENX/2; 
    ypos=screen_y; 
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
    void automove(Ball theball)
  {
    lastx=xpos;
    if(xpos < theball.x()-PADDLEWIDTH/2){
    if(xpos < SCREENX-PADDLEWIDTH) xpos++;
    }
    else if (xpos> 0) xpos--;
  }
  
  void winEnemy(Ball theBall)
  {
   
    if  (theBall.y()>=(float)236&&theBall.y()<=(float)237)
    {
      lives--;
    }
    if(lives==0)
    {
      textFont(myFont); 
      text("You lose", 120, 120);

    } 
  
  }
  void winPlayer(Ball theBall)
  {
    if  (theBall.y()<=(float)2&&theBall.y()>=(float)1.5)
    {
      enemyLives--;
    }
    if(enemyLives==0)
    {
      textFont(myFont); 
      text("You win", 120, 120);
     
    }  
  }
} 