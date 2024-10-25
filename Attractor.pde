class Attractor {
  PVector position;
  boolean reached;
  
  Attractor() {
    position = PVector.random2D(); // make new 2D unit vector with a random direction
    position.mult(random(width/2.5)); // give random position in a shrunk distribution
    position.x += width/2; // center attractors
    position.y += height/2 - 25; // // center attractors and adjust concentration up
  }
  
  void reached() { // method for signaling if node is within killDistance
   reached = true; 
  }
  
  void show() {
    fill(255);
    noStroke();
    ellipse(position.x, position.y, 4, 4);
  }
}
