import 'package:cuidapet/app/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UserService {
  final UserRepository _repository;

  UserService(this._repository);

  Future<void> login(
    String email, {
    String password,
    bool facebookLogin = false,
    String avatar = '',
  }) async {
    try {
      final accessToken = await _repository.login(
        email,
        password: password,
        facebookLogin: facebookLogin,
        avatar: avatar,
      );

      if (!facebookLogin) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      }
    } on PlatformException catch (e) {
      print('Erro ao fazer login no Firebase $e');
      rethrow;
    } catch (e) {
      print('Erro ao fazer login $e');
      rethrow;
    }
  }
}
