//main.dart
import 'package:firebase_flutter/presentation/auth_state.dart';
import 'package:firebase_flutter/presentation/screens/auth.dart';
import 'package:firebase_flutter/presentation/screens/chat.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthState(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 63, 17, 177),
        ),
      ),
      home: Consumer<AuthState>(
        builder: (context, authState, _) {
          // Misalkan, jika pengguna terautentikasi, tampilkan ChatScreen
          // Jika tidak, tampilkan AuthScreen
          return authState.currentUser != null ? ChatScreen() : AuthScreen();
        },
      ),
    );
  }
}



// class App extends StatelessWidget {
//   const App({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'FlutterChat',
//       theme: ThemeData().copyWith(
//         useMaterial3: true,
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: const Color.fromARGB(255, 63, 17, 177),
//         ),
//       ),
//       home: Consumer<AuthState>(
//         builder: (ctx, authState, _) {
//           if (authState.isAuthenticating) {
//             return const ChatScreen();
//           }
//           return const AuthScreen();
//         },
//       ),
//     );
//   }
// }