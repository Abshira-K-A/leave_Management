// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // Import for FirebaseAuth
// import 'package:intl/intl.dart';

// class LeaveApplicationPage extends StatefulWidget {
//   @override
//   _LeaveApplicationPageState createState() => _LeaveApplicationPageState();
// }

// class _LeaveApplicationPageState extends State<LeaveApplicationPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController daysController = TextEditingController();
//   final TextEditingController employeeIdController = TextEditingController();
//   String? employeeEmail;
//   String? selectedLeaveType;
//   final List<String> leaveTypes = ['Sick Leave', 'LOP', 'Casual Leave'];
//   DateTime? startDate;
//   DateTime? endDate;
//   DateTime? applicationDate;
//   final DateFormat dateFormat = DateFormat('dd-MM-yyyy');

//   String? managerDepartment; // To store manager's department
//   List<DocumentSnapshot> leaveApplications = []; // To store the leave applications that belong to the same department

//   @override
//   void initState() {
//     super.initState();
//     fetchUserEmail(); // Fetch email on page load
//     fetchManagerDepartment(); // Fetch manager department on page load
//   }

//   Future<void> fetchUserEmail() async {
//     try {
//       final User? user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         DocumentSnapshot userDoc = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(user.uid)
//             .get();
        
//         setState(() {
//           employeeEmail = userDoc['email'];
//         });
//       }
//     } catch (e) {
//       print("Error fetching user email: $e");
//     }
//   }

//   Future<void> fetchManagerDepartment() async {
//     try {
//       final User? user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         // Fetch the user's document to get the department
//         DocumentSnapshot userDoc = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(user.uid)
//             .get();

//         setState(() {
//           managerDepartment = userDoc['department']; // Assuming the field is named 'department'
//         });

//         // Now that we have the department, fetch the leave applications
//         fetchLeaveApplications();
//       }
//     } catch (e) {
//       print("Error fetching manager department: $e");
//     }
//   }

//   Future<void> fetchLeaveApplications() async {
//     try {
//       if (managerDepartment != null) {
//         // Fetch leave applications where the department matches the manager's department
//         QuerySnapshot leaveApplicationsSnapshot = await FirebaseFirestore.instance
//             .collection('leaveApplications')
//             .where('department', isEqualTo: managerDepartment)
//             .get();

//         setState(() {
//           leaveApplications = leaveApplicationsSnapshot.docs;
//         });
//       }
//     } catch (e) {
//       print("Error fetching leave applications: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Leave Application")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 // Leave Type Dropdown
//                 DropdownButtonFormField<String>(
//                   decoration: const InputDecoration(labelText: 'Leave Type'),
//                   value: selectedLeaveType,
//                   items: leaveTypes.map((String type) {
//                     return DropdownMenuItem<String>(
//                       value: type,
//                       child: Text(type),
//                     );
//                   }).toList(),
//                   onChanged: (newValue) {
//                     setState(() {
//                       selectedLeaveType = newValue;
//                     });
//                   },
//                   validator: (value) => value == null ? 'Please select a leave type' : null,
//                 ),
//                 const SizedBox(height: 10),
//                 // Start Date Picker
//                 TextFormField(
//                   readOnly: true,
//                   decoration: const InputDecoration(labelText: 'Start Date'),
//                   controller: TextEditingController(
//                     text: startDate != null ? dateFormat.format(startDate!) : '',
//                   ),
//                   onTap: () async {
//                     DateTime? pickedDate = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(2101),
//                     );
//                     if (pickedDate != null) {
//                       setState(() {
//                         startDate = pickedDate;
//                       });
//                     }
//                   },
//                   validator: (value) => value == null || value.isEmpty ? 'Please select Start Date' : null,
//                 ),
//                 const SizedBox(height: 10),
//                 // End Date Picker
//                 TextFormField(
//                   readOnly: true,
//                   decoration: const InputDecoration(labelText: 'End Date'),
//                   controller: TextEditingController(
//                     text: endDate != null ? dateFormat.format(endDate!) : '',
//                   ),
//                   onTap: () async {
//                     DateTime? pickedDate = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(2101),
//                     );
//                     if (pickedDate != null) {
//                       setState(() {
//                         endDate = pickedDate;
//                       });
//                     }
//                   },
//                   validator: (value) => value == null || value.isEmpty ? 'Please select End Date' : null,
//                 ),
//                 const SizedBox(height: 10),
//                 // Number of Days
//                 TextFormField(
//                   controller: daysController,
//                   decoration: const InputDecoration(labelText: 'Number of Days'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) => value == null || value.isEmpty ? 'Please enter number of days' : null,
//                 ),
//                 const SizedBox(height: 10),
//                 // Employee ID (Text Field)
//                 //TextFormField(
//                   //controller: employeeIdController,
//                   //decoration: const InputDecoration(labelText: 'Employee ID'),
//                   //keyboardType: TextInputType.text,
//                   //validator: (value) => value == null || value.isEmpty ? 'Please enter Employee ID' : null,
//                 //),
//                 const SizedBox(height: 10),
//                 // Application Date Picker
//                 TextFormField(
//                   readOnly: true,
//                   decoration: const InputDecoration(labelText: 'Application Date'),
//                   controller: TextEditingController(
//                     text: applicationDate != null ? dateFormat.format(applicationDate!) : '',
//                   ),
//                   onTap: () async {
//                     DateTime? pickedDate = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(2101),
//                     );
//                     if (pickedDate != null) {
//                       setState(() {
//                         applicationDate = pickedDate;
//                       });
//                     }
//                   },
//                   validator: (value) => value == null || value.isEmpty ? 'Please select Application Date' : null,
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       submitLeaveApplication();
//                     }
//                   },
//                   child: const Text("Submit Leave Request"),
//                 ),
//                 const SizedBox(height: 20),
//                 // Display leave applications from the same department
//                 if (leaveApplications.isNotEmpty)
//                   ...leaveApplications.map((application) {
//                     return Card(
//                       child: ListTile(
//                         title: Text(application['leaveType']),
//                         subtitle: Text('From: ${application['startDate']} To: ${application['endDate']}'),
//                       ),
//                     );
//                   }).toList(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> submitLeaveApplication() async {
//     try {
//       final User? user = FirebaseAuth.instance.currentUser;
//       if (user == null) {
//         throw Exception('User is not authenticated');
//       }

//       String employeeId = employeeIdController.text.isNotEmpty
//           ? employeeIdController.text
//           : user.uid;

//       // Add the leave application to Firestore with the manager's department
//       await FirebaseFirestore.instance.collection('leaveApplications').add({
//         'leaveType': selectedLeaveType,
//         'startDate': startDate != null ? dateFormat.format(startDate!) : null,
//         'endDate': endDate != null ? dateFormat.format(endDate!) : null,
//         'numberOfDays': int.tryParse(daysController.text),
//         'applicationDate': applicationDate != null ? dateFormat.format(applicationDate!) : null,
//         'email': employeeEmail,
//         'status': 'pending',
//         'userid': user.uid,
//         'department': managerDepartment, // Add department to the application
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Leave application submitted successfully!"),
//           backgroundColor: Colors.green,
//         ),
//       );

//       // Clear fields after submission
//       setState(() {
//         selectedLeaveType = null;
//         startDate = null;
//         endDate = null;
//         applicationDate = null;
//         leaveApplications = []; // Reset the displayed leave applications
//       });
//       daysController.clear();
//       employeeIdController.clear();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Failed to submit leave application. Please try again."),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // Import for FirebaseAuth
// import 'package:intl/intl.dart';

// class LeaveApplicationPage extends StatefulWidget {
//   @override
//   _LeaveApplicationPageState createState() => _LeaveApplicationPageState();
// }

// class _LeaveApplicationPageState extends State<LeaveApplicationPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController daysController = TextEditingController();
//   final TextEditingController employeeIdController = TextEditingController();
//   String? employeeEmail;
//   String? selectedLeaveType;
//   final List<String> leaveTypes = ['Sick Leave', 'LOP', 'Casual Leave'];
//   DateTime? startDate;
//   DateTime? endDate;
//   DateTime? applicationDate;
//   final DateFormat dateFormat = DateFormat('dd-MM-yyyy');

//   String? managerDepartment; // To store manager's department
//   List<DocumentSnapshot> leaveApplications = []; // To store the leave applications that belong to the same department

//   @override
//   void initState() {
//     super.initState();
//     fetchUserEmail(); // Fetch email on page load
//     fetchManagerDepartment(); // Fetch manager department on page load
//   }

//   Future<void> fetchUserEmail() async {
//     try {
//       final User? user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         DocumentSnapshot userDoc = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(user.uid)
//             .get();
        
//         setState(() {
//           employeeEmail = userDoc['email'];
//         });
//       }
//     } catch (e) {
//       print("Error fetching user email: $e");
//     }
//   }

//   Future<void> fetchManagerDepartment() async {
//     try {
//       final User? user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         // Fetch the user's document to get the department
//         DocumentSnapshot userDoc = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(user.uid)
//             .get();

//         setState(() {
//           managerDepartment = userDoc['department']; // Assuming the field is named 'department'
//         });

//         // Now that we have the department, fetch the leave applications
//         fetchLeaveApplications();
//       }
//     } catch (e) {
//       print("Error fetching manager department: $e");
//     }
//   }

//   Future<void> fetchLeaveApplications() async {
//     try {
//       if (managerDepartment != null) {
//         // Fetch leave applications where the department matches the manager's department
//         QuerySnapshot leaveApplicationsSnapshot = await FirebaseFirestore.instance
//             .collection('leaveApplications')
//             .where('department', isEqualTo: managerDepartment) // Ensure department matches
//             .get();

//         setState(() {
//           leaveApplications = leaveApplicationsSnapshot.docs;
//         });
//       }
//     } catch (e) {
//       print("Error fetching leave applications: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Leave Application")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 // Leave Type Dropdown
//                 DropdownButtonFormField<String>(
//                   decoration: const InputDecoration(labelText: 'Leave Type'),
//                   value: selectedLeaveType,
//                   items: leaveTypes.map((String type) {
//                     return DropdownMenuItem<String>(
//                       value: type,
//                       child: Text(type),
//                     );
//                   }).toList(),
//                   onChanged: (newValue) {
//                     setState(() {
//                       selectedLeaveType = newValue;
//                     });
//                   },
//                   validator: (value) => value == null ? 'Please select a leave type' : null,
//                 ),
//                 const SizedBox(height: 10),
//                 // Start Date Picker
//                 TextFormField(
//                   readOnly: true,
//                   decoration: const InputDecoration(labelText: 'Start Date'),
//                   controller: TextEditingController(
//                     text: startDate != null ? dateFormat.format(startDate!) : '',
//                   ),
//                   onTap: () async {
//                     DateTime? pickedDate = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(2101),
//                     );
//                     if (pickedDate != null) {
//                       setState(() {
//                         startDate = pickedDate;
//                       });
//                     }
//                   },
//                   validator: (value) => value == null || value.isEmpty ? 'Please select Start Date' : null,
//                 ),
//                 const SizedBox(height: 10),
//                 // End Date Picker
//                 TextFormField(
//                   readOnly: true,
//                   decoration: const InputDecoration(labelText: 'End Date'),
//                   controller: TextEditingController(
//                     text: endDate != null ? dateFormat.format(endDate!) : '',
//                   ),
//                   onTap: () async {
//                     DateTime? pickedDate = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(2101),
//                     );
//                     if (pickedDate != null) {
//                       setState(() {
//                         endDate = pickedDate;
//                       });
//                     }
//                   },
//                   validator: (value) => value == null || value.isEmpty ? 'Please select End Date' : null,
//                 ),
//                 const SizedBox(height: 10),
//                 // Number of Days
//                 TextFormField(
//                   controller: daysController,
//                   decoration: const InputDecoration(labelText: 'Number of Days'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) => value == null || value.isEmpty ? 'Please enter number of days' : null,
//                 ),
//                 const SizedBox(height: 10),
//                 // Application Date Picker
//                 TextFormField(
//                   readOnly: true,
//                   decoration: const InputDecoration(labelText: 'Application Date'),
//                   controller: TextEditingController(
//                     text: applicationDate != null ? dateFormat.format(applicationDate!) : '',
//                   ),
//                   onTap: () async {
//                     DateTime? pickedDate = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(2101),
//                     );
//                     if (pickedDate != null) {
//                       setState(() {
//                         applicationDate = pickedDate;
//                       });
//                     }
//                   },
//                   validator: (value) => value == null || value.isEmpty ? 'Please select Application Date' : null,
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       submitLeaveApplication();
//                     }
//                   },
//                   child: const Text("Submit Leave Request"),
//                 ),
//                 const SizedBox(height: 20),
//                 // Display leave applications from the same department
//                 if (leaveApplications.isNotEmpty)
//                   ...leaveApplications.map((application) {
//                     return Card(
//                       child: ListTile(
//                         title: Text(application['leaveType']),
//                         subtitle: Text('From: ${application['startDate']} To: ${application['endDate']}'),
//                       ),
//                     );
//                   }).toList(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> submitLeaveApplication() async {
//     try {
//       final User? user = FirebaseAuth.instance.currentUser;
//       if (user == null) {
//         throw Exception('User is not authenticated');
//       }

//       String employeeId = employeeIdController.text.isNotEmpty
//           ? employeeIdController.text
//           : user.uid;

//       // Add the leave application to Firestore with the manager's department
//       await FirebaseFirestore.instance.collection('leaveApplications').add({
//         'leaveType': selectedLeaveType,
//         'startDate': startDate != null ? dateFormat.format(startDate!) : null,
//         'endDate': endDate != null ? dateFormat.format(endDate!) : null,
//         'numberOfDays': int.tryParse(daysController.text),
//         'applicationDate': applicationDate != null ? dateFormat.format(applicationDate!) : null,
//         'email': employeeEmail,
//         'status': 'pending',
//         'userid': user.uid,
//         'department': managerDepartment, // Add department to the application
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Leave application submitted successfully!"),
//           backgroundColor: Colors.green,
//         ),
//       );

//       // Clear fields after submission
//       setState(() {
//         selectedLeaveType = null;
//         startDate = null;
//         endDate = null;
//         applicationDate = null;
//         leaveApplications = []; // Reset the displayed leave applications
//       });
//       daysController.clear();
//       employeeIdController.clear();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Failed to submit leave application. Please try again."),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import for FirebaseAuth
import 'package:intl/intl.dart';

class LeaveApplicationPage extends StatefulWidget {
  @override
  _LeaveApplicationPageState createState() => _LeaveApplicationPageState();
}

class _LeaveApplicationPageState extends State<LeaveApplicationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController daysController = TextEditingController();
  final TextEditingController employeeIdController = TextEditingController();
  String? employeeEmail;
  String? selectedLeaveType;
  final List<String> leaveTypes = ['Sick Leave', 'LOP', 'Casual Leave'];
  DateTime? startDate;
  DateTime? endDate;
  DateTime? applicationDate;
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');

  String? managerDepartment; // To store manager's department
  List<DocumentSnapshot> leaveApplications = []; // To store the leave applications that belong to the same department
  String? username; // To store username

  @override
  void initState() {
    super.initState();
    fetchUserEmail(); // Fetch email on page load
    fetchManagerDepartment(); // Fetch manager department on page load
  }

  Future<void> fetchUserEmail() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        
        setState(() {
          employeeEmail = userDoc['email'];
          username = userDoc['firstName']; // Fetch the username (assuming it's firstName)
        });
      }
    } catch (e) {
      print("Error fetching user email: $e");
    }
  }

  Future<void> fetchManagerDepartment() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Fetch the user's document to get the department
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        setState(() {
          managerDepartment = userDoc['department']; // Assuming the field is named 'department'
        });

        // Now that we have the department, fetch the leave applications
        fetchLeaveApplications();
      }
    } catch (e) {
      print("Error fetching manager department: $e");
    }
  }

  Future<void> fetchLeaveApplications() async {
    try {
      if (managerDepartment != null) {
        // Fetch leave applications where the department matches the manager's department
        QuerySnapshot leaveApplicationsSnapshot = await FirebaseFirestore.instance
            .collection('leaveApplications')
            .where('department', isEqualTo: managerDepartment) // Ensure department matches
            .get();

        setState(() {
          leaveApplications = leaveApplicationsSnapshot.docs;
        });
      }
    } catch (e) {
      print("Error fetching leave applications: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Leave Application")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Leave Type Dropdown
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Leave Type'),
                  value: selectedLeaveType,
                  items: leaveTypes.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedLeaveType = newValue;
                    });
                  },
                  validator: (value) => value == null ? 'Please select a leave type' : null,
                ),
                const SizedBox(height: 10),
                // Start Date Picker
                TextFormField(
                  readOnly: true,
                  decoration: const InputDecoration(labelText: 'Start Date'),
                  controller: TextEditingController(
                    text: startDate != null ? dateFormat.format(startDate!) : '',
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        startDate = pickedDate;
                      });
                    }
                  },
                  validator: (value) => value == null || value.isEmpty ? 'Please select Start Date' : null,
                ),
                const SizedBox(height: 10),
                // End Date Picker
                TextFormField(
                  readOnly: true,
                  decoration: const InputDecoration(labelText: 'End Date'),
                  controller: TextEditingController(
                    text: endDate != null ? dateFormat.format(endDate!) : '',
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        endDate = pickedDate;
                      });
                    }
                  },
                  validator: (value) => value == null || value.isEmpty ? 'Please select End Date' : null,
                ),
                const SizedBox(height: 10),
                // Number of Days
                TextFormField(
                  controller: daysController,
                  decoration: const InputDecoration(labelText: 'Number of Days'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter number of days' : null,
                ),
                const SizedBox(height: 10),
                // Application Date Picker
                TextFormField(
                  readOnly: true,
                  decoration: const InputDecoration(labelText: 'Application Date'),
                  controller: TextEditingController(
                    text: applicationDate != null ? dateFormat.format(applicationDate!) : '',
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        applicationDate = pickedDate;
                      });
                    }
                  },
                  validator: (value) => value == null || value.isEmpty ? 'Please select Application Date' : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      submitLeaveApplication();
                    }
                  },
                  child: const Text("Submit Leave Request"),
                ),
                const SizedBox(height: 20),
                // Display leave applications from the same department
                if (leaveApplications.isNotEmpty)
                  ...leaveApplications.map((application) {
                    return Card(
                      child: ListTile(
                        title: Text(application['leaveType']),
                        subtitle: Text('From: ${application['startDate']} To: ${application['endDate']}'),
                      ),
                    );
                  }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submitLeaveApplication() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User is not authenticated');
      }

      String employeeId = employeeIdController.text.isNotEmpty
          ? employeeIdController.text
          : user.uid;

      // Add the leave application to Firestore with the manager's department and username
      await FirebaseFirestore.instance.collection('leaveApplications').add({
        'leaveType': selectedLeaveType,
        'startDate': startDate != null ? dateFormat.format(startDate!) : null,
        'endDate': endDate != null ? dateFormat.format(endDate!) : null,
        'numberOfDays': int.tryParse(daysController.text),
        'applicationDate': applicationDate != null ? dateFormat.format(applicationDate!) : null,
        'email': employeeEmail,
        'status': 'pending',
        'userid': user.uid,
        'department': managerDepartment, // Add department to the application
        'username': username, // Add the username to the application
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Leave application submitted successfully!"),
          backgroundColor: Colors.green,
        ),
      );

      // Clear fields after submission
      setState(() {
        selectedLeaveType = null;
        startDate = null;
        endDate = null;
        applicationDate = null;
        leaveApplications = []; // Reset the displayed leave applications
      });
      daysController.clear();
      employeeIdController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to submit leave application"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
