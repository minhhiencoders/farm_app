import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:smart_farm_application/configs/contants.dart';
import 'package:smart_farm_application/utilities/hive_utils.dart';
import 'package:upgrader/upgrader.dart';
import 'app.dart';
import 'model/information.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Upgrader.clearSavedSettings();
  await Hive.initFlutter();
  HiveUtils.registerAdapter(InformationAdapter());
  HiveUtils.registerAdapter(ClientAdapter());
  HiveUtils.registerAdapter(OptsAdapter());
  HiveUtils.registerAdapter(UserAdapter());
  await HiveUtils.initHive(Contant.BOMBO_BOX);
  MapboxOptions.setAccessToken(Contant.TOKEN_MAPBOX);
  runApp(const ProviderScope(child: MyApp()));
}
