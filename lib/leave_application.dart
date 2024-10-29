// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class LeaveApplicationPage extends StatefulWidget {
//   @override
//   _LeaveApplicationPageState createState() => _LeaveApplicationPageState();
// }

// class _LeaveApplicationPageState extends State<LeaveApplicationPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController leaveTimeController = TextEditingController();
//   final TextEditingController endTimeController = TextEditingController(); // Added controller for end date
//   final TextEditingController daysController = TextEditingController();
//   final TextEditingController applicationDateController = TextEditingController(); // Added controller for application date
//   final TextEditingController notesController = TextEditingController();

//   // Dropdown items for leave type
//   String? selectedLeaveType;
//   final List<String> leaveTypes = ['Sick Leave', 'LOP', 'Casual Leave'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Leave Application")),
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
//                   validator: (value) {
//                     if (value == null) {
//                       return 'Please select a leave type';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: leaveTimeController,
//                   decoration: const InputDecoration(labelText: 'Start Date'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter Start Date';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: endTimeController, // Assign the controller for end date
//                   decoration: const InputDecoration(labelText: 'End Date'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter End Date';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: daysController,
//                   decoration: const InputDecoration(labelText: 'Number of Days'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter number of days';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: applicationDateController, // Assign the controller for application date
//                   decoration: const InputDecoration(labelText: 'Application Date'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter Application Date';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: notesController,
//                   decoration: const InputDecoration(labelText: 'Notes'),
//                   maxLines: 3,
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
//       await FirebaseFirestore.instance.collection('leaveApplications').add({
//         'leaveType': selectedLeaveType,
//         'startDate': leaveTimeController.text,
//         'endDate': endTimeController.text, // Include endDate
//         'numberOfDays': daysController.text,
//         'applicationDate': applicationDateController.text, // Include applicationDate
//         'notes': notesController.text,
//       });

//       // Show a SnackBar for successful submission
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: const Text("Leave application submitted successfully!"),
//           backgroundColor: Colors.green,
//         ),
//       );

//       // Clear the form fields after submission
//       leaveTimeController.clear();
//       endTimeController.clear(); // Clear the end date controller
//       daysController.clear();
//       applicationDateController.clear(); // Clear the application date controller
//       notesController.clear();
//       selectedLeaveType = null;
//     } catch (e) {
//       // Handle error
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: const Text("Failed to submit leave application. Please try again."),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class LeaveApplicationPage extends StatefulWidget {
  @override
  _LeaveApplicationPageState createState() => _LeaveApplicationPageState();
}

class _LeaveApplicationPageState extends State<LeaveApplicationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController daysController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  // Dropdown items for leave type
  String? selectedLeaveType;
  final List<String> leaveTypes = ['Sick Leave', 'LOP', 'Casual Leave'];

  // Date fields
  DateTime? startDate;
  DateTime? endDate;
  DateTime? applicationDate;

  // Format for displaying dates
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Leave Application")),
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
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a leave type';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select Start Date';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select End Date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Number of Days
                TextFormField(
                  controller: daysController,
                  decoration: const InputDecoration(labelText: 'Number of Days'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter number of days';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select Application Date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Notes
                TextFormField(
                  controller: notesController,
                  decoration: const InputDecoration(labelText: 'Notes'),
                  maxLines: 3,
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
      await FirebaseFirestore.instance.collection('leaveApplications').add({
        'leaveType': selectedLeaveType,
        'startDate': startDate != null ? dateFormat.format(startDate!) : null,
        'endDate': endDate != null ? dateFormat.format(endDate!) : null,
        'numberOfDays': int.tryParse(daysController.text),
        'applicationDate': applicationDate != null ? dateFormat.format(applicationDate!) : null,
        'notes': notesController.text,
      });

      // Show a SnackBar for successful submission
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Leave application submitted successfully!"),
          backgroundColor: Colors.green,
        ),
      );

      // Clear the form fields after submission
      setState(() {
        selectedLeaveType = null;
        startDate = null;
        endDate = null;
        applicationDate = null;
      });
      daysController.clear();
      notesController.clear();
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Failed to submit leave application. Please try again."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
