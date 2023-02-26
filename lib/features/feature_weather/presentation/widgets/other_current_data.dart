import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/current_city_entity.dart';

class OtherCurrentData extends StatelessWidget {
  const OtherCurrentData({
    super.key,
    required this.height,
    required this.width,
    required this.currentCityEntity,
    required this.sunrise,
    required this.sunset,
  });

  final double height;
  final double width;
  final CurrentCityEntity currentCityEntity;
  final String sunrise;
  final String sunset;

  @override
  Widget build(BuildContext context) {
    return DelayedWidget(
      delayDuration: const Duration(milliseconds: 300),
      animationDuration: const Duration(seconds: 1),
      animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 15.0, bottom: 8),
            child: Text(
              'Other current data',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontFamily: 'comic',
              ),
            ),
          ),
          SizedBox(
            height: height * 0.225,
            width: width,
            child: ListView.builder(
              itemCount: 6,
              padding: EdgeInsets.only(left: 10),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                final visibility =
                    (currentCityEntity.visibility! / 1000).toStringAsFixed(0);
                final windSpeed =
                    (currentCityEntity.wind!.speed! * 3.6).toStringAsFixed(2);
                final List listName = [
                  "Wind speed",
                  "Humidity",
                  "Sunrise",
                  "Visibility",
                  "Sunset",
                  "Clouds",
                ];
                final List listImage = [
                  'assets/images/wind1.png',
                  'assets/images/drop.png',
                  'assets/images/sunrise.png',
                  'assets/images/visibility.png',
                  'assets/images/sunrise.png',
                  'assets/images/precipitation.png',
                ];
                final List listValue = [
                  "$windSpeed km/h",
                  "${currentCityEntity.main!.humidity!}%",
                  sunrise,
                  "$visibility km",
                  sunset,
                  "${currentCityEntity.clouds!.all}%",
                ];
                return SizedBox(
                  height: 130,
                  width: 110,
                  child: Card(
                    color: Colors.grey.withOpacity(0.22),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            listName[index],
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: 'comic',
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  listImage[index],
                                ),
                              ),
                            ),
                          ),
                          Text(
                            listValue[index],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                              fontFamily: 'comic',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
