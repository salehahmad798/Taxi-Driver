class BreakSession {
  final String id;
  final DateTime startTime;
  final DateTime? endTime;
  final int duration; // in minutes
  final bool isActive;

  BreakSession({
    required this.id,
    required this.startTime,
    this.endTime,
    required this.duration,
    required this.isActive,
  });

  BreakSession copyWith({
    String? id,
    DateTime? startTime,
    DateTime? endTime,
    int? duration,
    bool? isActive,
  }) {
    return BreakSession(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      duration: duration ?? this.duration,
      isActive: isActive ?? this.isActive,
    );
  }
}

