import 'package:flutter/material.dart';
import 'package:school_fees_management/models/user.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;
  String? _error;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;
  bool get isAdmin => _currentUser?.role == 'admin';
  bool get isParent => _currentUser?.role == 'parent';
  String? get error => _error;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setError(String? error) {
    _error = error;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    setLoading(true);
    setError(null);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Mock login - in a real app, this would be an API call
      if (email == 'admin@example.com' && password == 'password') {
        _currentUser = User(
          id: '1',
          name: 'مدير النظام',
          email: 'admin@example.com',
          phone: '0123456789',
          role: 'admin',
          profileImage: null,
        );
        setLoading(false);
        notifyListeners();
        return true;
      } else if (email == 'parent@example.com' && password == 'password') {
        _currentUser = User(
          id: '2',
          name: 'أحمد محمد',
          email: 'parent@example.com',
          phone: '0123456789',
          role: 'parent',
          profileImage: null,
        );
        setLoading(false);
        notifyListeners();
        return true;
      } else {
        setError('البريد الإلكتروني أو كلمة المرور غير صحيحة');
        setLoading(false);
        return false;
      }
    } catch (e) {
      setError('حدث خطأ أثناء تسجيل الدخول. يرجى المحاولة مرة أخرى.');
      setLoading(false);
      return false;
    }
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
