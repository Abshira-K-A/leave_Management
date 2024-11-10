// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'WFH_details.dart';
// import 'leave_reject.dart';
// import 'login.dart';
// import 'employee_Details.dart';
// import 'leave_request.dart';
// import 'leave_approved.dart';
// import 'profile_.dart'; // Import Approved Leave Page

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
//         title: const Text("Manager Dashboard"),
//         actions: [
//           // Profile icon button
//           IconButton(
//             icon: const Icon(Icons.account_circle),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const EmployeeProfilePage()),
//               );
//             },
//           ),
//           // Logout button
//           IconButton(
//             onPressed: () {
//               logout(context);
//             },
//             icon: const Icon(Icons.logout),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: GridView.count(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           crossAxisCount: 2,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//           children: [
//             StreamBuilder(
//               stream: FirebaseFirestore.instance.collection('users').snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 int employeeCount = snapshot.data?.docs.length ?? 0;
//                 return DashboardCard(
//                   icon: Icons.people,
//                   title: "Employees",
//                   count: employeeCount,
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const EmployeeDetailsPage()),
//                     );
//                   },
//                 );
//               },
//             ),
//             StreamBuilder(
//   stream: FirebaseFirestore.instance.collection('leaveApplications').snapshots(),
//   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return const Center(child: CircularProgressIndicator());
//     }
//     int leaveRequestCount = snapshot.data?.docs.length ?? 0;
//     return DashboardCard(
//       icon: Icons.pending_actions,
//       title: "Leave",
//       count: leaveRequestCount,
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => LeaveApplicationsPage()),
//         );
//       },
//     );
//   },
// ),

            
//             StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('leaveApplications')
//                   .where('managerStatus', isEqualTo: 'approved')
//                   .snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 int approvedRequestCount = snapshot.data?.docs.length ?? 0;
//                 return DashboardCard(
//                   icon: Icons.check_circle,
//                   title: "Approved",
//                   count: approvedRequestCount,
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const ApprovedLeavePage()),
//                     );
//                   },
//                 );
//               },
//             ),
//             StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('leaveApplications')
//                   .where('managerStatus', isEqualTo: 'approved')
//                   .snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 int rejectedRequestCount = snapshot.data?.docs.length ?? 0;
//                 return DashboardCard(
//                   icon: Icons.cancel,
//                   title: "Rejected",
//                   count: rejectedRequestCount,
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const RejectedLeavePage()),
//                     );
//                   },
//                 );
//               },
//             ),
//             // New Work from Home Dashboard Card
//             StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('workFromHomeRequests') // Replace with your collection name for work from home requests
//                   .where('status', isEqualTo: 'pending') // Adjust as needed
//                   .snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 int workFromHomeCount = snapshot.data?.docs.length ?? 0;
//                 return DashboardCard(
//                   icon: Icons.home_work,
//                   title: "Work from home",
//                   count: workFromHomeCount,
//                   onTap: () {
//                     // Navigate to a new page for Work from Home details if needed
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const WorkFromHomeDetailsPage ()), // Replace with the actual page if created
//                     );
//                   },
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> logout(BuildContext context) async {
//     await FirebaseAuth.instance.signOut();
//     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
//   }
// }

// class DashboardCard extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final int count;
//   final VoidCallback onTap;

//   const DashboardCard({
//     super.key,
//     required this.icon,
//     required this.title,
//     required this.count,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(icon, size: 30, color: Colors.blue),
//               const SizedBox(height: 10),
//               Text(
//                 title,
//                 style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 5),
//               Text(
//                 '$count',
//                 style: const TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'WFH_details.dart';
import 'leave_reject.dart';
import 'login.dart';
import 'employee_Details.dart';
import 'leave_request.dart';
import 'leave_approved.dart';
import 'profile_.dart';

class Manager extends StatefulWidget {
  const Manager({super.key});

  @override
  State<Manager> createState() => _ManagerState();
}

class _ManagerState extends State<Manager> {
  String? currentUserDepartment;
  String? currentUserId;

  @override
  void initState() {
    super.initState();
    _fetchCurrentUserDetails();
  }

  Future<void> _fetchCurrentUserDetails() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUserId = user.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        currentUserDepartment = userDoc['department'] ?? 'Unknown';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manager Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EmployeeProfilePage()),
              );
            },
          ),
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: currentUserDepartment == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .where('department', isEqualTo: currentUserDepartment)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Center(child: Text("Error loading data"));
                      }

                      int employeeCount = (snapshot.data?.docs.length ?? 0);

                      // Decrease by 1 to exclude the logged-in user
                      if (employeeCount > 0) {
                        employeeCount -= 1;
                      }

                      return DashboardCard(
                        icon: Icons.people,
                        title: "Employees",
                        count: employeeCount,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const EmployeeDetailsPage()),
                          );
                        },
                      );
                    },
                  ),
                  // Other cards remain unchanged
                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('leaveApplications').snapshots(),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LeaveApplicationsPage()),
                          );
                        },
                      );
                    },
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('leaveApplications')
                        .where('managerStatus', isEqualTo: 'approved')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      int approvedRequestCount = snapshot.data?.docs.length ?? 0;
                      return DashboardCard(
                        icon: Icons.check_circle,
                        title: "Approved",
                        count: approvedRequestCount,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ApprovedLeavePage()),
                          );
                        },
                      );
                    },
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('leaveApplications')
                        .where('managerStatus', isEqualTo: 'rejected')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      int rejectedRequestCount = snapshot.data?.docs.length ?? 0;
                      return DashboardCard(
                        icon: Icons.cancel,
                        title: "Rejected",
                        count: rejectedRequestCount,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RejectedLeavePage()),
                          );
                        },
                      );
                    },
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('workFromHomeRequests')
                        .where('status', isEqualTo: 'pending')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      int workFromHomeCount = snapshot.data?.docs.length ?? 0;
                      return DashboardCard(
                        icon: Icons.home_work,
                        title: "Work from home",
                        count: workFromHomeCount,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const WorkFromHomeDetailsPage()),
                          );
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
              Icon(icon, size: 30, color: Colors.blue),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                '$count',
                style: const TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
