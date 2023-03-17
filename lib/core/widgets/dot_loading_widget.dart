import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';

class DotLoadingWidget extends StatelessWidget {
  const DotLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.white, size: 50),
    );
  }
}
