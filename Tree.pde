class Tree {
  ArrayList<Attractor> attractors = new ArrayList<>(); // collection of attractors
  ArrayList<Node> nodes = new ArrayList<>();

  Tree() {
    for (int i = 0; i < 200; i++) { // generate attractors
      attractors.add(new Attractor()); // collect attractors into array list
    }

    Node root = new Node(new PVector(width/2, height), new PVector(0, -1)); // start trunk at bottom center and draw up
    nodes.add(root);
    Node current = new Node(root);

    int trunkCounter = 0;
    while (!closeEnough(current)) { // builds trunk until it reaches attraction distance of any attractor
      Node trunk = new Node(current);
      nodes.add(current);
      current = trunk;
      System.out.printf("building trunk %d%n", trunkCounter);
      trunkCounter++;
    }
  }

  boolean closeEnough(Node n) { // for building trunk
    for (Attractor a : attractors) {
      float distance = PVector.dist(n.position, a.position); // get distance between node and each attractor
      //System.out.printf("distance: %f%n", distance);
      if (distance < attractionDistance - 1) { // look for attractor within attraction distance
        return true;
      }
    }
    return false;
  }

  void grow() {
    for (Attractor a : attractors) { // for each attractor, find closest node and calculate it's direction
      Node closest = null;
      PVector closestDirection = null;
      float shortestDistance = -1;

      for (Node n : nodes) { // for each node, calculate the average direction towards all of the attractors influencing it
        PVector direction = PVector.sub(a.position, n.position); // get direction node is in by subtracting the attractors position vector from the nodes position vector
        float distance = direction.mag(); // calculate the magnitude (length) of the new direction to get distance between each node and each attractor
        
        if (distance < killDistance) {
          a.reached();
          closest = null;
          
        } else if (closest == null || distance < shortestDistance) {
          closest = n;
          closestDirection = direction;
          shortestDistance = distance;
        }
      }
      if (closest != null) {
        closestDirection.normalize(); // normalize (scales the PVector to a length of 1 while preserving direction)
        closest.direction.add(closestDirection);
        closest.count++;
      }
    }
    // remove reached attractors
    for (int i = attractors.size() - 1; i >= 0; i--) { // must read backwards, as size would change if elements are removed when reading from beginning
      if (attractors.get(i).reached) {
        attractors.remove(i);
      }
    }
    // create branches moving towards attractors
    for (int i = nodes.size() - 1; i >= 0; i--) {
      Node n = nodes.get(i);
      if (n.count > 0) {
        n.direction.div(n.count); // calculates average direction
        n.direction.normalize();
        Node newN = new Node(n); // create new nodes moving towards attractors
        nodes.add(newN);
        n.reset();
      }
    }

    
  }

  void show() {
    for (Attractor a : attractors) { // display attractors
      a.show();
    }
    for (Node n : nodes) {
      if (n.parent != null) {
        stroke(255);
        strokeWeight(n.strokeWeight);
        line(n.position.x, n.position.y, n.parent.position.x, n.parent.position.y); // draws from end position to parent end
      }
    }
  }
}
