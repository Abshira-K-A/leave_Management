import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'manager.dart';

class LeaveRequestPagee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leave Requests"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('leave_requests').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading leave requests"));
          }
          if (snapshot.data?.docs.isEmpty ?? true) {
            return const Center(child: Text("No leave requests available."));
          }

          final leaveRequests = snapshot.data!.docs;

          return ListView.builder(
            itemCount: leaveRequests.length,
            itemBuilder: (context, index) {
              var request = leaveRequests[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  title: Text("Leave Type: ${request['leaveType'] ?? 'Unknown'}"),
                  subtitle: Text(
                    "Employee: ${request['email']}\n"
                    "Duration: ${request['startDate']} to ${request['endDate']}\n"
                    "Status: ${request['status']}",
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check, color: Colors.green),
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('leave_requests')
                              .doc(request.id)
                              .update({
                                'status': 'approved',
                                'managerApproved': true,
                              });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('leave_requests')
                              .doc(request.id)
                              .update({
                                'status': 'rejected',
                                'managerApproved': false,
                              });
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
