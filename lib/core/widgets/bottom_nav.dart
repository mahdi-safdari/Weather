import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final PageController controller;
  const BottomNav({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 50,
      color: Colors.white,
      child: SizedBox(
        height: 63,
        child: Row(
          children: <Widget>[
            IconButton(
                onPressed: () {
                  controller.animateToPage(0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                },
                icon: const Icon(Icons.home)),
            const SizedBox(),
            IconButton(
                onPressed: () {
                  controller.animateToPage(1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                },
                icon: const Icon(Icons.bookmark)),
          ],
        ),
      ),
    );
  }
}
