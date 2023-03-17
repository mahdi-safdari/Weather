import 'package:clean_block_floor_lint_dio/features/feature_weather/presentation/widgets/current_weather_main.dart';

import '../../../../core/utils/date_converter.dart';
import '../../domain/use_cases/get_suggestion_city_usecase.dart';
import '../../../../core/widgets/dot_loading_widget.dart';
import '../../domain/entities/current_city_entity.dart';
import '../../../../core/params/forecast_param.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../../locator.dart';
import '../bloc/cw_status.dart';
import '../bloc/home_bloc.dart';
import '../widgets/forcast_weather_days.dart';
import '../widgets/other_current_data.dart';
import '../widgets/search_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  String cityName = "Tehran";
  PageController pageController = PageController();
  TextEditingController textEditingController = TextEditingController();
  GetSuggestionCityUseCase getSuggestionCityUseCase = GetSuggestionCityUseCase(locator());
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(LoadCwEvent(cityName));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: height * 0.02),
          //! Search box
          SearchBox(width: width, textEditingController: textEditingController, getSuggestionCityUseCase: getSuggestionCityUseCase),

          //! main ui
          BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (HomeState previous, HomeState current) {
              //! Rebuild just when current weather status changed
              if (previous.cwStatus == current.cwStatus) {
                return false;
              }
              return true;
            },
            builder: (BuildContext context, HomeState state) {
              //! Loading
              if (state.cwStatus is CwLoading) {
                return const Expanded(
                  child: DotLoadingWidget(),
                );
              }

              //! completed data
              if (state.cwStatus is CwCompleted) {
                //! Cast
                final CwCompleted cwCompleted = state.cwStatus as CwCompleted;
                final CurrentCityEntity currentCityEntity = cwCompleted.currentCityEntity;
                //! Create params for api call
                final ForecastParams forecastParams = ForecastParams(
                  currentCityEntity.coord!.lat!,
                  currentCityEntity.coord!.lon!,
                );
                //! Start load forecast weather event
                BlocProvider.of<HomeBloc>(context).add(LoadFwEvent(forecastParams));

                //! change Times to Hour --5:55 AM/PM----
                final sunrise = DateConverter.changeDtToDateTimeHour(currentCityEntity.sys!.sunrise, currentCityEntity.timezone);
                final sunset = DateConverter.changeDtToDateTimeHour(currentCityEntity.sys!.sunset, currentCityEntity.timezone);
                return Expanded(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 380,

                        //! current weather main
                        child: CurrentWeatherMain(currentCityEntity: currentCityEntity),
                      ),

                      //! forcast weather 5 day

                      ForcastWeatherDays(width: width),

                      const SizedBox(height: 10),

                      //! List Viwe other current weather data

                      OtherCurrentData(height: height, width: width, currentCityEntity: currentCityEntity, sunrise: sunrise, sunset: sunset),
                      const SizedBox(height: 30),
                    ],
                  ),
                );
              }
              //! Error data
              if (state.cwStatus is CwError) {
                return const Center(
                  child: Text('Error'),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
