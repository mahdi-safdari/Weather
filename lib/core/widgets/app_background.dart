import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppBackground {
  static AssetImage getBackGroundImage() {
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('kk').format(now);
    //! Day
    if (6 > int.parse(formattedDate)) {
      return const AssetImage('assets/back/night.png');
    }
    //! Night
    else if (18 > int.parse(formattedDate)) {
      return const AssetImage('assets/back/after_noon.png');
    } else {
      return const AssetImage('assets/back/night.png');
    }
  }

  static Widget setIconForMain(dynamic description) {
    if (description == "clear sky") {
      return const Image(image: AssetImage('assets/images/sun.png'));
    } else if (description == "few clouds") {
      return const Image(image: AssetImage('assets/images/sun1.png'));
    } else if (description.contains("clouds")) {
      return const Image(image: AssetImage('assets/images/cloud.png'));
    } else if (description.contains("thunderstorm")) {
      return const Image(image: AssetImage('assets/images/rain.png'));
    } else if (description.contains("drizzle")) {
      return const Image(image: AssetImage('assets/images/rainy-day.png'));
    } else if (description.contains("rain")) {
      return const Image(image: AssetImage('assets/images/rainy.png'));
    } else if (description.contains("snow")) {
      return const Image(image: AssetImage('assets/images/snow.png'));
    } else {
      return const Image(image: AssetImage('assets/images/wind1.png'));
    }
  }
}
