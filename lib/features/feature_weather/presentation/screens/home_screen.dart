import 'package:clean_block_floor_lint_dio/core/widgets/app_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/widgets/dot_loading_widget.dart';
import '../../domain/entities/current_city_entity.dart';
import '../bloc/cw_status.dart';
import '../bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String cityName = "sast";
  PageController pageController = PageController();
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
          BlocBuilder<HomeBloc, HomeState>(
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
                      const Padding(
                        padding: EdgeInsets.all(8),
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
