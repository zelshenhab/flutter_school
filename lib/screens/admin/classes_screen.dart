import 'package:flutter/material.dart';
import 'package:school_fees_management/widgets/custom_button.dart';
import 'package:school_fees_management/widgets/custom_text_field.dart';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({Key? key}) : super(key: key);

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _academicYearController = TextEditingController();
  final _semesterController = TextEditingController();
  final _feesController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  final List<Map<String, dynamic>> _classes = [
    {
      'id': '1',
      'name': 'الصف الأول',
      'academicYear': '2023-2024',
      'semester': 'الفصل الأول',
      'fees': 1500.0,
      'description': 'الصف الأول الابتدائي',
      'studentCount': 25,
    },
    {
      'id': '2',
      'name': 'الصف الثاني',
      'academicYear': '2023-2024',
      'semester': 'الفصل الأول',
      'fees': 1600.0,
      'description': 'الصف الثاني الابتدائي',
      'studentCount': 22,
    },
    {
      'id': '3',
      'name': 'الصف الثالث',
      'academicYear': '2023-2024',
      'semester': 'الفصل الأول',
      'fees': 1700.0,
      'description': 'الصف الثالث الابتدائي',
      'studentCount': 20,
    },
    {
      'id': '4',
      'name': 'الصف الرابع',
      'academicYear': '2023-2024',
      'semester': 'الفصل الأول',
      'fees': 1800.0,
      'description': 'الصف الرابع الابتدائي',
      'studentCount': 18,
    },
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _academicYearController.dispose();
    _semesterController.dispose();
    _feesController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _showAddClassDialog() {
    _nameController.clear();
    _academicYearController.text = '2023-2024';
    _semesterController.text = 'الفصل الأول';
    _feesController.clear();
    _descriptionController.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة فصل جديد'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: _nameController,
                  labelText: 'اسم الفصل',
                  hintText: 'أدخل اسم الفصل',
                  prefixIcon: Icons.class_,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال اسم الفصل';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _academicYearController,
                  labelText: 'العام الدراسي',
                  hintText: 'أدخل العام الدراسي',
                  prefixIcon: Icons.calendar_today,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال العام الدراسي';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _semesterController,
                  labelText: 'الفصل الدراسي',
                  hintText: 'أدخل الفصل الدراسي',
                  prefixIcon: Icons.schedule,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال الفصل الدراسي';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _feesController,
                  labelText: 'الرسوم',
                  hintText: 'أدخل الرسوم',
                  prefixIcon: Icons.attach_money,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال الرسوم';
                    }
                    if (double.tryParse(value) == null) {
                      return 'الرجاء إدخال رقم صحيح';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _descriptionController,
                  labelText: 'الوصف',
                  hintText: 'أدخل وصف الفصل',
                  prefixIcon: Icons.description,
                  maxLines: 3,
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
                  _classes.add({
                    'id': DateTime.now().millisecondsSinceEpoch.toString(),
                    'name': _nameController.text,
                    'academicYear': _academicYearController.text,
                    'semester': _semesterController.text,
                    'fees': double.parse(_feesController.text),
                    'description': _descriptionController.text,
                    'studentCount': 0,
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم إضافة الفصل بنجاح')),
                );
              }
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }

  void _showEditClassDialog(Map<String, dynamic> classData) {
    _nameController.text = classData['name'];
    _academicYearController.text = classData['academicYear'];
    _semesterController.text = classData['semester'];
    _feesController.text = classData['fees'].toString();
    _descriptionController.text = classData['description'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تعديل الفصل'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: _nameController,
                  labelText: 'اسم الفصل',
                  hintText: 'أدخل اسم الفصل',
                  prefixIcon: Icons.class_,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال اسم الفصل';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _academicYearController,
                  labelText: 'العام الدراسي',
                  hintText: 'أدخل العام الدراسي',
                  prefixIcon: Icons.calendar_today,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال العام الدراسي';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _semesterController,
                  labelText: 'الفصل الدراسي',
                  hintText: 'أدخل الفصل الدراسي',
                  prefixIcon: Icons.schedule,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال الفصل الدراسي';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _feesController,
                  labelText: 'الرسوم',
                  hintText: 'أدخل الرسوم',
                  prefixIcon: Icons.attach_money,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال الرسوم';
                    }
                    if (double.tryParse(value) == null) {
                      return 'الرجاء إدخال رقم صحيح';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _descriptionController,
                  labelText: 'الوصف',
                  hintText: 'أدخل وصف الفصل',
                  prefixIcon: Icons.description,
                  maxLines: 3,
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
                  final index = _classes.indexWhere((c) => c['id'] == classData['id']);
                  if (index != -1) {
                    _classes[index] = {
                      'id': classData['id'],
                      'name': _nameController.text,
                      'academicYear': _academicYearController.text,
                      'semester': _semesterController.text,
                      'fees': double.parse(_feesController.text),
                      'description': _descriptionController.text,
                      'studentCount': classData['studentCount'],
                    };
                  }
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم تعديل الفصل بنجاح')),
                );
              }
            },
            child: const Text('تعديل'),
          ),
        ],
      ),
    );
  }

  void _deleteClass(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف الفصل'),
        content: const Text('هل أنت متأكد من حذف هذا الفصل؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _classes.removeWhere((c) => c['id'] == id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم حذف الفصل بنجاح')),
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
        title: const Text('إدارة الفصول'),
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
                      hintText: 'بحث عن فصل...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                CustomButton(
                  text: 'إضافة فصل',
                  icon: Icons.add,
                  width: 150,
                  onPressed: _showAddClassDialog,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _classes.length,
              itemBuilder: (context, index) {
                final classData = _classes[index];
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
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.class_,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    classData['name'],
                                    style: Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Text(
                                    '${classData['academicYear']} - ${classData['semester']}',
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
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
                                  _showEditClassDialog(classData);
                                } else if (value == 'delete') {
                                  _deleteClass(classData['id']);
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
                                  const Text('الرسوم'),
                                  const SizedBox(height: 4),
                                  Text(
                                    '₪ ${classData['fees']}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('عدد الطلاب'),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${classData['studentCount']}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (classData['description'] != null && classData['description'].isNotEmpty) ...[
                          const SizedBox(height: 16),
                          Text(
                            'الوصف:',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(classData['description']),
                        ],
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
}
