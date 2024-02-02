// auth_state.dart
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class AuthState with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late StreamSubscription<User?> _authStateSubscription;
  late Stream<User?> _authStateStream;
  late User? _currentUser;

  bool _isLoggedIn = false;

  bool _isAuthenticating = false;

  bool get isAuthenticating => _isAuthenticating;

  void setAuthenticating(bool value) {
    _isAuthenticating = value;
    notifyListeners();
  }

  AuthState() {
    _authStateStream = _auth.authStateChanges();
    _authStateSubscription = _authStateStream.listen((user) {
      _currentUser = user;
      notifyListeners();
    });
  }

  User? get currentUser => _currentUser;

  @override
  void dispose() {
    _authStateSubscription.cancel();
    super.dispose();
  }

}
