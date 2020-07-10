import 'package:flutter/material.dart';

final List<Icon> iconValue = [
  Icon(
    Icons.clear,
    size: 24,
    color: Colors.blue,
  ),
  Icon(
    Icons.trip_origin,
    size: 24,
    color: Colors.red,
  )
];

class Square extends StatefulWidget {
  Square({Key key, this.value, this.onPressed}) : super(key: key);
  final int value;
  final Function onPressed;

  @override
  State<StatefulWidget> createState() => _SquareState();
}

class _SquareState extends State<Square> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: widget.value == null ? Icon(null) : iconValue[widget.value],
        onPressed: widget.onPressed,
      ),
      padding: EdgeInsets.all(10),
    );
  }
}
