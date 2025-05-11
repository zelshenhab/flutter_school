import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_fees_management/providers/auth_provider.dart';
import 'package:school_fees_management/screens/admin/classes_screen.dart';
import 'package:school_fees_management/screens/admin/payments_screen.dart';
import 'package:school_fees_management/screens/admin/school_settings_screen.dart';
import 'package:school_fees_management/screens/admin/students_screen.dart';
import 'package:school_fees_management/screens/auth/login_screen.dart';
import 'package:school_fees_management/widgets/admin_dashboard_card.dart';
import 'package:school_fees_management/widgets/chart_card.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة تحكم الإدارة'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('تسجيل الخروج'),
                  content: const Text('هل أنت متأكد من تسجيل الخروج؟'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('إلغاء'),
                    ),
                    TextButton(
                      onPressed: () {
                        authProvider.logout();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                          (route) => false,
                        );
                      },
                      child: const Text('تأكيد'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: const Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'مرحباً، ${authProvider.currentUser?.name ?? "مدير النظام"}',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'مرحباً بك في لوحة تحكم نظام إدارة الرسوم الدراسية',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Stats Summary
              Text(
                'ملخص الإحصائيات',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  AdminDashboardCard(
                    title: 'إجمالي الطلاب',
                    value: '120',
                    icon: Icons.people,
                    color: Colors.blue,
                  ),
                  AdminDashboardCard(
                    title: 'إجمالي الفصول',
                    value: '8',
                    icon: Icons.class_,
                    color: Colors.green,
                  ),
                  AdminDashboardCard(
                    title: 'الرسوم المحصلة',
                    value: '₪ 45,000',
                    icon: Icons.payments,
                    color: Colors.purple,
                  ),
                  AdminDashboardCard(
                    title: 'الرسوم المتأخرة',
                    value: '₪ 12,500',
                    icon: Icons.warning,
                    color: Colors.orange,
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Revenue Chart
              Text(
                'إحصائيات الرسوم',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              
              const ChartCard(
                title: 'إجمالي الرسوم المحصلة للفصل الدراسي الحالي',
              ),
              
              const SizedBox(height: 24),
              
              // Quick Actions
              Text(
                'الإجراءات السريعة',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildActionCard(
                    context,
                    'إدارة الفصول',
                    Icons.class_,
                    Colors.indigo,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ClassesScreen()),
                    ),
                  ),
                  _buildActionCard(
                    context,
                    'إدارة الطلاب',
                    Icons.people,
                    Colors.teal,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const StudentsScreen()),
                    ),
                  ),
                  _buildActionCard(
                    context,
                    'المدفوعات',
                    Icons.payment,
                    Colors.deepOrange,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PaymentsScreen()),
                    ),
                  ),
                  _buildActionCard(
                    context,
                    'إعدادات المدرسة',
                    Icons.settings,
                    Colors.blueGrey,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SchoolSettingsScreen()),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Recent Payments
              Text(
                'آخر المدفوعات',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                        child: Icon(
                          Icons.receipt,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      title: Text('أحمد محمد - الصف الثالث'),
                      subtitle: Text('${DateTime.now().subtract(Duration(days: index)).toString().substring(0, 10)}'),
                      trailing: Text(
                        '₪ ${(index + 1) * 500}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
