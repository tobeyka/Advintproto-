class Catcher
{
 float x;
 float y;
 PImage img;
 
 Catcher(float x,float y,PImage img)
 {
  this.x=x;
  this.y=y;
  this.img=img;
 }
 
 boolean caught(PVector aPos)
 {
   boolean ret = false;
   if( aPos.y > y-20 && aPos.y < y+10 && aPos.x > x-20 && aPos.x < x+23 )
   {
    ret = true; 
   }
   return ret;
 }
 
 void display()
 {
  image(img,x,y); 
 }
 
 void move(float newX)
 {
   //x = max(mouseX,30);
   //x = min(mouseX,width-30);
   this.x = newX;
 }
  
}
