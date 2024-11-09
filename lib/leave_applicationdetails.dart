import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class LeaveApplicationDetailsPage extends StatelessWidget {
  final DocumentSnapshot leaveApplication;

  LeaveApplicationDetailsPage({super.key, required this.leaveApplication});

  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');

  // Function to update the leave request status
  Future<void> updateLeaveStatus(String leaveId, String status) async {
    try {
      await FirebaseFirestore.instance
          .collection('leaveApplications')
          .doc(leaveId)
          .update({'status': status});
    } catch (e) {
      print("Error updating leave status: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    String leaveType = leaveApplication['leaveType'] ?? 'N/A';
    String startDate = leaveApplication['startDate'] ?? 'N/A';
    String endDate = leaveApplication['endDate'] ?? 'N/A';
    String applicationDate = leaveApplication['applicationDate'] ?? 'N/A';
    String employeeEmail = leaveApplication['email'] ?? 'N/A';
    String status = leaveApplication['status'] ?? 'N/A';
    String leaveId = leaveApplication.id;

    // Convert the start and end date to DateTime to calculate the duration
    DateTime startDateTime = dateFormat.parse(startDate);
    DateTime endDateTime = dateFormat.parse(endDate);
    Duration leaveDuration = endDateTime.difference(startDateTime);

    // Fetch user details (e.g., firstName) based on email
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: employeeEmail) // Query based on the 'email' field
          .get(),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (userSnapshot.hasError) {
          return Center(child: Text('Error: ${userSnapshot.error}'));
        }

        if (userSnapshot.data == null || userSnapshot.data!.docs.isEmpty) {
          return const Center(child: Text('User not found'));
        }

        // Get the firstName from the user data
        String firstName = userSnapshot.data!.docs[0]['firstName'] ?? 'N/A';

        return Scaffold(
          appBar: AppBar(
            title: const Text('Leave Application Details'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Employee Name: $firstName', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Leave Type: $leaveType', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('Email: $employeeEmail'),
                Text('Leave Duration: ${leaveDuration.inDays} days'),
                Text('Start Date: $startDate'),
                Text('End Date: $endDate'),
                Text('Application Date: $applicationDate'),
                Text('Status: $status'),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: status == 'pending' ? () => _approveLeave(context, leaveId) : null,
                      child: const Text('Approve'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    ),
                    ElevatedButton(
                      onPressed: status == 'pending' ? () => _rejectLeave(context, leaveId) : null,
                      child: const Text('Reject'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Approve leave request
  void _approveLeave(BuildContext context, String leaveId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Approve Leave Request'),
          content: const Text('Are you sure you want to approve this leave request?'),
          actions: [
            TextButton(
              onPressed: () {
                updateLeaveStatus(leaveId, 'approved');
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Leave request approved')));
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  // Reject leave request
  void _rejectLeave(BuildContext context, String leaveId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reject Leave Request'),
          content: const Text('Are you sure you want to reject this leave request?'),
          actions: [
            TextButton(
              onPressed: () {
                updateLeaveStatus(leaveId, 'rejected');
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Leave request rejected')));
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
}
