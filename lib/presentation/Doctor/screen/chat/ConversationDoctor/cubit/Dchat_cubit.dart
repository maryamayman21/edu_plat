import 'dart:convert';
import 'package:edu_platt/presentation/Doctor/screen/chat/ConversationDoctor/StudentModel/model.dart';
import 'package:edu_platt/presentation/Doctor/screen/chat/ConversationDoctor/repo/chat_Repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'cubit_state.dart';


class DoctorChatCubit extends Cubit<DoctorChatState> {
  final DoctorChatRepository doctorchatRepository;

  DoctorChatCubit(this.doctorchatRepository) : super(ChatInitial() );

  Future<void> fetchStudents(String token) async {
    try {
      emit(ChatLoading());

      print("🔵 Fetching students with token: $token");

      final response = await http.get(
        Uri.parse(
            "https://great-hot-impala.ngrok-free.app/api/Chat/GetStudentsForDoctor/students"),
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
        final List<dynamic> studentsList = responseData["students"] ?? [];

        print("🔵 Parsed Students List: $studentsList");

        List<StudentModel> students = studentsList
            .map((e) => StudentModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();

        emit(ChatLoaded(students) );
      } else {
        emit(ChatError("Failed to fetch students") );
      }
    } catch (e) {
      print("❌ Error fetching students: $e");
      emit(ChatError("An error occurred while fetching students") );
    }
  }
}