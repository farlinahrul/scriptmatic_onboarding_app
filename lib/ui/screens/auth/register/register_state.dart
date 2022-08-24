import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  final int time;

  RegisterState() : time = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [time];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterLoaded extends RegisterState {}

class RegisterChangeState extends RegisterState {}
