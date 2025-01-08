import 'package:equatable/equatable.dart';

class DailyTimer extends Equatable{
  final String time;
  final int value;

  const DailyTimer({required this.time, required this.value});

  factory DailyTimer.fromList(List<dynamic> list) {
    return DailyTimer(
      time: list[0] as String,
      value: list[1] as int,
    );
  }

  @override
  String toString() {
    return 'DataItem(time: $time, value: $value)';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [time, value];
}
