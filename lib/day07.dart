// --- Day 7: Recursive Circus ---
// https://adventofcode.com/2017/day/7

String solveA(List<String> lines) {
  var list = lines.where((line) => line.contains("->")).toList(growable: false);

  var possibleTopNodes = new List();
  var nodes = new List();

  for (String line in list) {
    List<String> split = line.split(" -> ");
    possibleTopNodes.add(split[0].split(" (")[0]);
    nodes.addAll(split[1].split(", "));
  }

  for (String node in possibleTopNodes) {
    if (!nodes.contains(node)) {
      return node;
    }
  }

  throw "This should not happen!";
}

class Node {
  final String name;
  int _weight;
  final List<Node> children = new List();

  Node(this.name, this._weight);

  int get weight => children.fold(_weight, (prev, node) => prev + node.weight);

  void addNode(Node node) {
    children.add(node);
  }

  void addNodes(Iterable<Node> nodes) {
    children.addAll(nodes);
  }

  String toString() {
    return "$name ($_weight) [$weight] -> $children";
  }
}

int solveB(List<String> lines) {
  Map<String, Node> nodeCache = new Map();

  for (String line in lines) {
    var split = line.split(" (");
    var name = split[0];
    var weight = int.parse(split[1].split(")")[0]);

    if (nodeCache.containsKey(name)) {
      nodeCache[name]._weight = weight;
    } else {
      nodeCache[name] = new Node(name, weight);
    }

    if (line.contains(" -> ")) {
      var split = line.split(" -> ");
      nodeCache[name].addNodes(split[1].split(", ").map((String nodeName) {
        if (nodeCache.containsKey(nodeName)) {
          return nodeCache[nodeName];
        } else {
          var node = new Node(nodeName, -1);
          nodeCache[nodeName] = node;
          return node;
        }
      }));
    }
  }

  nodeCache[solveA(lines)].children.forEach((x) => print(x));
}

Node getNode(Node node) {
  for (Node n in node.children) {
    node.children.
  }
}