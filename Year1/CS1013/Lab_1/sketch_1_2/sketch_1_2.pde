int i;
void setup(){ 
size(200, 200); 
noStroke(); fill(255, 04, 110); 
i=0;
} 
void draw(){ 
background(255); 
rect(i, 70, 50, 50); 
if(i++>=199) i=0; 
}