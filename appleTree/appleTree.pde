
Apple [] apples = new Apple[20];

PImage tree;

void setup() {
  size(900,675);
  tree = loadImage("tree.jpg");
  for (int i = 0; i < apples.length; i++) {
    apples[i] = new Apple ();
  }
}

void draw() {
  background(0);
  image(tree,0,0);
  for (int i = 0; i < apples.length; i++) {
    apples[i].show();
    apples[i].fall();
  }
  
  
}
