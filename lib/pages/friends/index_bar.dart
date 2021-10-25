import 'package:flutter/material.dart';
import 'package:wechat_demo/pages/const.dart';

class IndexBar extends StatefulWidget {
  final void Function(String str) indexBarCallBack;

  const IndexBar({Key? key, required this.indexBarCallBack}) : super(key: key);

  @override
  _IndexBarState createState() => _IndexBarState();
}

class _IndexBarState extends State<IndexBar> {
  final index_words = [];

  Color _backgroundColor = Color.fromRGBO(1, 1, 1, 0.0);
  Color _textColor = Colors.black;

  @override
  void initState() {
    super.initState();

    index_words.add('🔍');
    for (int i = 0; i < 26; i++) {
      var string = String.fromCharCode(i + 65);
      index_words.add(string);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> indexWidgets = [];
    for (int i = 0; i < index_words.length; i++) {
      indexWidgets.add(
          Expanded(
            child: Container(
              child: Text(
                index_words[i],
                style: TextStyle(
                    fontSize: 10,
                    color: _textColor,
                ),
              ),
            ),
          )
      );
    }
    return Positioned(
      top: screenHeight(context) / 8,
      right: 0,
      width: 30,
      height: screenHeight(context) / 2,
      child: Container(
        color: const Color.fromRGBO(1, 1, 1, 0.25),
        child: GestureDetector(
          onVerticalDragDown: (DragDownDetails details) {
            widget.indexBarCallBack(getIndexLetter(context, details.globalPosition)!);

            _backgroundColor = Color.fromRGBO(1, 1, 1, 0.5);
            _textColor = Colors.white;
            setState(() {});
          },
          onVerticalDragUpdate: (DragUpdateDetails details) {
            widget.indexBarCallBack(getIndexLetter(context, details.globalPosition)!);
          },
          onVerticalDragEnd: (DragEndDetails details) {
            _backgroundColor = Color.fromRGBO(1, 1, 1, 0.0);
            _textColor = Colors.black;
            setState(() {});
          },
          child: Container(
            color: _backgroundColor,
            child: Column(
              children: indexWidgets,
            ),
          ),
        ),
      ),
    );
  }

  String? getIndexLetter(BuildContext context, Offset globalPosition) {
    RenderBox? box = context.findRenderObject() as RenderBox?;
    if (box != null) {
      double y = box.globalToLocal(globalPosition).dy;
      final itemHeight = screenHeight(context)/2/index_words.length;
      int index = (y ~/ itemHeight).clamp(0, index_words.length - 1);
      return index_words[index];
    }
  }
}
