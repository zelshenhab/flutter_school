class Payment {
  final String id;
  final String studentId;
  final String studentName;
  final String classId;
  final String className;
  final String parentId;
  final String parentName;
  final double amount;
  final String paymentDate;
  final String academicYear;
  final String semester;
  final String paymentMethod;
  final String receiptNumber;
  final String status; // 'paid', 'pending', 'overdue'
  final String? notes;

  Payment({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.classId,
    required this.className,
    required this.parentId,
    required this.parentName,
    required this.amount,
    required this.paymentDate,
    required this.academicYear,
    required this.semester,
    required this.paymentMethod,
    required this.receiptNumber,
    required this.status,
    this.notes,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      studentId: json['studentId'],
      studentName: json['studentName'],
      classId: json['classId'],
      className: json['className'],
      parentId: json['parentId'],
      parentName: json['parentName'],
      amount: json['amount'].toDouble(),
      paymentDate: json['paymentDate'],
      academicYear: json['academicYear'],
      semester: json['semester'],
      paymentMethod: json['paymentMethod'],
      receiptNumber: json['receiptNumber'],
      status: json['status'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'studentName': studentName,
      'classId': classId,
      'className': className,
      'parentId': parentId,
      'parentName': parentName,
      'amount': amount,
      'paymentDate': paymentDate,
      'academicYear': academicYear,
      'semester': semester,
      'paymentMethod': paymentMethod,
      'receiptNumber': receiptNumber,
      'status': status,
      'notes': notes,
    };
  }
}
