import 'package:flutter/material.dart';

// Assuming you have EmployeePage, HRPage, and ManagerPage widgets
import 'employee.dart'; // Import your EmployeePage widget
import 'hr.dart'; // Import your HRPage widget
import 'manager.dart'; // Import your ManagerPage widget

class HomePage extends StatefulWidget {
  final String userRole; // 'employee', 'hr', or 'manager'

  const HomePage({super.key, required this.userRole});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateBasedOnRole();
    });
  }

  void _navigateBasedOnRole() {
    if (widget.userRole == 'Employee') {
      // Navigate to EmployeePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Employee()),
      );
    } else if (widget.userRole == 'HR') {
      // Navigate to HRPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HR()),
      );
    } else if (widget.userRole == 'Manager') {
      // Navigate to ManagerPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Manager()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // You can return a temporary placeholder widget while routing happens.
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage"),
      ),
      body: const Center(
        child: CircularProgressIndicator(), // Loading indicator while routing
      ),
    );
  }
}
