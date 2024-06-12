
import '../models/user_info.dart';

class UserInfoViewModel {
  UserInfo _userInfo = UserInfo(
    userName: 'userName',
    userSurname: 'userSurname',
    phoneNumber: 'phoneNumber',
    profilePictureUrl: 'https://cdn.pixabay.com/photo/2024/02/17/16/08/ai-generated-8579697_1280.jpg',
  );

  UserInfo get userInfo {
    return _userInfo;
  }

  void editUserInfo({
    required String newName,
    required String newSurname,
    required String newNumber,
    required String newPicture,
  }) {
    _userInfo.userName = newName;
    _userInfo.userSurname = newSurname;
    _userInfo.phoneNumber = newNumber;
    _userInfo.profilePictureUrl = newPicture;
  }
}
