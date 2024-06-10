import 'package:equatable/equatable.dart';

class AgePrediction extends Equatable {
  final String name;
  final int age;
  final int count;

  const AgePrediction({required this.name, required this.age, required this.count});

  factory AgePrediction.fromJson(Map<String, dynamic> json) {
    return AgePrediction(
      name: json['name'],
      age: json['age'],
      count: json['count'],
    );
  }

  @override
  List<Object?> get props => [name, age, count];
}
