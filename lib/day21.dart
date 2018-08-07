// --- Day 21: Fractal Art ---
// https://adventofcode.com/2017/day/21

import 'dart:math' as math;

int solve(List<String> input, int iterations) {
  Map<String, String> rules2x2 = new Map();
  Map<String, String> rules3x3 = new Map();

  for (String line in input) {
    var parts = line.split(" => ");
    var from = parts[0];
    var to = parts[1];

    if (from.length == 5) {
      // 2x2 rule
      var lines = from.split("/");
      var line1 = lines[0];
      var line2 = lines[1];

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
      rules2x2["$line2/$line1"] = to;

      //  - V-flip
      StringBuffer sb = new StringBuffer();
      sb.write(line1[1]);
      sb.write(line1[0]);
      sb.write("/");
      sb.write(line2[1]);
      sb.write(line2[0]);
      rules2x2[sb.toString()] = to;
    } else {
      // 3x3 rule
      var lines = from.split("/");
      var line1 = lines[0];
      var line2 = lines[1];
      var line3 = lines[2];

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
      String h_flip = "$line3/$line2/$line1";
      rules3x3[h_flip] = to;
      // H-flip - 90 degrees
      rules3x3[rotate3x3(h_flip)] = to;
      // H-flip - 180 degrees
      rules3x3[rotate3x3(rotate3x3(h_flip))] = to;
      // H-flip - 270 degrees
      rules3x3[rotate3x3(rotate3x3(rotate3x3(h_flip)))] = to;

      //  - V-flip
      StringBuffer sb = new StringBuffer();
      sb.write(line1[2]);
      sb.write(line1[1]);
      sb.write(line1[0]);
      sb.write("/");
      sb.write(line2[2]);
      sb.write(line2[1]);
      sb.write(line2[0]);
      sb.write("/");
      sb.write(line3[2]);
      sb.write(line3[1]);
      sb.write(line3[0]);

      String v_flip = sb.toString();
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
  String image = ".#./..#/###";

  for (int i = 0; i < iterations; i++) {
    var lines = image.split("/");

    if (lines.length % 2 == 0) {
      // Split into 2x2 blocks
      int numberOf2x2Blocks = math.pow((lines.length / 2).floor(), 2);

      if (numberOf2x2Blocks == 1) {
        image = rules2x2[image];
      } else {
        List<String> images = new List();

        for (int j = 0; j + 2 <= lines.length; j += 2) {
          var line1 = lines[j];
          var line2 = lines[j + 1];

          for (int k = 0; k + 2 <= line1.length; k += 2) {
            images.add("${line1[k]}${line1[k + 1]}/${line2[k]}${line2[k + 1]}");
          }
        }

        image = merge(images.map((part) => rules2x2[part]).toList());
      }
    } else if (lines.length % 3 == 0) {
      // Split into 3x3 blocks
      int numberOf3x3Blocks = math.pow((lines.length / 3).floor(), 2);

      if (numberOf3x3Blocks == 1) {
        image = rules3x3[image];
      } else {
        List<String> images = new List();

        for (int j = 0; j + 3 <= lines.length; j += 3) {
          var line1 = lines[j];
          var line2 = lines[j + 1];
          var line3 = lines[j + 2];

          for (int k = 0; k + 3 <= line1.length; k += 3) {
            images.add("${line1[k]}${line1[k + 1]}${line1[k + 2]}/"
                "${line2[k]}${line2[k + 1]}${line2[k + 2]}/"
                "${line3[k]}${line3[k + 1]}${line3[k + 2]}");
          }
        }

        image = merge(images.map((part) => rules3x3[part]).toList());
      }
    } else {
      throw "Should not happen!";
    }
  }

  int count = 0;
  for (int i = 0; i < image.length; i++) {
    if (image[i] == "#") {
      count++;
    }
  }

  return count;
}

String rotate2x2(String input) {
  StringBuffer sb = new StringBuffer();
  var lines = input.split("/");
  var line1 = lines[0];
  var line2 = lines[1];

  sb.write(line2[0]);
  sb.write(line1[0]);
  sb.write("/");
  sb.write(line2[1]);
  sb.write(line1[1]);

  return sb.toString();
}

String rotate3x3(String input) {
  StringBuffer sb = new StringBuffer();
  var lines = input.split("/");
  var line1 = lines[0];
  var line2 = lines[1];
  var line3 = lines[2];

  sb.write(line3[0]);
  sb.write(line2[0]);
  sb.write(line1[0]);
  sb.write("/");
  sb.write(line3[1]);
  sb.write(line2[1]);
  sb.write(line1[1]);
  sb.write("/");
  sb.write(line3[2]);
  sb.write(line2[2]);
  sb.write(line1[2]);

  return sb.toString();
}

String merge(List<String> images) {
  int squareSize = math.sqrt(images.length).truncate();
  List<String> imageParts = new List();

  for (int i = 0; i < images.length; i += squareSize) {
    imageParts.add(mergeHorizontal(images.getRange(i, i + squareSize)));
  }

  return mergeVertical(imageParts);
}

String mergeHorizontal(Iterable<String> images) {
  return images.reduce((String s1, String s2) {
    var parts1 = s1.split("/");
    var parts2 = s2.split("/");

    var first = true;
    var sb = new StringBuffer();

    for (int i = 0; i < parts1.length; i++) {
      if (first) {
        first = false;
        sb.write("${parts1[i]}${parts2[i]}");
      } else {
        sb.write("/${parts1[i]}${parts2[i]}");
      }
    }

    return sb.toString();
  });
}

String mergeVertical(Iterable<String> images) => images.join("/");
