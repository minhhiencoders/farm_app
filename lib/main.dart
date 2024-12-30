import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:smart_farm_application/configs/contants.dart';

import 'app.dart';
import 'model/information.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(InformationAdapter());
  Hive.registerAdapter(ClientAdapter());
  Hive.registerAdapter(OptsAdapter());
  Hive.registerAdapter(UserAdapter());
  // Hive.registerAdapter(ClientInforAdapter());
  // Hive.registerAdapter(SectorAdapter());
  // Hive.registerAdapter(FlowmetaAdapter());
  // Hive.registerAdapter(SpmetaAdapter());
  // Hive.registerAdapter(SpparamsAdapter());
  // Hive.registerAdapter(SensorDeviceAdapter());
  // Hive.registerAdapter(FertmetaAdapter());
  MapboxOptions.setAccessToken(Contant.TOKEN_MAPBOX);
  runApp(const ProviderScope(child: MyApp()));
}
