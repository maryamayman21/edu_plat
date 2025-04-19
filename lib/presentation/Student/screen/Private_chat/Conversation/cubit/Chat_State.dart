part of 'Chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<DoctorModel> doctors;
  ChatLoaded(this.doctors);
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}