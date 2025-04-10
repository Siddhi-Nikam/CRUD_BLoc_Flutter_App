import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc/user_bloc_bloc.dart';
import 'bloc/bloc/user_bloc_event.dart';

class EditUserScreen extends StatefulWidget {
  final String userId;
  final String userName;
  final String userEmail;

  const EditUserScreen(
      {super.key,
      required this.userId,
      required this.userName,
      required this.userEmail});

  @override
  // ignore: library_private_types_in_public_api
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.userName);
    emailController = TextEditingController(text: widget.userEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit User"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: 'Name', border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: 'Email', border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final updatedName = nameController.text;
                final updatedEmail = emailController.text;

                // Dispatch the event to update user
                context.read<UserBloc>().add(UpdateUser(
                      widget.userId,
                      updatedName,
                      updatedEmail,
                    ));
                Navigator.pop(context); // Go back after updating
              },
              child: Text("Update User"),
            ),
          ],
        ),
      ),
    );
  }
}
