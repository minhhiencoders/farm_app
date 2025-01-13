import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_farm_application/components/circle_button_widget.dart';
import 'package:smart_farm_application/model/daily_timer.dart';
import 'package:smart_farm_application/page/home/compare_screen.dart';
import 'package:smart_farm_application/utilities/string-utils.dart';
import 'package:smart_farm_application/view_models/client_infor_view_model.dart';
import 'package:smart_farm_application/view_models/report_view_model.dart';

import '../../components/map_arears_widget.dart';
import '../../configs/contants.dart';
import '../../model/area.dart';
import '../../model/client_infor.dart';
import '../../model/information.dart';
import '../../router/routing_app.dart';
import '../../utilities/hive_utils.dart';

class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen> {
  // void _initializeDateTime() {
  //   final DateTime now = DateTime.now();
  //   final date = _selectedDate ?? DateTime(now.year, now.month, now.day);
  //   final time = _selectedTime ?? TimeOfDay(hour: now.hour, minute: now.minute);
  //
  //   final formattedDateTime =
  //       '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} '
  //       '${time.format(context)}';
  //   widget.controller.text = formattedDateTime;
  // }
  @override
  Widget build(BuildContext context) {
    final client = ref.watch(clientInfoProvider);
    List<Area> listArea = [];
    if (client.hasValue) {
      List<Sector> sectors =
          ref.watch(clientInfoProvider).value?.normalSectors ?? <Sector>[];
      if (sectors.isNotEmpty) {
        for (var element in sectors) {
          listArea.add(Area(
              positions: [StringUtils.coordinatesToPositions(element.coords)],
              nameSector: element.name ?? '',
              center: StringUtils.centerToPositions(element.center),
              acreage: element.area,
              spmeta: element.spmeta,
              sectorId: element.id,
              listDailyTimer: element.dailyscheds.map((e) => DailyTimer.fromList(e)).toList()
          ));
        }
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: CircleButtonWidget(
        voidCallback: () async{
          await HiveUtils.getValue<Information?>(
              Contant.INFORMATION_LIST, Contant.INFORMATION)
              .then(
                (value) {
              if (value != null) {
                ref.read(reportProvider.notifier).getCompareReport(value.authToken.toString(), value.clients.first.id.toString(), StringUtils.dateTimeToTimestampString(DateTime.now().subtract(Duration(days: 7))).toString(), StringUtils.dateTimeToTimestampString(DateTime.now()).toString());

              }
            },
          ).whenComplete(() => Navigator.of(context).pushNamed(
            AppRouter.compare,
          ),);
        },
        icon: Icons.info,
      ),
      body: MapAreasWidget(
        listArea: listArea,
        isReport: true,
      ),
    );
  }
}
