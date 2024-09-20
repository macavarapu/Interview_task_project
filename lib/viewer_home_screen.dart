// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:interview_task_project/profile_screen.dart';

// // class ViewerHomeScreen extends StatelessWidget {
// //   final User user;

// //   ViewerHomeScreen({required this.user});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Viewer Home')),
// //       drawer: Drawer(
// //         child: ListView(
// //           children: [
// //             ListTile(
// //               title: Text('Profile'),
// //               onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(user: user))),
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
// //         stream: FirebaseFirestore.instance.collection('users').where('role', isEqualTo: 'viewer').snapshots(),
// //         builder: (context, snapshot) {
// //           if (!snapshot.hasData) {
// //             return CircularProgressIndicator();
// //           }
// //           final viewers = snapshot.data!.docs;
// //           return ListView.builder(
// //             itemCount: viewers.length,
// //             itemBuilder: (context, index) {
// //               final viewer = viewers[index];
// //               return ListTile(
// //                 title: Text(viewer['name']),
// //                 subtitle: Text('Email: ${viewer['email']}'),
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:interview_task_project/profile_screen.dart';

// class ViewerHomeScreen extends StatelessWidget {
//   final User user;

//   ViewerHomeScreen({required this.user});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Viewer Home')),
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
//       body: Center(
//         child: Text('Welcome, ${user.email}!'), // Display viewer-specific info here
//       ),
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:interview_task_project/profile_screen.dart';

class ViewerHomeScreen extends StatelessWidget {
  final User user;

  ViewerHomeScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Viewer Home'),
        backgroundColor: Colors.amber,
        ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user.displayName ?? 'Viewer'),
              accountEmail: Text(user.email!),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(user.displayName != null && user.displayName!.isNotEmpty
                    ? user.displayName![0]
                    : 'V'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person,size: 20,color: Colors.black,),
              title: Text('Profile'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen(user: user)),
              ),
            ),
            ListTile(
              leading: Icon(Icons.login_outlined,size: 20,color: Colors.red,),
              title: Text('Logout'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
     
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${user.displayName ?? 'Viewer'}!'),
            SizedBox(height: 20),
            Card(
              child: Text('Email: ${user.email}')),
          ],
        ),
      ),
    );
  }
}
