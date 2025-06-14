part of 'Dchat_cubit.dart';

@immutable
abstract class DoctorChatState {}

class ChatInitial extends DoctorChatState {}

class ChatLoading extends DoctorChatState {}

class ChatLoaded extends DoctorChatState {
  final List<StudentModel> students;
  final bool hasUnread;

  ChatLoaded(this.students, {this.hasUnread = false});
}


class ChatError extends DoctorChatState {
  final String message;
  ChatError(this.message);
}