import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:smart_farm_application/components/circle_button_widget.dart';
import 'package:smart_farm_application/components/loading_widget.dart';
import 'package:smart_farm_application/utilities/string-utils.dart';
import 'package:smart_farm_application/view_models/client_infor_view_model.dart';

import '../../components/map_arears_widget.dart';
import '../../model/area.dart';
import '../../model/client_infor.dart';
import '../../model/daily_timer.dart';

class ControlScreen extends ConsumerStatefulWidget {
  const ControlScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ControlScreenState();
}

class _ControlScreenState extends ConsumerState<ControlScreen> {
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
        voidCallback: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: const Text('Tất cả khu vực'),
                content: SizedBox(
                  width: double.maxFinite,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: listArea.length,
                    itemBuilder: (context, index) {
                      final area = listArea[index];
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: index < listArea.length - 1
                                ? 8
                                : 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          child: Row(
                            children: [
                              RichText(text: TextSpan(text: 'Tên: ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black26), children: [TextSpan(text: area.nameSector)])),
                              Spacer(),
                              RichText(text: TextSpan(text: 'Diện tích: ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black26), children: [TextSpan(text: area.acreage.toString())])),
                            ],
                          ), // Assuming DailyTimer has a name property
                        ),
                      );
                    },
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF1F2937),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    child: const Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        icon: Icons.list_alt,
      ),
      body: client.hasValue
          ? MapAreasWidget(listArea: listArea)
          : LoadingWidget(),
    );
  }
}
