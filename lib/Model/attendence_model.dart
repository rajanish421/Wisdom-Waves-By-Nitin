class Attendance {
  final String attendanceId;
  final String batchId;
  final String batchName;
  final List<StudentAttendance> students;

  Attendance({
    required this.attendanceId,
    required this.batchId,
    required this.batchName,
    required this.students,
  });

  // Convert Dart object → Map (for Firebase/JSON)
  Map<String, dynamic> toMap() {
    return {
      'attendanceId': attendanceId,
      'batchId': batchId,
      'batchName': batchName,
      'students': students.map((s) => s.toMap()).toList(),
    };
  }

  // Convert Map (from Firebase/JSON) → Dart object
  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      attendanceId: map['attendanceId'] ?? '',
      batchId: map['batchId'] ?? '',
      batchName: map['batchName'] ?? '',
      students: map['students'] != null
          ? List<StudentAttendance>.from(
          map['students'].map((s) => StudentAttendance.fromMap(s)))
          : [],
    );
  }
}

// Student Attendance Model
class StudentAttendance {
  final String userId;
  final String name;
   bool status; // "Present" / "Absent"
  final DateTime createdAt;

  StudentAttendance({
    required this.userId,
    required this.name,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory StudentAttendance.fromMap(Map<String, dynamic> map) {
    return StudentAttendance(
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      status: map['status'] ?? false,
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}
