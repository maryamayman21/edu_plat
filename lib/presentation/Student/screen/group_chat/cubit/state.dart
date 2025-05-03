
import 'package:edu_platt/presentation/Student/screen/group_chat/model/GroupChatModel.dart';

abstract class GroupChatState {}

class GroupChatInitial extends GroupChatState {}

class GroupChatLoading extends GroupChatState {}

class GroupChatLoaded extends GroupChatState {
  final GroupChatResponse groupChat;

  GroupChatLoaded(this.groupChat);
}

class GroupChatError extends GroupChatState {
  final String message;

  GroupChatError(this.message);
}
