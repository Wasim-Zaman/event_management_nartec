import 'package:event_management/common/constants/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppToasts {
  static var errorToast = (String message) => Fluttertoast.showToast(
        msg: message.replaceAll("Exception:", ""),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.dangerColor,
        textColor: AppColors.appWhiteColor,
        fontSize: 16.0,
      );

  static var successToast = (String message) => Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.successColor,
        textColor: AppColors.appWhiteColor,
        fontSize: 16.0,
      );
}
