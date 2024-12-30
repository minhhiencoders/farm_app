import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
class CardViewWidget extends StatefulWidget {
  const CardViewWidget({super.key, required this.listPrice, required this.title, required this.subTitle});
  final List<Map<String, dynamic>> listPrice;
  final String title;
  final String subTitle;
  @override
  _CardViewWidgetState createState() => _CardViewWidgetState();
}

class _CardViewWidgetState extends State<CardViewWidget> {
  double total = 0.0;
  int? selectedDuration;

  // List of subscription options
  // final List<Map<String, dynamic>> subscriptionOptions = [
  //   {'duration': 3, 'price': 3600000}, // 3 months
  //   {'duration': 6, 'price': 3300000}, // 6 months
  //   {'duration': 12, 'price': 3000000}, // 12 months
  //   {'duration': 24, 'price': 2700000}, // 24 months
  // ];

  // Handle item click
  void _onItemClicked(int duration, double price) {
    setState(() {
      selectedDuration = duration;
      total = duration * price; // Multiply duration by monthly price
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10.dm, vertical: 10.dm),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      widget.subTitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildRow('Thời gian', 'Hàng tháng', isHeader: true),
                const Divider(),
                ...widget.listPrice.map((option) {
                  final isSelected = selectedDuration == option['duration'];
                  return GestureDetector(
                    onTap: () => _onItemClicked(
                      option['duration'],
                      option['price'].toDouble(),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: isSelected ? Colors.grey : Colors.transparent,
                          borderRadius: BorderRadius.circular(10)),
                      child: _buildRow(
                        '${option['duration']} tháng',
                        NumberFormat.currency(locale: 'vi_VN', symbol: 'VND')
                            .format(option['price']),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          const Divider(height: 1),
          // Footer
          Container(
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'TỔNG CỘNG',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  NumberFormat.currency(locale: 'vi_VN', symbol: 'VND')
                      .format(total),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String left, String right, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            left,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
              color: isHeader ? Colors.black : Colors.grey[800],
            ),
          ),
          Text(
            right,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
              color: isHeader ? Colors.black : Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
