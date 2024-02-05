part of 'person_bloc.dart';

abstract class PersonState extends Equatable {
  const PersonState();
}

class PersonInitial extends PersonState {
  @override
  List<Object> get props => [];
}

class PersonLoading extends PersonState {
  @override
  List<Object> get props => [];
}

class PersonError extends PersonState {
  final String message;

  const PersonError({required this.message});

  @override
  List<Object> get props => [message];
}

class PersonAddLoaded extends PersonState {
  final int value;

  const PersonAddLoaded({required this.value});

  @override
  List<Object> get props => [value];
}

class PersonUpdateLoaded extends PersonState {
  final int value;

  const PersonUpdateLoaded({required this.value});

  @override
  List<Object> get props => [value];
}

class PersonDeleteLoaded extends PersonState {
  final int value;

  const PersonDeleteLoaded({required this.value});

  @override
  List<Object> get props => [value];
}

class PersonGetLoaded extends PersonState {
  final List<PersonModel> person;

  const PersonGetLoaded({required this.person});

  @override
  List<Object> get props => [person];
}
