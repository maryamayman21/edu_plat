import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../core/cashe/services/profile_cashe_service.dart';
import '../../../core/network_handler/network_handler.dart';
import '../../Auth/service/token_service.dart';
import '../repository/profile_repository.dart';

part 'phone_state.dart';

class PhoneCubit extends Cubit<PhoneState> {
  final ProfileRepository profileRepository;
  final TokenService tokenService;
  final ProfileCacheService profileCacheService;
  final TextEditingController phoneController = TextEditingController();
  PhoneCubit(
      {required this.profileRepository,
        required this.tokenService,
        required this.profileCacheService,
      }
      ) : super(PhoneNumberInitial());


  Future<void> updatePhoneNumber(String phoneNumber) async {
    try {
      final token = await tokenService.getToken();
      await profileRepository.updatePhoneNumber(token!, phoneNumber);
      await profileCacheService.savePhoneNumber(phoneNumber);
      final cachedPhoneNumber = await profileCacheService.getPhoneNumber();

      if (cachedPhoneNumber != null) {
        phoneController.text = phoneNumber;
        emit(PhoneNumberSuccess(cachedPhoneNumber));
      } else {
        emit(PhoneNumberFailure("Failed to retrieve cached phone number."));
      }
    } catch (e) {
      emit(PhoneNumberFailure("Failed to update phone number: $e"));
    }
  }

  Future<void> fetchPhoneNumber() async {
    try {
      if (!isClosed) {
        emit(PhoneNumberLoading());
      }
      //try cache
      final cachedPhoneNumber = await profileCacheService.getPhoneNumber();
      if (cachedPhoneNumber != null) {
        phoneController.text = cachedPhoneNumber;
        emit(PhoneNumberSuccess(cachedPhoneNumber));
        return;
      } else {
      }
      final token = await tokenService.getToken();
      String? phoneNumber =    await profileRepository.fetchPhoneNumber(token!);
      if(phoneNumber != null) {
        await profileCacheService.savePhoneNumber(phoneNumber);
      }
      phoneController.text = phoneNumber?? "";
      if (!isClosed) {
        emit(PhoneNumberSuccess(phoneNumber));
      }
    } catch (error) {
      if (!isClosed) {
        if (error is DioError && error.response != null) {
          final errorMessage =
              error.response?.data['message'] ?? 'An unexpected error occurred';
          emit(PhoneNumberFailure(errorMessage));
        } else {
          emit(PhoneNumberFailure(NetworkHandler.mapErrorToMessage(error)));
        }
      }
    }
  }
  @override
  Future<void> close() {
    phoneController.dispose(); // Dispose of the controller
    return super.close();
  }


}