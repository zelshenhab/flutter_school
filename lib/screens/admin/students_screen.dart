import 'package:flutter/material.dart';
import 'package:school_fees_management/widgets/custom_button.dart';
import 'package:school_fees_management/widgets/custom_text_field.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({Key? key}) : super(key: key);

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _parentNameController = TextEditingController();
  final _parentPhoneController = TextEditingController();
  final _parentEmailController = TextEditingController();
  
  final List<Map<String, dynamic>> _students = [
    {
      'id': '1',
      'name': 'أحمد محمد',
      'parentName': 'محمد أحمد',
      'parentPhone': '0123456789',
      'parentEmail': 'mohamed@example.com',
      'className': 'الصف الأول',
      'academicYear': '2023-2024',
      'registrationDate': '2023-09-01',
      'isActive': true,
      'paymentStatus': 'مدفوع',
    },
    {
      'id': '2',
      'name': 'سارة خالد',
      'parentName': 'خالد إبراهيم',
      'parentPhone': '0123456788',
      'parentEmail': 'khaled@example.com',
      'className': 'الصف الثاني',
      'academicYear': '2023-2024',
      'registrationDate': '2023-09-02',
      'isActive': true,
      'paymentStatus': 'متأخر',
    },
    {
      'id': '3',
      'name': 'محمود علي',
      'parentName': 'علي محمود',
      'parentPhone': '0123456787',
      'parentEmail': 'ali@example.com',
      'className': 'الصف الثالث',
      'academicYear': '2023-2024',
      'registrationDate': '2023-09-03',
      'isActive': true,
      'paymentStatus': 'مدفوع',
    },
    {
      'id': '4',
      'name': 'فاطمة أحمد',
      'parentName': 'أحمد محمد',
      'parentPhone': '0123456786',
      'parentEmail': 'ahmed@example.com',
      'className': 'الصف الرابع',
      'academicYear': '2023-2024',
      'registrationDate': '2023-09-04',
      'isActive': true,
      'paymentStatus': 'مدفوع جزئي',
    },
  ];

  final List<String> _classes = [
    'الصف الأول',
    'الصف الثاني',
    'الصف الثالث',
    'الصف الرابع',
  ];

  String _selectedClass = 'الصف الأول';

  @override
  void dispose() {
    _nameController.dispose();
    _parentNameController.dispose();
    _parentPhoneController.dispose();
    _parentEmailController.dispose();
    super.dispose();
  }

  void _showAddStudentDialog() {
    _nameController.clear();
    _parentNameController.clear();
    _parentPhoneController.clear();
    _parentEmailController.clear();
    _selectedClass = _classes[0];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة طالب جديد'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: _nameController,
                  labelText: 'اسم الطالب',
                  hintText: 'أدخل اسم الطالب',
                  prefixIcon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال اسم الطالب';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _parentNameController,
                  labelText: 'اسم ولي الأمر',
                  hintText: 'أدخل اسم ولي الأمر',
                  prefixIcon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال اسم ولي الأمر';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _parentPhoneController,
                  labelText: 'رقم هاتف ولي الأمر',
                  hintText: 'أدخل رقم هاتف ولي الأمر',
                  prefixIcon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال رقم هاتف ولي الأمر';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _parentEmailController,
                  labelText: 'البريد الإلكتروني لولي الأمر',
                  hintText: 'أدخل البريد الإلكتروني لولي الأمر',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال البريد الإلكتروني لولي الأمر';
                    }
                    if (!value.contains('@')) {
                      return 'الرجاء إدخال بريد إلكتروني صحيح';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedClass,
                  decoration: InputDecoration(
                    labelText: 'الفصل',
                    prefixIcon: const Icon(Icons.class_),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  items: _classes.map((className) {
                    return DropdownMenuItem<String>(
                      value: className,
                      child: Text(className),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedClass = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء اختيار الفصل';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  _students.add({
                    'id': DateTime.now().millisecondsSinceEpoch.toString(),
                    'name': _nameController.text,
                    'parentName': _parentNameController.text,
                    'parentPhone': _parentPhoneController.text,
                    'parentEmail': _parentEmailController.text,
                    'className': _selectedClass,
                    'academicYear': '2023-2024',
                    'registrationDate': DateTime.now().toString().substring(0, 10),
                    'isActive': true,
                    'paymentStatus': 'غير مدفوع',
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم إضافة الطالب بنجاح')),
                );
              }
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }

  void _showEditStudentDialog(Map<String, dynamic> student) {
    _nameController.text = student['name'];
    _parentNameController.text = student['parentName'];
    _parentPhoneController.text = student['parentPhone'];
    _parentEmailController.text = student['parentEmail'];
    _selectedClass = student['className'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تعديل بيانات الطالب'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: _nameController,
                  labelText: 'اسم الطالب',
                  hintText: 'أدخل اسم الطالب',
                  prefixIcon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال اسم الطالب';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _parentNameController,
                  labelText: 'اسم ولي الأمر',
                  hintText: 'أدخل اسم ولي الأمر',
                  prefixIcon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال اسم ولي الأمر';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _parentPhoneController,
                  labelText: 'رقم هاتف ولي الأمر',
                  hintText: 'أدخل رقم هاتف ولي الأمر',
                  prefixIcon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال رقم هاتف ولي الأمر';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _parentEmailController,
                  labelText: 'البريد الإلكتروني لولي الأمر',
                  hintText: 'أدخل البريد الإلكتروني لولي الأمر',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال البريد الإلكتروني لولي الأمر';
                    }
                    if (!value.contains('@')) {
                      return 'الرجاء إدخال بريد إلكتروني صحيح';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedClass,
                  decoration: InputDecoration(
                    labelText: 'الفصل',
                    prefixIcon: const Icon(Icons.class_),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  items: _classes.map((className) {
                    return DropdownMenuItem<String>(
                      value: className,
                      child: Text(className),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedClass = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء اختيار الفصل';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  final index = _students.indexWhere((s) => s['id'] == student['id']);
                  if (index != -1) {
                    _students[index] = {
                      'id': student['id'],
                      'name': _nameController.text,
                      'parentName': _parentNameController.text,
                      'parentPhone': _parentPhoneController.text,
                      'parentEmail': _parentEmailController.text,
                      'className': _selectedClass,
                      'academicYear': student['academicYear'],
                      'registrationDate': student['registrationDate'],
                      'isActive': student['isActive'],
                      'paymentStatus': student['paymentStatus'],
                    };
                  }
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم تعديل بيانات الطالب بنجاح')),
                );
              }
            },
            child: const Text('تعديل'),
          ),
        ],
      ),
    );
  }

  void _deleteStudent(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف الطالب'),
        content: const Text('هل أنت متأكد من حذف هذا الطالب؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _students.removeWhere((s) => s['id'] == id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم حذف الطالب بنجاح')),
              );
            },
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الطلاب'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'بحث عن طالب...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                CustomButton(
                  text: 'إضافة طالب',
                  icon: Icons.add,
                  width: 150,
                  onPressed: _showAddStudentDialog,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _students.length,
              itemBuilder: (context, index) {
                final student = _students[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                              child: Icon(
                                Icons.person,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    student['name'],
                                    style: Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Text(
                                    student['className'],
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: _getStatusColor(student['paymentStatus']).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                student['paymentStatus'],
                                style: TextStyle(
                                  color: _getStatusColor(student['paymentStatus']),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            PopupMenuButton(
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'edit',
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit),
                                      SizedBox(width: 8),
                                      Text('تعديل'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: 'payment',
                                  child: Row(
                                    children: [
                                      Icon(Icons.payment),
                                      SizedBox(width: 8),
                                      Text('تسجيل دفعة'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete, color: Colors.red),
                                      SizedBox(width: 8),
                                      Text('حذف', style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                              ],
                              onSelected: (value) {
                                if (value == 'edit') {
                                  _showEditStudentDialog(student);
                                } else if (value == 'payment') {
                                  // TODO: Implement payment registration
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('سيتم تنفيذ هذه الميزة قريبًا')),
                                  );
                                } else if (value == 'delete') {
                                  _deleteStudent(student['id']);
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Divider(),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('ولي الأمر'),
                                  const SizedBox(height: 4),
                                  Text(
                                    student['parentName'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('رقم الهاتف'),
                                  const SizedBox(height: 4),
                                  Text(
                                    student['parentPhone'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('البريد الإلكتروني'),
                                  const SizedBox(height: 4),
                                  Text(
                                    student['parentEmail'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('تاريخ التسجيل'),
                                  const SizedBox(height: 4),
                                  Text(
                                    student['registrationDate'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'مدفوع':
        return Colors.green;
      case 'مدفوع جزئي':
        return Colors.orange;
      case 'متأخر':
        return Colors.red;
      case 'غير مدفوع':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}
