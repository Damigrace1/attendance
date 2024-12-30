import 'package:qr_attendance_system/models/auth/user.dart';
import 'package:stacked/stacked.dart';

import '../../../services/firebase_services.dart';

class ProfileViewModel extends BaseViewModel {
  bool profileInfoExpanded = false;

  void expandProfile(bool v){
    profileInfoExpanded = v;
    notifyListeners();
  }

  Future<UserModel?> getUser()async{
    setBusy(true);
    final res =
    await  FirestoreService().readUser();
    setBusy(false);
    return res;
  }
}
