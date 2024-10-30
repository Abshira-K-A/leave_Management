// class LeaveStatusPage extends StatelessWidget {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final String? userEmail = FirebaseAuth.instance.currentUser?.email;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Leave Status")),
//       body: StreamBuilder(
//         stream: _firestore
//             .collection('leaveApplications')
//             .where('email', isEqualTo: userEmail)
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text("No leave applications found."));
//           }

//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               DocumentSnapshot doc = snapshot.data!.docs[index];
//               return ListTile(
//                 title: Text("${doc['leaveType']} - ${doc['numberOfDays']} days"),
//                 subtitle: Text("Start: ${doc['startDate']}, End: ${doc['endDate']}"),
//                 trailing: Text(
//                   doc['status'],
//                   style: TextStyle(
//                     color: doc['status'] == 'Approved'
//                         ? Colors.green
//                         : (doc['status'] == 'Rejected' ? Colors.red : Colors.orange),
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
