import 'package:flutter/foundation.dart';
import 'package:flutter_hero_admin_app/credentials/supabase_credentials.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationService {
  Future<void> signUp({required String email, required String password}) async {
    GotrueSessionResponse response =
        await SupabaseCredentials.supabaseClient.auth.signUp(email, password);

    if (response.error == null) {
      String? userEmail = response.data!.user!.email;
      if (kDebugMode) {
        print('## signup successful: $userEmail');
      }
    } else {
      throw CustomException('## sign up error: ${response.error!.message}');
    }
  }

  Future<void> login({required String email, required String password}) async {
    GotrueSessionResponse response =
        await SupabaseCredentials.supabaseClient.auth.signIn(
            email: email,
            password: password,
            options: AuthOptions(redirectTo: SupabaseCredentials.apiUrl));

    if (response.error == null) {
      String? userEmail = response.data!.user!.email;
      if (kDebugMode) {
        print('## login successful: $userEmail');
      }
    } else {
      throw CustomException('## login error: ${response.error!.message}');
    }
  }
}

class CustomException implements Exception {
  String cause;
  CustomException(this.cause);
}
