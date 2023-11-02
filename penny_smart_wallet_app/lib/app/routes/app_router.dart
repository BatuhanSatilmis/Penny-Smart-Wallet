import 'package:penny_smart_wallet/app/views/view_add/add_view.dart';
import 'package:penny_smart_wallet/app/views/view_calculation/calculation.dart';
import 'package:penny_smart_wallet/app/views/view_edit_account/edit_account_view.dart';
import 'package:penny_smart_wallet/app/views/view_forgot_password/forgot_password_view.dart';
import 'package:penny_smart_wallet/app/views/view_home/home.dart';
import 'package:penny_smart_wallet/app/views/view_login/login_view.dart';
import 'package:penny_smart_wallet/app/views/view_settings/settings_view.dart';
import 'package:penny_smart_wallet/app/views/view_signup/signup_view.dart';
import 'package:penny_smart_wallet/app/views/view_splashscreen/splashscreen_view.dart';
import 'package:penny_smart_wallet/app/views/view_statistics/statistics_view.dart';
import 'package:penny_smart_wallet/core/widgets/bottomnavigationbar.dart';
import 'package:auto_route/auto_route.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'View',
)
class AppRouter extends _$AppRouter {
  final List<AutoRoute> routes = [
    AutoRoute(
      page: SplashScreenViewRoute.page,
      initial: true,
    ),
    AutoRoute(page: BottomViewRoute.page),
    AutoRoute(page: LoginPageViewRoute.page),
    AutoRoute(page: HomeViewRoute.page),
    AutoRoute(page: AddViewRoute.page),
    AutoRoute(page: ForgotPasswordViewRoute.page),
    AutoRoute(page: SettingsViewRoute.page),
    AutoRoute(page: EditAccountViewRoute.page),
    AutoRoute(page: CalculationViewRoute.page),
    AutoRoute(page: StatisticsViewRoute.page),
    AutoRoute(page: SignUpViewRoute.page),
  ];
}
