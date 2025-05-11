import 'package:flutter/material.dart';
import 'package:school_fees_management/widgets/custom_button.dart';
import 'package:school_fees_management/widgets/custom_text_field.dart';

class SchoolSettingsScreen extends StatefulWidget {
  const SchoolSettingsScreen({Key? key}) : super(key: key);

  @override
  State<SchoolSettingsScreen> createState() => _SchoolSettingsScreenState();
}

class _SchoolSettingsScreenState extends State<SchoolSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _websiteController = TextEditingController();
  
  final Map<String, dynamic> _schoolData = {
    'name': 'مدرسة النجاح الابتدائية',
    'address': 'شارع الرئيسي، المدينة',
    'phone': '0123456789',
    'email': 'info@school.com',
    'website': 'www.school.com',
    'logo': 'assets/images/logo.png',
    'academicYears': ['2022-2023', '2023-2024', '2024-2025'],
    'semesters': ['الفصل الأول', 'الفصل الثاني'],
    'currentAcademicYear': '2023-2024',
    'currentSemester': 'الفصل الأول',
  };

  @override
  void initState() {
    super.initState();
    _loadSchoolData();
  }

  void _loadSchoolData() {
    _nameController.text = _schoolData['name'];
    _addressController.text = _schoolData['address'];
    _phoneController.text = _schoolData['phone'];
    _emailController.text = _schoolData['email'];
    _websiteController.text = _schoolData['website'];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  void _saveSchoolSettings() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _schoolData['name'] = _nameController.text;
        _schoolData['address'] = _addressController.text;
        _schoolData['phone'] = _phoneController.text;
        _schoolData['email'] = _emailController.text;
        _schoolData['website'] = _websiteController.text;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم حفظ إعدادات المدرسة بنجاح')),
      );
    }
  }

  void _showAddAcademicYearDialog() {
    final yearController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة عام دراسي جديد'),
        content: TextField(
          controller: yearController,
          decoration: const InputDecoration(
            labelText: 'العام الدراسي',
            hintText: 'مثال: 2025-2026',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              if (yearController.text.isNotEmpty) {
                setState(() {
                  _schoolData['academicYears'].add(yearController.text);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم إضافة العام الدراسي بنجاح')),
                );
              }
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }

  void _showAddSemesterDialog() {
    final semesterController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة فصل دراسي جديد'),
        content: TextField(
          controller: semesterController,
          decoration: const InputDecoration(
            labelText: 'الفصل الدراسي',
            hintText: 'مثال: الفصل الصيفي',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              if (semesterController.text.isNotEmpty) {
                setState(() {
                  _schoolData['semesters'].add(semesterController.text);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم إضافة الفصل الدراسي بنجاح')),
                );
              }
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إعدادات المدرسة'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // School Logo
            Center(
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.school,
                      size: 60,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'تغيير الشعار',
                    icon: Icons.upload,
                    isOutlined: true,
                    width: 150,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('سيتم تنفيذ تغيير الشعار قريبًا')),
                      );
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // School Information Form
            Text(
              'معلومات المدرسة',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _nameController,
                    labelText: 'اسم المدرسة',
                    hintText: 'أدخل اسم المدرسة',
                    prefixIcon: Icons.school,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال اسم المدرسة';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _addressController,
                    labelText: 'عنوان المدرسة',
                    hintText: 'أدخل عنوان المدرسة',
                    prefixIcon: Icons.location_on,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال عنوان المدرسة';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _phoneController,
                    labelText: 'رقم الهاتف',
                    hintText: 'أدخل رقم هاتف المدرسة',
                    prefixIcon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال رقم الهاتف';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _emailController,
                    labelText: 'البريد الإلكتروني',
                    hintText: 'أدخل البريد الإلكتروني للمدرسة',
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال البريد الإلكتروني';
                      }
                      if (!value.contains('@')) {
                        return 'الرجاء إدخال بريد إلكتروني صحيح';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _websiteController,
                    labelText: 'الموقع الإلكتروني',
                    hintText: 'أدخل الموقع الإلكتروني للمدرسة',
                    prefixIcon: Icons.web,
                    keyboardType: TextInputType.url,
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'حفظ المعلومات',
                    onPressed: _saveSchoolSettings,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Academic Years
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الأعوام الدراسية',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle),
                  onPressed: _showAddAcademicYearDialog,
                  tooltip: 'إضافة عام دراسي',
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'العام الدراسي الحالي',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _schoolData['currentAcademicYear'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: _schoolData['academicYears'].map<DropdownMenuItem<String>>((year) {
                        return DropdownMenuItem<String>(
                          value: year,
                          child: Text(year),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _schoolData['currentAcademicYear'] = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'جميع الأعوام الدراسية',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _schoolData['academicYears'].map<Widget>((year) {
                        return Chip(
                          label: Text(year),
                          deleteIcon: const Icon(Icons.close, size: 18),
                          onDeleted: year == _schoolData['currentAcademicYear']
                              ? null
                              : () {
                                  setState(() {
                                    _schoolData['academicYears'].remove(year);
                                  });
                                },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Semesters
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الفصول الدراسية',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle),
                  onPressed: _showAddSemesterDialog,
                  tooltip: 'إضافة فصل دراسي',
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'الفصل الدراسي الحالي',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _schoolData['currentSemester'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: _schoolData['semesters'].map<DropdownMenuItem<String>>((semester) {
                        return DropdownMenuItem<String>(
                          value: semester,
                          child: Text(semester),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _schoolData['currentSemester'] = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'جميع الفصول الدراسية',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _schoolData['semesters'].map<Widget>((semester) {
                        return Chip(
                          label: Text(semester),
                          deleteIcon: const Icon(Icons.close, size: 18),
                          onDeleted: semester == _schoolData['currentSemester']
                              ? null
                              : () {
                                  setState(() {
                                    _schoolData['semesters'].remove(semester);
                                  });
                                },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
