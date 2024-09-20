// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AddUserDialog extends StatefulWidget {
//   @override
//   _AddUserDialogState createState() => _AddUserDialogState();
// }

// class _AddUserDialogState extends State<AddUserDialog> {
//   String name = '';
//   String email = '';
//   String password = '';
//   String role = 'Viewer';

//   void _addUser() async {
//     if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
//       await FirebaseFirestore.instance.collection('users').add({
//         'name': name,
//         'email': email,
//         'password': password,  // Note: Save passwords securely (hashed)
//         'role': role,
//       });
//       Navigator.pop(context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Add User'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextFormField(
//             decoration: InputDecoration(labelText: 'Name'),
//             onChanged: (val) => name = val,
//           ),
//           TextFormField(
//             decoration: InputDecoration(labelText: 'Email'),
//             onChanged: (val) => email = val,
//           ),
//           TextFormField(
//             decoration: InputDecoration(labelText: 'Password'),
//             onChanged: (val) => password = val,
//           ),
//           DropdownButtonFormField(
//             value: role,
//             items: ['Admin', 'Viewer'].map((role) {
//               return DropdownMenuItem(value: role, child: Text(role));
//             }).toList(),
//             onChanged: (val) => setState(() => role = val as String),
//           ),
//         ],
//       ),
//       actions: [
//         ElevatedButton(
//           onPressed: _addUser,
//           child: Text('Submit'),
//         ),
//       ],
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddViewerDialog extends StatefulWidget {
  @override
  _AddViewerDialogState createState() => _AddViewerDialogState();
}

class _AddViewerDialogState extends State<AddViewerDialog> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  // void _addViewer() async {
  //   try {
  //     UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
  //       email: _emailController.text,
  //       password: _passwordController.text,
  //     );
  //     await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
  //       'name': _emailController.text.split('@')[0],
  //       'email': _emailController.text,
  //       'role': 'viewer',
  //     });
  //     Navigator.pop(context);
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error adding viewer: $e')));
  //   }
  // }

void _addViewer() async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
    await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
      'name': _emailController.text.split('@')[0],
      'email': _emailController.text,
      'role': 'viewer',
    });
    
    // Viewer added successfully
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Viewer added successfully!'),
        backgroundColor: Colors.green, // Green for success
      ),
    );
    Navigator.pop(context); // Close the dialog after successful addition
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error adding viewer: ${e.toString()}'),
        backgroundColor: Colors.red, // Red for error
      ),
    );
  }
}




  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Viewer'),
      backgroundColor: Colors.amber,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
        ],
      ),
      actions: [
        ElevatedButton(onPressed: _addViewer, child: Text('Add Viewer')),
      ],
    );
  }
}
