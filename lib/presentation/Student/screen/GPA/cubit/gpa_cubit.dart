import 'package:edu_platt/core/cashe/services/gpa_cashe_service.dart';
import 'package:edu_platt/presentation/Auth/service/token_service.dart';
import 'package:edu_platt/presentation/Student/screen/GPA/model/model.dart';
import 'package:edu_platt/presentation/Student/screen/GPA/repo/repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'cubit_state.dart';

class GpaCubit extends Cubit<GpaState> {
  final GPARepository gpaRepository;
  final TokenService tokenService;
  final GpaCasheServer gpaCacheService;


  GpaCubit({ required this.gpaRepository,required this.gpaCacheService,required this.tokenService}) : super(GpaInitial());

  Future<void> fetchGpa() async {
    emit(GpaLoading());
    try {
      final token = await tokenService.getToken();
      if (token == null) throw Exception("Token not found");

      final gpa = await gpaRepository.fetchGpa(token);
      print('fetched gpa : ${gpa.gpa}');
      await gpaCacheService.saveGpa(gpa.gpa);
      print('cached server successfully');

      emit(GpaLoaded(gpa));
    } catch (e) {
      try {
        final cachedGpa = await gpaCacheService.getGpa();
        if (cachedGpa != null && cachedGpa['gpa'] != 0.0) {
          emit(GpaLoaded(GpaModel(gpa: cachedGpa['gpa']!)));
        } else {
          emit(GpaError("Failed to fetch GPA: $e"));
        }
      } catch (cacheError) {
        emit(GpaError("Failed to fetch GPA from cache: $cacheError"));
      }
    }
  }


  Future<void> updateGpa(double gpa) async {
    emit(GpaLoading());
    try {
      final token = await tokenService.getToken();
      if (token == null) throw Exception("Token not found");
      print('updated gpa : $gpa');
      await gpaRepository.updateGpa(gpa, token);
      print('updated server successfully');
      await gpaCacheService.saveGpa(gpa);
      print('updated cashe successfully');

      emit(GpaLoaded(GpaModel(gpa: gpa)));
      //await gpaCacheService.saveGpa(gpa);
    } catch (e) {
      emit(GpaError("Failed to update GPA: $e"));
    }
  }
}