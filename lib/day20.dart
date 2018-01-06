// --- Day 20: Particle Swarm ---
// https://adventofcode.com/2017/day/20

import 'dart:typed_data';

class Particle {
  final int id;
  Int32x4 _position;
  Int32x4 _velocity;
  Int32x4 _acceleration;

  Particle(this.id, this._position, this._velocity, this._acceleration);

  Int32x4 get position => _position;
  Int32x4 get velocity => _velocity;
  Int32x4 get acceleration => _acceleration;

  int get accelerationAsManhattanDistance =>
      _acceleration.x.abs() + _acceleration.y.abs() + _acceleration.z.abs();

  void tick() {
    _velocity += _acceleration;
    _position += _velocity;
  }
}

int solveA(List<String> input) {
  int id = 0;
  List<Particle> particles = input.map((String line) {
    var parts = line.split(", ");
    var position = parseCoordinate(parts[0]);
    var velocity = parseCoordinate(parts[1]);
    var acceleration = parseCoordinate(parts[2]);

    return new Particle(id++, position, velocity, acceleration);
  }).toList();

  return particles.reduce((p1, p2) {
    return p1.accelerationAsManhattanDistance <
            p2.accelerationAsManhattanDistance
        ? p1
        : p2;
  }).id;
}

// p=< 3,0,0>
Int32x4 parseCoordinate(String input) {
  var parts = input.substring(3, input.length - 1).trim().split(",");
  return new Int32x4(
      int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]), 0);
}
