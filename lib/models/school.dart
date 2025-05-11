class School {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String email;
  final String website;
  final String logo;
  final List<String> academicYears;
  final List<String> semesters;
  final String currentAcademicYear;
  final String currentSemester;

  School({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.website,
    required this.logo,
    required this.academicYears,
    required this.semesters,
    required this.currentAcademicYear,
    required this.currentSemester,
  });

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      website: json['website'],
      logo: json['logo'],
      academicYears: List<String>.from(json['academicYears']),
      semesters: List<String>.from(json['semesters']),
      currentAcademicYear: json['currentAcademicYear'],
      currentSemester: json['currentSemester'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'website': website,
      'logo': logo,
      'academicYears': academicYears,
      'semesters': semesters,
      'currentAcademicYear': currentAcademicYear,
      'currentSemester': currentSemester,
    };
  }
}
