import 'package:drone_vision/services/api_service.dart';
import 'package:drone_vision/services/connectivity_service.dart';
import 'package:drone_vision/services/token_service.dart';
import 'package:drone_vision/ui/views/index/index_view.dart';
import 'package:drone_vision/ui/views/login/login_view.dart';
import 'package:drone_vision/ui/views/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  dependencies: [
    LazySingleton(classType: DialogService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: TokenService),
    LazySingleton(classType: ConnectivityService),
    LazySingleton(classType: ApiService),
  ],
  routes: [
    MaterialRoute(
      page: SplashView,
      name: 'splashView',
      initial: true,
    ),
    MaterialRoute(
      page: IndexView,
      name: 'homeView',
    ),
    MaterialRoute(
      page: LoginView,
      name: 'loginView',
    ),
  ],
)
class App {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/
}