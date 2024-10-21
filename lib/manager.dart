// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import 'login.dart';

// class Manager extends StatefulWidget {
//   const Manager({super.key});

//   @override
//   State<Manager> createState() => _ManagerState();
// }

// class _ManagerState extends State<Manager> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Manager"),
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
//       body: const Center(
//         child: Text("Welcome to the Manager page"), // Placeholder content
//       ),
//     );
//   }

//   Future<void> logout(BuildContext context) async {
//     const CircularProgressIndicator(); // Optional loading indicator
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

class Manager extends StatefulWidget {
  const Manager({super.key});

  @override
  State<Manager> createState() => _ManagerState();
}

class _ManagerState extends State<Manager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manager Dashboard"),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title of the dashboard
            const Text(
              "Welcome, Manager",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Employees Section
            _buildDashboardCard(
              icon: Icons.people,
              title: "Employees",
              description: "View and manage employees",
              onTap: () {
                // Navigate to employees page
                // TODO: Implement Employees screen navigation
              },
            ),

            // Apply Leave Section
            _buildDashboardCard(
              icon: Icons.time_to_leave,
              title: "Apply Leave",
              description: "Submit leave applications",
              onTap: () {
                // Navigate to apply leave page
                // TODO: Implement Apply Leave screen navigation
              },
            ),

            // Leave Status Section
            _buildDashboardCard(
              icon: Icons.check_circle,
              title: "Leave Status",
              description: "Check leave status",
              onTap: () {
                // Navigate to leave status page
                // TODO: Implement Leave Status screen navigation
              },
            ),

            // Pay Components Section
            _buildDashboardCard(
              icon: Icons.payment,
              title: "Pay Components",
              description: "View salary and pay components",
              onTap: () {
                // Navigate to pay components page
                // TODO: Implement Pay Components screen navigation
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build each dashboard card
  Widget _buildDashboardCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Colors.blue),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
