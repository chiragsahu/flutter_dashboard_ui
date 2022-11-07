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
      child: Container(
        color: Color.fromARGB(255, 30, 41, 55),
        child: Center(
          child: Column(
            children: const [
              // ListView.builder(
              //     itemCount: 5,
              //     shrinkWrap: true,
              //     itemBuilder: (BuildContext context, int index) {
              //       return Row(
              //         children: [
              //           Text("tile $index"),
              //         ],
              //       );
              //     })
              SizedBox(height: 10.0),
              NavbarButton("Dashboard"),
              NavbarButton("Kanban"),
              NavbarButton("Messages"),
              NavbarButton("Users Lists"),
              NavbarButton("Transactions"),
              NavbarButton("Task List"),
              NavbarButton("Settings"),
              NavbarButton("Calendar"),

              NavbarButton("Dashboard"),
              NavbarButton("Kanban"),
              NavbarButton("Messages"),
              NavbarButton("Users Lists"),
              NavbarButton("Transactions"),
              NavbarButton("Task List"),
              NavbarButton("Settings"),
              NavbarButton("Calendar"),
            ],
          ),
        ),
      ),
    );
  }
}
