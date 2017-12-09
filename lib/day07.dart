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
  int _weight;
  final List<Node> children = new List();

  Node(this._weight);

  int get weight => children.fold(_weight, (prev, node) => prev + node.weight);

  void addNodes(Iterable<Node> nodes) {
    children.addAll(nodes);
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
      nodeCache[name] = new Node(weight);
    }

    if (line.contains(" -> ")) {
      var split = line.split(" -> ");
      nodeCache[name].addNodes(split[1].split(", ").map((String nodeName) {
        if (nodeCache.containsKey(nodeName)) {
          return nodeCache[nodeName];
        } else {
          var node = new Node(-1);
          nodeCache[nodeName] = node;
          return node;
        }
      }));
    }
  }

  return _findWeight(nodeCache[solveA(lines)]);
}

int _findWeight(Node input) {
  Map<int, List<Node>> map = new Map();

  for (Node node in input.children) {
    int weight = node.weight;
    if (map.containsKey(weight)) {
      map[weight].add(node);
    } else {
      map[weight] = new List()..add(node);
    }
  }

  if (map.length == 1) {
    return -1;
  }

  var oddNode = map.values.singleWhere((list) => list.length == 1).first;

  int result = _findWeight(oddNode);

  if (result != -1) {
    return result;
  } else {
    int a = map.values.singleWhere((list) => list.length > 1).first.weight;

    return oddNode._weight + (a - oddNode.weight);
  }
}
