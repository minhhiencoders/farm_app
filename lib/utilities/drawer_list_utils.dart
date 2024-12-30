import 'package:flutter/cupertino.dart';
import '../model/drawer_item.dart';

class DrawerListItem {
  static final controll = DrawerItem(
    title: 'Controll',
    icon: CupertinoIcons.map,
  );

  static final workSchedule =
      DrawerItem(title: 'Profile', icon: CupertinoIcons.profile_circled);
  static final contact = DrawerItem(
    title: 'Contact',
    icon: CupertinoIcons.phone,
  );
  static final priceList =
      DrawerItem(title: 'Settings', icon: CupertinoIcons.settings);
  static final logout =
      DrawerItem(title: 'Logout', icon: CupertinoIcons.square_arrow_right);

  static final List<DrawerItem> screens = [
    controll,
    workSchedule,
    priceList,
    logout,
  ];
}
