part of 'person_bloc.dart';

abstract class PersonEvent extends Equatable {
  const PersonEvent();
}

class AddPersonEvent extends PersonEvent {
  final PersonModel person;

  const AddPersonEvent(this.person);

  @override
  List<Object?> get props => [person];
}

class UpdatePersonEvent extends PersonEvent {
  final PersonModel person;

  const UpdatePersonEvent(this.person);

  @override
  List<Object?> get props => [person];
}

class DeletePersonEvent extends PersonEvent {
  final PersonModel person;

  const DeletePersonEvent(this.person);

  @override
  List<Object?> get props => [person];
}

class GetPersonEvent extends PersonEvent {
  @override
  List<Object?> get props => [];
}
