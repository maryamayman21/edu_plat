import 'package:flutter_bloc/flutter_bloc.dart';


class MaterialTypeCubit extends Cubit<Map<String, dynamic>> {
  MaterialTypeCubit() : super({'materialType':'Lectures', 'currentIndex': 0});

  void updateType(Map<String, dynamic> newType) => emit(newType);
}

