import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

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

  static BoxDecoration decorationGradient() {
    final list = [
      [Color(0xff3f51b5), Color(0xfff44336)],
      [Color(0xffffeb3b), Color(0xff00bcd4)],
      [Color(0xff795548), Color(0xff2196f3)],
      [Color(0xff00bcd4), Color(0xff673ab7)],
      [Color(0xff2196f3), Color(0xff00bcd4)],
      [Color(0xff673ab7), Color(0xffff5722)],
      [Color(0xff9c27b0), Color(0xff673ab7)],
      [Color(0xff00bcd4), Color(0xff3f51b5)],
      [Color(0xff3f51b5), Color(0xffe91e63)],
      [Color(0xff009688), Color(0xff3f51b5)],
      [Color(0xff03a9f4), Color(0xff9c27b0)],
      [Color(0xff03a9f4), Color(0xff9c27b0)],
      [Color(0xff3f51b5), Color(0xff9c27b0)],
      [Color(0xff00bcd4), Color(0xffe91e63)],
      [Color(0xff009688), Color(0xffe91e63)],
      [Color(0xff03a9f4), Color(0xffe91e63)],
      [Color(0xff3f51b5), Color(0xff00bcd4)],
      [Color(0xff673ab7), Color(0xff009688)],
      [Color(0xff3f51b5), Color(0xff00bcd4)],
      [Color(0xffe91e63), Color(0xff03a9f4)],
      [Color(0xff2196f3), Color(0xff4caf50)],
    ];
    Random random = Random();
    return BoxDecoration(
      gradient: LinearGradient(
        colors: list[random.nextInt(list.length)],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
    );
  }

  static Widget setIconForMain(dynamic description) {
    if (description == "clear sky") {
      return const Image(image: AssetImage('assets/images/sun.png'));
    } else if (description == "few clouds") {
      return const Image(image: AssetImage('assets/images/sunny.png'));
    } else if (description == "scattered clouds") {
      return const Image(image: AssetImage('assets/images/sunny.png'));
    } else if (description == "broken clouds") {
      return const Image(image: AssetImage('assets/images/sun1.png'));
    } else if (description == "overcast clouds") {
      return const Image(image: AssetImage('assets/images/cloud.png'));
    } else if (description.contains("thunderstorm")) {
      return const Image(image: AssetImage('assets/images/rain.png'));
    } else if (description.contains("drizzle")) {
      return const Image(image: AssetImage('assets/images/cloudy.png'));
    } else if (description.contains("rain")) {
      return const Image(image: AssetImage('assets/images/heavy-rain.png'));
    } else if (description.contains("snow")) {
      return const Image(image: AssetImage('assets/images/snow.png'));
    } else if (description.contains("sleet")) {
      return const Image(image: AssetImage('assets/images/snow.png'));
    } else {
      return const Image(image: AssetImage('assets/images/wind1.png'));
    }
  }

  static Widget setAnimateIcons(String description) {
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('kk').format(now);
    //# Night
    if (6 > int.parse(formattedDate)) {
      if (description == "clear sky") {
        return Lottie.asset('assets/json/clear-night.json');
      } else if (description == "few clouds") {
        return Lottie.asset('assets/json/few-cloudy-night.json');
      } else if (description == "scattered clouds") {
        return Lottie.asset('assets/json/few-cloudy-night.json');
      } else if (description == "broken clouds") {
        return Lottie.asset('assets/json/cloudynight.json');
      } else if (description == "overcast clouds") {
        return Lottie.asset('assets/json/cloudy.json');
      } else if (description.contains("thunderstorm")) {
        return Lottie.asset('assets/json/storm.json');
      } else if (description.contains("drizzle")) {
        return Lottie.asset('assets/json/rainynight.json');
      } else if (description.contains("rain")) {
        return Lottie.asset('assets/json/rainy.json');
      } else if (description.contains("snow")) {
        return Lottie.asset('assets/json/snow.json');
      } else if (description.contains("sleet")) {
        return Lottie.asset('assets/json/snownight.json');
      } else {
        return Lottie.asset('assets/json/windy.json');
      }
    }
    //# Day
    else if (18 > int.parse(formattedDate)) {
      if (description == "clear sky") {
        return Lottie.asset('assets/json/sunny.json');
      } else if (description == "few clouds") {
        return Lottie.asset('assets/json/few-cloudy.json');
      } else if (description == "scattered clouds") {
        return Lottie.asset('assets/json/few-cloudy.json');
      } else if (description == "broken clouds") {
        return Lottie.asset('assets/json/cloudyDay.json', fit: BoxFit.contain);
      } else if (description == "overcast clouds") {
        return Lottie.asset('assets/json/cloudy.json');
      } else if (description.contains("thunderstorm")) {
        return Lottie.asset('assets/json/storm.json');
      } else if (description.contains("drizzle")) {
        return Lottie.asset('assets/json/rain-sunny.json');
      } else if (description.contains("rain")) {
        return Lottie.asset('assets/json/rainy.json', fit: BoxFit.fill);
      } else if (description.contains("snow")) {
        return Lottie.asset('assets/json/snow.json');
      } else if (description.contains("sleet")) {
        return Lottie.asset('assets/json/snow-sunny.json');
      } else {
        return Lottie.asset('assets/json/windy.json');
      }
      //# Night
    } else {
      if (description == "clear sky") {
        return Lottie.asset('assets/json/clear-night.json');
      } else if (description == "few clouds") {
        return Lottie.asset('assets/json/few-cloudy-night.json');
      } else if (description == "scattered clouds") {
        return Lottie.asset('assets/json/few-cloudy-night.json');
      } else if (description == "broken clouds") {
        return Lottie.asset('assets/json/cloudynight.json');
      } else if (description == "overcast clouds") {
        return Lottie.asset('assets/json/cloudy.json');
      } else if (description.contains("thunderstorm")) {
        return Lottie.asset('assets/json/storm.json');
      } else if (description.contains("drizzle")) {
        return Lottie.asset('assets/json/rainynight.json');
      } else if (description.contains("rain")) {
        return Lottie.asset('assets/json/rainy.json');
      } else if (description.contains("snow")) {
        return Lottie.asset('assets/json/snow.json');
      } else if (description.contains("sleet")) {
        return Lottie.asset('assets/json/snownight.json');
      } else {
        return Lottie.asset('assets/json/windy.json');
      }
    }
  }
}
