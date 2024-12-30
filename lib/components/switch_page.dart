import 'package:flutter/widgets.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:smart_farm_application/model/drawer_item.dart';
import 'package:smart_farm_application/page/home/control_screen.dart';
import 'package:smart_farm_application/page/home/irrigation_alternately_screen.dart';
import 'package:smart_farm_application/page/home/price_list_screen.dart';
import 'package:smart_farm_application/page/home/sensor_station_screen.dart';
import 'package:smart_farm_application/page/home/word_schedule_screen.dart';

import '../page/home/report_screen.dart';
import '../utilities/drawer_list_utils.dart';

Widget switchPage(DrawerItem currentItem) {
  if (currentItem == DrawerListItem.control) {
    return ControlScreen();
  } else if (currentItem == DrawerListItem.workSchedule) {
    return WordScheduleScreen();
  } else if (currentItem == DrawerListItem.priceList) {
    return PriceListScreen();
  } else if (currentItem == DrawerListItem.sensorStation) {
    return SensorStationScreen();
  } else if (currentItem == DrawerListItem.report) {
    return ReportScreen();
  } else if (currentItem == DrawerListItem.irrigationAlternately) {
    return IrrigationAlternatelyScreen();
  } else {
    return ControlScreen();
  }
}
