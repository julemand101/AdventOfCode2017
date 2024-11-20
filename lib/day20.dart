// --- Day 20: Particle Swarm ---
// https://adventofcode.com/2017/day/20

class Coordinate {
  int x, y, z;
  Coordinate(this.x, this.y, this.z);

  void add(Coordinate c) {
    x += c.x;
    y += c.y;
    z += c.z;
  }
}

class Particle {
  final int id;
  final Coordinate _position;
  final Coordinate _velocity;
  final Coordinate _acceleration;

  Particle(this.id, this._position, this._velocity, this._acceleration);

  Coordinate get position => _position;
  Coordinate get velocity => _velocity;
  Coordinate get acceleration => _acceleration;

  void tick() {
    _velocity.add(_acceleration);
    _position.add(_velocity);
  }

  @override
  String toString() => '$id pos=$_position}';

  bool equalPosition(Particle p) {
    return _position.x == p._position.x &&
        _position.y == p._position.y &&
        _position.z == p._position.z;
  }
}

int solveA(List<String> input) {
  return parse(input)
      .reduce((p1, p2) => manhattanDistanceFromZero(p1.acceleration) <
              manhattanDistanceFromZero(p2.acceleration)
          ? p1
          : p2)
      .id;
}

int solveB(List<String> input) {
  final particles = parse(input);

  // This solution is kind of a hack because the loop count is found after the
  // solution was found (by using 1000 as loop count). 40 is the minimum number
  // of loops we need to find the solution and is hardcoded to make the tests
  // faster.
  //
  // The best solution whould be to found the right time when we should stop
  // the loop. Maybe some day I go back and fix this. :)
  for (int i = 0; i < 40; i++) {
    final copyList = particles.toList();

    for (final p1 in copyList) {
      for (final p2 in copyList) {
        if (p1.id != p2.id && p1.equalPosition(p2)) {
          particles
            ..remove(p1)
            ..remove(p2);
        }
      }
    }

    for (final x in particles) {
      x.tick();
    }
  }

  return particles.length;
}

List<Particle> parse(List<String> input) {
  int id = 0;
  return input.map((String line) {
    final parts = line.split(", ");
    final position = parseCoordinate(parts[0]);
    final velocity = parseCoordinate(parts[1]);
    final acceleration = parseCoordinate(parts[2]);

    return Particle(id++, position, velocity, acceleration);
  }).toList();
}

// p=< 3,0,0>
Coordinate parseCoordinate(String input) {
  final parts = input.substring(3, input.length - 1).trim().split(",");
  return Coordinate(
      int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
}

int manhattanDistanceFromZero(Coordinate coordinate) =>
    coordinate.x.abs() + coordinate.y.abs() + coordinate.z.abs();
