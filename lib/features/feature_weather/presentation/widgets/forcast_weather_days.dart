import 'package:clean_block_floor_lint_dio/core/widgets/dot_loading_widget.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/domain/entities/forecase_days_entity.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/presentation/bloc/fw_status.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/presentation/widgets/day_weather_view.dart';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/forecast_days_model.dart';
import '../bloc/home_bloc.dart';

class ForcastWeatherDays extends StatelessWidget {
  const ForcastWeatherDays({
    super.key,
    required this.width,
  });

  final double width;

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
            padding: EdgeInsets.only(left: 15.0),
            child: Text('5-day forcast', style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'comic')),
          ),
          SizedBox(
            width: width,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (BuildContext context, state) {
                  //! show Loading State for Fw
                  if (state.fwStatus is FwLoading) {
                    return const DotLoadingWidget();
                  }

                  //! show Completed State for Fw
                  if (state.fwStatus is FwCompleted) {
                    //! casting
                    final FwCompleted fwCompleted = state.fwStatus as FwCompleted;
                    final ForecastDaysEntity forecastDaysEntity = fwCompleted.forecastDaysEntity;
                    final List<ListElement> mainDaily = forecastDaysEntity.list!;

                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 40,
                      itemBuilder: (BuildContext context, int index) {
                        return DaysWeatherView(list: mainDaily[index], city: forecastDaysEntity.city!);
                      },
                    );
                  }

                  //! show Error State for Fw
                  if (state.fwStatus is FwError) {
                    final FwError fwError = state.fwStatus as FwError;
                    return Center(child: Text(fwError.messeage));
                  }

                  //! show Default State for Fw
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
