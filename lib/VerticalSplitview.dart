import 'package:flutter/material.dart';

enum SplitViewMode { vertical, horizontal }

class VerticalSplitView extends StatefulWidget {
  final Widget left;
  final Widget right;
  final double ratio;
  final bool resizeable;
  final bool resizeToExtent;
  final double maxWidthRatio;
  final double minWidthRatio;
  final bool animated;
  final SplitViewMode? splitViewMode;

  const VerticalSplitView(
      {required this.left,
      required this.right,
      this.ratio = 0.2,
      this.maxWidthRatio = 0.5,
      this.minWidthRatio = 0.1,
      this.resizeable = true,
      this.resizeToExtent = true,
      this.splitViewMode = SplitViewMode.horizontal,
      this.animated = false})
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
  late double _maxWidth;

  get _width1 => _ratio * _maxWidth;
  get _width2 => (1 - _ratio) * _maxWidth;

  bool resizeAnimation = false;

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
            GestureDetector(
              onTap: () {
                if (resizeAnimation) {
                  setState(() {
                    resizeAnimation = !resizeAnimation;
                    if (resizeAnimation) {
                      _ratio = widget.maxWidthRatio;
                    } else {
                      _ratio = widget.minWidthRatio;
                    }
                  });
                }
              },
              child: AnimatedContainer(
                width: _width1,
                duration: const Duration(milliseconds: 500),
                child: widget.left,
              ),
            ),
            MouseRegion(
              cursor: widget.resizeable
                  ? SystemMouseCursors.resizeLeftRight
                  : MouseCursor.defer,
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
                      // print("dx is ${details.delta.dx}  ratio is $_ratio");
                      if (!widget.resizeToExtent) {
                        if (_ratio >= widget.maxWidthRatio)
                          _ratio = widget.maxWidthRatio;

                        if (_ratio <= widget.minWidthRatio)
                          _ratio = widget.minWidthRatio;
                      }
                      if (_ratio > 1)
                        _ratio = 1;
                      else if (_ratio < 0.0) {
                        _ratio = 0.0;
                      }
                    });
                  }
                },
              ),
            ),
            Expanded(child: widget.right),
          ],
        ),
      );
    });
  }
}
