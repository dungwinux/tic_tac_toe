import 'package:flutter/material.dart';
import 'package:tic_tac_toe/component/square.dart';

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  int prevTurn;
  int turn = 0;
  List<List<int>> board = List.generate(3, (i) => List.filled(3, null));

  List<int> get expandedBoard => board.expand((e) => e).toList(growable: false);

  nextTurn() {
    int newTurn;
    if (turn == 0)
      newTurn = 1;
    else if (turn == 1) newTurn = 0;
    setState(() {
      prevTurn = turn;
      turn = newTurn;
    });
  }

  bool get hasWinner {
    final expandBoard = expandedBoard;
    return [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ].any((e) => (expandBoard[e[0]] != null &&
        expandBoard[e[0]] == expandBoard[e[1]] &&
        expandBoard[e[2]] == expandBoard[e[1]]));
  }

  bool get isFilled => !expandedBoard.any((e) => e == null);

  onSquarePressed(int idx) {
    int x = idx ~/ 3;
    int y = idx.remainder(3);
    return () {
      if (hasWinner || board[x][y] != null) return;
      setState(() {
        board[x][y] = turn;
      });
      nextTurn();
    };
  }

  Widget boardToWidget() {
    int idx = 0;
    return Table(
      children: board
          .map(
            (List<int> row) => TableRow(
              children: row
                  .map(
                    (int val) => Square(
                      value: val,
                      onPressed: onSquarePressed(idx++),
                    ),
                  )
                  .toList(growable: false),
            ),
          )
          .toList(growable: false),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder(
        horizontalInside: BorderSide(),
        verticalInside: BorderSide(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          constraints: BoxConstraints.tightFor(
            width: 200,
            height: 200,
          ),
          child: boardToWidget(),
        ),
        Container(
          child: Row(
            children: hasWinner
                ? [
                    iconValue[prevTurn],
                    Text("WON", style: TextStyle(fontSize: 20)),
                  ]
                : (isFilled
                    ? [
                        Text("DRAW", style: TextStyle(fontSize: 20)),
                      ]
                    : [
                        iconValue[turn],
                        Text("turn", style: TextStyle(fontSize: 20)),
                      ]),
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          constraints: BoxConstraints.tightFor(
            width: 120,
            height: 48,
          ),
        ),
      ],
    );
  }
}
