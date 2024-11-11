// // import 'package:flutter/material.dart';

// // class ManagerLeaveRequest extends StatefulWidget {
// //   const ManagerLeaveRequest({super.key});

// //   @override
// //   State<ManagerLeaveRequest> createState() => _ManagerLeaveRequestState();
// // }

// // class _ManagerLeaveRequestState extends State<ManagerLeaveRequest> {
// //   final _formKey = GlobalKey<FormState>();
// //   final TextEditingController _leaveTypeController = TextEditingController();
// //   final TextEditingController _startDateController = TextEditingController();
// //   final TextEditingController _endDateController = TextEditingController();
// //   final TextEditingController _reasonController = TextEditingController();

// //   @override
// //   void dispose() {
// //     _leaveTypeController.dispose();
// //     _startDateController.dispose();
// //     _endDateController.dispose();
// //     _reasonController.dispose();
// //     super.dispose();
// //   }

// //   Future<void> _submitLeaveRequest() async {
// //     if (_formKey.currentState!.validate()) {
// //       // Logic to submit the leave request
// //       // You can add code here to send the data to Firestore or any backend service

// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Leave request submitted successfully!')),
// //       );
// //       Navigator.pop(context);
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Request Leave'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Form(
// //           key: _formKey,
// //           child: ListView(
// //             children: [
// //               TextFormField(
// //                 controller: _leaveTypeController,
// //                 decoration: const InputDecoration(
// //                   labelText: 'Leave Type',
// //                   border: OutlineInputBorder(),
// //                 ),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter the leave type';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               const SizedBox(height: 16),
// //               TextFormField(
// //                 controller: _startDateController,
// //                 decoration: const InputDecoration(
// //                   labelText: 'Start Date',
// //                   hintText: 'YYYY-MM-DD',
// //                   border: OutlineInputBorder(),
// //                 ),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter the start date';
// //                   }
// //                   return null;
// //                 },
// //                 onTap: () async {
// //                   FocusScope.of(context).requestFocus(FocusNode());
// //                   DateTime? pickedDate = await showDatePicker(
// //                     context: context,
// //                     initialDate: DateTime.now(),
// //                     firstDate: DateTime(2000),
// //                     lastDate: DateTime(2100),
// //                   );
// //                   if (pickedDate != null) {
// //                     _startDateController.text = pickedDate.toIso8601String().split('T').first;
// //                   }
// //                 },
// //               ),
// //               const SizedBox(height: 16),
// //               TextFormField(
// //                 controller: _endDateController,
// //                 decoration: const InputDecoration(
// //                   labelText: 'End Date',
// //                   hintText: 'YYYY-MM-DD',
// //                   border: OutlineInputBorder(),
// //                 ),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter the end date';
// //                   }
// //                   return null;
// //                 },
// //                 onTap: () async {
// //                   FocusScope.of(context).requestFocus(FocusNode());
// //                   DateTime? pickedDate = await showDatePicker(
// //                     context: context,
// //                     initialDate: DateTime.now(),
// //                     firstDate: DateTime(2000),
// //                     lastDate: DateTime(2100),
// //                   );
// //                   if (pickedDate != null) {
// //                     _endDateController.text = pickedDate.toIso8601String().split('T').first;
// //                   }
// //                 },
// //               ),
// //               const SizedBox(height: 16),
// //               TextFormField(
// //                 controller: _reasonController,
// //                 maxLines: 4,
// //                 decoration: const InputDecoration(
// //                   labelText: 'Reason',
// //                   border: OutlineInputBorder(),
// //                 ),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter the reason for leave';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               const SizedBox(height: 24),
// //               ElevatedButton(
// //                 onPressed: _submitLeaveRequest,
// //                 child: const Text('Submit Request'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // For Firebase Auth
// import 'package:intl/intl.dart';

// class ManagerLeaveApplicationPage extends StatefulWidget {
//   @override
//   _ManagerLeaveApplicationPageState createState() => _ManagerLeaveApplicationPageState();
// }

// class _ManagerLeaveApplicationPageState extends State<ManagerLeaveApplicationPage> {
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
//   String? username; // To store username
//   String? employeeId; // To store employee ID

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
//           username = userDoc['firstName']; // Assuming it's firstName
//           employeeId = user.uid; // Assuming employee ID is the Firebase user ID
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
//         DocumentSnapshot userDoc = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(user.uid)
//             .get();

//         setState(() {
//           managerDepartment = userDoc['department']; // Assuming the field is named 'department'
//         });
//       }
//     } catch (e) {
//       print("Error fetching manager department: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Manager Leave Application")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
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
//                 TextFormField(
//                   controller: daysController,
//                   decoration: const InputDecoration(labelText: 'Number of Days'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) => value == null || value.isEmpty ? 'Please enter number of days' : null,
//                 ),
//                 const SizedBox(height: 10),
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

//       await FirebaseFirestore.instance.collection('managerLeaveApplications').add({
//         'leaveType': selectedLeaveType,
//         'startDate': startDate != null ? dateFormat.format(startDate!) : null,
//         'endDate': endDate != null ? dateFormat.format(endDate!) : null,
//         'numberOfDays': int.tryParse(daysController.text),
//         'applicationDate': applicationDate != null ? dateFormat.format(applicationDate!) : null,
//         'email': employeeEmail,
//         'userid': user.uid,
//         'department': managerDepartment,
//         'username': username,
//         'hrStatus': 'Pending',
//       });

//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Leave Request Submitted'),
//             content: const Text('Your leave request has been successfully submitted.'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     } catch (e) {
//       print("Error submitting leave application: $e");
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // For Firebase Auth
import 'package:intl/intl.dart';

class ManagerLeaveApplicationPage extends StatefulWidget {
  @override
  _ManagerLeaveApplicationPageState createState() => _ManagerLeaveApplicationPageState();
}

class _ManagerLeaveApplicationPageState extends State<ManagerLeaveApplicationPage> {
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
  String? username; // To store username
  String? employeeId; // To store employee ID

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
          username = userDoc['firstName']; // Assuming it's firstName
          employeeId = user.uid; // Assuming employee ID is the Firebase user ID
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
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        setState(() {
          managerDepartment = userDoc['department']; // Assuming the field is named 'department'
        });
      }
    } catch (e) {
      print("Error fetching manager department: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manager Leave Application")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
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
                TextFormField(
                  controller: daysController,
                  decoration: const InputDecoration(labelText: 'Number of Days'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter number of days' : null,
                ),
                const SizedBox(height: 10),
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

      await FirebaseFirestore.instance.collection('managerLeaveApplications').add({
        'leaveType': selectedLeaveType,
        'startDate': startDate != null ? dateFormat.format(startDate!) : null,
        'endDate': endDate != null ? dateFormat.format(endDate!) : null,
        'numberOfDays': int.tryParse(daysController.text),
        'applicationDate': applicationDate != null ? dateFormat.format(applicationDate!) : null,
        'email': employeeEmail,
        'userid': user.uid,
        'department': managerDepartment,
        'username': username,
        'hrStatus': 'Pending',
      });

      // Show a success SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Leave request submitted successfully!'),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );

      // Optionally, clear the form fields after submission
      setState(() {
        selectedLeaveType = null;
        startDate = null;
        endDate = null;
        applicationDate = null;
        daysController.clear();
      });
    } catch (e) {
      print("Error submitting leave application: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Error submitting leave request. Please try again.'),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
