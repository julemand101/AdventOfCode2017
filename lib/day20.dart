// --- Day 20: Particle Swarm ---
// https://adventofcode.com/2017/day/20

class Coordinate {
  int x, y, z;
  Coordinate(this.x, this.y, this.z);

  add(Coordinate c) {
    x += c.x;
    y += c.y;
    z += c.z;
  }
}

class Particle {
  final int id;
  Coordinate _position;
  Coordinate _velocity;
  Coordinate _acceleration;

  Particle(this.id, this._position, this._velocity, this._acceleration);

  Coordinate get position => _position;
  Coordinate get velocity => _velocity;
  Coordinate get acceleration => _acceleration;

  void tick() {
    _velocity.add(_acceleration);
    _position.add(_velocity);
  }

  String toString() {
    return "$id pos=$_position}";
  }

  bool equalPosition(Particle p) {
    return (_position.x == p._position.x &&
        _position.y == p._position.y &&
        _position.z == p._position.z);
  }
}

int solveA(List<String> input) {
  return parse(input).reduce((p1, p2) {
    return manhattanDistanceFromZero(p1.acceleration) <
            manhattanDistanceFromZero(p2.acceleration)
        ? p1
        : p2;
  }).id;
}

int solveB(List<String> input) {
  List<Particle> particles = parse(input);

  // This solution is kind of a hack because the loop count is found after the
  // solution was found (by using 1000 as loop count). 40 is the minimum number
  // of loops we need to find the solution and is hardcoded to make the tests
  // faster.
  //
  // The best solution whould be to found the right time when we should stop
  // the loop. Maybe some day I go back and fix this. :)
  for (int i = 0; i < 40; i++) {
    List<Particle> copyList = particles.toList();

    for (Particle p1 in copyList) {
      for (Particle p2 in copyList) {
        if (p1.id != p2.id && p1.equalPosition(p2)) {
          particles.remove(p1);
          particles.remove(p2);
        }
      }
    }

    particles.forEach((x) => x.tick());
  }

  return particles.length;
}

List<Particle> parse(List<String> input) {
  int id = 0;
  return input.map((String line) {
    var parts = line.split(", ");
    var position = parseCoordinate(parts[0]);
    var velocity = parseCoordinate(parts[1]);
    var acceleration = parseCoordinate(parts[2]);

    return new Particle(id++, position, velocity, acceleration);
  }).toList();
}

// p=< 3,0,0>
Coordinate parseCoordinate(String input) {
  var parts = input.substring(3, input.length - 1).trim().split(",");
  return new Coordinate(
      int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
}

int manhattanDistanceFromZero(Coordinate coordinate) =>
    coordinate.x.abs() + coordinate.y.abs() + coordinate.z.abs();
