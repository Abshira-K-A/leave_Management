import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'login.dart';
import 'employee_Details.dart'; // Import this if needed for employee details page

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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Manager Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('My Profile'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfilePage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                logout(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(), // Disable scrolling for GridView
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            // Employees Section
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text("Error loading data"));
                }

                // Get the employee count
                int employeeCount = snapshot.data?.docs.length ?? 0;

                // Return the DashboardCard with the employee count
                return DashboardCard(
                  icon: Icons.people,
                  title: "Employees",
                  count: employeeCount,
                  onTap: () {
                    // Navigate to employee details page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EmployeeDetailsPage()),
                    );
                  },
                );
              },
            ),

            // Leave Requests Section
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('leave_requests').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                int leaveRequestCount = snapshot.data?.docs.length ?? 0;
                return DashboardCard(
                  icon: Icons.pending_actions,
                  title: "Leave",
                  count: leaveRequestCount,
                  onTap: () {
                    // TODO: Implement Leave Requests screen navigation
                  },
                );
              },
            ),

            // Approved Leave Requests Section
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('leave_requests')
                  .where('status', isEqualTo: 'approved')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                int approvedCount = snapshot.data?.docs.length ?? 0;
                return DashboardCard(
                  icon: Icons.check_circle,
                  title: "Approved",
                  count: approvedCount,
                  onTap: () {
                    // TODO: Implement Approved Requests screen navigation
                  },
                );
              },
            ),

            // Pending Leave Requests Section
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('leave_requests')
                  .where('status', isEqualTo: 'pending')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                int pendingCount = snapshot.data?.docs.length ?? 0;
                return DashboardCard(
                  icon: Icons.pending,
                  title: "Pending",
                  count: pendingCount,
                  onTap: () {
                    // TODO: Implement Pending Requests screen navigation
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}

// A reusable widget for the Manager Dashboard cards
class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final int count;
  final VoidCallback onTap;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.blue),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                '$count',
                style: const TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Placeholder pages for navigation items
class MyProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Profile")),
      body: const Center(child: Text("My Profile Content")),
    );
  }
}
