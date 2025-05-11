import 'package:flutter/material.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock payment history data
    final List<Map<String, dynamic>> _paymentHistory = [
      {
        'id': '1',
        'studentName': 'أحمد محمد',
        'className': 'الصف الأول',
        'amount': 1500.0,
        'paymentDate': '2023-09-15',
        'paymentMethod': 'نقدي',
        'receiptNumber': 'REC-001',
        'status': 'مدفوع',
      },
      {
        'id': '2',
        'studentName': 'فاطمة محمد',
        'className': 'الصف الثالث',
        'amount': 1000.0,
        'paymentDate': '2023-09-20',
        'paymentMethod': 'تحويل بنكي',
        'receiptNumber': 'REC-002',
        'status': 'مدفوع',
      },
      {
        'id': '3',
        'studentName': 'فاطمة محمد',
        'className': 'الصف الثالث',
        'amount': 700.0,
        'paymentDate': '2023-10-05',
        'paymentMethod': 'نقدي',
        'receiptNumber': 'REC-003',
        'status': 'مستحق',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل المدفوعات'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'بحث في المدفوعات...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _paymentHistory.length,
              itemBuilder: (context, index) {
                final payment = _paymentHistory[index];
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
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('طريقة الدفع: ${payment['paymentMethod']}'),
                            if (payment['status'] == 'مدفوع')
                              TextButton.icon(
                                icon: const Icon(Icons.print, size: 18),
                                label: const Text('طباعة الإيصال'),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('سيتم تنفيذ طباعة الإيصال قريبًا')),
                                  );
                                },
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
      case 'مستحق':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
