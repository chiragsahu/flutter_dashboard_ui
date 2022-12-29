import 'package:flutter/material.dart';
import 'package:volt_dashboard/navbar/NavbarButton.dart';

class NavbarData {
  String? title;
  bool? hasMessages;
  bool? hasDropdown;
  Function(bool)? hoverAction;
  NavbarData(this.title,
      {this.hasMessages, this.hasDropdown, this.hoverAction});
}

class Navbar extends StatefulWidget {
  const Navbar({Key? key, this.onNavBarHovered}) : super(key: key);

  final Function(bool)? onNavBarHovered;

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final List<NavbarData> navBarDataList = [
    NavbarData("Dashboard"),
    NavbarData("Kanban"),
    NavbarData("Messages"),
    NavbarData("Users Lists"),
    NavbarData("Transactions", hasDropdown: false),
    NavbarData("Task List"),
    NavbarData("Settings"),
    NavbarData("Calendar"),
    NavbarData("Dashboard"),
    NavbarData("Kanban"),
    NavbarData("Messages"),
    NavbarData("Users Lists"),
    NavbarData("Transactions"),
    NavbarData("Task List"),
    NavbarData("Settings", hasDropdown: true),
    NavbarData("Settings"),
    NavbarData("Calendar"),
  ];
  @override
  Widget build(BuildContext context) {
    return Material(
      child: MouseRegion(
        onEnter: (event) {
          if (widget.onNavBarHovered != null) {
            widget.onNavBarHovered!(true);
          }
        },
        onExit: (event) {
          if (widget.onNavBarHovered != null) {
            widget.onNavBarHovered!(false);
          }
        },
        child: Container(
          color: const Color.fromARGB(255, 30, 41, 55),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
            child: ListView.builder(
              itemCount: navBarDataList.length,
              itemBuilder: (context, index) {
                return Material(
                  color: const Color.fromARGB(255, 30, 41, 55),
                  child: InkWell(
                    // splashColor: Theme.of(context).primaryColorLight,
                    hoverColor: Colors.transparent,
                    onTap: () {},
                    child: NavbarButton(
                      text: navBarDataList[index].title!,
                      hasDropdown: navBarDataList[index].hasDropdown ?? false,
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
