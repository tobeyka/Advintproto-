class Apple
{
  PVector pos;
  int state;
  float speed;
  ArrayList<PImage> images;
  int timeLS;
  float aplLen;
  
  Apple(float spd, int timeMS, ArrayList<PImage> imgs, PImage tree)
  {
    aplLen = imgs.get(1).width;
    
    float x = random(aplLen,width-aplLen);
    float y = random(aplLen,400);
    float g = green( tree.get((int)x,(int)y) );
    while( (g>90 && g<190)==false )
    {
      x = random(aplLen,width-aplLen);
      y = random(aplLen,400);
      g = green( tree.get((int)x,(int)y) );
    }
    
    pos = new PVector(x,y);
    speed = spd;
    state = 0; 
    timeLS = timeMS;
    images = imgs;
  }
  
  void growth(int growDel)
  {
    if( millis() - timeLS >= growDel*1000 && state < 4 )
    {
      state++;
      timeLS = millis();
    }
  }
  
  void display()
  {
   image( images.get( min(state,3) ) , pos.x,pos.y);
  }
  
  void fall()
  {

    if( state == 4 )
    {
     pos.y += speed; 
    }
    
    if( pos.y > height - random(10,35) )
    {
      state=5;
    }
    

  }
  
}
