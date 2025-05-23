import 'dart:convert';

import 'package:edu_platt/core/constant/constant.dart';
import 'package:edu_platt/presentation/Student/screen/group_chat/cubit/state.dart';
import 'package:edu_platt/presentation/Student/screen/group_chat/model/GroupChatModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../Auth/service/token_service.dart';

class GroupChatCubit extends Cubit<GroupChatState> {
  final TokenService tokenService;

  GroupChatCubit(this.tokenService) : super(GroupChatInitial());
  Future<void> fetchGroupChat(String courseCode) async {
    emit(GroupChatLoading());

    try {
      final token = await tokenService.getToken();

      final url = "${ApiConstants.baseUrl}${ApiConstants.getGroupChatEndpoint}$courseCode";

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['success'] == true) {
          final groupChat = GroupChatResponse.fromJson(jsonData);
          emit(GroupChatLoaded(groupChat));
        } else {
          emit(GroupChatError(jsonData['message']));
        }
      } else {
        emit(GroupChatError("Error: ${response.statusCode}"));
      }
    } catch (e) {
      emit(GroupChatError(e.toString()));
    }
  }
}
