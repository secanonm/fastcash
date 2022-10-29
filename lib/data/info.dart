import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

final userLocalData = GetStorage();

String? userId;
String? userMail;
String? userKey;

getUserLocalData() {
  userId = userLocalData.read('userId');
  userMail = userLocalData.read('userMail');
  userKey = userLocalData.read('userKey');
}

class UserDataController extends GetxController {
  var walletBalance = '0'.obs;
  var productId = [].obs;
  updateData(value) => walletBalance.value = value;
  updateProduct(value) => productId.value = value;
}

UserDataController userController = Get.put(UserDataController());
