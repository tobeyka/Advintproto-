float spawnDel = 1.5; // delay in seconds after which a new apple can appear
float spawnProb = 0.66; // probability of that apple appearing after that delay
int growDel = 120;
float fallSpd = 5;
float aplSz = 15;
int timeLS;
PImage tree;
ArrayList<PImage> aplImgs = new ArrayList<PImage>();
ArrayList<Apple> apples = new ArrayList<Apple>();
Catcher ctcr;

void setup()
{
  size(900,675);
  tree = loadImage("tree.jpg");
  aplImgs.add( getResizedImage("apple_green.png",aplSz*1.5) );
  aplImgs.add( getResizedImage("yellow_apple.png",aplSz) );
  aplImgs.add( getResizedImage("orange_apple.png",aplSz) );
  aplImgs.add( getResizedImage("apple_red.png",aplSz*1.4) );
  PImage ctImg = loadImage("ctch.png");
  ctImg.resize(70,70);
  ctcr = new Catcher(450,640,ctImg);
  timeLS = millis();
  imageMode(CENTER);
}

void draw()
{
  background(0);
  image(tree,width/2,height/2);
  
  ctcr.display();
  ctcr.move();
  
  spawnApples();
  
  for(int i=0;i<apples.size();i++)
  {
   apples.get(i).display(); 
   apples.get(i).growth(growDel);
  }
  
  for(int i=0;i<apples.size();i++)
  {
    boolean reached = apples.get(i).fall();
    if(reached)
    {
     apples.remove(i); 
     break; 
    }
  }
  
  for(int i=0;i<apples.size();i++)
  {
   if( apples.get(i).state==4 && ctcr.caught(apples.get(i).pos) )
   {
    apples.remove(i); 
    break;  
   }
  }
  
}

PImage getResizedImage(String pth, float rsz)
{
  PImage img = loadImage(pth);
  img.resize((int)rsz,(int)rsz);
  return img;
}

void spawnApples()
{ 
  if( millis() - timeLS > spawnDel*1000 )
  {
      if( random(1) < spawnProb )
      {
        apples.add( new Apple(fallSpd, millis(), aplImgs, tree) );
      }
      
    timeLS = millis();
  }
}
