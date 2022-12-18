import 'package:clean_block_floor_lint_dio/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/domain/use_cases/get_suggestion_city_usecase.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/widgets/dot_loading_widget.dart';
import '../../domain/entities/forecase_days_entity.dart';
import '../../domain/entities/current_city_entity.dart';
import '../../../../core/widgets/app_background.dart';
import '../../../../core/params/forecast_param.dart';
import '../../data/models/forecast_days_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class _HomeScreenState extends State<HomeScreen> {
  String cityName = "sast";
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                onSubmitted: (String prefix) {
                  textEditingController.text = prefix;
                  BlocProvider.of<HomeBloc>(context).add(LoadCwEvent(prefix));
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
                  subtitle: Text('${itemData.region}, ${itemData.country}'),
                );
              },
              onSuggestionSelected: (Data suggestion) {
                textEditingController.text = suggestion.name!;
                BlocProvider.of<HomeBloc>(context)
                    .add(LoadCwEvent(suggestion.name!));
              },
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

                return Expanded(
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.02),
                        child: SizedBox(
                          width: width,
                          height: 400,

                          //! page view indicator
                          child: PageView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            allowImplicitScrolling: true,
                            controller: pageController,
                            itemCount: 2,
                            itemBuilder: (BuildContext context, int position) {
                              if (position == 0) {
                                return Column(
                                  children: <Widget>[
                                    //! city name
                                    Padding(
                                      padding: const EdgeInsets.only(top: 50),
                                      child: Text(
                                        currentCityEntity.name!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ),

                                    //! city description
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Text(
                                        currentCityEntity
                                            .weather![0].description!,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),

                                    //! weather icon
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: AppBackground.setIconForMain(
                                        currentCityEntity
                                            .weather![0].description!,
                                      ),
                                    ),

                                    //! weather temp
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Text(
                                        "${currentCityEntity.main!.temp!.round()}\u00B0",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 50,
                                        ),
                                      ),
                                    ),

                                    //! max & min Temp
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                );
                              } else {
                                return Container(
                                  color: Colors.amber,
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      //! smooth page indicator
                      Center(
                        child: SmoothPageIndicator(
                          controller: pageController,
                          count: 2,
                          effect: const WormEffect(
                            spacing: 5,
                            dotHeight: 10,
                            dotWidth: 10,
                            activeDotColor: Colors.white,
                          ),
                          onDotClicked: (int index) {
                            pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOutQuint,
                            );
                          },
                        ),
                      ),

                      //! Divider
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
                      //! forecast weather 7 days
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: SizedBox(
                          width: width,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Center(
                              child: BlocBuilder<HomeBloc, HomeState>(
                                builder:
                                    (BuildContext context, HomeState state) {
                                  //! forecast weather loading state
                                  if (state.fwStatus is FwLoading) {
                                    return const DotLoadingWidget();
                                  }
                                  //! forecast weather Completed state
                                  if (state.fwStatus is FwCompleted) {
                                    //! Castring
                                    final FwCompleted fwCompleted =
                                        state.fwStatus as FwCompleted;
                                    final ForecastDaysEntity
                                        forecastDaysEntity =
                                        fwCompleted.forecastDaysEntity;
                                    final List<Daily> mainDaily =
                                        forecastDaysEntity.daily!;

                                    return ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 8,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return DaysWeatherView(
                                          daily: mainDaily[index],
                                        );
                                      },
                                    );
                                  }
                                  //! Forecast weather Error state
                                  if (state.fwStatus is FwError) {
                                    final FwError fwError =
                                        state.fwStatus as FwError;
                                    return Center(
                                      child: Text(fwError.messeage),
                                    );
                                  }
                                  //! Forecast weather Default state
                                  return Container();
                                },
                              ),
                            ),
                          ),
                        ),
                      ),

                      //! Divider
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
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
}
