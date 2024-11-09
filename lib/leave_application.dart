
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
  final TextEditingController employeeIdController = TextEditingController(); // Controller for Employee ID input
  String? employeeEmail; // To store employee email
  String? selectedLeaveType;
  final List<String> leaveTypes = ['Sick Leave', 'LOP', 'Casual Leave'];
  DateTime? startDate;
  DateTime? endDate;
  DateTime? applicationDate;
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');

  @override
  void initState() {
    super.initState();
    fetchUserEmail(); // Fetch email on page load
  }

  Future<void> fetchUserEmail() async {
    try {
      // Get the current user's ID
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Fetch the email from Firestore using the user ID
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        
        setState(() {
          employeeEmail = userDoc['email']; // Store the email
        });
      }
    } catch (e) {
      print("Error fetching user email: $e");
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
                // Employee ID (Text Field)
                // TextFormField(
                //   controller: employeeIdController, // Use the controller to capture input
                //   decoration: const InputDecoration(labelText: 'Employee ID'),
                //   keyboardType: TextInputType.text,
                //   validator: (value) => value == null || value.isEmpty ? 'Please enter Employee ID' : null,
                // ),
                // const SizedBox(height: 10),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submitLeaveApplication() async {
    try {
      // Get the current user's ID (employee ID)
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User is not authenticated');
      }

      String employeeId = employeeIdController.text.isNotEmpty
          ? employeeIdController.text
          : user.uid; // Use the entered Employee ID or fallback to Firebase UID

      // Add the leave application to the Firestore 'leaveApplications' collection
      await FirebaseFirestore.instance.collection('leaveApplications').add({
        'leaveType': selectedLeaveType,
        'startDate': startDate != null ? dateFormat.format(startDate!) : null,
        'endDate': endDate != null ? dateFormat.format(endDate!) : null,
        'numberOfDays': int.tryParse(daysController.text),
        'applicationDate': applicationDate != null ? dateFormat.format(applicationDate!) : null,
        // 'employeeId': employeeId, // Store employee ID
        'email': employeeEmail, // Store the employee email
        'status': 'pending', // Set initial status as pending
        'userid': user.uid, // Store the currently logged-in user's ID
      });

      // Show success message
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
      });
      daysController.clear();
      employeeIdController.clear(); // Clear the Employee ID field as well
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to submit leave application. Please try again."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

