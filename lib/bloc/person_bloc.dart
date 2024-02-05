import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sqflite_crud_operation/service/database_helper.dart';

import '../models/person_model.dart';

part 'person_event.dart';

part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  PersonBloc() : super(PersonInitial()) {
    on<AddPersonEvent>(_onAddPersonEvent);
    on<UpdatePersonEvent>(_onUpdatePersonEvent);
    on<DeletePersonEvent>(_onDeletePersonEvent);
    on<GetPersonEvent>(_onGetPersonEvent);
  }

  _onAddPersonEvent(
      AddPersonEvent addPersonEvent, Emitter<PersonState> state) async {
    emit(PersonLoading());

    final result = await DatabaseHelper.addPerson(addPersonEvent.person);

    result.fold((l) {
      emit(PersonError(message: l.message));
    }, (r) {
      emit(PersonAddLoaded(value: r));
    });
  }

  _onUpdatePersonEvent(
      UpdatePersonEvent updatePersonEvent, Emitter<PersonState> state) async {
    emit(PersonLoading());

    final result = await DatabaseHelper.updatePerson(updatePersonEvent.person);

    result.fold((l) {
      emit(PersonError(message: l.message));
    }, (r) {
      emit(PersonUpdateLoaded(value: r));
    });
  }

  _onDeletePersonEvent(
      DeletePersonEvent deletePersonEvent, Emitter<PersonState> state) async {
    emit(PersonLoading());

    final result = await DatabaseHelper.deletePerson(deletePersonEvent.person);

    result.fold((l) {
      emit(PersonError(message: l.message));
    }, (r) {
      emit(PersonDeleteLoaded(value: r));
    });
  }

  _onGetPersonEvent(
      GetPersonEvent getPersonEvent, Emitter<PersonState> state) async {
    emit(PersonLoading());

    final result = await DatabaseHelper.getAllPerson();

    result.fold((l) {
      emit(PersonError(message: l.message));
    }, (r) {
      emit(PersonGetLoaded(person: r));
    });
  }
}
