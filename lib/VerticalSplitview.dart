import 'package:flutter/material.dart';

class VerticalSplitView extends StatefulWidget {
  final Widget left;
  final Widget right;
  final double ratio;
  final bool resizeable;

  const VerticalSplitView(
      {required this.left,
      required this.right,
      this.ratio = 0.2,
      this.resizeable = true})
      : assert(left != null),
        assert(right != null),
        assert(ratio >= 0),
        assert(ratio <= 1);

  @override
  _VerticalSplitViewState createState() => _VerticalSplitViewState();
}

class _VerticalSplitViewState extends State<VerticalSplitView> {
  final _dividerWidth = 16.0;

  //from 0-1
  late double _ratio;
  late double _maxWidth = 1000;

  get _width1 => _ratio * _maxWidth;

  get _width2 => (1 - _ratio) * _maxWidth;

  @override
  void initState() {
    super.initState();
    _ratio = widget.ratio;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    setState(() {
      _maxWidth = screenWidth * 0.95;
      // print(_maxWidth);
    });
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      assert(_ratio <= 1);
      assert(_ratio >= 0);
      if (_maxWidth == null) _maxWidth = constraints.maxWidth - _dividerWidth;
      // _maxWidth = constraints.maxWidth - _dividerWidth;
      if (_maxWidth != constraints.maxWidth) {
        _maxWidth = constraints.maxWidth - _dividerWidth;
      }

      return SizedBox(
        width: constraints.maxWidth,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: _width1,
              child: widget.left,
            ),
            MouseRegion(
              cursor: SystemMouseCursors.resizeLeftRight,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: SizedBox(
                  width: _dividerWidth,
                  height: constraints.maxHeight,
                  child: const VerticalDivider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                ),
                onPanUpdate: (DragUpdateDetails details) {
                  if (widget.resizeable) {
                    setState(() {
                      _ratio += details.delta.dx / _maxWidth;
                      if (_ratio > 1)
                        _ratio = 1;
                      else if (_ratio < 0.0) _ratio = 0.0;
                    });
                  }
                },
              ),
            ),
            SizedBox(
              width: _width2,
              child: widget.right,
            ),
          ],
        ),
      );
    });
  }
}

// https://medium.com/@leonar.d/how-to-create-a-flutter-split-view-7e2ac700ea12