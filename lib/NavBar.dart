// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        ListView.builder(itemBuilder: (BuildContext context,int index) {
          
        })
      ],),
    );
  }
}
