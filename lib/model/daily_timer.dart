import 'package:equatable/equatable.dart';

class DailyTimer extends Equatable{
  final String time;
  final String value;

  const DailyTimer({required this.time, required this.value});

  factory DailyTimer.fromList(List<dynamic> list) {
    return DailyTimer(
      time: list[0].toString(),
      value: list[1].toString(),
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
