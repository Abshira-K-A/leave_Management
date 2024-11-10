// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:intl/intl.dart';

// // class LeaveApplicationsPage extends StatelessWidget {
// //   final DateFormat dateFormat = DateFormat('dd-MM-yyyy');

// //   // Function to fetch and display all leave applications
// //   Future<List<DocumentSnapshot>> fetchLeaveApplications() async {
// //     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
// //         .collection('leaveApplications')
// //         .orderBy('applicationDate', descending: true) // Order by application date (descending)
// //         .get();

// //     return querySnapshot.docs;
// //   }

// //   // Function to update the leave request status
// //   Future<void> updateLeaveStatus(String leaveId, String status) async {
// //     try {
// //       await FirebaseFirestore.instance
// //           .collection('leaveApplications')
// //           .doc(leaveId)
// //           .update({'status': status});
// //     } catch (e) {
// //       print("Error updating leave status: $e");
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Leave Applications'),
// //       ),
// //       body: FutureBuilder<List<DocumentSnapshot>>(
// //         future: fetchLeaveApplications(), // Fetch leave applications
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return const Center(child: CircularProgressIndicator());
// //           }

// //           if (snapshot.hasError) {
// //             return Center(child: Text('Error: ${snapshot.error}'));
// //           }

// //           if (!snapshot.hasData || snapshot.data!.isEmpty) {
// //             return const Center(child: Text("No leave applications found"));
// //           }

// //           // Display the list of leave applications
// //           return ListView.builder(
// //             itemCount: snapshot.data!.length,
// //             itemBuilder: (context, index) {
// //               var leaveApplication = snapshot.data![index];

// //               String leaveType = leaveApplication['leaveType'] ?? 'N/A';
// //               String startDate = leaveApplication['startDate'] ?? 'N/A';
// //               String endDate = leaveApplication['endDate'] ?? 'N/A';
// //               String applicationDate = leaveApplication['applicationDate'] ?? 'N/A';
// //               String employeeId = leaveApplication['employeeId'] ?? 'N/A';
// //               String employeeEmail = leaveApplication['email'] ?? 'N/A';
// //               String status = leaveApplication['status'] ?? 'N/A';
// //               String leaveId = leaveApplication.id;

// //               // Convert the start and end date to DateTime to calculate the duration
// //               DateTime startDateTime = dateFormat.parse(startDate);
// //               DateTime endDateTime = dateFormat.parse(endDate);
// //               Duration leaveDuration = endDateTime.difference(startDateTime);

// //               return Card(
// //                 margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
// //                 child: ListTile(
// //                   title: Text('Leave Type: $leaveType'),
// //                   subtitle: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text('Employee ID: $employeeId'),
// //                       Text('Email: $employeeEmail'),
// //                       Text('Leave Duration: ${leaveDuration.inDays} days'),
// //                       Text('Start Date: $startDate'),
// //                       Text('End Date: $endDate'),
// //                       Text('Application Date: $applicationDate'),
// //                       Text('Status: $status'),
// //                     ],
// //                   ),
// //                   trailing: Column(
// //                     mainAxisSize: MainAxisSize.min, // Prevent overflow by ensuring buttons take minimal space
// //                     children: [
// //                       // Approve and Reject Buttons with icons
// //                       IconButton(
// //                         onPressed: status == 'pending' ? () => _approveLeave(context, leaveId) : null,
// //                         icon: const Icon(Icons.check, color: Colors.green), // Tick mark icon
// //                         tooltip: 'Approve Leave',
// //                       ),
// //                       const SizedBox(height: 8),
// //                       IconButton(
// //                         onPressed: status == 'pending' ? () => _rejectLeave(context, leaveId) : null,
// //                         icon: const Icon(Icons.close, color: Colors.red), // Cross mark icon
// //                         tooltip: 'Reject Leave',
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   // Approve leave request
// //   void _approveLeave(BuildContext context, String leaveId) {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: const Text('Approve Leave Request'),
// //           content: const Text('Are you sure you want to approve this leave request?'),
// //           actions: [
// //             TextButton(
// //               onPressed: () {
// //                 updateLeaveStatus(leaveId, 'approved');
// //                 Navigator.of(context).pop();
// //                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Leave request approved')));
// //               },
// //               child: const Text('Yes'),
// //             ),
// //             TextButton(
// //               onPressed: () => Navigator.of(context).pop(),
// //               child: const Text('No'),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   // Reject leave request
// //   void _rejectLeave(BuildContext context, String leaveId) {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: const Text('Reject Leave Request'),
// //           content: const Text('Are you sure you want to reject this leave request?'),
// //           actions: [
// //             TextButton(
// //               onPressed: () {
// //                 updateLeaveStatus(leaveId, 'rejected');
// //                 Navigator.of(context).pop();
// //                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Leave request rejected')));
// //               },
// //               child: const Text('Yes'),
// //             ),
// //             TextButton(
// //               onPressed: () => Navigator.of(context).pop(),
// //               child: const Text('No'),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
// import 'package:real_project/leave_applicationdetails.dart';

// class LeaveApplicationsPage extends StatelessWidget {
//   final DateFormat dateFormat = DateFormat('dd-MM-yyyy');

//   // Function to fetch and display all leave applications
//   Future<List<DocumentSnapshot>> fetchLeaveApplications() async {
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//         .collection('leaveApplications')
//         .orderBy('applicationDate', descending: true) // Order by application date (descending)
//         .get();

//     return querySnapshot.docs;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Leave Applications'),
//       ),
//       body: FutureBuilder<List<DocumentSnapshot>>(
//         future: fetchLeaveApplications(), // Fetch leave applications
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text("No leave applications found"));
//           }

//           // Display the list of leave applications
//           return ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               var leaveApplication = snapshot.data![index];

//               String leaveType = leaveApplication['leaveType'] ?? 'N/A';
//               String employeeEmail = leaveApplication['email'] ?? 'N/A';
//               String leaveId = leaveApplication.id;

//               return Card(
//                 margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                 child: ListTile(
//                   title: Text('Leave Type: $leaveType'),
//                   subtitle: Text('Email: $employeeEmail'),
//                   onTap: () {
//                     // Navigate to the details page when the tile is tapped
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => LeaveApplicationDetailsPage(leaveApplication: leaveApplication),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_project/leave_applicationdetails.dart';

class LeaveApplicationsPage extends StatelessWidget {
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');

  // Function to fetch the department of the currently logged-in user
  Future<String> _getUserDepartment() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return userDoc['department'] ?? ''; // Return the user's department
    } catch (e) {
      throw Exception('Error fetching user department: $e');
    }
  }

  // Function to fetch and display leave applications for the logged-in user's department
  Future<List<DocumentSnapshot>> fetchLeaveApplications(String department) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('leaveApplications')
        .where('department', isEqualTo: department) // Filter by department
        .orderBy('applicationDate', descending: true) // Order by application date (descending)
        .get();

    return querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getUserDepartment(), // Fetch the user's department
      builder: (context, departmentSnapshot) {
        if (departmentSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (departmentSnapshot.hasError) {
          return Center(child: Text('Error: ${departmentSnapshot.error}'));
        }

        String department = departmentSnapshot.data ?? '';

        return Scaffold(
          appBar: AppBar(
            title: const Text('Leave Applications'),
          ),
          body: FutureBuilder<List<DocumentSnapshot>>(
            future: fetchLeaveApplications(department), // Fetch leave applications for the department
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No leave applications found"));
              }

              // Display the list of leave applications
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var leaveApplication = snapshot.data![index];

                  String leaveType = leaveApplication['leaveType'] ?? 'N/A';
                  String employeeEmail = leaveApplication['email'] ?? 'N/A';
                  String leaveId = leaveApplication.id;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text('Leave Type: $leaveType'),
                      subtitle: Text('Email: $employeeEmail'),
                      onTap: () {
                        // Navigate to the details page when the tile is tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LeaveApplicationDetailsPage(leaveApplication: leaveApplication),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
