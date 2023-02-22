import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final PageController controller;
  const BottomNav({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
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
              width: 30,
              height: 30,
              child: Image.asset('assets/images/home.png'),
            ),
          ),
          const SizedBox(),
          IconButton(
            onPressed: () {
              controller.animateToPage(1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
            },
            icon: SizedBox(
              width: 30,
              height: 30,
              child: Image.asset('assets/images/bookmark.png'),
            ),
          ),
        ],
      ),
    );
  }
}
