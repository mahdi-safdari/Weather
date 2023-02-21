import 'package:clean_block_floor_lint_dio/features/feature_bookmark/presentation/bloc/bookmark_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/utils/date_converter.dart';
import '../../domain/use_cases/get_suggestion_city_usecase.dart';
import '../../../../core/widgets/dot_loading_widget.dart';
import '../../domain/entities/forecase_days_entity.dart';
import '../../domain/entities/current_city_entity.dart';
import '../../../../core/widgets/app_background.dart';
import '../../../../core/params/forecast_param.dart';
import '../../data/models/forecast_days_model.dart';
import '../../data/models/suggest_city_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/bookmark_icon.dart';
import '../widgets/day_weather_view.dart';
import 'package:flutter/material.dart';
import '../../../../locator.dart';
import '../bloc/cw_status.dart';
import '../bloc/fw_status.dart';
import '../bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  String cityName = "Tehran";
  PageController pageController = PageController();
  TextEditingController textEditingController = TextEditingController();
  GetSuggestionCityUseCase getSuggestionCityUseCase =
      GetSuggestionCityUseCase(locator());
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                      onSubmitted: (String prefix) {
                        textEditingController.text = prefix;
                        BlocProvider.of<HomeBloc>(context)
                            .add(LoadCwEvent(prefix));
                      },
                      controller: textEditingController,
                      style: DefaultTextStyle.of(context).style.copyWith(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        hintText: "Enter a City...",
                        hintStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    suggestionsCallback: (String pattern) {
                      return getSuggestionCityUseCase(pattern);
                    },
                    itemBuilder: (BuildContext context, Data itemData) {
                      return ListTile(
                        leading: const Icon(Icons.location_on),
                        title: Text(itemData.name!),
                        subtitle:
                            Text('${itemData.region}, ${itemData.country}'),
                      );
                    },
                    onSuggestionSelected: (Data suggestion) {
                      textEditingController.text = suggestion.name!;
                      BlocProvider.of<HomeBloc>(context)
                          .add(LoadCwEvent(suggestion.name!));
                    },
                  ),
                ),
                const SizedBox(width: 10),
                BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (HomeState previous, HomeState current) {
                    if (previous.cwStatus == current.cwStatus) {
                      return false;
                    }
                    return true;
                  },
                  builder: (BuildContext context, HomeState state) {
                    //! Show loading state for cw
                    if (state.cwStatus is CwLoading) {
                      return const CircularProgressIndicator();
                    }
                    //! Show Error state for cw
                    if (state.cwStatus is CwError) {
                      return IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.error,
                            color: Colors.white, size: 35),
                      );
                    }
                    //! Show completed state for cw
                    if (state.cwStatus is CwCompleted) {
                      final CwCompleted cwCompleted =
                          state.cwStatus as CwCompleted;
                      BlocProvider.of<BookmarkBloc>(context).add(
                          GetCityByNameEvent(
                              cwCompleted.currentCityEntity.name!));
                      return BookMarkIcon(
                        name: cwCompleted.currentCityEntity.name!,
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
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
                final CurrentCityEntity currentCityEntity =
                    cwCompleted.currentCityEntity;
                //! Create params for api call
                final ForecastParams forecastParams = ForecastParams(
                  currentCityEntity.coord!.lat!,
                  currentCityEntity.coord!.lon!,
                );
                //! Start load forecast weather event
                BlocProvider.of<HomeBloc>(context)
                    .add(LoadFwEvent(forecastParams));

                //! change Times to Hour --5:55 AM/PM----
                final sunrise = DateConverter.changeDtToDateTimeHour(
                    currentCityEntity.sys!.sunrise, currentCityEntity.timezone);
                final sunset = DateConverter.changeDtToDateTimeHour(
                    currentCityEntity.sys!.sunset, currentCityEntity.timezone);
                return Expanded(
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.02),
                        child: Container(
                          width: 100,
                          height: 420,

                          //!
                          child: Column(
                            children: <Widget>[
                              //! city name
                              Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: Text(
                                  currentCityEntity.name!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'eras',
                                    fontSize: 30,
                                  ),
                                ),
                              ),

                              //! city description
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text(
                                  currentCityEntity.weather![0].description!,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'comic',
                                    fontSize: 20,
                                  ),
                                ),
                              ),

                              //! weather icon
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: AppBackground.setIconForMain(
                                  currentCityEntity.weather![0].description!,
                                ),
                              ),

                              //! weather temp
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
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
                                        const Text(
                                          'max',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "${currentCityEntity.main!.tempMax!.round()}\u00B0",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    //! Divider
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      child: Container(
                                        color: Colors.grey,
                                        width: 2,
                                        height: 40,
                                      ),
                                    ),
                                    //! Min Temp
                                    Column(
                                      children: <Widget>[
                                        const Text(
                                          'min',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "${currentCityEntity.main!.tempMin!.round()}\u00B0",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
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
                      ),

                      //! List Viwe
                      SizedBox(
                        height: 150,
                        width: width,
                        child: ListView.builder(
                          itemCount: 4,
                          padding: EdgeInsets.only(left: 10),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            final List listName = [
                              "wind speed",
                              "sunrise",
                              "sunset",
                              "humidity",
                            ];
                            final List listValue = [
                              "${currentCityEntity.wind!.speed!} m/s",
                              sunrise,
                              sunset,
                              "${currentCityEntity.main!.humidity!}%",
                            ];
                            return SizedBox(
                              height: 150,
                              width: 140,
                              child: Card(
                                color: Colors.grey.withOpacity(0.123),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7))),
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        listName[index],
                                        style: TextStyle(
                                          fontSize: height * 0.025,
                                          color: Colors.white,
                                          fontFamily: 'comic',
                                        ),
                                      ),
                                      Text(
                                        listValue[index],
                                        style: TextStyle(
                                          fontSize: height * 0.022,
                                          color: Colors.grey,
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
                      const SizedBox(height: 30),
                    ],
                  ),
                );
              }
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
