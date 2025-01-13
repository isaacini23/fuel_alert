// =========== API ROUTES ==============

String baseUrl = "https://api.fuelalertng.com";

String login = "/api/v1/login";
String register = "/api/v1/register";
String verifyEmailOtp = "/api/v1/verify-email-otp";
String resetPassword = "/api/v1/reset-passeword";
String forgotPassword = "/api/v1/forgot-passeword";
String googleAuth = "/api/v1/google-signin";
String appleAuth = "/api/v1/apple-signin";
String resendEmail = "/api/v1/resend-email";
String deleteUser = "/api/v1/delete/";

String getProfile = "/api/v1/profile";
String updateProfile = "/api/v1/update-profile";
String changePassword = "/api/v1/change-password";

String getStationTypes = "/api/v1/stations/types";
String getAllStations = "/api/v1/stations/based-on-user-location";
String updateStationDetails = "/api/v1/stations";
String addToFavorite = "/api/v1/stations/add-to-favorite";
String removeFromFavorite = "/api/v1/stations/remove-from-favorite";
String getAllFavoriteStations = "/api/v1/stations/get-favorite-station";
String addStation = "/api/v1/stations/add";
String stationRating = "/api/v1/station/";
String stationSearch = "/api/v1/stations/search";
String getPriceReference = "/api/v1/stations/price-reference";
String filterStation = "/api/v1/stations/all";

String disableNotification = "/api/v1/disable-notification";
String enableNotification = "/api/v1/enable-notification";
String getNotification = "/api/v1/notifications/all";

String getRewardLeaderBoard = "/api/v1/rewards/leadershipboard";
String getPointsConfig = "/api/v1/rewards/points-config";
String updatePointsConfig = "/api/v1/rewards/update-points-config";

String getUserReviews = "/api/v1/users/reviews";