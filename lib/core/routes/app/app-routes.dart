import 'package:fuel_alert/core/routes/app/app-route-names.dart';
import 'package:fuel_alert/screens/authentication/forgot-password/forgot-password-screen.dart';
import 'package:fuel_alert/screens/authentication/forgot-password/reset-password-screen.dart';
import 'package:fuel_alert/screens/authentication/forgot-password/verify-password-screen.dart';
import 'package:fuel_alert/screens/authentication/sign-in/sign-in-screen.dart';
import 'package:fuel_alert/screens/authentication/sign-up/sign-up-screen.dart';
import 'package:fuel_alert/screens/authentication/sign-up/verify-email-screen.dart';
import 'package:fuel_alert/screens/dashboard/dashboard.dart';
import 'package:fuel_alert/screens/dashboard/views/home/filter/filter-screen.dart';
import 'package:fuel_alert/screens/dashboard/views/rewards/views/rules.dart';
import 'package:fuel_alert/screens/dashboard/views/rewards/views/top-contributors.dart';
import 'package:fuel_alert/screens/dashboard/views/settings/changeLocation/change-location.dart';
import 'package:fuel_alert/screens/dashboard/views/settings/changePassword/change-password.dart';
import 'package:fuel_alert/screens/dashboard/views/settings/myPoints/my-points.dart';
import 'package:fuel_alert/screens/dashboard/views/settings/myReviews/my-reviews.dart';
import 'package:fuel_alert/screens/dashboard/views/settings/myRewards/my-rewards.dart';
import 'package:fuel_alert/screens/dashboard/views/settings/notifications/notification-view.dart';
import 'package:fuel_alert/screens/dashboard/views/settings/profile/profile.dart';
import 'package:fuel_alert/screens/dashboard/views/station-details/pump-scale-screen.dart';
import 'package:fuel_alert/screens/dashboard/views/station-details/queue-report-screen.dart';
import 'package:fuel_alert/screens/dashboard/views/station-details/rating-review-screen.dart';
import 'package:fuel_alert/screens/dashboard/views/station-details/station-details-view.dart';
import 'package:fuel_alert/screens/dashboard/views/station-details/submit-price-screen.dart';
import 'package:fuel_alert/screens/onboarding/onboarding-screen.dart';
import 'package:fuel_alert/screens/splash/splash.dart';
import 'package:get/route_manager.dart';

// ================ APP ROUTES ===============

List<GetPage> getPages = [
  GetPage(
      name: splashScreen,
      transition: Transition.cupertino,
      page: () => SplashScreen()),
  GetPage(
      name: onboardingScreen,
      transition: Transition.cupertino,
      page: () => OnboardingScreen()),
  GetPage(
      name: signInScreen,
      transition: Transition.cupertino,
      page: () => SignInScreen()),
  GetPage(
      name: signUpScreen,
      transition: Transition.cupertino,
      page: () => SignUpScreen()),
  GetPage(
      name: verifyEmailScreen,
      transition: Transition.cupertino,
      page: () => VerifyEmailScreen()),
  GetPage(
      name: forgotPasswordScreen,
      transition: Transition.cupertino,
      page: () => ForgotPasswordScreen()),
  GetPage(
      name: resetPasswordScreen,
      transition: Transition.cupertino,
      page: () => ResetPasswordScreen()),
  GetPage(
      name: verifyPasswordScreen,
      transition: Transition.cupertino,
      page: () => PasswordVerifyEmailScreen()),
  GetPage(
      name: dashboard,
      transition: Transition.cupertino,
      page: () => DashboardScreen()),
  GetPage(
      name: profileView,
      transition: Transition.cupertino,
      page: () => ProfileView()),
  GetPage(
      name: notificationView,
      transition: Transition.cupertino,
      page: () => NotificationView()),
  GetPage(
      name: changePasswordView,
      transition: Transition.cupertino,
      page: () => ChangePasswordView()),
  GetPage(
      name: changeLocationView,
      transition: Transition.cupertino,
      page: () => ChangeLocationScreen()),
  GetPage(
      name: notificationView,
      transition: Transition.cupertino,
      page: () => NotificationView()),
  GetPage(
      name: myPointsView,
      transition: Transition.cupertino,
      page: () => MyPointsView()),
  GetPage(
      name: myRewardsView,
      transition: Transition.cupertino,
      page: () => MyRewardsView()),
  GetPage(
      name: myReviewView,
      transition: Transition.cupertino,
      page: () => MyReviewsView()),
  GetPage(
      name: changePasswordView,
      transition: Transition.cupertino,
      page: () => ChangePasswordView()),
  GetPage(
      name: topContributorsScreen,
      transition: Transition.cupertino,
      page: () => TopContributorsScreen()),
  GetPage(
      name: rulesScreen,
      transition: Transition.cupertino,
      page: () => RulesView()),
  GetPage(
      name: stationDetailsScreen,
      transition: Transition.cupertino,
      page: () => StationDetailsView()),
  GetPage(
      name: pumpScaleScreen,
      transition: Transition.cupertino,
      page: () => PumpScaleScreen()),
  GetPage(
      name: submitPriceScreen,
      transition: Transition.cupertino,
      page: () => SubmitPriceScreen()),
  GetPage(
      name: queueReportScreen,
      transition: Transition.cupertino,
      page: () => QueueReportScreen()),
  GetPage(
      name: ratingAndReviewScreen,
      transition: Transition.cupertino,
      page: () => RatingReviewScreen()),
  GetPage(
      name: filterStationScreen,
      transition: Transition.cupertino,
      page: () => FilterScreen()),
];
