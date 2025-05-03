import 'package:edu_platt/core/cashe/services/course_cashe_service.dart';
import 'package:edu_platt/core/cashe/services/notes_cache_service.dart';
import 'package:edu_platt/core/cashe/services/profile_cashe_service.dart';
import 'package:edu_platt/core/file_picker/file_picker_service.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Auth/service/token_service.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/Student/screen/Private_chat/Conversation/cubit/Chat_cubit.dart';
import 'package:edu_platt/presentation/Student/screen/Private_chat/Conversation/doctorModel/modelDoctor.dart';
import 'package:edu_platt/presentation/profile/cubit/profile_cubit.dart';
import 'package:edu_platt/presentation/profile/repository/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../profile/data/profile_web_services.dart';



class ConvirationWedgit extends StatefulWidget {
  const ConvirationWedgit({super.key});

  @override
  State<ConvirationWedgit> createState() => _ConvirationWedgitState();
}

class _ConvirationWedgitState extends State<ConvirationWedgit> {

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
          create: (context) => ProfileCubit(
        profileRepository:
        ProfileRepository(ProfileWebServices()),
    tokenService: TokenService(),
    filePickerService: FilePickerService(),
    profileCacheService: ProfileCacheService(),
    courseCacheService: CourseCacheService(),
    notesCacheService: NotesCacheService()
    )
    ..getProfileData(),

        child: Scaffold(
          backgroundColor: color.primaryColor,
          appBar: AppBar(
            title: const Text("Conversation" ,style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
            backgroundColor: color.primaryColor,
          ),
          body: Container(
            color: Colors.grey[200],
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ChatLoaded) {
                  return ListView.builder(
                    itemCount: state.doctors.length,
                    itemBuilder: (context, index) {
                      final DoctorModel  doctor = state.doctors[index] as DoctorModel;
                      return Padding(
                        padding: REdgeInsets.all(8.0),
                        child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(12),
                                    leading: CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.grey[300],
                                      backgroundImage: doctor.imageBytes != null
                                          ? MemoryImage(doctor.imageBytes!)
                                          : null,
                                      child: doctor.imageBytes == null
                                          ? Icon(Icons.person, color: Colors.white, size: 40)
                                          : null,
                                    ),
                                    title: Text(
                                      doctor.name,
                                      style: TextStyle(
                                        color: color.secondColor,
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    trailing: Icon(Icons.chat, color: Colors.grey),
                                    onTap: () {
                                      if (doctor.id != null && doctor.name != null && doctor.email != null) {
                                        Navigator.pushNamed(
                                          context,
                                          AppRouters.privateChat,
                                          arguments: {
                                            "doctorName": doctor.name!,
                                            "doctorEmail": doctor.email!,
                                          },
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Doctor data is incomplete!")),
                                        );
                                      }
                                        },
                                      )
                                  ),

                      );
                    },
                  );
                } else {
                  return Center(child: Text("No doctors found"));
                }
              },
            ),
          ),
        ),

    );
  }
}

