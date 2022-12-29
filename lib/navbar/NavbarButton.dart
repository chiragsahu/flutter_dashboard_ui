import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum NavbarState { collasped, expanded }

class NavbarButton extends StatefulWidget {
  NavbarButton({
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
  late NavbarState navBarState;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // print("constraint width is ${constraints.maxWidth}");
          if (constraints.maxWidth < 140) {
            navBarState = NavbarState.collasped;
          } else {
            navBarState = NavbarState.expanded;
          }

          return SizedBox(
            height: 75,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      color: Colors.white,
                    ),
                    if (navBarState == NavbarState.expanded) ...[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            child: Text(
                              widget.text,
                              style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      )
                    ],
                    if (navBarState == NavbarState.expanded &&
                        widget.hasDropdown) ...[
                      const Icon(
                        Icons.keyboard_arrow_right_sharp,
                        color: Colors.white,
                      )
                    ]
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
