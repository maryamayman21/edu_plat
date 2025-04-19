part of 'linear_progress_cubit.dart';

@immutable
sealed class LinearProgressState {}

final class LinearProgressInitial extends LinearProgressState {
  final double progress;
  LinearProgressInitial(this.progress);
}

final class LinearProgressCompleted extends LinearProgressState {
  LinearProgressCompleted();
}
