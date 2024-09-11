import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  //final FirebaseAuth auth = FirebaseAuth.instance;
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> signInWithEmailAndPassword(String email, password) async {
    try {
      await _supabase.auth.signInWithPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> updateDisplayName(String displayName) async {
    try {
      final response = await Supabase.instance.client.auth.updateUser(
        UserAttributes(
          data: {'display_name': displayName},
        ),
      );

      if (response.user != null) {
        print('Display name updated successfully');
      } else {
        print('Failed to update display name');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<AuthResponse> signUpWithEmailPassword(String email, password) async {
    try {
      AuthResponse res =
          await _supabase.auth.signUp(email: email, password: password);
      return res;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    return await _supabase.auth.signOut();
  }
  //User? get currentUser => _supabase.auth.currentUser;
}
