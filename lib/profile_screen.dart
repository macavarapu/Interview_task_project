// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class ProfileScreen extends StatefulWidget {
//   final User user;
//   ProfileScreen({required this.user});

//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   String currentPassword = '';
//   String newPassword = '';

//   void _changePassword() async {
//     User user = FirebaseAuth.instance.currentUser!;
//     AuthCredential credential = EmailAuthProvider.credential(email: user.email!, password: currentPassword);

//     try {
//       await user.reauthenticateWithCredential(credential);
//       await user.updatePassword(newPassword);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password changed successfully')));
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to change password: $e')));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Profile')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Current Password'),
//               obscureText: true,
//               onChanged: (val) => currentPassword = val,
//             ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'New Password'),
//               obscureText: true,
//               onChanged: (val) => newPassword = val,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _changePassword,
//               child: Text('Change Password'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// // }





// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'login_screen.dart'; // Import your login screen

// class ProfileScreen extends StatefulWidget {
//   final User user;

//   ProfileScreen({required this.user});

//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   String currentPassword = '';
//   String newPassword = '';
//   bool _showCurrentPassword = false;
//   bool _showNewPassword = false;

//   void _changePassword() async {
//     User user = FirebaseAuth.instance.currentUser!;
//     AuthCredential credential = EmailAuthProvider.credential(
//       email: user.email!,
//       password: currentPassword,
//     );

//     try {
//       await user.reauthenticateWithCredential(credential);
//       await user.updatePassword(newPassword);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Password changed successfully')),
//       );
      
//       // Navigate to login screen after changing password
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => LoginScreen()),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to change password: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('Profile'),
//         backgroundColor: Colors.amber,
//         ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextFormField(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20)
//                 ),
//                 labelText: 'Current Password',
//                suffixIcon: IconButton(
//                 icon: Icon(
//                   _showCurrentPassword ? Icons.visibility : Icons.visibility_off,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     _showCurrentPassword = !_showCurrentPassword;
//                   });
//                 },
//               ),
//               ),
//               obscureText: !_showCurrentPassword,
//               onChanged: (val) => currentPassword = val,
             
//             ),
//             SizedBox(height: 20,),
//             TextFormField(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 labelText: 'New Password',
//                suffixIcon: IconButton(
//                 icon: Icon(
//                   _showNewPassword ? Icons.visibility : Icons.visibility_off,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     _showNewPassword = !_showNewPassword;
//                   });
//                 },
//               ),
//               ),
//               obscureText: !_showNewPassword,
//               onChanged: (val) => newPassword = val,
             
//             ),
//             SizedBox(height: 40),
//              Container(
//                 height: 50,
//                 width: 200,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   color: Colors.purple,
//                 ),
//                // width: MediaQuery.of(context).size.width,
//                 //color: Colors.purple,
//                 child: TextButton(
//                   onPressed: _changePassword, 
//                   child: Text('Change Password',style: TextStyle(fontSize: 15,color: Colors.white),),
//                   ),
//               ),
            
//             // ElevatedButton(
//             //   onPressed: _changePassword,
//             //   child: Text('Change Password'),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import your login screen

class ProfileScreen extends StatefulWidget {
  final User user;

  ProfileScreen({required this.user});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String currentPassword = '';
  String newPassword = '';
  bool _showCurrentPassword = false;
  bool _showNewPassword = false;

  // Function to display the confirmation dialog
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Password'),
          content: Text('Are you sure you want to change your password?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _changePassword(); // Call the change password function
              },
            ),
          ],
        );
      },
    );
  }

  // Function to change the password
  void _changePassword() async {
    User user = FirebaseAuth.instance.currentUser!;
    AuthCredential credential = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );

    try {
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password changed successfully')),
      );

      // Navigate to the login screen after changing the password
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to change password: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
         
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)),
                labelText: 'Current Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _showCurrentPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _showCurrentPassword = !_showCurrentPassword;
                    });
                  },
                ),
              ),
              obscureText: !_showCurrentPassword,
              onChanged: (val) => currentPassword = val,
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)),
                labelText: 'New Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _showNewPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _showNewPassword = !_showNewPassword;
                    });
                  },
                ),
              ),
              obscureText: !_showNewPassword,
              onChanged: (val) => newPassword = val,
            ),
            SizedBox(height: 40),
            Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.purple,
              ),
              child: TextButton(
                onPressed: () {
                  _showConfirmationDialog(); // Show confirmation dialog
                },
                child: Text(
                  'Change Password',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
