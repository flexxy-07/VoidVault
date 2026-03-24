import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:void_vault/features/auth/repo/auth_repo.dart';

final authRepoProvider = Provider((ref) => AuthRepo());

final authConrollerProvider = Provider((ref){
  return AuthController(ref);
});

final authStateProvider = StreamProvider<User?>((ref){
  return ref.read(authRepoProvider).authState;
});

class AuthController {
  final Ref ref;
  AuthController(this.ref);

  Future<void> signUp(String email, String password) async {
    await ref.read(authRepoProvider).signUp(email, password);
  }

  Future<void> logIn(String email, String password) async {
    await ref.read(authRepoProvider).login(email, password);
  }

  Future<void> logOut() async {
    await ref.read(authRepoProvider).logOut();
  }
}