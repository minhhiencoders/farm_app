import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:smart_farm_application/components/circle_button_widget.dart';
import 'package:smart_farm_application/components/dialog_list.dart';
import 'package:smart_farm_application/view_models/client_infor_view_model.dart';

import '../../components/map_arears_widget.dart';
import '../../model/client_infor.dart';

class ControlScreen extends ConsumerStatefulWidget {
  const ControlScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ControlScreenState();
}

class _ControlScreenState extends ConsumerState<ControlScreen> {
  List<List<double>> swapCoordinates(List<List<double>> coordinates) {
    return coordinates.map((coord) {
      if (coord.length != 2) {
        throw ArgumentError('Each coordinate pair must contain exactly 2 values');
      }
      return [coord[1], coord[0]];
    }).toList();
  }


  List<Position> coordinatesToPositions(List<List<double>> coordinates) {
    return coordinates.map((coord) {
      if (coord.length != 2) {
        throw ArgumentError('Each coordinate pair must contain exactly 2 values');
      }
      return Position(coord[1],coord[0]);
    }).toList();
  }

  Position centerToPositions(List<double> coordinates) {
    return Position(coordinates[1],coordinates[0]);
  }

  @override
  Widget build(BuildContext context) {
    final client = ref.watch(clientInforProvider);
    List<List<List<Position>>> positions = [];
    List<String> nameSectors = [];
    List<Position> centers = [];
    if (client.hasValue) {
      List<Sector> sectors = ref.watch(clientInforProvider).value?.normalSectors ?? <Sector>[];
      print('wwwwwwwwwwwwwwwwwwww');
      print(sectors.length);
      if (sectors.isNotEmpty) {
        for (var element in sectors) {
              positions.add([coordinatesToPositions(element.coords)]);
              nameSectors.add(element.name ?? '');
              centers.add(centerToPositions(element.center));
            }
      }
    }


    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: CircleButtonWidget(
        voidCallback: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.8,
                child: DialogList(),
              ),
            ),
          );
        },
        icon: Icons.question_answer,
      ),
      body: MapAreasWidget(position: positions,nameSector: nameSectors, centers: centers,),
    );
  }
}
