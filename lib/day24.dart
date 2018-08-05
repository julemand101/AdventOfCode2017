// --- Day 24: Electromagnetic Moat ---
// https://adventofcode.com/2017/day/24

int solveA(Iterable<String> input) {
  List<Component> components =
      input.map((input) => new Component(input)).toList();

  return getHigestScore(components, 0);
}

int getHigestScore(List<Component> availableComponents, int end) {
  var maxScore = 0;

  findNextComponents(availableComponents, end).forEach((component) {
    List<Component> newAvailableComponents = availableComponents.toList();
    newAvailableComponents.remove(component);

    var newEnd = component.getOpposite(end);
    var score =
        component.score + getHigestScore(newAvailableComponents, newEnd);

    if (score > maxScore) {
      maxScore = score;
    }
  });

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

  String toString() {
    return "$a/$b";
  }
}
