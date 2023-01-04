import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum NavbarState { collasped, expanded }

class NavbarButton extends StatefulWidget {
  const NavbarButton(
      {Key? key,
      required this.text,
      this.hasMessages = false,
      this.hasDropdown = false,
      this.selected = false,
      this.onNavbarTap})
      : super(key: key);

  final bool selected;
  final bool hasMessages;
  final bool hasDropdown;
  final String text;
  final Function()? onNavbarTap;

  @override
  State<NavbarButton> createState() => _NavbarButtonState();
}

class _NavbarButtonState extends State<NavbarButton> {
  late NavbarState navBarState;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
      child: Container(
        // send this widget down the tree below layout builder.
        decoration: BoxDecoration(
            color: widget.selected ? Colors.white12 : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          onTap: () => widget.onNavbarTap!(),
          hoverColor: Colors.white12,
          child: MouseRegion(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                // print("constraint width is ${constraints.maxWidth}");
                navBarState = constraints.maxWidth < 140
                    ? NavbarState.collasped
                    : NavbarState.expanded;

                return SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: Colors.white60,
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
                            ),
                            if (widget.hasDropdown) ...[
                              const Icon(
                                Icons.keyboard_arrow_right_sharp,
                                color: Colors.white,
                              )
                            ]
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
