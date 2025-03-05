import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc/user_bloc_bloc.dart';
import 'bloc/bloc/user_bloc_event.dart';
import 'bloc/bloc/user_bloc_state.dart';

class AddNewUser extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  AddNewUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New User'),
        backgroundColor: Colors.lightBlue,
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("User added successfully!"),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          } else if (state is UserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Failed to add user: ${state.message}"),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final name = nameController.text.trim();
                  final email = emailController.text.trim();

                  if (name.isEmpty || email.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please fill in all fields"),
                        backgroundColor: Colors.orange,
                      ),
                    );
                    return;
                  }
                  context.read<UserBloc>().add(AddUser(name, email));
                },
                child: Text('Add User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
