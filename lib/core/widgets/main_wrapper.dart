import 'package:clean_block_floor_lint_dio/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/presentation/bloc/cw_status.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({Key? key}) : super(key: key);

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(const LoadCwEvent('Tehran'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (BuildContext context, HomeState state) {
          if (state.cwStatus is CwLoading) {
            return const Center(
              child: Text('Loading ...'),
            );
          }
          if (state.cwStatus is CwCompleted) {
            //! Cast
            final CwCompleted cwCompleted = state.cwStatus as CwCompleted;
            final CurrentCityEntity currentCityEntity =
                cwCompleted.currentCityEntity;

            return Center(
              child: Text(currentCityEntity.name.toString()),
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
    );
  }
}
