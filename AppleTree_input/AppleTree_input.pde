import processing.serial.*;

Serial myConnection;


float spawnDel = 1.5; // delay in seconds after which a new apple can appear
float spawnProb = 0.66; // probability of that apple appearing after that delay
int growDel = 60;
float fallSpd = 5;
float aplSz = 15;
int timeLS;
PImage tree;
ArrayList<PImage> aplImgs = new ArrayList<PImage>();
ArrayList<Apple> apples = new ArrayList<Apple>();
Catcher ctcr;

void setup()
{
  size(900, 675);

  printArray(Serial.list());
  myConnection = new Serial(this, Serial.list()[1], 9600);
  myConnection.bufferUntil('\n');


  tree = loadImage("tree.jpg");
  aplImgs.add( getResizedImage("apple_green.png", aplSz*1.5) );
  aplImgs.add( getResizedImage("yellow_apple.png", aplSz) );
  aplImgs.add( getResizedImage("orange_apple.png", aplSz) );
  aplImgs.add( getResizedImage("apple_red.png", aplSz*1.4) );
  PImage ctImg = loadImage("ctch.png");
  ctImg.resize(70, 70);
  ctcr = new Catcher(450, 640, ctImg);
  timeLS = millis();
  imageMode(CENTER);
}

//end of SETUP

void draw()
{
  background(0);
  image(tree, width/2, height/2);

  for (int i=0; i<apples.size(); i++)
  {

    if ( apples.get(i).state == 5 )
    {
      apples.get(i).display();
    }
  }

  ctcr.display();

  spawnApples();

  for (int i=0; i<apples.size(); i++)
  {

    if ( apples.get(i).state < 5 )
    {
      apples.get(i).display();
    }

    apples.get(i).growth(growDel);
    apples.get(i).fall();
  }

  for (int i=0; i<apples.size(); i++)
  {
    if ( apples.get(i).state==4 && ctcr.caught(apples.get(i).pos) )
    {
      apples.remove(i); 
      break;
    }
  }
}

PImage getResizedImage(String pth, float rsz)
{
  PImage img = loadImage(pth);
  img.resize((int)rsz, (int)rsz);
  return img;
}

void spawnApples()
{ 
  if ( millis() - timeLS > spawnDel*1000 )
  {
    if ( random(1) < spawnProb )
    {
      apples.add( new Apple(fallSpd, millis(), aplImgs, tree) );
    }

    timeLS = millis();
  }
}

void serialEvent(Serial conn) {
  String fromSerial = conn.readString();

  if (fromSerial != null) {
    fromSerial = trim(fromSerial);

    String[] data = split(fromSerial, ',');
    //data[0] = button
    //data[1] = potentiometer
    printArray(data);
    
    float potCntrl = float(data[1]);
    potCntrl = map(potCntrl, 0, 4096, 0, width);
    ctcr.move(potCntrl);
    
  }

  println( fromSerial );

}
