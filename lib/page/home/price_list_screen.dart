import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_farm_application/components/card_view_widget.dart';


class PriceListScreen extends ConsumerStatefulWidget {
  const PriceListScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PriceListScreenState();
}

class _PriceListScreenState extends ConsumerState<PriceListScreen> {
  final List<Map<String, dynamic>> basePrice = [
    {'duration': 3, 'price': 3600000}, // 3 months
    {'duration': 6, 'price': 3300000}, // 6 months
    {'duration': 12, 'price': 3000000}, // 12 months
    {'duration': 24, 'price': 2700000}, // 24 months
  ];

  final List<Map<String, dynamic>> controlTechnologyPrice = [
    {'duration': 3, 'price': 4200000}, // 3 months
    {'duration': 6, 'price': 3800000}, // 6 months
    {'duration': 12, 'price': 3600000}, // 12 months
    {'duration': 24, 'price': 3200000}, // 24 months
  ];
final List<Map<String, dynamic>> comprehensiveTechnologyPrice = [
    {'duration': 3, 'price': 5200000}, // 3 months
    {'duration': 6, 'price': 4800000}, // 6 months
    {'duration': 12, 'price': 4600000}, // 12 months
    {'duration': 24, 'price': 4200000}, // 24 months
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Bảng giá', style: TextStyle(fontSize: 50.spMin, fontWeight: FontWeight.bold),),
              CardViewWidget(listPrice: basePrice, title: 'Cơ bản', subTitle: 'Không có hệ thống châm phân và cảm biến EC, pH',),
              CardViewWidget(listPrice: controlTechnologyPrice, title: 'Công nghệ điều khiển', subTitle: 'Có hệ thống châm phân và cảm biến EC, pH',),
              CardViewWidget(listPrice: comprehensiveTechnologyPrice, title: 'Công nghệ toàn diện', subTitle: 'Đầy đủ tính năng theo yêu cầu chủ vườn',),
            ],
          ),
        ),
      ),
    );
  }
}
