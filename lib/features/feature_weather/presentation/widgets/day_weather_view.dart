import 'package:clean_block_floor_lint_dio/core/utils/date_converter.dart';
import 'package:clean_block_floor_lint_dio/core/widgets/app_background.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/data/models/forecast_days_model.dart';
import 'package:flutter/material.dart';

class DaysWeatherView extends StatefulWidget {
  final ListElement list;
  final City city;
  const DaysWeatherView({super.key, required this.list, required this.city});

  @override
  State<DaysWeatherView> createState() => _DaysWeatherViewState();
}

class _DaysWeatherViewState extends State<DaysWeatherView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.5, 1, curve: Curves.decelerate),
      ),
    );
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return Transform(
          transform:
              Matrix4.translationValues(animation.value * width, 0.0, 0.0),
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Card(
              color: Colors.transparent,
              elevation: 0,
              child: SizedBox(
                width: 40,
                height: 50,
                child: Column(
                  children: <Widget>[
                    Text(
                      DateConverter.changeDtToDateTime(widget.list.dt),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                        fontFamily: 'comic',
                      ),
                    ),
                    Text(
                      DateConverter.changeDtToDateTimeHour(
                          widget.list.dt, widget.city.timezone),
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.grey,
                        fontFamily: 'eras',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: AppBackground.setIconForMain(
                        widget.list.weather![0].description,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          "${widget.list.main!.temp!.round()}\u00B0",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontFamily: 'eras',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    // _fwBloc.dispose();
    // _cwBloc.dispose();
    super.dispose();
  }
}
