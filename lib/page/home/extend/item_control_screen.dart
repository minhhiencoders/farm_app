import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../components/input_widget.dart';
import '../../../components/timePickerTextField_component.dart';
import '../../../model/area.dart';

class ItemControlScreenScreen extends ConsumerStatefulWidget {
  const ItemControlScreenScreen({
    super.key,
    required this.area,
    this.isShowIrrigation = true
  });
  final Area area;
  final bool isShowIrrigation;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ItemControlScreenScreenState();
}

class _ItemControlScreenScreenState
    extends ConsumerState<ItemControlScreenScreen> {
  final _handmadeController = TextEditingController();
  final _timerController = TextEditingController();
  final _timerAndDayController = TextEditingController();
  final _minutesController = TextEditingController();
  final _minutesOfDayController = TextEditingController();
  final _temperatureMaxController = TextEditingController();
  final _humidityMinController = TextEditingController();
  final _countMinutesController = TextEditingController();
  final _countAutoMaxController = TextEditingController();
  final _countedAutoToDayController = TextEditingController();
  final _fertilizerController = TextEditingController();
  final _manureController = TextEditingController();
  final _pesticideController = TextEditingController();
  final _kaliController = TextEditingController();
  final _a1Controller = TextEditingController();
  final _a2Controller = TextEditingController();
  final _a3Controller = TextEditingController();
  final _b1Controller = TextEditingController();
  final _b2Controller = TextEditingController();
  final _b3Controller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _handmadeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Khu vực: ${widget.area.nameSector}'),
                  Text('Diện tích: ${widget.area.acreage}'),
                ],
              ),
            ),
            Text('Tưới thủ công 123'),
            Row(
              spacing: 10.dg,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: InputWidget(
                    isCenter: true,
                    hintText: 'Số phút',
                    controller: _handmadeController,
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(onPressed: () {}, child: Text('Bật')),
                        ElevatedButton(onPressed: () {}, child: Text('Tắt')),
                      ],
                    ))
              ],
            ),
            if(widget.isShowIrrigation)
              Column(spacing: 10.dm,
              children: [
                Row(
                  spacing: 10.dm,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text('Phân (kg)'),
                    ),
                    Expanded(child: InputWidget(
                      isCenter: true,
                      hintText: 'Khối lượng (kg)',
                      controller: _fertilizerController,
                    ))
                  ],
                ),
                Row(
                  spacing: 10.dm,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text('Đạm (%)'),
                    ),
                    Expanded(child: InputWidget(
                      isCenter: true,
                      hintText: '%',
                      controller: _manureController,
                    ))
                  ],
                ),
                Row(
                  spacing: 10.dm,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text('Lân (%)'),
                    ),
                    Expanded(child: InputWidget(
                      isCenter: true,
                      hintText: '%',
                      controller: _pesticideController,
                    ))
                  ],
                ),
                Row(
                  spacing: 10.dm,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text('Kali (%)'),
                    ),
                    Expanded(child: InputWidget(
                      isCenter: true,
                      hintText: '%',
                      controller: _kaliController,
                    ))
                  ],
                ),
                Row(
                  spacing: 10.dm,
                  children: [
                    Expanded(child: InputWidget(
                      isCenter: true,
                      hintText: 'Tên chất',
                      controller: _a1Controller,
                    )),
                    Expanded(child: InputWidget(
                      isCenter: true,
                      hintText: 'Khối lượng (kg)',
                      controller: _b1Controller,
                    ))
                  ],
                ),
                Row(
                  spacing: 10.dm,
                  children: [
                    Expanded(child: InputWidget(
                      isCenter: true,
                      hintText: 'Tên chất',
                      controller: _a2Controller,
                    )),
                    Expanded(child: InputWidget(
                      isCenter: true,
                      hintText: 'Khối lượng (kg)',
                      controller: _b2Controller,
                    ))
                  ],
                ),
                Row(
                  spacing: 10.dm,
                  children: [
                    Expanded(child: InputWidget(
                      isCenter: true,
                      hintText: 'Tên chất',
                      controller: _a3Controller,
                    )),
                    Expanded(child: InputWidget(
                      isCenter: true,
                      hintText: 'Khối lượng (kg)',
                      controller: _b3Controller,
                    ))
                  ],
                )
              ],
            ),
            Text('Hẹn giờ hằng ngày (theo phút)'),
            Row(
              spacing: 0.05.sw,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: InputWidget(
                    isCenter: true,
                    number: true,
                    hintText: '',
                    controller: _minutesOfDayController,
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: TimePickerTextField(
                      onChangeText: (String value) {
                        print(value);
                      },
                      controller: _timerController,
                    ))
              ],
            ),
            Row(children: [
              Spacer(),
              ElevatedButton(onPressed: () {}, child: Text('Xác nhận')),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Basic dialog title'),
                          content: const Text(
                            'A dialog is a type of modal window that\n'
                            'appears in front of app content to\n'
                            'provide critical information, or prompt\n'
                            'for a decision to be made.',
                          ),
                          actions: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('Disable'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('Enable'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.info))
            ]),
            Text('Hẹn giờ'),
            Row(
              spacing: 0.05.sw,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: InputWidget(
                    isCenter: true,
                    number: true,
                    hintText: '',
                    controller: _minutesController,
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: TimePickerTextField(
                      getDateTimer: true,
                      onChangeText: (String value) {
                        print(value);
                      },
                      controller: _timerAndDayController,
                    ))
              ],
            ),
            Row(children: [
              Spacer(),
              ElevatedButton(onPressed: () {}, child: Text('Xác nhận')),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Basic dialog title'),
                          content: const Text(
                            'A dialog is a type of modal window that\n'
                            'appears in front of app content to\n'
                            'provide critical information, or prompt\n'
                            'for a decision to be made.',
                          ),
                          actions: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('Disable'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('Enable'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                        ;
                      },
                    );
                  },
                  icon: Icon(Icons.info))
            ]),
            Text(
                'Tưới tự động thông minh - dữ liệu từ bộ cảm biến ${widget.area.spmeta?.sensorDeviceId}'),
            Row(
              children: [
                Expanded(flex: 2, child: Text('Nhiệt độ tối đa')),
                Expanded(
                  child: InputWidget(
                    isCenter: true,
                    number: true,
                    hintText: '%C',
                    controller: _temperatureMaxController,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(flex: 2, child: Text('Độ ẩm không khí tối thiểu')),
                Expanded(
                  child: InputWidget(
                    isCenter: true,
                    number: true,
                    hintText: '%',
                    controller: _humidityMinController,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(flex: 2, child: Text('Số phút tưới')),
                Expanded(
                  child: InputWidget(
                    isCenter: true,
                    number: true,
                    hintText: 'phút',
                    controller: _countMinutesController,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Text('Số lần tưới tự động tối đa trong ngày')),
                Expanded(
                  child: InputWidget(
                    isCenter: true,
                    number: true,
                    hintText: '',
                    controller: _countAutoMaxController,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                    flex: 2, child: Text('Số lần đã tưới tự động hôm nay')),
                Expanded(
                  child: InputWidget(
                    isCenter: true,
                    isDisable: true,
                    number: true,
                    hintText: '${widget.area.spmeta?.timesActivatedToday}',
                    controller: _countedAutoToDayController,
                  ),
                ),
              ],
            ),
            Center(
              child: ElevatedButton(onPressed: () {}, child: Text('Lưu')),
            )
          ],
        ),
      ),
    );
  }
}
