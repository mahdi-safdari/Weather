import 'package:clean_block_floor_lint_dio/core/widgets/app_background.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CurrentWeatherMain extends StatelessWidget {
  const CurrentWeatherMain({
    super.key,
    required this.currentCityEntity,
  });

  final CurrentCityEntity currentCityEntity;

  @override
  Widget build(BuildContext context) {
    return DelayedWidget(
      delayDuration: const Duration(milliseconds: 300),
      animationDuration: const Duration(milliseconds: 1500),
      animation: DelayedAnimations.SLIDE_FROM_TOP,
      child: Shimmer(
        interval: Duration(milliseconds: 600),
        child: Column(
          children: <Widget>[
            //! city name
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                currentCityEntity.name!,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'eras',
                  fontSize: 35,
                ),
              ),
            ),

            //! city description
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                currentCityEntity.weather![0].description!,
                style: TextStyle(
                  color: Colors.blueAccent[100],
                  fontFamily: 'comic',
                  fontSize: 20,
                ),
              ),
            ),

            //! weather icon
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                width: 100,
                height: 100,
                child: AppBackground.setIconForMain(
                  currentCityEntity.weather![0].description!,
                ),
              ),
            ),

            //! weather temp
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                "${currentCityEntity.main!.temp!.round()}\u00B0",
                style: const TextStyle(
                  fontFamily: 'eras',
                  color: Colors.white,
                  fontSize: 50,
                ),
              ),
            ),

            //! max & min Temp
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //! Max Temp
                  Column(
                    children: <Widget>[
                      Text(
                        'max',
                        style: TextStyle(
                          color: Colors.blueAccent[100],
                          fontSize: 16,
                          fontFamily: 'comic',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${currentCityEntity.main!.tempMax!.round()}\u00B0",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'eras',
                        ),
                      ),
                    ],
                  ),
                  //! Divider
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Container(
                      color: Colors.blueAccent[100],
                      width: 2,
                      height: 40,
                    ),
                  ),
                  //! Min Temp
                  Column(
                    children: <Widget>[
                      Text(
                        'min',
                        style: TextStyle(
                          color: Colors.blueAccent[100],
                          fontSize: 16,
                          fontFamily: 'comic',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${currentCityEntity.main!.tempMin!.round()}\u00B0",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'eras',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
