import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../components/circle_button_widget.dart';
import 'navigation_screen.dart';

class PriceListScreen extends ConsumerStatefulWidget {
  const PriceListScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PriceListScreenState();
}

class _PriceListScreenState extends ConsumerState<PriceListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleButtonWidget(
            voidCallback: () {},
            icon: Icons.menu_rounded,
          )
        ],
      ),
    );
  }
}
