import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAllUsers extends UserEvent {
  @override
  List<Object> get props => [];
}

class FetchUserById extends UserEvent {
  final String userId;
  FetchUserById(this.userId);
  @override
  List<Object> get props => [userId];
}

class AddUser extends UserEvent {
  final String name;
  final String email;
  AddUser(this.name, this.email);
  @override
  List<Object> get props => [name, email];
}

class UpdateUser extends UserEvent {
  final String userId;
  final String name;
  final String email;
  UpdateUser(this.userId, this.name, this.email);
  @override
  List<Object> get props => [userId, name, email];
}

class DeleteUser extends UserEvent {
  final String userId;
  DeleteUser(this.userId);
  @override
  List<Object> get props => [userId];
}
