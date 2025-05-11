import 'package:flutter/material.dart';
import 'package:school_fees_management/widgets/custom_button.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({Key? key}) : super(key: key);

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  final List<Map<String, dynamic>> _payments = [
    {
      'id': '1',
      'studentName': 'أحمد محمد',
      'className': 'الصف الأول',
      'parentName': 'محمد أحمد',
      'amount': 1500.0,
      'paymentDate': '2023-09-15',
      'academicYear': '2023-2024',
      'semester': 'الفصل الأول',
      'paymentMethod': 'نقدي',
      'receiptNumber': 'REC-001',
      'status': 'مدفوع',
    },
    {
      'id': '2',
      'studentName': 'سارة خالد',
      'className': 'الصف الثاني',
      'parentName': 'خالد إبراهيم',
      'amount': 800.0,
      'paymentDate': '2023-09-20',
      'academicYear': '2023-2024',
      'semester': 'الفصل الأول',
      'paymentMethod': 'تحويل بنكي',
      'receiptNumber': 'REC-002',
      'status': 'مدفوع جزئي',
    },
    {
      'id': '3',
      'studentName': 'محمود علي',
      'className': 'الصف الثالث',
      'parentName': 'علي محمود',
      'amount': 1700.0,
      'paymentDate': '2023-09-25',
      'academicYear': '2023-2024',
      'semester': 'الفصل الأول',
      'paymentMethod': 'نقدي',
      'receiptNumber': 'REC-003',
      'status': 'مدفوع',
    },
    {
      'id': '4',
      'studentName': 'فاطمة أحمد',
      'className': 'الصف الرابع',
      'parentName': 'أحمد محمد',
      'amount': 900.0,
      'paymentDate': '2023-09-30',
      'academicYear': '2023-2024',
      'semester': 'الفصل الأول',
      'paymentMethod': 'تحويل بنكي',
      'receiptNumber': 'REC-004',
      'status': 'مدفوع جزئي',
    },
  ];

  final List<Map<String, dynamic>> _pendingPayments = [
    {
      'id': '1',
      'studentName': 'سارة خالد',
      'className': 'الصف الثاني',
      'parentName': 'خالد إبراهيم',
      'amount': 800.0,
      'dueDate': '2023-10-15',
      'academicYear': '2023-2024',
      'semester': 'الفصل الأول',
      'status': 'متأخر',
    },
    {
      'id': '2',
      'studentName': 'فاطمة أحمد',
      'className': 'الصف الرابع',
      'parentName': 'أحمد محمد',
      'amount': 900.0,
      'dueDate': '2023-10-20',
      'academicYear': '2023-2024',
      'semester': 'الفصل الأول',
      'status': 'مستحق',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showPaymentDetailsDialog(Map<String, dynamic> payment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تفاصيل الدفعة'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('الطالب', payment['studentName']),
              _buildDetailRow('الفصل', payment['className']),
              _buildDetailRow('ولي الأمر', payment['parentName']),
              _buildDetailRow('المبلغ', '₪ ${payment['amount']}'),
              _buildDetailRow('تاريخ الدفع', payment['paymentDate']),
              _buildDetailRow('العام الدراسي', payment['academicYear']),
              _buildDetailRow('الفصل الدراسي', payment['semester']),
              _buildDetailRow('طريقة الدفع', payment['paymentMethod']),
              _buildDetailRow('رقم الإيصال', payment['receiptNumber']),
              _buildDetailRow('الحالة', payment['status']),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إغلاق'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement print receipt functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('سيتم تنفيذ طباعة الإيصال قريبًا')),
              );
            },
            child: const Text('طباعة الإيصال'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  void _showRegisterPaymentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تسجيل دفعة جديدة'),
        content: const SingleChildScrollView(
          child: Text('سيتم تنفيذ هذه الميزة قريبًا'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة المدفوعات'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'المدفوعات المستلمة'),
            Tab(text: 'المدفوعات المستحقة'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Received Payments Tab
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'بحث عن مدفوعات...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    CustomButton(
                      text: 'تسجيل دفعة',
                      icon: Icons.add,
                      width: 150,
                      onPressed: _showRegisterPaymentDialog,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _payments.length,
                  itemBuilder: (context, index) {
                    final payment = _payments[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () => _showPaymentDetailsDialog(payment),
                        borderRadius: BorderRadius.circular(12),
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
                                      Icons.receipt,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          payment['studentName'],
                                          style: Theme.of(context).textTheme.titleMedium,
                                        ),
                                        Text(
                                          payment['className'],
                                          style: Theme.of(context).textTheme.bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '₪ ${payment['amount']}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.green,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(payment['status']).withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          payment['status'],
                                          style: TextStyle(
                                            color: _getStatusColor(payment['status']),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const Divider(),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('رقم الإيصال: ${payment['receiptNumber']}'),
                                  Text('تاريخ الدفع: ${payment['paymentDate']}'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          
          // Pending Payments Tab
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'بحث عن مدفوعات مستحقة...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    CustomButton(
                      text: 'إرسال تذكير',
                      icon: Icons.notification_important,
                      width: 150,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('سيتم تنفيذ إرسال التذكيرات قريبًا')),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _pendingPayments.length,
                  itemBuilder: (context, index) {
                    final payment = _pendingPayments[index];
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
                                    color: _getStatusColor(payment['status']).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    payment['status'] == 'متأخر' ? Icons.warning : Icons.schedule,
                                    color: _getStatusColor(payment['status']),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        payment['studentName'],
                                        style: Theme.of(context).textTheme.titleMedium,
                                      ),
                                      Text(
                                        payment['className'],
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '₪ ${payment['amount']}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(payment['status']).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        payment['status'],
                                        style: TextStyle(
                                          color: _getStatusColor(payment['status']),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Divider(),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('ولي الأمر: ${payment['parentName']}'),
                                Text('تاريخ الاستحقاق: ${payment['dueDate']}'),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomButton(
                                    text: 'تسجيل دفعة',
                                    icon: Icons.payment,
                                    isOutlined: true,
                                    onPressed: _showRegisterPaymentDialog,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: CustomButton(
                                    text: 'إرسال تذكير',
                                    icon: Icons.notification_important,
                                    isOutlined: true,
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('سيتم تنفيذ إرسال التذكير قريبًا')),
                                      );
                                    },
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
      case 'مستحق':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
