// --- Day 22: Sporifica Virus ---
// https://adventofcode.com/2017/day/22

int solveA(List<String> mapList, int burstsOfActivity) {
  Map map = new Map();

  for (int y = 0; y < mapList.length; y++) {
    String line = mapList[y];

    for (int x = 0; x < line.length; x++) {
      if (line[x] == "#") {
        map.infect(x, y);
      }
    }
  }

  Virus virus = new Virus(mapList.length, map);

  for (int i = 0; i < burstsOfActivity; i++) {
    virus.burst();
  }

  return virus.infectCount;
}

enum Direction { left, right, up, down }

class Virus {
  int x;
  int y;
  final Map map;
  Direction direction = Direction.up;
  int infectCount = 0;

  Virus(int mapSize, this.map)
      : this.x = (mapSize / 2).floor(),
        this.y = (mapSize / 2).floor();

  void burst() {
    bool isCurrentNodeInfected = map.isInfected(x, y);

    if (isCurrentNodeInfected) {
      turnRight();
    } else {
      turnLeft();
    }

    if (isCurrentNodeInfected) {
      map.clean(x, y);
    } else {
      map.infect(x, y);
      infectCount++;
    }

    stepForward();
  }

  void turnRight() {
    switch (direction) {
      case Direction.up:
        direction = Direction.right;
        break;
      case Direction.right:
        direction = Direction.down;
        break;
      case Direction.down:
        direction = Direction.left;
        break;
      case Direction.left:
        direction = Direction.up;
        break;
    }
  }

  void turnLeft() {
    switch (direction) {
      case Direction.up:
        direction = Direction.left;
        break;
      case Direction.left:
        direction = Direction.down;
        break;
      case Direction.down:
        direction = Direction.right;
        break;
      case Direction.right:
        direction = Direction.up;
        break;
    }
  }

  void stepForward() {
    switch (direction) {
      case Direction.up:
        y -= 1;
        break;
      case Direction.left:
        x -= 1;
        break;
      case Direction.down:
        y += 1;
        break;
      case Direction.right:
        x += 1;
        break;
    }
  }
}

class Map {
  Set<String> _infected = new Set();

  void infect(int x, int y) => _infected.add(_xyToString(x, y));
  void clean(int x, int y) => _infected.remove(_xyToString(x, y));
  bool isInfected(int x, int y) => _infected.contains(_xyToString(x, y));
  String _xyToString(int x, int y) => "$x-$y";
}
