import 'dart:ui';

import 'package:clean_block_floor_lint_dio/features/feature_bookmark/domain/entities/city_entity.dart';
import 'package:clean_block_floor_lint_dio/features/feature_bookmark/presentation/bloc/bookmark_bloc.dart';
import 'package:clean_block_floor_lint_dio/features/feature_bookmark/presentation/bloc/get_all_city_status.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class BookMarkScreen extends StatelessWidget {
  final PageController pageController;
  const BookMarkScreen({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    BlocProvider.of<BookmarkBloc>(context).add(GetAllCityEvent());
    return BlocBuilder<BookmarkBloc, BookmarkState>(
      buildWhen: (BookmarkState previous, BookmarkState current) {
        //! Rebuild UI just when allCityStatus changes
        if (current.getAllCityStatus == previous.getAllCityStatus) {
          return false;
        } else {
          return true;
        }
      },
      builder: (BuildContext context, BookmarkState state) {
        //! show loading for allCityStatus
        if (state.getAllCityStatus is GetAllCityLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        //! show loaded for allCityStatus
        if (state.getAllCityStatus is GetAllCityCompleted) {
          //! casting for getting sities
          GetAllCityCompleted getAllCityCompleted = state.getAllCityStatus as GetAllCityCompleted;
          List<City> cities = getAllCityCompleted.cities;
          return SafeArea(
              child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              const Text(
                'Watch List',
                style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'eras'),
              ),
              const SizedBox(height: 20),
              Expanded(
                //! show text in center if there is no city bookmark
                child: (cities.isEmpty)
                    ? const Center(
                        child: Text(
                          'There is no city Bookmark.',
                          style: TextStyle(
                            fontFamily: 'comic',
                            color: Colors.white,
                            fontSize: 28,
                          ),
                        ),
                      )
                    : DelayedWidget(
                        delayDuration: const Duration(milliseconds: 300),
                        animationDuration: const Duration(seconds: 1),
                        animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: cities.length,
                          itemBuilder: (BuildContext context, int index) {
                            City city = cities[index];
                            return GestureDetector(
                              onTap: () {
                                //! cast for getting bookmark city data
                                BlocProvider.of<HomeBloc>(context).add(LoadCwEvent(city.name));
                                pageController.animateToPage(
                                  0,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: ClipRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                    child: Container(
                                      width: width,
                                      height: 60,
                                      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)), color: Colors.grey.withOpacity(0.1)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage('assets/images/placeholder.png'),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  city.name,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontFamily: 'eras',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                BlocProvider.of<BookmarkBloc>(context).add(DeleteCityEvent(city.name));
                                                BlocProvider.of<BookmarkBloc>(context).add(GetAllCityEvent());
                                              },
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage('assets/images/trash.png'),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ],
          ));
        }
        //! show Error for allCityStatus
        if (state.getAllCityStatus is GetAllCityError) {
          //! casting for getting error
          GetAllCityError getAllCityError = state.getAllCityStatus as GetAllCityError;
          return Center(child: Text(getAllCityError.message!));
        }
        //! show default value
        return Container();
      },
    );
  }
}
