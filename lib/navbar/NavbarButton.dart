import 'package:flutter/material.dart';

class NavbarButton extends StatefulWidget {
  const NavbarButton(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  State<NavbarButton> createState() => _NavbarButtonState();
}

class _NavbarButtonState extends State<NavbarButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.text),
    );
  }
}
