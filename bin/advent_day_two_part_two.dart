import 'dart:io';

Future<void> main() async {
  int totalPoints = 0;
  final list = await readFile();
  for (var roundInst in list) {
    List<String> choices = roundInst.split(" ");
    final result =
        Result.values.firstWhere((element) => element.meaning == choices.last);
    final opponentChoice =
        Shape.values.firstWhere((element) => element.meaning == choices.first);

    final round = Round(
        result: result,
        opponent: opponentChoice,
        me: chooseShape(opponentChoice, result));
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

Shape chooseShape(Shape opponent, Result result) {
  switch (result) {
    case Result.win:
      return Shape.values
          .firstWhere((element) => element.meaning == opponent.win);
    case Result.lose:
      return Shape.values
          .firstWhere((element) => element.meaning == opponent.lose);
    default:
      return opponent;
  }
}

enum Shape {
  rock("A", 1, "B", "C"),
  paper("B", 2, "C", "A"),
  scissors("C", 3, "A", "B");

  const Shape(this.meaning, this.points, this.win, this.lose);
  final String meaning;
  final int points;
  final String win;
  final String lose;
}

enum Result {
  draw("Y", 3),
  lose("X", 0),
  win("Z", 6);

  const Result(this.meaning, this.points);
  final String meaning;
  final int points;
}

class Round {
  Shape me;
  Shape opponent;
  Result result;
  Round({
    required this.me,
    required this.opponent,
    required this.result,
  });
  int calculatePoints() {
    return result.points + me.points;
  }
}
