import 'package:flutter/material.dart';

enum SplitViewMode { vertical, horizontal }

enum ResizeType { fixed, resizeableToExtent, resizeWithAnimation }

class SplitView extends StatefulWidget {
  final Widget left;
  final Widget right;
  final double ratio;
  final ResizeType resizeType;

  bool isNavbarShrinked = false;
  bool? animated;

  final double minWidthRatio;
  final double maxWidthRatio;
  final SplitViewMode? splitViewMode;

  SplitView({
    required this.left,
    required this.right,
    this.ratio = 0.2,
    this.maxWidthRatio = 0.5,
    this.minWidthRatio = 0.1,
    required this.splitViewMode,
    required this.resizeType,
  })  : assert(left != null),
        assert(right != null),
        assert(ratio >= 0 || ratio <= 1);

  @override
  _SplitViewState createState() => _SplitViewState();
}

class _SplitViewState extends State<SplitView> {
  final _dividerWidth = 16.0;

  //from 0-1
  late double _ratio;
  late double _maxWidth;
  late int animationTime;

  get _width1 => _ratio * _maxWidth;

  @override
  void initState() {
    super.initState();
    if (widget.resizeType == ResizeType.fixed) {
      widget.animated = false;
      animationTime = 0;
    } else {
      animationTime = 500;
    }
    _ratio = widget.ratio;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    setState(() {
      _maxWidth = screenWidth * 0.95;
    });
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      assert(_ratio >= 0 || _ratio <= 1);
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
                if (widget.resizeType == ResizeType.resizeWithAnimation) {
                  setState(() {
                    widget.isNavbarShrinked = !widget.isNavbarShrinked;
                    if (widget.isNavbarShrinked) {
                      _ratio = widget.maxWidthRatio;
                    } else {
                      _ratio = widget.minWidthRatio;
                    }
                  });
                }
              },
              child: AnimatedContainer(
                width: _width1,
                duration: Duration(milliseconds: animationTime),
                child: widget.left,
              ),
            ),
            MouseRegion(
              cursor: widget.resizeType != ResizeType.fixed
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
                  if (widget.resizeType != ResizeType.fixed) {
                    setState(() {
                      _ratio += details.delta.dx / _maxWidth;
                      // print("dx is ${details.delta.dx}  ratio is $_ratio");
                      if (widget.resizeType != ResizeType.resizeableToExtent) {
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
