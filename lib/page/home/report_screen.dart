import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:smart_farm_application/components/circle_button_widget.dart';
import 'package:smart_farm_application/page/home/compare_screen.dart';
import 'package:smart_farm_application/utilities/string-utils.dart';
import 'package:smart_farm_application/view_models/client_infor_view_model.dart';

import '../../components/map_arears_widget.dart';
import '../../model/area.dart';
import '../../model/client_infor.dart';

class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen> {



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
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  CompareScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
          );
        },
        icon: Icons.info,
      ),
      body: MapAreasWidget( listArea: listArea, isReport: true,),
    );
  }
}
