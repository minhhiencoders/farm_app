import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/timePickerTextField_component.dart';
class CompareScreen extends ConsumerStatefulWidget {
  const CompareScreen({super.key});

  @override
  ConsumerState createState() => _CompareScreenState();
}

class _CompareScreenState extends ConsumerState<CompareScreen> {
  final _fromTimeController = TextEditingController();
  final _toTimeController = TextEditingController();
  final List<Map<String, dynamic>> agriculturalData = [
    {
      'id': '1',
      'area': 'A',
      'size': '4164.81m²',
      'waterAmount': '0.0L, 0.0mm',
      'wateringTime': '0.0 ys',
      'fertilizer': '0.0 yg, 0.0 yg/m²',
      'manure': '0.0 yg, 0.0 yg/m²',
      'pesticide': '0.0 yg, 0.0 yg/m²',
      'potassium': '0.0 yg, 0.0 yg/m²',
    },
    {
      'id': '2',
      'area': 'B',
      'size': '3888.86m²',
      'waterAmount': '0.0L, 0.0mm',
      'wateringTime': '0.0 ys',
      'fertilizer': '0.0 yg, 0.0 yg/m²',
      'manure': '0.0 yg, 0.0 yg/m²',
      'pesticide': '0.0 yg, 0.0 yg/m²',
      'potassium': '0.0 yg, 0.0 yg/m²',
    },
    {
      'id': '6',
      'area': 'C',
      'size': '6693.73m²',
      'waterAmount': '0.0L, 0.0mm',
      'wateringTime': '0.0 ys',
      'fertilizer': '0.0 yg, 0.0 yg/m²',
      'manure': '0.0 yg, 0.0 yg/m²',
      'pesticide': '0.0 yg, 0.0 yg/m²',
      'potassium': '0.0 yg, 0.0 yg/m²',
    },
    {
      'id': '7',
      'area': 'D',
      'size': '5039.23m²',
      'waterAmount': '0.0L, 0.0mm',
      'wateringTime': '0.0 ys',
      'fertilizer': '0.0 yg, 0.0 yg/m²',
      'manure': '0.0 yg, 0.0 yg/m²',
      'pesticide': '0.0 yg, 0.0 yg/m²',
      'potassium': '0.0 yg, 0.0 yg/m²',
    },
    {
      'id': '8',
      'area': 'E',
      'size': '9792.51m²',
      'waterAmount': '0.0L, 0.0mm',
      'wateringTime': '0.0 ys',
      'fertilizer': '0.0 yg, 0.0 yg/m²',
      'manure': '0.0 yg, 0.0 yg/m²',
      'pesticide': '0.0 yg, 0.0 yg/m²',
      'potassium': '0.0 yg, 0.0 yg/m²',
    },
  ];

  String _searchQuery = '';
  String _sortField = 'id';
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('So Sánh'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showSortOptions,
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _showSearch,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.dm),
            child: Row(
              spacing: 5.dm,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    spacing: 10.dm,
                    children: [
                      TimePickerTextField(onChangeText: (String value) {  }, controller: _fromTimeController, getDateTimer: true,),
                      TimePickerTextField(onChangeText: (String value) {  }, controller: _toTimeController, getDateTimer: true,),
                    ],
                  ),
                ),
                Expanded(
                  child: ElevatedButton(onPressed: () {

                  }, child: Text('Xem')),
                )
              ],
            ),
          ),
          if (_searchQuery.isNotEmpty)
            Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search areas...',
                        ),
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                      ),
                    ),
                    if (_searchQuery.isNotEmpty)
                      IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      ),
                  ],
                ),
              ),
            ),
          Expanded(
            child: _buildMainContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    var filteredData = agriculturalData;

    if (_searchQuery.isNotEmpty) {
      filteredData = agriculturalData.where((data) {
        return data['area']
            .toString()
            .toLowerCase()
            .contains(_searchQuery.toLowerCase()) ||
            data['id']
                .toString()
                .toLowerCase()
                .contains(_searchQuery.toLowerCase());
      }).toList();
    }

    // Sort data
    filteredData.sort((a, b) {
      if (_sortAscending) {
        return a[_sortField].toString().compareTo(b[_sortField].toString());
      } else {
        return b[_sortField].toString().compareTo(a[_sortField].toString());
      }
    });

    return RefreshIndicator(
      backgroundColor: Colors.white,
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 1));
        setState(() {});
      },
      child: ListView.builder(
        itemCount: filteredData.length,
        itemBuilder: (context, index) {
          final data = filteredData[index];
          return _buildListItem(data);
        },
      ),
    );
  }

  Widget _buildListItem(Map<String, dynamic> data) {
    return Card(
      color: Colors.white,
      elevation: 10.spMin,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green.shade100,
          child: Text(data['id']),
        ),
        title: Text('Khu vực  ${data['area']}'),
        subtitle: Text('${data['size']}'),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow('Lượng nước đã tưới', data['waterAmount']),
                _buildDetailRow('Thời gian đã tưới	', data['wateringTime']),
                _buildDetailRow('Lượng phân tổng', data['fertilizer']),
                _buildDetailRow('Lượng đạm', data['manure']),
                _buildDetailRow('Lượng lân', data['pesticide']),
                _buildDetailRow('Lượng kali', data['potassium']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Sort by ID'),
                onTap: () {
                  setState(() {
                    if (_sortField == 'id') {
                      _sortAscending = !_sortAscending;
                    } else {
                      _sortField = 'id';
                      _sortAscending = true;
                    }
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Sort by Area'),
                onTap: () {
                  setState(() {
                    if (_sortField == 'area') {
                      _sortAscending = !_sortAscending;
                    } else {
                      _sortField = 'area';
                      _sortAscending = true;
                    }
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Sort by Size'),
                onTap: () {
                  setState(() {
                    if (_sortField == 'size') {
                      _sortAscending = !_sortAscending;
                    } else {
                      _sortField = 'size';
                      _sortAscending = true;
                    }
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSearch() {
    setState(() {
      _searchQuery = _searchQuery.isEmpty ? ' ' : '';
    });
  }
}
