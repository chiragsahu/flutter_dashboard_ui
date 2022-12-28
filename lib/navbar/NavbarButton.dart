import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavbarButton extends StatefulWidget {
  const NavbarButton({
    Key? key,
    required this.text,
    this.hasMessages = false,
    this.hasDropdown = false,
  }) : super(key: key);
  final bool hasMessages;
  final bool hasDropdown;
  final String text;

  @override
  State<NavbarButton> createState() => _NavbarButtonState();
}

class _NavbarButtonState extends State<NavbarButton> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // print("constraint width is ${constraints.maxWidth}");
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 5, 10),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.calendar_month,
                      color: Colors.white,
                    ),
                  ),
                  if (constraints.maxWidth > 140) ...[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          child: Text(
                            widget.text,
                            style: GoogleFonts.inter(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                  if (constraints.maxWidth > 140 && widget.hasDropdown) ...[
                    const Icon(
                      Icons.keyboard_arrow_right_sharp,
                      color: Colors.white,
                    )
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
