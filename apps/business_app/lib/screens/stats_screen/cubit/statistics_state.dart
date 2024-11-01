part of 'statistics_cubit.dart';

@immutable
sealed class StatisticsState {}

final class StatisticsInitial extends StatisticsState {}
class Loading extends StatisticsState{}
class Loaded extends StatisticsState {}
