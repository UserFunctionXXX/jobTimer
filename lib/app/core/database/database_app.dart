import 'package:isar/isar.dart';

abstract class DatabaseApp {
  Future<Isar> openConnection();
}