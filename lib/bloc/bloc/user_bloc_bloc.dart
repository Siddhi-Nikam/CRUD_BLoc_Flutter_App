import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Repo/api_service.dart';
import 'user_bloc_event.dart';
import 'user_bloc_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService userService;

  UserBloc(this.userService) : super(UserInitial()) {
    on<FetchAllUsers>((event, emit) async {
      emit(UserLoading());
      try {
        final users = await userService.getAllUsers();
        emit(UsersLoaded(users));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<FetchUserById>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await userService.getUserById(event.userId);
        emit(UserLoaded(user));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<AddUser>((event, emit) async {
      emit(UserLoading());
      try {
        await userService.addUser(event.name, event.email);
        emit(UserAdded());
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<UpdateUser>((event, emit) async {
      emit(UserLoading());
      try {
        await userService.updateUser(event.userId, event.name, event.email);
        emit(UserUpdated());
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<DeleteUser>((event, emit) async {
      emit(UserLoading());
      try {
        await userService.deleteUser(event.userId);
        emit(UserDeleted());
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
