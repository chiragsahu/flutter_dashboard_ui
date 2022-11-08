import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavbarButton extends StatefulWidget {
  const NavbarButton(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  State<NavbarButton> createState() => _NavbarButtonState();
}

class _NavbarButtonState extends State<NavbarButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 12, 10, 2),
      child: Row(
        children: [
          const Icon(
            Icons.calendar_month,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              widget.text,
              style: GoogleFonts.inter(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
