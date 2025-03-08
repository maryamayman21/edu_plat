import 'package:flutter_bloc/flutter_bloc.dart';

class MaterialTypeCubit extends Cubit<String> {
  MaterialTypeCubit() : super('Lectures');

  void updateType(String newType) => emit(newType);
}

