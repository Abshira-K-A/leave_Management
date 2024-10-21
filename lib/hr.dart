// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import 'login.dart';

// class Teacher extends StatefulWidget {
//   const Teacher({super.key});

//   @override
//   State<Teacher> createState() => _TeacherState();
// }

// class _TeacherState extends State<Teacher> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Teacher"),
//         actions: [
//           IconButton(
//             onPressed: () {
//               logout(context);
//             },
//             icon: const Icon(
//               Icons.logout,
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Future<void> logout(BuildContext context) async {
//     const CircularProgressIndicator();
//     await FirebaseAuth.instance.signOut();
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const LoginPage(),
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class HR extends StatefulWidget {
  const HR({super.key});

  @override
  State<HR> createState() => _HRState();
}

class _HRState extends State<HR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HR"),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      body: const Center(
        child: Text("Welcome to the HR page"), // Placeholder content
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    const CircularProgressIndicator(); // Optional loading indicator
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }
}

