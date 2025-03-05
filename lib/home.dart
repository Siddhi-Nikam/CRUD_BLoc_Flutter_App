import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Repo/api_service.dart';
import 'add_new_user.dart';
import 'bloc/bloc/user_bloc_bloc.dart';
import 'bloc/bloc/user_bloc_event.dart';
import 'bloc/bloc/user_bloc_state.dart';
import 'edit.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(UserService())..add(FetchAllUsers()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("User List"),
          backgroundColor: Colors.lightBlue,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return BlocProvider.value(
                        value: context.read<UserBloc>(), // Ensure Bloc access
                        child: AddNewUser(),
                      );
                    },
                  ));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      size: 20,
                      color: const Color.fromARGB(255, 4, 114, 204),
                    ),
                    SizedBox(width: 5),
                    Text("Add User",
                        style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 4, 115, 206))),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is UserLoading)
                    Center(child: CircularProgressIndicator()),

                  // ✅ Always display ListView (even if empty)
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context.read<UserBloc>().add(FetchAllUsers());
                      },
                      child: ListView.builder(
                        itemCount:
                            state is UsersLoaded ? state.users.length : 0,
                        itemBuilder: (context, index) {
                          if (state is UsersLoaded && state.users.isNotEmpty) {
                            final user = state.users[index];
                            final userId = user['id'] ?? user['_id'];

                            return Card(
                              elevation: 2,
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                tileColor:
                                    const Color.fromARGB(255, 217, 215, 215),
                                title: Text(user['name'] ?? "No Name",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text(user['email'] ?? "No Email",
                                    style: TextStyle(fontSize: 14)),
                                trailing: SizedBox(
                                  width: 100, //Prevents overflow
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit,
                                            color: Colors.blue),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditUserScreen(
                                                userId: userId.toString(),
                                                userName: user['name'],
                                                userEmail: user['email'],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () {
                                          if (userId != null) {
                                            context.read<UserBloc>().add(
                                                DeleteUser(userId.toString()));
                                          } else {
                                            print(
                                                "Error: Cannot delete, User ID is null");
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            // ✅ Keep ListView even if no users
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
