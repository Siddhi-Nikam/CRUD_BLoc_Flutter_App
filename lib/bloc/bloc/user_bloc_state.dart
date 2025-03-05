import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UsersLoaded extends UserState {
  final List<Map<String, dynamic>> users;
  UsersLoaded(this.users);
  @override
  List<Object> get props => [users];
}

class UserLoaded extends UserState {
  final Map<String, dynamic> user;
  UserLoaded(this.user);
  @override
  List<Object> get props => [user];
}

class UserAdded extends UserState {}

class UserUpdated extends UserState {}

class UserDeleted extends UserState {}

class UserError extends UserState {
  final String message;
  UserError(this.message);
  @override
  List<Object> get props => [message];
}
