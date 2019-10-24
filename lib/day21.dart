// --- Day 21: Fractal Art ---
// https://adventofcode.com/2017/day/21

import 'dart:math' as math;

int solve(List<String> input, int iterations) {
  final rules2x2 = <String, String>{};
  final rules3x3 = <String, String>{};

  for (final line in input) {
    final parts = line.split(' => ');
    final from = parts[0];
    final to = parts[1];

    if (from.length == 5) {
      // 2x2 rule
      final lines = from.split('/');
      final line1 = lines[0];
      final line2 = lines[1];

      // Add rule without any rotations or flips
      rules2x2[from] = to;

      // Add rotations
      //  - 90 degrees
      rules2x2[rotate2x2(from)] = to;

      //  - 180 degrees
      rules2x2[rotate2x2(rotate2x2(from))] = to;

      //  - 270 degrees
      rules2x2[rotate2x2(rotate2x2(rotate2x2(from)))] = to;

      // Add flips
      //  - H-flip
      rules2x2['$line2/$line1'] = to;

      //  - V-flip
      final sb = StringBuffer()
        ..write(line1[1])
        ..write(line1[0])
        ..write('/')
        ..write(line2[1])
        ..write(line2[0]);
      rules2x2[sb.toString()] = to;
    } else {
      // 3x3 rule
      final lines = from.split('/');
      final line1 = lines[0];
      final line2 = lines[1];
      final line3 = lines[2];

      // Add rule without any rotations or flips
      rules3x3[from] = to;

      // Add rotations
      //  - 90 degrees
      rules3x3[rotate3x3(from)] = to;
      //  - 180 degrees
      rules3x3[rotate3x3(rotate3x3(from))] = to;

      //  - 270 degrees
      rules3x3[rotate3x3(rotate3x3(rotate3x3(from)))] = to;

      // Add flips
      //  - H-flip
      final h_flip = "$line3/$line2/$line1";
      rules3x3[h_flip] = to;
      // H-flip - 90 degrees
      rules3x3[rotate3x3(h_flip)] = to;
      // H-flip - 180 degrees
      rules3x3[rotate3x3(rotate3x3(h_flip))] = to;
      // H-flip - 270 degrees
      rules3x3[rotate3x3(rotate3x3(rotate3x3(h_flip)))] = to;

      //  - V-flip
      final sb = StringBuffer()
        ..write(line1[2])
        ..write(line1[1])
        ..write(line1[0])
        ..write('/')
        ..write(line2[2])
        ..write(line2[1])
        ..write(line2[0])
        ..write('/')
        ..write(line3[2])
        ..write(line3[1])
        ..write(line3[0]);

      final v_flip = sb.toString();
      rules3x3[v_flip] = to;
      // V-flip - 90 degrees
      rules3x3[rotate3x3(v_flip)] = to;
      // V-flip - 180 degrees
      rules3x3[rotate3x3(rotate3x3(v_flip))] = to;
      // V-flip - 270 degrees
      rules3x3[rotate3x3(rotate3x3(rotate3x3(v_flip)))] = to;
    }
  }

  // Start image
  var image = '.#./..#/###';

  for (int i = 0; i < iterations; i++) {
    final lines = image.split('/');

    if (lines.length % 2 == 0) {
      // Split into 2x2 blocks
      final numberOf2x2Blocks = math.pow((lines.length / 2).floor(), 2).toInt();

      if (numberOf2x2Blocks == 1) {
        image = rules2x2[image];
      } else {
        final images = <String>[];

        for (int j = 0; j + 2 <= lines.length; j += 2) {
          final line1 = lines[j];
          final line2 = lines[j + 1];

          for (var k = 0; k + 2 <= line1.length; k += 2) {
            images.add('${line1[k]}${line1[k + 1]}/${line2[k]}${line2[k + 1]}');
          }
        }

        image = merge(images.map((part) => rules2x2[part]).toList());
      }
    } else if (lines.length % 3 == 0) {
      // Split into 3x3 blocks
      final numberOf3x3Blocks = math.pow((lines.length / 3).floor(), 2).toInt();

      if (numberOf3x3Blocks == 1) {
        image = rules3x3[image];
      } else {
        final images = <String>[];

        for (var j = 0; j + 3 <= lines.length; j += 3) {
          final line1 = lines[j];
          final line2 = lines[j + 1];
          final line3 = lines[j + 2];

          for (int k = 0; k + 3 <= line1.length; k += 3) {
            images.add('${line1[k]}${line1[k + 1]}${line1[k + 2]}/'
                '${line2[k]}${line2[k + 1]}${line2[k + 2]}/'
                '${line3[k]}${line3[k + 1]}${line3[k + 2]}');
          }
        }

        image = merge(images.map((part) => rules3x3[part]).toList());
      }
    } else {
      throw Exception('Should not happen!');
    }
  }

  int count = 0;
  for (int i = 0; i < image.length; i++) {
    if (image[i] == '#') {
      count++;
    }
  }

  return count;
}

String rotate2x2(String input) {
  final lines = input.split('/');
  final line1 = lines[0];
  final line2 = lines[1];

  return '${line2[0]}${line1[0]}/'
      '${line2[1]}${line1[1]}';
}

String rotate3x3(String input) {
  final lines = input.split('/');
  final line1 = lines[0];
  final line2 = lines[1];
  final line3 = lines[2];

  return '${line3[0]}${line2[0]}${line1[0]}/'
      '${line3[1]}${line2[1]}${line1[1]}/'
      '${line3[2]}${line2[2]}${line1[2]}';
}

String merge(List<String> images) {
  final squareSize = math.sqrt(images.length).truncate();
  final imageParts = <String>[];

  for (int i = 0; i < images.length; i += squareSize) {
    imageParts.add(mergeHorizontal(images.getRange(i, i + squareSize)));
  }

  return mergeVertical(imageParts);
}

String mergeHorizontal(Iterable<String> images) {
  return images.reduce((String s1, String s2) {
    final parts1 = s1.split('/');
    final parts2 = s2.split('/');

    var first = true;
    final sb = StringBuffer();

    for (var i = 0; i < parts1.length; i++) {
      if (first) {
        first = false;
        sb.write('${parts1[i]}${parts2[i]}');
      } else {
        sb.write('/${parts1[i]}${parts2[i]}');
      }
    }

    return sb.toString();
  });
}

String mergeVertical(Iterable<String> images) => images.join('/');
