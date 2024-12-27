import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({Key? key}) : super(key: key);

  @override
  _DeleteAccountPageState createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  // Variable to store the selected reason
  String? _selectedReason;

  // Firebase Authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to handle account deletion
  void _deleteAccount() async {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    try {
      // Delete the user account from Firebase
      User? user = _auth.currentUser;

      if (user != null) {
        // Perform the account deletion
        await user.delete();

        // Close the loading dialog
        Navigator.of(context).pop();

        // Show success dialog after deletion
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('Account Deleted'),
              content: Text('Your account has been successfully deleted.'),
            );
          },
        );
      } else {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user found. Please log in again.')),
        );
      }
    } catch (e) {
      Navigator.of(context).pop(); // Close the loading dialog
      // Handle any errors (e.g., user not logged in, network issue, etc.)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delete Account"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Please let us know why you're deleting your account:",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            RadioListTile<String>(
              title: const Text("I don't need the service anymore"),
              value: "No longer needed",
              groupValue: _selectedReason,
              onChanged: (String? value) {
                setState(() {
                  _selectedReason = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text("I found a better alternative"),
              value: "Found an alternative",
              groupValue: _selectedReason,
              onChanged: (String? value) {
                setState(() {
                  _selectedReason = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text("The service is not useful to me"),
              value: "Not useful",
              groupValue: _selectedReason,
              onChanged: (String? value) {
                setState(() {
                  _selectedReason = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text("Other reasons"),
              value: "Other",
              groupValue: _selectedReason,
              onChanged: (String? value) {
                setState(() {
                  _selectedReason = value;
                });
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _selectedReason == null
                  ? null // Disable button if no reason is selected
                  : _deleteAccount,
              child: const Text("Delete Account"),
            ),
          ],
        ),
      ),
    );
  }
}
