Tree tree;
float killDistance = 20;
float attractionDistance = 100;
float maxStroke = 2;


void setup() { // called once on launch
  size(600, 600);
  tree = new Tree();
}

void draw() { // called repeatedly after launch
  background(0);
  tree.show();
  tree.grow();
}
