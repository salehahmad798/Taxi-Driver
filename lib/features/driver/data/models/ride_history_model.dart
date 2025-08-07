class RideHistory {
  final String id;
  final DateTime time;
  final String destination;
  final double distance;
  final double earnings;
  final int duration; // in minutes

  RideHistory({
    required this.id,
    required this.time,
    required this.destination,
    required this.distance,
    required this.earnings,
    required this.duration,
  });
}

