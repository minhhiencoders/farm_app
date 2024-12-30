import 'package:flutter/cupertino.dart';
import '../model/drawer_item.dart';

class DrawerListItem {
  static final control = DrawerItem(
    title: 'Điều khiển',
    icon: CupertinoIcons.map,
  );

  static final workSchedule =
      DrawerItem(title: 'Lịch làm việc', icon: CupertinoIcons.news);
  static final report =
  DrawerItem(title: 'Báo cáo', icon: CupertinoIcons.chart_bar);
  static final irrigationAlternately =
  DrawerItem(title: 'Tưới luân phiên', icon: CupertinoIcons.map_pin_ellipse);
  static final sensorStation =
  DrawerItem(title: 'Trạm cảm biến', icon: CupertinoIcons.circle_grid_hex_fill);
  static final priceList =
      DrawerItem(title: 'Bảng giá', icon: CupertinoIcons.chart_pie_fill);
  static final logout =
      DrawerItem(title: 'Logout', icon: CupertinoIcons.square_arrow_right);

  static final List<DrawerItem> screens = [
    control,
    irrigationAlternately,
    report,
    sensorStation,
    workSchedule,
    priceList,
    logout,
  ];
}
