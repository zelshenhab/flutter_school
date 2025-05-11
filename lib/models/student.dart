class Student {
  final String id;
  final String name;
  final String parentId;
  final String classId;
  final String className;
  final String academicYear;
  final String registrationDate;
  final bool isActive;
  final String? profileImage;

  Student({
    required this.id,
    required this.name,
    required this.parentId,
    required this.classId,
    required this.className,
    required this.academicYear,
    required this.registrationDate,
    required this.isActive,
    this.profileImage,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
      classId: json['classId'],
      className: json['className'],
      academicYear: json['academicYear'],
      registrationDate: json['registrationDate'],
      isActive: json['isActive'],
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parentId': parentId,
      'classId': classId,
      'className': className,
      'academicYear': academicYear,
      'registrationDate': registrationDate,
      'isActive': isActive,
      'profileImage': profileImage,
    };
  }
}
