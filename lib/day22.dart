// --- Day 22: Sporifica Virus ---
// https://adventofcode.com/2017/day/22

typedef VirusCall = void Function(Virus virus);

int solveA(List<String> mapList, int burstsOfActivity) {
  return solve(mapList, burstsOfActivity, (virus) => virus.burstA());
}

int solveB(List<String> mapList, int burstsOfActivity) {
  return solve(mapList, burstsOfActivity, (virus) => virus.burstB());
}

int solve(List<String> mapList, int burstsOfActivity, VirusCall virusCall) {
  final map = InfectionMap(mapList);
  final virus = Virus(mapList.length, map);

  for (int i = 0; i < burstsOfActivity; i++) {
    virusCall(virus);
  }

  return virus.infectCount;
}

enum Direction { left, right, up, down }

class Virus {
  int x;
  int y;
  final InfectionMap map;
  Direction direction = Direction.up;
  int infectCount = 0;

  final Map<State, State> stateTransform = {
    State.clean: State.weakened,
    State.weakened: State.infected,
    State.infected: State.flagged,
    State.flagged: State.clean
  };

  Virus(int mapSize, this.map)
      : this.x = (mapSize / 2).floor(),
        this.y = (mapSize / 2).floor();

  void burstA() {
    final isCurrentNodeInfected = map.isInfected(x, y);

    if (isCurrentNodeInfected) {
      turnRight();

      map.clean(x, y);
    } else {
      turnLeft();

      map.infect(x, y);
      infectCount++;
    }

    stepForward();
  }

  void burstB() {
    final currentState = map.getState(x, y);

    switch (currentState) {
      case State.clean:
        turnLeft();
        break;
      case State.weakened:
        // No turn
        break;
      case State.infected:
        turnRight();
        break;
      case State.flagged:
        turnAround();
        break;
    }

    final newState = stateTransform[currentState];
    map.setState(x, y, newState);
    if (newState == State.infected) {
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

  void turnAround() {
    switch (direction) {
      case Direction.up:
        direction = Direction.down;
        break;
      case Direction.left:
        direction = Direction.right;
        break;
      case Direction.down:
        direction = Direction.up;
        break;
      case Direction.right:
        direction = Direction.left;
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

enum State { clean, weakened, infected, flagged }

class InfectionMap {
  final _infected = <int, State>{}; // element not in map == clean

  InfectionMap(List<String> mapList) {
    for (var y = 0; y < mapList.length; y++) {
      final line = mapList[y];

      for (var x = 0; x < line.length; x++) {
        if (line[x] == '#') {
          infect(x, y);
        }
      }
    }
  }

  void infect(int x, int y) => _infected[_xyToInt(x, y)] = State.infected;

  void clean(int x, int y) => _infected.remove(_xyToInt(x, y));

  State getState(int x, int y) => _infected[_xyToInt(x, y)] ?? State.clean;

  void setState(int x, int y, State state) {
    if (state == State.clean) {
      clean(x, y);
    } else {
      _infected[_xyToInt(x, y)] = state;
    }
  }

  bool isInfected(int x, int y) => _infected[_xyToInt(x, y)] == State.infected;

  // https://stackoverflow.com/a/919661
  int _xyToInt(int xIn, int yIn) {
    final x = f(xIn);
    final y = f(yIn);

    return ((x + y) * (x + y + 1) ~/ 2) + y;
  }

  int f(int n) => (n >= 0) ? n * 2 : (-n * 2) - 1;
}
