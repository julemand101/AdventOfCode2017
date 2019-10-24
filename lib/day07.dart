// --- Day 7: Recursive Circus ---
// https://adventofcode.com/2017/day/7

String solveA(List<String> lines) {
  final possibleTopNodes = <String>[];
  final nodes = <String>[];

  for (final line in lines.where((line) => line.contains("->"))) {
    final split = line.split(" -> ");
    possibleTopNodes.add(split[0].split(" (")[0]);
    nodes.addAll(split[1].split(", "));
  }

  for (final node in possibleTopNodes) {
    if (!nodes.contains(node)) {
      return node;
    }
  }

  throw Exception('This should not happen!');
}

class Node {
  int _weight;
  final List<Node> children = [];

  Node(this._weight);

  int get weight => children.fold(_weight, (prev, node) => prev + node.weight);

  void addNodes(Iterable<Node> nodes) {
    children.addAll(nodes);
  }
}

int solveB(List<String> lines) {
  final nodeCache = <String, Node>{};

  for (final line in lines) {
    final split = line.split(" (");
    final name = split[0];
    final weight = int.parse(split[1].split(")")[0]);

    if (nodeCache.containsKey(name)) {
      nodeCache[name]._weight = weight;
    } else {
      nodeCache[name] = Node(weight);
    }

    if (line.contains(" -> ")) {
      final split = line.split(" -> ");
      nodeCache[name].addNodes(split[1].split(", ").map((String nodeName) {
        if (nodeCache.containsKey(nodeName)) {
          return nodeCache[nodeName];
        } else {
          final node = Node(-1);
          nodeCache[nodeName] = node;
          return node;
        }
      }));
    }
  }

  return _findWeight(nodeCache[solveA(lines)]);
}

int _findWeight(Node input) {
  final map = <int, List<Node>>{};

  for (final node in input.children) {
    final weight = node.weight;
    if (map.containsKey(weight)) {
      map[weight].add(node);
    } else {
      map[weight] = [node];
    }
  }

  if (map.length == 1) {
    return -1;
  }

  final oddNode = map.values.singleWhere((list) => list.length == 1).first;

  final result = _findWeight(oddNode);

  if (result != -1) {
    return result;
  } else {
    final a = map.values.singleWhere((list) => list.length > 1).first.weight;

    return oddNode._weight + (a - oddNode.weight);
  }
}
