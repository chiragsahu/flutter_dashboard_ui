// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:volt_dashboard/navbar/NavbarButton.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(
          color: Color.fromARGB(255, 30, 41, 55),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
            child: MouseRegion(
              onEnter: (event) {
                print("onEnter");
              },
              onExit: (event) {
                print("exit");
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  NavbarButton("Dashboard"),
                  NavbarButton("Kanban"),
                  NavbarButton("Messages"),
                  NavbarButton("Users Lists"),
                  NavbarButton("Transactions", hasDropdown: true),
                  NavbarButton("Task List"),
                  NavbarButton("Settings"),
                  NavbarButton("Calendar"),
                  NavbarButton("Dashboard"),
                  NavbarButton("Kanban"),
                  NavbarButton("Messages"),
                  NavbarButton("Users Lists"),
                  NavbarButton("Transactions"),
                  NavbarButton("Task List"),
                  NavbarButton(
                    "Settings",
                    hasDropdown: true,
                  ),
                  NavbarButton("Settings"),
                  NavbarButton("Calendar"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
