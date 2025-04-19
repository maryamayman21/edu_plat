
import 'package:flutter_bloc/flutter_bloc.dart';

class IndexCubit extends Cubit<int> {
  IndexCubit() : super(0);

  void updateIndex(int newIndex) => emit(newIndex);
}
