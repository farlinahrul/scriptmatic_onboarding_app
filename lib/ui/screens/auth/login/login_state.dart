import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  final int time;

  LoginState() : time = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [time];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {}

class LoginChangeProp extends LoginState {}
