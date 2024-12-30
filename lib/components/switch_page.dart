import 'package:flutter/widgets.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:smart_farm_application/model/drawer_item.dart';
import 'package:smart_farm_application/page/home/home_screen.dart';
import 'package:smart_farm_application/page/home/price_list_screen.dart';
import 'package:smart_farm_application/page/home/word_schedule_screen.dart';

import '../utilities/drawer_list_utils.dart';

Widget switchPage(DrawerItem currentItem) {
  if (currentItem == DrawerListItem.controll) {
    return ControlScreen();
  } else if (currentItem == DrawerListItem.workSchedule) {
    return WordScheduleScreen();
  } else if (currentItem == DrawerListItem.priceList) {
    return PriceListScreen();
  } else {
    return ControlScreen();
  }
}
