


// //////////////
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class EmployeesPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Employees"),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('users')
//             .where('role', isEqualTo: 'Employee')  // Filtering by role
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text("No employees found"));
//           }

//           var employees = snapshot.data!.docs;

//           return ListView.builder(
//             itemCount: employees.length,
//             itemBuilder: (context, index) {
//               var employee = employees[index];
//               return ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: NetworkImage(employee['profilePicUrl'] ?? ''),
//                   radius: 25,
//                 ),
//                 title: Text(employee['name']),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Position: ${employee['position']}'),
//                     Text('Department: ${employee['department']}'),
//                   ],
//                 ),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.more_vert),
//                   onPressed: () {
//                     _showEmployeeDetails(context, employee);
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   void _showEmployeeDetails(BuildContext context, DocumentSnapshot employee) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(employee['name']),
//           content: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('Position: ${employee['position']}'),
//               Text('Department: ${employee['department']}'),
//               Text('Email: ${employee['email']}'),
//               Text('Phone: ${employee['phone']}'),
//               // Add more fields as necessary
//             ],
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text("Close"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeesPage extends StatelessWidget {
  get employeeData => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employees"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('role', isEqualTo: 'Employee')  // Filtering by role
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No employees found"));
          }

          var employees = snapshot.data!.docs;

          return ListView.builder(
            itemCount: employees.length,
            itemBuilder: (context, index) {
              var employee = employees[index];

              // Check if profilePicUrl exists and is not null
             String? profilePicUrl = (employeeData != null && employeeData.containsKey('profilePicUrl'))
                  ? employeeData['profilePicUrl']
                  : null;


              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: profilePicUrl != null && profilePicUrl.isNotEmpty
                      ? NetworkImage(profilePicUrl)
                      : AssetImage('assets/placeholder.png') as ImageProvider, // Placeholder image
                  radius: 25,
                ),
                title: Text(employee['name']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text('Position: ${employee['position']}'),
                    // Text('Department: ${employee['department']}'),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    _showEmployeeDetails(context, employee);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showEmployeeDetails(BuildContext context, DocumentSnapshot employee) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(employee['name']),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Position: ${employee['position']}'),
              Text('Department: ${employee['department']}'),
              Text('Email: ${employee['email']}'),
              Text('Phone: ${employee['phone']}'),
              // Add more fields as necessary
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
//           ],
        ]);
      },
    );
  }
}
