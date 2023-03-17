import 'package:clean_block_floor_lint_dio/core/widgets/app_background.dart';
import 'package:clean_block_floor_lint_dio/core/widgets/bottom_nav.dart';
import 'package:clean_block_floor_lint_dio/features/feature_bookmark/presentation/screens/bookmark_screen.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class MainWrapper extends StatelessWidget {
  MainWrapper({super.key});
  final PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    final List<Widget> pageViewWidget = [const HomeScreen(), BookMarkScreen(pageController: pageController)];
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNav(controller: pageController),
      body: Container(
        height: height,
        decoration: AppBackground.decorationGradient(),
        child: PageView(
          controller: pageController,
          children: pageViewWidget,
          physics: BouncingScrollPhysics(),
        ),
      ),
    );
  }
}
