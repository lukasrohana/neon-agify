import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/age_prediction.dart';
import '../repositories/agify_repository.dart';

abstract class AgePredictionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAgePrediction extends AgePredictionEvent {
  final String name;

  GetAgePrediction(this.name);

  @override
  List<Object?> get props => [name];
}

class ResetAgePrediction extends AgePredictionEvent {}

abstract class AgePredictionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AgePredictionInitial extends AgePredictionState {}

class AgePredictionLoading extends AgePredictionState {}

class AgePredictionLoaded extends AgePredictionState {
  final AgePrediction prediction;

  AgePredictionLoaded(this.prediction);

  @override
  List<Object?> get props => [prediction];
}

class AgePredictionError extends AgePredictionState {
  final String message;

  AgePredictionError(this.message);

  @override
  List<Object?> get props => [message];
}

class AgePredictionBloc extends Bloc<AgePredictionEvent, AgePredictionState> {
  final AgifyRepository repository;

  AgePredictionBloc(this.repository) : super(AgePredictionInitial()) {
    on<GetAgePrediction>(_onGetAgePrediction);
    on<ResetAgePrediction>(_onResetAgePrediction);
  }

  Future<void> _onGetAgePrediction(GetAgePrediction event, Emitter<AgePredictionState> emit) async {
    emit(AgePredictionLoading());
    try {
      final prediction = await repository.getAgeByName(event.name);
      emit(AgePredictionLoaded(prediction));
    }
    catch (e) {
      emit(AgePredictionError(e.toString()));
    }
  }

  void _onResetAgePrediction(ResetAgePrediction event, Emitter<AgePredictionState> emit) {
    emit(AgePredictionInitial());
  }
}
