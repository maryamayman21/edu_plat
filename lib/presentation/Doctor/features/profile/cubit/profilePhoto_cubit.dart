import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';


import 'package:shared_preferences/shared_preferences.dart';


class ProfileCubit extends Cubit<String?> {
 // final ProfileRepository repository;

  ProfileCubit({required profileRepository, required tokenService, required filePickerService}) : super(null) {
    _loadCachedPhoto();
  }

  Future<void> _loadCachedPhoto() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedPhoto = prefs.getString('profile_photo_url');
    if (cachedPhoto != null) {
      emit(cachedPhoto);
    }
  }

  void selectPhoto() async {
    final file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpeg', 'jpg'],
    );
    if (file != null) {
      final filePath = file.files.single.path!;
      emit(filePath); // Emit the new file path.
    }
  }

  Future<void> uploadPhoto() async {
    if (state == null) {
      throw Exception("No photo selected.");
    }
    try {
     // await repository.uploadProfilePhoto(state!);
      // Update the cached photo URL after successful upload.
      final prefs = await SharedPreferences.getInstance();
      final newPhotoUrl = prefs.getString('profile_photo_url');
      emit(newPhotoUrl);
    } catch (e) {
      // Handle error.
      print('Error uploading photo: $e');
    }
  }
}
