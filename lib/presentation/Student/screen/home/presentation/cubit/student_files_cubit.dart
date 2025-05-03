import 'package:bloc/bloc.dart';
import 'package:edu_platt/presentation/Student/screen/home/data/repo/home_repoImp.dart';
import 'package:edu_platt/presentation/Student/screen/home/data/request/student_help_file_request.dart';
import 'package:edu_platt/presentation/Student/screen/home/domain/entity/file_entity.dart';
import 'package:meta/meta.dart';

part 'student_files_state.dart';

class StudentFilesCubit extends Cubit<StudentFilesState> {
  StudentFilesCubit({
    required this.homeRepoImp

  }
      ) : super(StudentFilesInitial());
  HomeRepoImp homeRepoImp;


  Future<void> fetchCourseCard(String type) async {
    emit(StudentFilesLoading());
    var result = await homeRepoImp.fetchFile(StudentHelpFileRequest(type: type ));
    result.fold((failure) {
      emit(StudentFilesFailure(errorMessage: failure.message));
    }, (files) {
      emit(StudentFilesSuccess(files:files ));
    });
  }

}
