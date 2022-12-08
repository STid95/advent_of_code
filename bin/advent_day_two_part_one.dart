import 'dart:io';

Future<void> main() async {
  int totalPoints = 0;
  final list = await readFile();
  for (var roundInst in list) {
    List<String> choices = roundInst.split(" ");
    final round = Round(
        opponent: Shape.values
            .firstWhere((element) => element.opponent == choices.first),
        me: Shape.values.firstWhere((element) => element.me == choices.last));
    totalPoints += round.calculatePoints();
  }
  print("My total points are $totalPoints");
}

Future<List<String>> readFile() async {
  final input = await File('inputs/day_two/input.txt').readAsString();
  final list = input.split("\n");
  list.removeLast();

  return list;
}

enum Shape {
  rock("X", "A", 1),
  paper("Y", "B", 2),
  scissors("Z", "C", 3);

  const Shape(this.me, this.opponent, this.points);
  final String me;
  final String opponent;
  final int points;
}

class Round {
  Shape me;
  Shape opponent;
  Round({
    required this.me,
    required this.opponent,
  });
  int calculatePoints() {
    int result = 0;
    if (me == opponent) {
      result = 3;
    } else if (me == Shape.paper && opponent == Shape.rock ||
        me == Shape.rock && opponent == Shape.scissors ||
        me == Shape.scissors && opponent == Shape.paper) {
      result = 6;
    }
    return result + me.points;
  }
}
