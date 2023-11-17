import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'add_event.dart';
import 'add_state.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:penny_smart_wallet/core/data/model/add_date.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  final box = Hive.box<Add_data>('data');

  AddBloc() : super(AddInitialState());

  @override
  Stream<AddState> mapEventToState(AddEvent event) async* {
    if (event is SaveEvent) {
      var add = Add_data(
        event.selectedIncomeType,
        event.amount,
        event.date,
        event.explanation,
        event.selectedExpenseType,
      );
      box.add(add);
      yield AddSavedState();
    }
  }
}
