// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:interview_task_project/add_user.dart';
// // import 'profile_screen.dart';

// // class HomeScreen extends StatelessWidget {
// //   final User user;
// //   HomeScreen({required this.user});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Home')),
// //       drawer: Drawer(
// //         child: ListView(
// //           children: [
// //             ListTile(
// //               title: Text('Profile'),
// //               onTap: () {
// //                 Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(user: user)));
// //               },
// //             ),
// //             ListTile(
// //               title: Text('Logout'),
// //               onTap: () async {
// //                 await FirebaseAuth.instance.signOut();
// //                 Navigator.popUntil(context, (route) => route.isFirst);
// //               },
// //             ),
// //           ],
// //         ),
// //       ),
// //       body: StreamBuilder<QuerySnapshot>(
// //         stream: FirebaseFirestore.instance.collection('users').snapshots(),
// //         builder: (context, snapshot) {
// //           if (!snapshot.hasData) {
// //             return CircularProgressIndicator();
// //           }
// //           final users = snapshot.data!.docs;
// //           return ListView.builder(
// //             itemCount: users.length,
// //             itemBuilder: (context, index) {
// //               final user = users[index];
// //               return ListTile(
// //                 title: Text(user['name']),
// //                 subtitle: Text('Role: ${user['role']}'),
// //               );
// //             },
// //           );
// //         },
// //       ),
// //       floatingActionButton: user.email == 'admin@example.com' ? FloatingActionButton(
// //         onPressed: () {
// //           showDialog(
// //             context: context,
// //             builder: (context) => AddUserDialog(),
// //           );
// //         },
// //         child: Icon(Icons.add),
// //       ) : null,
// //     );
// //   }
// // }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:interview_task_project/add_user.dart'; // Ensure this is defined
// import 'package:interview_task_project/profile_screen.dart';

// class AdminHomeScreen extends StatelessWidget {
//   final User user;

//   AdminHomeScreen({required this.user});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Admin Home')),
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             ListTile(
//               title: Text('Profile'),
//               onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(user: user))),
//             ),
//             ListTile(
//               title: Text('Logout'),
//               onTap: () async {
//                 await FirebaseAuth.instance.signOut();
//                 Navigator.pushReplacementNamed(context, '/login'); // Ensure you navigate to login
//               },
//             ),
//           ],
//         ),
//       ),
//       body:Center(
//         child: Text('Welcome, ${user.email}!'), // Display viewer-specific info here
//       ),
//       //  StreamBuilder<QuerySnapshot>(
//       //   stream: FirebaseFirestore.instance.collection('users').where('role', isEqualTo: 'viewer').snapshots(),
//       //   builder: (context, snapshot) {
//       //     if (!snapshot.hasData) {
//       //       return Center(child: CircularProgressIndicator());
//       //     }
//       //     final viewers = snapshot.data!.docs;
//       //     return ListView.builder(
//       //       itemCount: viewers.length,
//       //       itemBuilder: (context, index) {
//       //         final viewer = viewers[index];
//       //         return ListTile(
//       //           title: Text(viewer['name']),
//       //           subtitle: Text('Email: ${viewer['email']}'),
//       //         );
//       //       },
//       //     );
//       //   },
//       // ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (context) => AddViewerDialog(),
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interview_task_project/add_user.dart'; // Ensure this is defined
import 'package:interview_task_project/profile_screen.dart';

class AdminHomeScreen extends StatelessWidget {
  final User user;

  AdminHomeScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Home')),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user.displayName ?? 'Admin'), // Ensure this is set when the user is created
              accountEmail: Text(user.email!),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(user.displayName != null && user.displayName!.isNotEmpty
                    ? user.displayName![0]
                    : 'A'),
              ),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen(user: user)),
              ),
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').where('role', isEqualTo: 'viewer').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No viewers found.'));
          }
          final viewers = snapshot.data!.docs;
          return ListView.builder(
            itemCount: viewers.length,
            itemBuilder: (context, index) {
              final viewer = viewers[index];
              return ListTile(
                title: Text(viewer['name']),
                subtitle: Text('Email: ${viewer['email']}'),
                
              );
            },
          );
        },
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddViewerDialog(),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}