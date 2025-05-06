
class UpdatePhoneNumberRequest{
final String phoneNumber;
UpdatePhoneNumberRequest({required this.phoneNumber});

Map<String, dynamic> toJson() {
  return {
    'newPhoneNumber': phoneNumber,
  };
}

}