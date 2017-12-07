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
