import 'package:edu_platt/core/cashe/services/course_cashe_service.dart';
import 'package:edu_platt/core/cashe/services/gpa_cashe_service.dart';
import 'package:edu_platt/core/cashe/services/notes_cache_service.dart';
import 'package:edu_platt/core/cashe/services/profile_cashe_service.dart';
import 'package:edu_platt/core/file_picker/file_picker_service.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Auth/service/token_service.dart';
import 'package:edu_platt/presentation/Student/screen/GPA/CoursesGpaCalculator.dart';
import 'package:edu_platt/presentation/Student/screen/GPA/SemesterGpaCalculator.dart';
import 'package:edu_platt/presentation/Student/screen/GPA/cubit/gpa_cubit.dart';
import 'package:edu_platt/presentation/Student/screen/GPA/repo/repo.dart';
import 'package:edu_platt/presentation/profile/cubit/profile_cubit.dart';
import 'package:edu_platt/presentation/profile/data/profile_web_services.dart';
import 'package:edu_platt/presentation/profile/model/user.dart';
import 'package:edu_platt/presentation/profile/repository/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Gpa_Calculator extends StatefulWidget {

  const Gpa_Calculator({super.key});

  @override
  State<Gpa_Calculator> createState() => _Gpa_CalculatorState();
}

class _Gpa_CalculatorState extends State<Gpa_Calculator>with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    // Future.microtask(() {
    //   context.read<GpaCubit>().fetchGpa();
    // });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
  providers: [
    BlocProvider(
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
),
    BlocProvider(
      create: (context) => GpaCubit(gpaRepository: GPARepository() , tokenService:TokenService() ,  gpaCacheService:GpaCasheServer() )..fetchGpa(),
    ),
  ],
  child: BlocListener<GpaCubit, GpaState>(
        listener: (context, state) {
          if (state is GpaLoaded) {
          }
        },
        child: Scaffold(
          appBar: AppBar(automaticallyImplyLeading: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            foregroundColor: color.primaryColor,
            title: const Text("GPA Calculator"),
            titleTextStyle: TextStyle(fontWeight: FontWeight.bold,color: color.primaryColor,fontSize: 25.sp),

          ),
          body: Container(
                    decoration: const BoxDecoration(
           gradient: LinearGradient(
             begin: Alignment.topLeft,
             end: Alignment.bottomRight,
             colors: [
               Color(0xFDD9E9FB),
               Colors.grey,
             ],
           ),
                    ),
            child: Column(
              children: [
                Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.r),
                      bottomRight: Radius.circular(30.r),)
                ),
                child: Padding(
                  padding: REdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (BuildContext context, ProfileState state) {
                            UserModel? user;
                            if (state is ProfileLoaded) {
                                user = state.userModel;
                                return Text(user!.userName,style: TextStyle(color: color.primaryColor,fontSize: 22.sp,fontWeight: FontWeight.bold),textAlign: TextAlign.left,);
                                }
                                return const Center(child: SizedBox());

                          },),
                      Row(
                        children: [
                      BlocBuilder<GpaCubit, GpaState>(
                          buildWhen: (previous, current) => current is GpaLoaded,
                        builder: (context, state) {
                          if (state is GpaLoading) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (state is GpaLoaded) {
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              child: Column(
                                  key: ValueKey(state.gpa.gpa),
                                  children: [
                                    Row(
                                      children: [
                                        Text("SGPA :",
                                          style: TextStyle(fontWeight: FontWeight.bold,
                                              color: Colors.pinkAccent,fontSize: 22.sp),),
                                        Text(" ${state.gpa.gpa.toStringAsFixed(2)}",
                                          style: TextStyle(color: color.secondColor,
                                              fontSize: 20.sp),
                                          textAlign: TextAlign.left,),
                                      ],
                                    )
                                  ]
                              ),
                            );
                          }
                          return const Center(child: SizedBox());
                        }
                      ),
                        ],
                      ),
                    ],
                  ),
                ),
                      ),
                Padding(
                  padding: REdgeInsets.all(15.0),
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    controller: _tabController,
                    labelColor: color.primaryColor,
                    unselectedLabelColor: Colors.grey,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(width: 3.0.w, color: color.secondColor),
                    ),
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: const [
                      Tab(child: Text("CGPA Calculator",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),),
                      Tab(child: Text("SGPA Calculator",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18))),
                    ],),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Coursesgpacalculator(
                      ),
                      Semestergpacalculator(
                        onSaveSGPA: (sgpa) {
                          context.read<GpaCubit>().updateGpa(sgpa);
                        },
                      ),
                    ],
                  ),
                ),

              ],
            ),
                  ),

        ),
      ),
);
  }
}
