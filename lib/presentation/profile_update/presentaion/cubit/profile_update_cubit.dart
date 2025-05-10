import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_update_state.dart';

class ProfileUpdateCubit extends Cubit<ProfileUpdateState> {
  ProfileUpdateCubit() : super(ProfileUpdateInitial());
}
