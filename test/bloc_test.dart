import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neon_agify/blocs/age_prediction_bloc.dart';
import 'package:neon_agify/models/age_prediction.dart';
import 'package:neon_agify/models/api_exceptions.dart';
import 'package:neon_agify/repositories/agify_repository.dart';

class MockAgifyRepository extends Mock implements AgifyRepository {}
class FakeAgePredictionEvent extends Fake implements AgePredictionEvent {}
class FakeAgePredictionState extends Fake implements AgePredictionState {}

void main() {
  late AgePredictionBloc bloc;
  late MockAgifyRepository repository;

  setUpAll(() {
    registerFallbackValue(FakeAgePredictionEvent());
    registerFallbackValue(FakeAgePredictionState());
  });

  setUp(() {
    repository = MockAgifyRepository();
    bloc = AgePredictionBloc(repository);
  });

  const michael = AgePrediction(name: 'michael', age: 63, count: 298219);
  blocTest<AgePredictionBloc, AgePredictionState>(
    'emits [AgePredictionLoading, AgePredictionLoaded] when API is called and result is received',
    build: () {
      when(() => repository.getAgeByName('michael')).thenAnswer(
        (_) async => michael,
      );
      return bloc;
    },
    act: (bloc) => bloc.add(GetAgePrediction('michael')),
    expect: () => [
      isA<AgePredictionLoading>(),
      isA<AgePredictionLoaded>().having((state) => state.prediction,
        'prediction',
        michael,
      ),
    ],
  );

  blocTest<AgePredictionBloc, AgePredictionState>(
    'emits [AgePredictionLoading, AgePredictionError] when API is called and an error occurs',
    build: () {
      when(() => repository.getAgeByName('Error')).thenThrow(ApiException('Failed to load age data'));
      return bloc;
    },
    act: (bloc) => bloc.add(GetAgePrediction('Error')),
    expect: () => [
      isA<AgePredictionLoading>(),
      isA<AgePredictionError>().having((state) => state.message,
        'message',
        'ApiException: Failed to load age data',
      ),
    ],
  );

  blocTest<AgePredictionBloc, AgePredictionState>(
    'emits [AgePredictionInitial] when resetting to restart prediction',
    build: () => bloc,
    act: (bloc) => bloc.add(ResetAgePrediction()),
    expect: () => [isA<AgePredictionInitial>()],
  );
}
