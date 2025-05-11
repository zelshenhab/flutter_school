class Class {
  final String id;
  final String name;
  final String academicYear;
  final String semester;
  final double fees;
  final String description;
  final int studentCount;

  Class({
    required this.id,
    required this.name,
    required this.academicYear,
    required this.semester,
    required this.fees,
    required this.description,
    this.studentCount = 0,
  });

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      id: json['id'],
      name: json['name'],
      academicYear: json['academicYear'],
      semester: json['semester'],
      fees: json['fees'].toDouble(),
      description: json['description'],
      studentCount: json['studentCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'academicYear': academicYear,
      'semester': semester,
      'fees': fees,
      'description': description,
      'studentCount': studentCount,
    };
  }
}
