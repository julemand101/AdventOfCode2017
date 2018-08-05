// --- Day 24: Electromagnetic Moat ---
// https://adventofcode.com/2017/day/24

int maxBridgeLength = 0;
int maxBridgeStrength = 0;

int solveA(Iterable<String> input) {
  List<Component> components =
      input.map((input) => new Component(input)).toList();

  return getHigestScore(components, 0, 0, 0);
}

int solveB(Iterable<String> input) {
  maxBridgeLength = 0;
  maxBridgeStrength = 0;
  solveA(input);
  return maxBridgeStrength;
}

int getHigestScore(List<Component> availableComponents, int end,
    int bridgeLength, int sumScore) {
  var maxScore = 0;

  findNextComponents(availableComponents, end).forEach((component) {
    List<Component> newAvailableComponents = availableComponents.toList();
    newAvailableComponents.remove(component);

    var newEnd = component.getOpposite(end);
    var score = component.score +
        getHigestScore(newAvailableComponents, newEnd, bridgeLength + 1,
            sumScore + component.score);

    if (score > maxScore) {
      maxScore = score;
    }
  });

  if (maxScore == 0) {
    if (bridgeLength > maxBridgeLength) {
      maxBridgeLength = bridgeLength;
      maxBridgeStrength = sumScore;
    } else if (bridgeLength == maxBridgeLength &&
        sumScore > maxBridgeStrength) {
      maxBridgeStrength = sumScore;
    }
  }

  return maxScore;
}

Iterable<Component> findNextComponents(Iterable<Component> comps, int end) =>
    comps.where((comp) => (comp.a == end || comp.b == end));

class Component {
  final int a;
  final int b;

  Component(String input)
      : a = int.parse(input.split("/")[0]),
        b = int.parse(input.split("/")[1]);

  int get score => a + b;

  int getOpposite(int end) {
    if (end == a && a == b) {
      return end;
    } else if (end == a) {
      return b;
    } else if (end == b) {
      return a;
    } else {
      throw "Should not happen!";
    }
  }
}
