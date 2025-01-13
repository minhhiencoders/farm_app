import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_farm_application/model/daily_timer.dart';
import 'package:smart_farm_application/view_models/control_view_model.dart';
import '../../../components/input_widget.dart';
import '../../../components/timePickerTextField_component.dart';
import '../../../configs/contants.dart';
import '../../../model/area.dart';
import '../../../model/information.dart';
import '../../../utilities/dialog_utils.dart';
import '../../../utilities/hive_utils.dart';
import '../../../utilities/scaffold_messenger_utils.dart';

class ItemControlScreenScreen extends ConsumerStatefulWidget {
  const ItemControlScreenScreen(
      {super.key, required this.area, this.isShowIrrigation = true});
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

  String token = '';
  int clientId = 1;
  String _beforeTime = '';
  String _dateTime = '';
  List<DailyTimer> listDailyTimer = [];
  @override
  void initState() {
    super.initState();
    _getInit();
    listDailyTimer = widget.area.listDailyTimer;
  }

  _getInit() async {
    await HiveUtils.getValue<Information?>(
            Contant.INFORMATION_LIST, Contant.INFORMATION)
        .then(
      (value) {
        if (value != null) {
          token = value.authToken ?? '';
          clientId = value.clients.first.id ?? 1;
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _handmadeController.dispose();
    _timerController.dispose();
    _timerAndDayController.dispose();
    _minutesController.dispose();
    _minutesOfDayController.dispose();
    _temperatureMaxController.dispose();
    _humidityMinController.dispose();
    _countMinutesController.dispose();
    _countAutoMaxController.dispose();
    _countedAutoToDayController.dispose();
    _fertilizerController.dispose();
    _manureController.dispose();
    _pesticideController.dispose();
    _kaliController.dispose();
    _a1Controller.dispose();
    _a2Controller.dispose();
    _a3Controller.dispose();
    _b1Controller.dispose();
    _b2Controller.dispose();
    _b3Controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.02.sw, vertical: 0.02.sh),
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
            Text('Tưới thủ công'),
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
                        ElevatedButton(
                            onPressed: () {
                              DialogUtils.showLoadingDialog(context,
                                  message: 'Loading...');
                              if (widget.isShowIrrigation) {
                                ref
                                    .read(controlProvider.notifier)
                                    .startSectorHasFertilizer(
                                        token,
                                        clientId,
                                        (int.parse(_handmadeController.text) *
                                                60)
                                            .toString(),
                                        _kaliController.text,
                                        _manureController.text,
                                        _pesticideController.text,
                                        _fertilizerController.text,
                                        _a1Controller.text,
                                        _b1Controller.text,
                                        _a2Controller.text,
                                        _b2Controller.text,
                                        _a3Controller.text,
                                        _b3Controller.text)
                                    .then(
                                  (value) {
                                    ScaffoldMessageUtil.showSuccess(context,
                                        message: value);
                                  },
                                ).onError(
                                  (error, stackTrace) {
                                    ScaffoldMessageUtil.showError(context,
                                        message: error.toString());
                                  },
                                ).whenComplete(
                                  () => DialogUtils.hideLoadingDialog(context),
                                );
                              } else {
                                ref
                                    .read(controlProvider.notifier)
                                    .startSector(
                                        token,
                                        clientId,
                                        (int.parse(_handmadeController.text) *
                                                60)
                                            .toString())
                                    .then(
                                  (value) {
                                    ScaffoldMessageUtil.showSuccess(context,
                                        message: value);
                                  },
                                ).onError(
                                  (error, stackTrace) {
                                    ScaffoldMessageUtil.showError(context,
                                        message: error.toString());
                                  },
                                ).whenComplete(
                                  () => DialogUtils.hideLoadingDialog(context),
                                );
                              }
                            },
                            child: Text('Bật')),
                        ElevatedButton(
                            onPressed: () {
                              DialogUtils.showLoadingDialog(context,
                                  message: 'Loading...');
                              ref
                                  .read(controlProvider.notifier)
                                  .stopSector(token, clientId)
                                  .then(
                                (value) {
                                  ScaffoldMessageUtil.showSuccess(context,
                                      message: value);
                                },
                              ).onError(
                                (error, stackTrace) {
                                  ScaffoldMessageUtil.showError(context,
                                      message: error.toString());
                                },
                              ).whenComplete(
                                () => DialogUtils.hideLoadingDialog(context),
                              );
                            },
                            child: Text('Tắt')),
                      ],
                    ))
              ],
            ),
            if (widget.isShowIrrigation)
              Column(
                spacing: 10.dm,
                children: [
                  Row(
                    spacing: 10.dm,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text('Phân (kg)'),
                      ),
                      Expanded(
                          child: InputWidget(
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
                      Expanded(
                          child: InputWidget(
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
                      Expanded(
                          child: InputWidget(
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
                      Expanded(
                          child: InputWidget(
                        isCenter: true,
                        hintText: '%',
                        controller: _kaliController,
                      ))
                    ],
                  ),
                  Row(
                    spacing: 10.dm,
                    children: [
                      Expanded(
                          child: InputWidget(
                        isCenter: true,
                        hintText: 'Tên chất',
                        controller: _a1Controller,
                      )),
                      Expanded(
                          child: InputWidget(
                        isCenter: true,
                        hintText: 'Khối lượng (kg)',
                        controller: _b1Controller,
                      ))
                    ],
                  ),
                  Row(
                    spacing: 10.dm,
                    children: [
                      Expanded(
                          child: InputWidget(
                        isCenter: true,
                        hintText: 'Tên chất',
                        controller: _a2Controller,
                      )),
                      Expanded(
                          child: InputWidget(
                        isCenter: true,
                        hintText: 'Khối lượng (kg)',
                        controller: _b2Controller,
                      ))
                    ],
                  ),
                  Row(
                    spacing: 10.dm,
                    children: [
                      Expanded(
                          child: InputWidget(
                        isCenter: true,
                        hintText: 'Tên chất',
                        controller: _a3Controller,
                      )),
                      Expanded(
                          child: InputWidget(
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
                        _beforeTime = value;
                      },
                      controller: _timerController,
                    ))
              ],
            ),
            Row(children: [
              Spacer(),
              ElevatedButton(
                  onPressed: () {
                    DialogUtils.showLoadingDialog(context,
                        message: 'Loading...');
                    ref
                        .read(controlProvider.notifier)
                        .setDailyTimer(
                            token,
                            widget.area.sectorId ?? 1,
                            clientId,
                            _beforeTime,
                            (int.parse(_minutesOfDayController.text) * 60)
                                .toString())
                        .then(
                      (value) {
                        listDailyTimer = value;
                        ScaffoldMessageUtil.showSuccess(context,
                            message: 'Thành công');
                      },
                    ).onError(
                      (error, stackTrace) {
                        ScaffoldMessageUtil.showError(context,
                            message: error.toString());
                      },
                    ).whenComplete(
                      () => DialogUtils.hideLoadingDialog(context),
                    );
                  },
                  child: Text('Xác nhận')),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: const Text('Hẹn giờ hằng ngày'),
                          content: SizedBox(
                            width: double.maxFinite,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: listDailyTimer.length,
                              itemBuilder: (context, index) {
                                final timer = listDailyTimer[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: index < listDailyTimer.length - 1
                                          ? 8
                                          : 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[50],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 16),
                                    child: Row(
                                      children: [
                                        RichText(text: TextSpan(text: 'Thời gian: ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black26), children: [TextSpan(text: timer.time)])),
                                        Spacer(),
                                        RichText(text: TextSpan(text: 'Thời lượng (phút): ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black26), children: [TextSpan(text: timer.value)])),
                                      ],
                                    ), // Assuming DailyTimer has a name property
                                  ),
                                );
                              },
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFF1F2937),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                              ),
                              child: const Text('Ok'),
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
                        _dateTime = value;
                      },
                      controller: _timerAndDayController,
                    ))
              ],
            ),
            Row(children: [
              Spacer(),
              ElevatedButton(
                  onPressed: () {
                    DialogUtils.showLoadingDialog(context,
                        message: 'Loading...');
                    ref
                        .read(controlProvider.notifier)
                        .setTimer(
                            token,
                            widget.area.sectorId ?? 1,
                            _dateTime,
                            (int.parse(_minutesOfDayController.text) * 60)
                                .toString())
                        .then(
                      (value) {
                        ScaffoldMessageUtil.showSuccess(context,
                            message: 'Thành công');
                      },
                    ).onError(
                      (error, stackTrace) {
                        ScaffoldMessageUtil.showError(context,
                            message: error.toString());
                      },
                    ).whenComplete(
                      () => DialogUtils.hideLoadingDialog(context),
                    );
                  },
                  child: Text('Xác nhận')),
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
              child: ElevatedButton(
                  onPressed: () {
                    DialogUtils.showLoadingDialog(context,
                        message: 'Loading...');
                    ref
                        .read(controlProvider.notifier)
                        .setAutoIrrigation(
                            token,
                            widget.area.sectorId ?? 1,
                            _countMinutesController.text,
                            _countAutoMaxController.text,
                            _temperatureMaxController.text,
                            _humidityMinController.text)
                        .then(
                      (value) {
                        ScaffoldMessageUtil.showSuccess(context,
                            message: 'Thành công');
                      },
                    ).onError(
                      (error, stackTrace) {
                        ScaffoldMessageUtil.showError(context,
                            message: error.toString());
                      },
                    ).whenComplete(
                      () => DialogUtils.hideLoadingDialog(context),
                    );
                  },
                  child: Text('Lưu')),
            )
          ],
        ),
      ),
    );
  }
}
