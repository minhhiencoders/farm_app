import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class ItemIrrigationScreen extends ConsumerStatefulWidget {
  const ItemIrrigationScreen({super.key});
  @override
  ConsumerState createState() => _ItemIrrigationScreenState();
}

class _ItemIrrigationScreenState extends ConsumerState<ItemIrrigationScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(
      children: [
        Text('Khu vực: alt A'),
        Text('Tưới thủ công')
      ],
    ),);
  }
}
