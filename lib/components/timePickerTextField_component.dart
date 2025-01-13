import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_farm_application/utilities/string-utils.dart';

class TimePickerTextField  extends StatefulWidget {
  const TimePickerTextField({
    super.key,
    this.hintName = '',
    this.compulsory = false,
    required this.onChangeText,
    required this.controller,
    this.getDateTimer = false,
    this.isInitDateTime = false,
    this.subtractDay
  });

  final String? hintName;
  final bool? compulsory;
  final TextEditingController controller;
  final Function(String) onChangeText;
  final bool getDateTimer;
  final bool isInitDateTime;
  final Duration? subtractDay;
  @override
  State<TimePickerTextField> createState() =>
      _DateTimePickerTextFieldState();
}

class _DateTimePickerTextFieldState extends State<TimePickerTextField> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _updateController();
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        widget.getDateTimer ? _updateController() : _updateControllerTimer(picked);
      });
    }
  }

  _updateControllerTimer(TimeOfDay? picked){
    String time = picked!.format(context);
    widget.controller.text = time;
    widget.onChangeText(StringUtils.timeToMillisecondsSinceEpoch(picked).toString());
  }

  void _updateController() {
    // Nếu _selectedDate hoặc _selectedTime chưa được chọn, lấy giá trị hiện tại
    final DateTime now = DateTime.now();
    final date = _selectedDate ?? DateTime(now.year, now.month, now.day);
    final time = _selectedTime ?? TimeOfDay(hour: now.hour, minute: now.minute);

    final formattedDateTime =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} '
        '${time.format(context)}';
    widget.controller.text = formattedDateTime;
    widget.onChangeText(StringUtils.dateAndTimeToMillisecondsSinceEpoch(time, date).toString());
  }

  @override
  void initState() {
    super.initState();
    // Move the initialization to post-frame callback
    if (widget.isInitDateTime) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _initializeDateTime();
      });
    }
  }

  void _initializeDateTime() {
    final DateTime now = DateTime.now();
    final date = widget.subtractDay != null ? DateTime(now.year, now.month, now.day).subtract(widget.subtractDay!) : DateTime(now.year, now.month, now.day);
    final time = TimeOfDay(hour: now.hour, minute: now.minute);

    final formattedDateTime =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} '
        '${time.format(context)}';
    widget.controller.text = formattedDateTime;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(20.spMin),
        border: Border.all(color: Colors.black26),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TextField(
              enabled: false,
              controller: widget.controller,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black26),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: widget.hintName!,
                hintStyle: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(fontSize: 15.sp),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.access_time, color: Colors.grey),
            onPressed: () => widget.getDateTimer ? _selectDate(context).whenComplete(() => _selectTime(context),) : _selectTime(context),
          ),
        ],
      ),
    );
  }
}
