import 'package:clean_block_floor_lint_dio/features/feature_weather/presentation/bloc/cw_status.dart';
import 'package:clean_block_floor_lint_dio/features/feature_weather/presentation/widgets/bookmark_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../feature_bookmark/presentation/bloc/bookmark_bloc.dart';
import '../../data/models/suggest_city_model.dart';
import '../../domain/use_cases/get_suggestion_city_usecase.dart';
import '../bloc/home_bloc.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    required this.width,
    required this.textEditingController,
    required this.getSuggestionCityUseCase,
  });

  final double width;
  final TextEditingController textEditingController;
  final GetSuggestionCityUseCase getSuggestionCityUseCase;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: Row(
        children: <Widget>[
          Expanded(
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
                      fontFamily: 'comic',
                    ),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  hintText: "Search a City...",
                  hintStyle: TextStyle(color: Colors.grey),
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
                  title: Text(
                    itemData.name!,
                    style: TextStyle(fontFamily: 'comic'),
                  ),
                  subtitle: Text(
                    '${itemData.region}, ${itemData.country}',
                    style: TextStyle(fontFamily: 'comic'),
                  ),
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
                  icon: const Icon(Icons.error, color: Colors.white, size: 35),
                );
              }
              //! Show completed state for cw
              if (state.cwStatus is CwCompleted) {
                final CwCompleted cwCompleted = state.cwStatus as CwCompleted;
                BlocProvider.of<BookmarkBloc>(context).add(
                    GetCityByNameEvent(cwCompleted.currentCityEntity.name!));
                return BookMarkIcon(
                  name: cwCompleted.currentCityEntity.name!,
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
