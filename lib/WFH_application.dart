// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class WorkFromHomePage extends StatefulWidget {
//   const WorkFromHomePage({super.key});

//   @override
//   _WorkFromHomePageState createState() => _WorkFromHomePageState();
// }

// class _WorkFromHomePageState extends State<WorkFromHomePage> {
//   final _formKey = GlobalKey<FormState>(); // Key to identify the form
//   final _reasonController = TextEditingController(); // Controller for reason field
//   final _startDateController = TextEditingController(); // Controller for start date field
//   final _endDateController = TextEditingController(); // Controller for end date field

//   // Function to submit the WFH request to Firestore
//   Future<void> _submitRequest() async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         // Add WFH request to Firestore
//         await FirebaseFirestore.instance.collection('workFromHomeRequests').add({
//           'reason': _reasonController.text,
//           'startDate': _startDateController.text,
//           'endDate': _endDateController.text,
//           'status': 'pending', // Initially, the request is pending
//           'timestamp': FieldValue.serverTimestamp(),
//         });

//         // Show success message
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Work from Home request submitted successfully')),
//         );

//         // Clear the form after submission
//         _reasonController.clear();
//         _startDateController.clear();
//         _endDateController.clear();
//       } catch (e) {
//         // Handle error
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Error submitting request')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Work from Home Request"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(  // Ensuring form is scrollable
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Reason for Work from Home
//                 TextFormField(
//                   controller: _reasonController,
//                   decoration: const InputDecoration(
//                     labelText: 'Reason for Work from Home',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the reason';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),

//                 // Start Date for WFH
//                 TextFormField(
//                   controller: _startDateController,
//                   decoration: const InputDecoration(
//                     labelText: 'Start Date (e.g., 01-01-2024)',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.datetime,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the start date';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),

//                 // End Date for WFH
//                 TextFormField(
//                   controller: _endDateController,
//                   decoration: const InputDecoration(
//                     labelText: 'End Date (e.g., 01-02-2024)',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.datetime,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the end date';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 24),

//                 // Submit button
//                 ElevatedButton(
//                   onPressed: _submitRequest,
//                   child: const Text('Submit Request'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class WorkFromHomePage extends StatefulWidget {
//   const WorkFromHomePage({super.key});

//   @override
//   _WorkFromHomePageState createState() => _WorkFromHomePageState();
// }

// class _WorkFromHomePageState extends State<WorkFromHomePage> {
//   final _formKey = GlobalKey<FormState>(); // Key to identify the form
//   final _reasonController = TextEditingController(); // Controller for reason field
//   final _startDateController = TextEditingController(); // Controller for start date field
//   final _endDateController = TextEditingController(); // Controller for end date field

//   // Function to submit the WFH request to Firestore
//   Future<void> _submitRequest() async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         // Add WFH request to Firestore
//         await FirebaseFirestore.instance.collection('workFromHomeRequests').add({
//           'reason': _reasonController.text,
//           'startDate': _startDateController.text,
//           'endDate': _endDateController.text,
//           'status': 'pending', // Initially, the request is pending
//           'timestamp': FieldValue.serverTimestamp(),
//         });

//         // Show success message
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Work from Home request submitted successfully')),
//         );

//         // Clear the form after submission
//         _reasonController.clear();
//         _startDateController.clear();
//         _endDateController.clear();
//       } catch (e) {
//         // Handle error
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Error submitting request')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Work from Home Request"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(  // Ensuring form is scrollable
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Reason for Work from Home
//                 TextFormField(
//                   controller: _reasonController,
//                   decoration: const InputDecoration(
//                     labelText: 'Reason for Work from Home',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the reason';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),

//                 // Start Date for WFH
//                 TextFormField(
//                   controller: _startDateController,
//                   decoration: const InputDecoration(
//                     labelText: 'Start Date (e.g., 01-01-2024)',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.datetime,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the start date';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),

//                 // End Date for WFH
//                 TextFormField(
//                   controller: _endDateController,
//                   decoration: const InputDecoration(
//                     labelText: 'End Date (e.g., 01-02-2024)',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.datetime,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the end date';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 24),

//                 // Submit button
//                 ElevatedButton(
//                   onPressed: _submitRequest,
//                   child: const Text('Submit Request'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class WorkFromHomePage extends StatefulWidget {
//   const WorkFromHomePage({super.key});

//   @override
//   _WorkFromHomePageState createState() => _WorkFromHomePageState();
// }

// class _WorkFromHomePageState extends State<WorkFromHomePage> {
//   final _formKey = GlobalKey<FormState>(); // Key to identify the form
//   final _reasonController = TextEditingController(); // Controller for reason field
//   final _startDateController = TextEditingController(); // Controller for start date field
//   final _endDateController = TextEditingController(); // Controller for end date field

//   // Function to submit the WFH request to Firestore
//   Future<void> _submitRequest() async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         // Add WFH request to Firestore
//         await FirebaseFirestore.instance.collection('workFromHomeRequests').add({
//           'reason': _reasonController.text,
//           'startDate': _startDateController.text,
//           'endDate': _endDateController.text,
//           'status': 'pending', // Initially, the request is pending
//           'timestamp': FieldValue.serverTimestamp(),
//         });

//         // Show success message
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Work from Home request submitted successfully')),
//         );

//         // Clear the form after submission
//         _reasonController.clear();
//         _startDateController.clear();
//         _endDateController.clear();
//       } catch (e) {
//         // Handle error
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Error submitting request')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Work from Home Request"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(  // Ensuring form is scrollable
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Reason for Work from Home
//                 TextFormField(
//                   controller: _reasonController,
//                   decoration: const InputDecoration(
//                     labelText: 'Reason for Work from Home',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the reason';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),

//                 // Start Date for WFH
//                 TextFormField(
//                   controller: _startDateController,
//                   decoration: const InputDecoration(
//                     labelText: 'Start Date (e.g., 01-01-2024)',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.datetime,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the start date';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),

//                 // End Date for WFH
//                 TextFormField(
//                   controller: _endDateController,
//                   decoration: const InputDecoration(
//                     labelText: 'End Date (e.g., 01-02-2024)',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.datetime,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the end date';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 24),

//                 // Submit button
//                 ElevatedButton(
//                   onPressed: _submitRequest,
//                   child: const Text('Submit Request'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WorkFromHomePage extends StatefulWidget {
  const WorkFromHomePage({super.key});

  @override
  _WorkFromHomePageState createState() => _WorkFromHomePageState();
}

class _WorkFromHomePageState extends State<WorkFromHomePage> {
  final _formKey = GlobalKey<FormState>(); // Key to identify the form
  final _reasonController = TextEditingController(); // Controller for reason field
  final _startDateController = TextEditingController(); // Controller for start date field
  final _endDateController = TextEditingController(); // Controller for end date field

  // Function to show date picker and set the selected date
  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      });
    }
  }

  // Function to submit the WFH request to Firestore
  Future<void> _submitRequest() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Add WFH request to Firestore
        await FirebaseFirestore.instance.collection('workFromHomeRequests').add({
          'reason': _reasonController.text,
          'startDate': _startDateController.text,
          'endDate': _endDateController.text,
          'status': 'pending', // Initially, the request is pending
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Work from Home request submitted successfully')),
        );

        // Clear the form after submission
        _reasonController.clear();
        _startDateController.clear();
        _endDateController.clear();
      } catch (e) {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error submitting request')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Work from Home Request"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(  // Ensuring form is scrollable
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Reason for Work from Home
                TextFormField(
                  controller: _reasonController,
                  decoration: const InputDecoration(
                    labelText: 'Reason for Work from Home',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the reason';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Start Date for WFH
                TextFormField(
                  controller: _startDateController,
                  decoration: const InputDecoration(
                    labelText: 'Start Date',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true, // Prevents keyboard from appearing
                  onTap: () {
                    _selectDate(context, _startDateController);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the start date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // End Date for WFH
                TextFormField(
                  controller: _endDateController,
                  decoration: const InputDecoration(
                    labelText: 'End Date',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true, // Prevents keyboard from appearing
                  onTap: () {
                    _selectDate(context, _endDateController);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the end date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Submit button
                ElevatedButton(
                  onPressed: _submitRequest,
                  child: const Text('Submit Request'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
