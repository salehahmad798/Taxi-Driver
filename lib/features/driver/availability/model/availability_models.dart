import 'package:flutter/material.dart';

class DailySchedule {
  final String day;
  final bool isActive;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  DailySchedule({
    required this.day,
    required this.isActive,
    required this.startTime,
    required this.endTime,
  });

  DailySchedule copyWith({
    String? day,
    bool? isActive,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
  }) {
    return DailySchedule(
      day: day ?? this.day,
      isActive: isActive ?? this.isActive,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'isActive': isActive,
      'startTime': '${startTime.hour}:${startTime.minute}',
      'endTime': '${endTime.hour}:${endTime.minute}',
    };
  }

  factory DailySchedule.fromJson(Map<String, dynamic> json) {
    final startTimeParts = json['startTime'].split(':');
    final endTimeParts = json['endTime'].split(':');
    
    return DailySchedule(
      day: json['day'],
      isActive: json['isActive'],
      startTime: TimeOfDay(hour: int.parse(startTimeParts[0]), minute: int.parse(startTimeParts[1])),
      endTime: TimeOfDay(hour: int.parse(endTimeParts[0]), minute: int.parse(endTimeParts[1])),
    );
  }
}
