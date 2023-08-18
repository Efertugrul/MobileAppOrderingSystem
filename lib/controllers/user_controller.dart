import 'package:food_delivery_app/data/repository/user_repo.dart';
import 'package:food_delivery_app/models/user_model.dart';
import 'package:get/get.dart';
import '../models/response_model.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({required this.userRepo});

  bool _isLoading = false;
  bool _isReady = false;
  bool get isLoading => _isLoading;
  bool get isReady => _isReady;
  late UserModel? _userModel;
  UserModel? get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      _isLoading = true;
      responseModel = ResponseModel(true, "successful");
    } else {
      print("ERROR!!");
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    _isReady = true;
    return responseModel;
  }
}
