import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// states
abstract class ButtonEvent {}

class ButtonInitial extends ButtonState {}

class ButtonLoading extends ButtonState {}

class ButtonSuccess extends ButtonState {}

class ButtonFailure extends ButtonState {
  final String error;

  ButtonFailure({required this.error});
}

// events
abstract class ButtonState {}

class ButtonPressed extends ButtonEvent {
  final VoidCallback onPressed;

  ButtonPressed({required this.onPressed});
}

// bloc
class ButtonBloc extends Bloc<ButtonEvent, ButtonState> {
  ButtonBloc() : super(ButtonInitial()) {
    on<ButtonPressed>((event, emit) async {
      emit(ButtonLoading());
      try {
        await Future.delayed(const Duration(seconds: 1));
        event.onPressed();
        emit(ButtonSuccess());
      } catch (e) {
        emit(ButtonFailure(error: e.toString()));
      }
    });
  }
}
