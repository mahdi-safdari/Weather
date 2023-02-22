import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final PageController controller;
  const BottomNav({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Card(
          margin: EdgeInsets.fromLTRB(80, 0, 80, 20),
          elevation: 1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  controller.animateToPage(0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                },
                icon: SizedBox(
                  width: 25,
                  height: 25,
                  child: Image.asset('assets/images/home.png'),
                ),
              ),
              IconButton(
                onPressed: () {
                  controller.animateToPage(1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                },
                icon: SizedBox(
                  width: 25,
                  height: 25,
                  child: Image.asset('assets/images/bookmark.png'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
