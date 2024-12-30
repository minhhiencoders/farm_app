import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:smart_farm_application/components/circle_button_widget.dart';
import 'package:smart_farm_application/utilities/string-utils.dart';
import 'package:smart_farm_application/view_models/client_infor_view_model.dart';

import '../../components/map_arears_widget.dart';
import '../../model/area.dart';
import '../../model/client_infor.dart';

class ControlScreen extends ConsumerStatefulWidget {
  const ControlScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ControlScreenState();
}

class _ControlScreenState extends ConsumerState<ControlScreen> {



  @override
  Widget build(BuildContext context) {
    final client = ref.watch(clientInforProvider);
    List<Area> listArea = [];
    if (client.hasValue) {
      List<Sector> sectors = ref.watch(clientInforProvider).value?.normalSectors ?? <Sector>[];
      if (sectors.isNotEmpty) {
        for (var element in sectors) {
              listArea.add(Area(positions: [StringUtils.coordinatesToPositions(element.coords)], nameSector: element.name ?? '', center: StringUtils.centerToPositions(element.center), acreage: element.area, spmeta: element.spmeta));
            }
      }
    }





    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: CircleButtonWidget(
        voidCallback: () {
        },
        icon: Icons.question_answer,
      ),
      body: MapAreasWidget( listArea: listArea),
    );
  }
}
