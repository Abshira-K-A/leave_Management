// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class ApprovedLeavePage extends StatelessWidget {
//   const ApprovedLeavePage({super.key});

//   // Function to fetch employee details based on employeeId
//   Future<Map<String, dynamic>?> fetchEmployeeDetails(String employeeId) async {
//     // Fetch employee details from the 'users' collection using employeeId
//     DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(employeeId).get();
//     if (userDoc.exists) {
//       return userDoc.data() as Map<String, dynamic>?;
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Approved Leave Requests"),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('leave_requests')
//             .where('status', isEqualTo: 'approved')
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text("No approved leave requests"));
//           }
//           return ListView(
//             children: snapshot.data!.docs.map((doc) {
//               // Fetch employee details based on the employeeId
//               String employeeId = doc['employeeId'];

//               return FutureBuilder(
//                 future: fetchEmployeeDetails(employeeId),
//                 builder: (context, AsyncSnapshot<Map<String, dynamic>?> employeeSnapshot) {
//                   if (employeeSnapshot.connectionState == ConnectionState.waiting) {
//                     return const ListTile(
//                       title: Text("Loading employee details..."),
//                       subtitle: Text("Please wait"),
//                     );
//                   }
//                   if (!employeeSnapshot.hasData) {
//                     return const ListTile(
//                       title: Text("Employee details not found"),
//                       subtitle: Text("Unable to fetch employee information"),
//                     );
//                   }

//                   final employee = employeeSnapshot.data!;
//                   final name = employee['name'] ?? 'N/A';  // Get employee name
//                   final email = employee['email'] ?? 'N/A';  // Get employee email

//                   // Calculate duration of leave
//                   DateTime startDate = (doc['startDate'] as Timestamp).toDate();
//                   DateTime endDate = (doc['endDate'] as Timestamp).toDate();
//                   Duration leaveDuration = endDate.difference(startDate);

//                   return ListTile(
//                     title: Text("Leave Type: ${doc['leaveType']}"),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Days: ${doc['numberOfDays']}"),
//                         Text("Name: $name"),
//                         Text("Email: $email"),
//                         Text("Duration: ${leaveDuration.inDays} days"),
//                       ],
//                     ),
//                     trailing: const Text("Approved"),
//                   );
//                 },
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class ApprovedLeavePage extends StatelessWidget {
//   const ApprovedLeavePage({super.key});

//   // Function to fetch employee details based on employeeId
//   Future<Map<String, dynamic>?> fetchEmployeeDetails(String employeeEmail) async {
//     // Fetch employee details from the 'users' collection using employeeId
//     DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(employeeEmail).get();
//     if (userDoc.exists) {
//       return userDoc.data() as Map<String, dynamic>?;
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Approved Leave Requests"),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('leaveApplications')  // Changed from 'leave_requests' to 'leaveApplications'
//             .where('status', isEqualTo: 'approved')
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text("No approved leave requests"));
//           }
//           return ListView(
//             children: snapshot.data!.docs.map((doc) {
//               // Fetch employee details based on the employeeId
//               String employeeEmail = doc['email'];

//               return FutureBuilder(
//                 future: fetchEmployeeDetails(employeeEmail),
//                 builder: (context, AsyncSnapshot<Map<String, dynamic>?> employeeSnapshot) {
//                   if (employeeSnapshot.connectionState == ConnectionState.waiting) {
//                     return const ListTile(
//                       title: Text("Loading employee details..."),
//                       subtitle: Text("Please wait"),
//                     );
//                   }
//                   if (!employeeSnapshot.hasData) {
//                     return const ListTile(
//                       title: Text("Employee details not found"),
//                       subtitle: Text("Unable to fetch employee information"),
//                     );
//                   }

//                   final employee = employeeSnapshot.data!;
//                   final name = employee['name'] ?? 'N/A';  // Get employee name
//                   final email = employee['email'] ?? 'N/A';  // Get employee email

//                   // Calculate duration of leave
//                   DateTime startDate = (doc['startDate'] as Timestamp).toDate();
//                   DateTime endDate = (doc['endDate'] as Timestamp).toDate();
//                   Duration leaveDuration = endDate.difference(startDate);

//                   return ListTile(
//                     title: Text("Leave Type: ${doc['leaveType']}"),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Days: ${doc['numberOfDays']}"),
//                         Text("Name: $name"),
//                         Text("Email: $email"),
//                         Text("Duration: ${leaveDuration.inDays} days"),
//                       ],
//                     ),
//                     trailing: const Text("Approved"),
//                   );
//                 },
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class ApprovedLeavePage extends StatelessWidget {
//   const ApprovedLeavePage({super.key});

//   // Function to fetch employee details based on the employee's email
//   Future<Map<String, dynamic>?> fetchEmployeeDetails(String employeeEmail) async {
//     try {
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(employeeEmail)
//           .get();
//       if (userDoc.exists) {
//         return userDoc.data() as Map<String, dynamic>?;
//       }
//     } catch (e) {
//       print("Error fetching employee details: $e");
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Approved Leave Requests"),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('leaveApplications')
//             .where('status', isEqualTo: 'approved')
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text("No approved leave requests"));
//           }
//           return ListView(
//             children: snapshot.data!.docs.map((doc) {
//               String employeeEmail = doc['email'];

//               return FutureBuilder(
//                 future: fetchEmployeeDetails(employeeEmail),
//                 builder: (context, AsyncSnapshot<Map<String, dynamic>?> employeeSnapshot) {
//                   if (employeeSnapshot.connectionState == ConnectionState.waiting) {
//                     return const ListTile(
//                       title: Text("Loading employee details..."),
//                       subtitle: Text("Please wait"),
//                     );
//                   }
//                   if (employeeSnapshot.hasError) {
//                     return const ListTile(
//                       title: Text("Error loading employee details"),
//                       subtitle: Text("Please try again later"), 
//                     );
//                   }
//                   if (!employeeSnapshot.hasData) {
//                     return ListTile(
//                       title: Text("Employee details not found"),
//                       subtitle: Text("Email: $employeeEmail"),
//                     );
//                   }

//                   final employee = employeeSnapshot.data!;
//                   final name = employee['name'] ?? 'N/A';
//                   final email = employee['email'] ?? 'N/A';

//                   // Convert Firestore Timestamp to DateTime
//                   DateTime startDate = (doc['startDate'] as Timestamp).toDate();
//                   DateTime endDate = (doc['endDate'] as Timestamp).toDate();
//                   Duration leaveDuration = endDate.difference(startDate);

//                   return Card(
//                     margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                     child: ListTile(
//                       title: Text("Leave Type: ${doc['leaveType']}"),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Name: $name"),
//                           Text("Email: $email"),
//                           Text("Start Date: ${startDate.toLocal().toString().split(' ')[0]}"),
//                           Text("End Date: ${endDate.toLocal().toString().split(' ')[0]}"),
//                           Text("Duration: ${leaveDuration.inDays + 1} days"), // Inclusive of start and end
//                           Text("Days Requested: ${doc['numberOfDays']}"),
//                           Text("Status: Approved"),
//                         ],
//                       ),
//                       trailing: const Icon(Icons.check_circle, color: Colors.green),
//                     ),
//                   );
//                 },
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ApprovedLeavePage extends StatelessWidget {
  const ApprovedLeavePage({super.key});

  // Helper function to safely convert a field to a DateTime from Firestore
  DateTime? _parseTimestamp(dynamic field) {
    if (field is Timestamp) {
      return field.toDate();
    } else if (field is String) {
      try {
        return DateTime.parse(field); // Handle the case where it's a string
      } catch (e) {
        print("Error parsing date string: $e");
        return null;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Approved Leave Requests"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('leaveApplications')
            .where('status', isEqualTo: 'approved')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No approved leave requests"));
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              final String email = doc['email'] ?? 'N/A';
              final String leaveType = doc['leaveType'] ?? 'N/A';
              final String leaveId = doc.id;

              // Safely parse the date fields using the helper function
              final DateTime? startDate = _parseTimestamp(doc['startDate']);
              final DateTime? endDate = _parseTimestamp(doc['endDate']);
              final DateTime? applicationDate = _parseTimestamp(doc['applicationDate']);

              // Debugging: print the retrieved values
              print("Start Date: $startDate, End Date: $endDate, Application Date: $applicationDate");

              // Check if dates are valid before rendering
              if (startDate == null || endDate == null || applicationDate == null) {
                return ListTile(
                  title: const Text("Invalid date format"),
                  subtitle: Text("Email: $email"),
                );
              }

              // Calculate the duration of the leave
              final int leaveDuration = endDate.difference(startDate).inDays + 1; // Inclusive of both dates

              // Format dates to a more readable format
              final String formattedStartDate = "${startDate.day}-${startDate.month}-${startDate.year}";
              final String formattedEndDate = "${endDate.day}-${endDate.month}-${endDate.year}";
              final String formattedApplicationDate = "${applicationDate.day}-${applicationDate.month}-${applicationDate.year}";

              // Fetch employee details (like firstName, lastName) from the users collection
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance.collection('users').doc(email).get(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                    return const ListTile(
                      title: Text("User not found"),
                    );
                  }

                  final userData = userSnapshot.data!;
                  final String employeeName = userData['firstName'] ?? 'N/A';
                  final String lastName = userData['lastName'] ?? 'N/A';

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text("Leave Type: $leaveType"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Employee Name: $employeeName $lastName"),
                          Text("Email: $email"),
                          Text("Leave Duration: $leaveDuration days"),
                          Text("Start Date: $formattedStartDate"),
                          Text("End Date: $formattedEndDate"),
                          Text("Application Date: $formattedApplicationDate"),
                        ],
                      ),
                      trailing: const Icon(Icons.check_circle, color: Colors.green),
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

