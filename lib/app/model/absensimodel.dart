class Attendance {
  final int id;
  final String checkIn;
  final String? checkOut;
  final String? totalTime;

  Attendance({
    required this.id,
    required this.checkIn,
    this.checkOut,
    this.totalTime,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'],
      checkIn: json['check_in'],
      checkOut: json['check_out'],
      totalTime: json['total_time'],
    );
  }
}
