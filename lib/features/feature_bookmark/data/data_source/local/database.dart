import 'dart:async';
import 'package:clean_block_floor_lint_dio/features/feature_bookmark/data/data_source/local/city_dao.dart';
import 'package:clean_block_floor_lint_dio/features/feature_bookmark/domain/entities/city_entity.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [City])
abstract class AppDatabase extends FloorDatabase {
  CityDao get cityDao;
}
