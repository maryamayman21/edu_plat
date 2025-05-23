import 'dart:convert';
import 'package:edu_platt/core/constant/constant.dart';
import 'package:edu_platt/presentation/Student/screen/Private_chat/Conversation/doctorModel/modelDoctor.dart';
import 'package:edu_platt/presentation/Student/screen/Private_chat/Conversation/repo/chat_Repo.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'Chat_State.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository chatRepository;

  ChatCubit(this.chatRepository) : super(ChatInitial());

  Future<void> fetchDoctors(String token) async {
    try {
      emit(ChatLoading());

      print("🔵 Fetching doctors with token: $token");

      final response = await http.get(
        Uri.parse(
            "${ApiConstants.baseUrl}/api/Chat/GetDoctorsForStudent/doctors"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      print("🔵 API Response Status Code: ${response
          .statusCode}");
      print("🔵 API Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> doctorsList = responseData["doctors"] ?? [];

        print("🔵 Parsed Doctors List: $doctorsList");

        List<DoctorModel> doctors = doctorsList
            .map((e) => DoctorModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();

        emit(ChatLoaded(doctors));
      } else {
        emit(ChatError("Failed to fetch doctors"));
      }
    } catch (e) {
      print("❌ Error fetching doctors: $e");
      emit(ChatError("An error occurred while fetching doctors"));
    }
  }
}