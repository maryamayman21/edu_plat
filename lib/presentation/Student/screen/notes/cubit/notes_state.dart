part of 'notes_cubit.dart';

@immutable
sealed class NotesState {}

final class NotesInitial extends NotesState {}
final class NotesSuccess extends NotesState {
  final notes;
  NotesSuccess(this.notes);
}
final class NotesFailure extends NotesState {
  final errorMessage;
  NotesFailure(this.errorMessage);
}
final class NotesLoading extends NotesState {}
final class NotesNotFound extends NotesState {}