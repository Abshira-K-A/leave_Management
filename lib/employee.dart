// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import 'login.dart';

// class Student extends StatefulWidget {
//   const Student({super.key});

//   @override
//   State<Student> createState() => _StudentState();
// }

// class _StudentState extends State<Student> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("student"),
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

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee"),
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
        child: Text("Welcome to the Employee page"), // Placeholder content
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
