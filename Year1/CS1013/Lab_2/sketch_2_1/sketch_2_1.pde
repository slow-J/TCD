
Player theEnemy;
Player thePlayer; 
Ball theBall;
void setup()
{ 
  size(320, 240); 
  
  
  thePlayer = new Player(SCREENY-MARGIN-PADDLEHEIGHT); 
  theEnemy = new Player(MARGIN);
  theBall = new Ball();
  ellipseMode(RADIUS);
  noStroke();
  frameRate(60);
} 
void mousePressed()
{
  if(theBall.outOfScreen()==true)
  {
    theBall.reset();
    loop();
  }
}
void draw()
{ 
  background(0);
  text("Enemy lives: "+thePlayer.enemyLives, 0, 20);
  text("Your lives: "+thePlayer.lives, 0, 220);
  thePlayer.move(mouseX); 
  theEnemy.automove(theBall);
  theBall.move();
  theBall.collide(thePlayer, theEnemy);
  thePlayer.draw(); 
  theEnemy.draw();
  theBall.draw();
  thePlayer.winEnemy(theBall);
  thePlayer.winPlayer(theBall);
}