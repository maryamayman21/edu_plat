


import 'package:edu_platt/core/constant/constant.dart';
import 'package:edu_platt/core/network/api_service.dart';
import 'package:edu_platt/presentation/profile_update/data/network/requests/add_profilepic_request.dart';
import 'package:edu_platt/presentation/profile_update/data/network/requests/update_phone_number_request.dart';
import 'package:edu_platt/presentation/profile_update/data/network/responses/add_profilepic_response.dart';
import 'package:edu_platt/presentation/profile_update/data/network/responses/fetch_phone_number_response.dart';
import 'package:edu_platt/presentation/profile_update/data/network/responses/fetch_profile_pic_response.dart';
import 'package:edu_platt/presentation/profile_update/data/network/responses/fetch_user_data_response.dart';
import 'package:edu_platt/presentation/profile_update/data/network/responses/update_phone_number_response.dart';

abstract class ProfileRemoteDataSource {
  Future<FetchUserDataResponse> fetchUserProfile();
  Future<FetchPhoneNumberResponse> fetchPhoneNumber();
  Future<FetchProfilePicResponse> fetchProfilePicture();
  Future<UploadProfilePicResponse> uploadProfilePicture(UploadProfilePicRequest request );
   Future<UpdatePhoneNumberResponse> updatePhoneNumber(UpdatePhoneNumberRequest request );

}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  final ApiService apiService;

  ProfileRemoteDataSourceImpl(this.apiService);

  @override
  Future<FetchPhoneNumberResponse> fetchPhoneNumber() async{
    var response = await  apiService.getFromUrl(endPoint: '${ApiConstants.baseUrl}${ApiConstants.userFetchPhoneNumberEndpoint}');
    return FetchPhoneNumberResponse.fromJson(response.data);
  }


  @override
  Future<FetchUserDataResponse> fetchUserProfile()async{
    var response = await  apiService.getFromUrl(endPoint: '${ApiConstants.baseUrl}${ApiConstants.userProfileEndpoint}');
    return FetchUserDataResponse.fromJson(response.data);
  }

  @override
  Future<UpdatePhoneNumberResponse> updatePhoneNumber(UpdatePhoneNumberRequest request)async{
    var response = await  apiService.post(endPoint: '${ApiConstants.baseUrl}${ApiConstants.userUpdatePhoneNumberEndpoint}',  data: request.toJson());
    return UpdatePhoneNumberResponse.fromJson(response.data);
  }

  @override
  Future<FetchProfilePicResponse> fetchProfilePicture()async {
    var response = await  apiService.getFromUrl(endPoint: '${ApiConstants.baseUrl}${ApiConstants.profilePhotoEndpoint}',);
    return FetchProfilePicResponse.fromJson(response.data);
  }

  @override
  Future<UploadProfilePicResponse> uploadProfilePicture(UploadProfilePicRequest request)async {
    var response = await  apiService.postFormData(endPoint: '${ApiConstants.baseUrl}${ApiConstants.profilePhotoEndpoint}',formData:  await request.toFormData() );
    return UploadProfilePicResponse.fromJson(response.data);
  }

}