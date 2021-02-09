class Apple {
  float x = random(width);
  float y = random(-500,-100);
  float yspeed = 1;
  
  void fall() {
    y = y + yspeed;
  
  }
  
  void show () {
    noStroke();
    fill(255,26, 26);
    ellipse(x,y,20,20);
    
  }
}
