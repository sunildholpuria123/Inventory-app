import 'package:drift/drift.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/database/app_database.dart' show AppDatabase, UsersCompanion, User;

class AuthRepository {
  final AppDatabase db;

  AuthRepository(this.db);

  Future<User?> login({
    required String email,
    required String password,
  }) async {
    final query =
    await (db.select(db.users)
      ..where(
            (tbl) =>
        tbl.email.equals(
          email,
        ) &
        tbl.password.equals(
          password,
        ),
      ))
        .getSingleOrNull();

    if (query != null) {
      final prefs =
      await SharedPreferences.getInstance();

      await prefs.setBool(
        'isLoggedIn',
        true,
      );

      await prefs.setString(
        'userRole',
        query.role,
      );

      await prefs.setInt(
        'userId',
        query.id,
      );
    }

    return query;
  }

  Future<void> logout() async {
    final prefs =
    await SharedPreferences.getInstance();

    await prefs.clear();
  }

  Future<bool> isLoggedIn() async {
    final prefs =
    await SharedPreferences.getInstance();

    return prefs.getBool(
      'isLoggedIn',
    ) ??
        false;
  }

  Future<void> createDefaultAdmin() async {
    final existing =
    await db.select(db.users).get();

    if (existing.isNotEmpty) {
      return;
    }

    await db.into(db.users).insert(
      UsersCompanion.insert(
        name: 'Admin',
        email: 'admin@gmail.com',
        password: 'admin123',
        role: 'ADMIN',
      ),
    );
  }
}