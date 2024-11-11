import 'package:flutter/material.dart';

class ManagerLeaveRequest extends StatefulWidget {
  const ManagerLeaveRequest({super.key});

  @override
  State<ManagerLeaveRequest> createState() => _ManagerLeaveRequestState();
}

class _ManagerLeaveRequestState extends State<ManagerLeaveRequest> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _leaveTypeController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    _leaveTypeController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _submitLeaveRequest() async {
    if (_formKey.currentState!.validate()) {
      // Logic to submit the leave request
      // You can add code here to send the data to Firestore or any backend service

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Leave request submitted successfully!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Leave'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _leaveTypeController,
                decoration: const InputDecoration(
                  labelText: 'Leave Type',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the leave type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _startDateController,
                decoration: const InputDecoration(
                  labelText: 'Start Date',
                  hintText: 'YYYY-MM-DD',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the start date';
                  }
                  return null;
                },
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    _startDateController.text = pickedDate.toIso8601String().split('T').first;
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _endDateController,
                decoration: const InputDecoration(
                  labelText: 'End Date',
                  hintText: 'YYYY-MM-DD',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the end date';
                  }
                  return null;
                },
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    _endDateController.text = pickedDate.toIso8601String().split('T').first;
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _reasonController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Reason',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the reason for leave';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitLeaveRequest,
                child: const Text('Submit Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
