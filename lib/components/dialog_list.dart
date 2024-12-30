import 'package:flutter/material.dart';

class Area {
  final int id;
  final String name;
  final double area;

  Area({required this.id, required this.name, required this.area});
}

class DialogList extends StatelessWidget {
  final List<Area> areas = [
    Area(id: 1, name: 'A', area: 4164.8),
    Area(id: 2, name: 'B', area: 3888.9),
    Area(id: 6, name: 'C', area: 6693.7),
    Area(id: 7, name: 'D', area: 5039.2),
    Area(id: 8, name: 'E', area: 9792.5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tất cả khu vực'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SingleChildScrollView(
            clipBehavior: Clip.hardEdge,
            scrollDirection: Axis.horizontal,
            child: Table(
              border: TableBorder.all(),
              defaultColumnWidth: const FixedColumnWidth(120.0),
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.green,
                  ),
                  children: const [
                    TableCell(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('id', style: TextStyle(color: Colors.white)),
                    )),
                    TableCell(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Tên', style: TextStyle(color: Colors.white)),
                    )),
                    TableCell(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Diện tích',
                          style: TextStyle(color: Colors.white)),
                    )),
                  ],
                ),
                ...areas
                    .map((area) => TableRow(
                          children: [
                            TableCell(
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title:
                                          Text('Chi tiết khu vực ${area.name}'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('ID: ${area.id}'),
                                          Text('Diện tích: ${area.area}m²'),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text('Đóng'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(area.id.toString()),
                                ),
                              ),
                            ),
                            TableCell(
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title:
                                          Text('Chi tiết khu vực ${area.name}'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('ID: ${area.id}'),
                                          Text('Diện tích: ${area.area}m²'),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text('Đóng'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(area.name),
                                ),
                              ),
                            ),
                            TableCell(
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title:
                                          Text('Chi tiết khu vực ${area.name}'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('ID: ${area.id}'),
                                          Text('Diện tích: ${area.area}m²'),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text('Đóng'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('${area.area}m²'),
                                ),
                              ),
                            ),
                          ],
                        ))
                    .toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
