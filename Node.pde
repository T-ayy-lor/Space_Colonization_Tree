class Node {
  Node parent;
  PVector position;
  PVector direction;
  PVector saveDirection;
  float length = 1;
  float strokeWeight = 1;
  int count;

  Node(PVector position, PVector direction) { // for root/trunk
    parent = null;
    this.position = position.copy();
    this.direction = direction.copy();
    saveDirection = direction.copy();
  }

  Node(Node parent) {
    this.parent = parent;
    this.position = parent.next();
    this.direction = parent.direction.copy();
    this.saveDirection = direction.copy();
  }

  PVector next() {
    PVector endPosition = PVector.mult(direction, length);
    PVector next = PVector.add(position, endPosition); // determine next "branch" position by adding current position with the direction * length
    return next;
  }

  int depth(Node n) {
    int depth = 0;
    while (n.parent != null) {
      depth++;
      n = n.parent;
    }
    return depth;
  }

  void reset() {
    count = 0;
    direction = saveDirection.copy();
  }
}
