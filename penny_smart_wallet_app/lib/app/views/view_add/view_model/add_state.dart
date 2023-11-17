import 'package:equatable/equatable.dart';

abstract class AddState extends Equatable {
  const AddState();

  @override
  List<Object> get props => [];
}

class AddInitialState extends AddState {}

class AddSavedState extends AddState {}
