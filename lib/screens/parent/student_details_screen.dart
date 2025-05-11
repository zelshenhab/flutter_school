import 'package:flutter/material.dart';

class StudentDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> student;

  const StudentDetailsScreen({
    Key? key,
    required this.student,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock payment history data
    final List<Map<String, dynamic>> _paymentHistory = [
      {
        'id': '1',
        'amount': student['paymentStatus'] == 'مدفوع' ? student['totalFees'] : student['paidFees'],
        'paymentDate': '2023-09-15',
        'paymentMethod': 'نقدي',
        'receiptNumber': 'REC-001',
        'status': 'مدفوع',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(student['name']),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Student Info Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                          child: Icon(
                            Icons.person,
                            size: 30,
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
                              const SizedBox(height: 4),
                              Text(
                                '${student['className']} - ${student['academicYear']}',
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Payment Summary
            Text(
              'ملخص الرسوم',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildPaymentSummaryItem(
                            context,
                            'إجمالي الرسوم',
                            '₪ ${student['totalFees']}',
                            Colors.blue,
                            Icons.attach_money,
                          ),
                        ),
                        Expanded(
                          child: _buildPaymentSummaryItem(
                            context,
                            'المدفوع',
                            '₪ ${student['paidFees']}',
                            Colors.green,
                            Icons.check_circle,
                          ),
                        ),
                        Expanded(
                          child: _buildPaymentSummaryItem(
                            context,
                            'المتبقي',
                            '₪ ${student['remainingFees']}',
                            student['remainingFees'] > 0 ? Colors.red : Colors.green,
                            student['remainingFees'] > 0 ? Icons.warning : Icons.check_circle,
                          ),
                        ),
                      ],
                    ),
                    if (student['remainingFees'] > 0) ...[
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.info, color: Colors.orange),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'يرجى دفع المبلغ المتبقي قبل نهاية الفصل الدراسي.',
                              style: TextStyle(
                                color: Colors.orange[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Payment History
            Text(
              'سجل المدفوعات',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: _paymentHistory.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Text('لا توجد مدفوعات مسجلة'),
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _paymentHistory.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final payment = _paymentHistory[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                            child: Icon(
                              Icons.receipt,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          title: Text('₪ ${payment['amount']}'),
                          subtitle: Text('${payment['paymentDate']} - ${payment['paymentMethod']}'),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                payment['status'],
                                style: TextStyle(
                                  color: _getStatusColor(payment['status']),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'رقم: ${payment['receiptNumber']}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            
            const SizedBox(height: 24),
            
            // Class Information
            Text(
              'معلومات الفصل',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildClassInfoItem(
                      context,
                      'الفصل',
                      student['className'],
                      Icons.class_,
                    ),
                    const SizedBox(height: 16),
                    _buildClassInfoItem(
                      context,
                      'العام الدراسي',
                      student['academicYear'],
                      Icons.calendar_today,
                    ),
                    const SizedBox(height: 16),
                    _buildClassInfoItem(
                      context,
                      'الفصل الدراسي',
                      'الفصل الأول',
                      Icons.schedule,
                    ),
                    const SizedBox(height: 16),
                    _buildClassInfoItem(
                      context,
                      'المعلم',
                      'أ. محمد أحمد',
                      Icons.person,
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

  Widget _buildPaymentSummaryItem(
    BuildContext context,
    String title,
    String value,
    Color color,
    IconData icon,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildClassInfoItem(
    BuildContext context,
    String title,
    String value,
    IconData icon,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
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
