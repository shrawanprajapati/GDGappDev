import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  SessionService._();
  static final SessionService instance = SessionService._();
  String? userId;
  String? role;
  String? name;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('session_user_id');
    role = prefs.getString('session_role');
    name = prefs.getString('session_name');
  }

  Future<void> login({
    required String id,
    required String userRole,
    required String userName,
  }) async {
    userId = id;
    role = userRole;
    name = userName;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('session_user_id', id);
    await prefs.setString('session_role', userRole);
    await prefs.setString('session_name', userName);
  }

  Future<void> logout() async {
    userId = null;
    role = null;
    name = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('session_user_id');
    await prefs.remove('session_role');
    await prefs.remove('session_name');
  }
}
