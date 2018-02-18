boolean paused = false;
Alien theAliens[];
Bullet theBullet;
Player thePlayer;
Bomb theBombs[];
PFont myFont; 
int xpos1;
int ypos1;
void setup()
{
  size(400, 400);
  PImage alienImage;
  PImage explodingImage;

  alienImage = loadImage("spacerOne.gif");
  explodingImage = loadImage("exploding.GIF");
  thePlayer = new Player(SCREENY-MARGIN/4-PADDLEHEIGHT); 
  theAliens = new Alien[10];
  theBullet = null;
  theBombs = new Bomb[10];
  init_aliens (theAliens, alienImage, explodingImage );
  init_bombs ( theBombs);
  noStroke();
  frameRate(80);
}

void init_aliens ( Alien theAliens[],  PImage alienImage, PImage explodingImage)
{
  xpos1=MARGIN+5; 
  ypos1=MARGIN;
   for  (int  i=  0;  i<  theAliens.length;  i++)    
  {    
    theAliens[i]=new Alien(xpos1+i*xpos1, ypos1, alienImage, explodingImage);
    
  }  
}
void init_bombs ( Bomb theBombs[])
{
   for  (int  i=  0;  i<  theBombs.length;  i++)    
  {    
    theBombs[i]=new Bomb(410, 410);
    
  }  
}

void draw()
{ 
  background(0);
  winCheck(theAliens);
   if(theBullet != null)
   {
    theBullet.move();
    theBullet.collide(theAliens);
    theBullet.draw();
  }
   thePlayer.move(mouseX);
   thePlayer.draw();
   for  (int  i=  0;  i<  theAliens.length;  i++)    
  {   
    
    theAliens[i].move();
    theAliens[i].draw();
    if(random(0,1000)<1&&(theBombs[i].outOfScreen()==true)&&theAliens[i].notDead()==true)
    {
      theBombs[i].reset( theAliens[i].x(),theAliens[i].y()+BOMBHEIGHT);
    }  
    
    theBombs[i].move();      
    theBombs[i].draw();
    if(theBombs[i].collide(thePlayer)==true)
    {
      paused =true;    
    }    
  }  
  if (paused==true)
  {
    noLoop();
  }
}
  
void mousePressed()
{
 theBullet = new Bullet(thePlayer.x()+PADDLEWIDTH/2-BULLETWIDTH/2, thePlayer.y());
 
}
void winCheck(Alien theAliens[])
{
  int check = 0;
  for  (int  i=  0;  i<  theAliens.length;  i++)    
  {
    if (theAliens[i].notDead()==false)
    {
      check++;
    }
    if (check==10)
    {
      theBombs[i].win();
      paused =true;
    }
  }
}