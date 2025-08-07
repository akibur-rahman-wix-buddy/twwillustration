

const String baseUrl = "https://alex.softvencefsd.xyz";

class Endpoints {
  Endpoints._();



  ///>>>>>>>>>>>>>>>>>>>>> auth and forget >>>>>>>>>>>>>>>>>>>>>>>>>
  static String login() => "/api/login";
  static String postEmailForgetApiLink() =>"/api/forget-password";
  static String otpForgetApiLink() =>"/api/check-otp";
  static String forgetPasswordChangeApiLink() =>"/api/reset-password";
  static String logout() =>"/api/logout";


  ///>>>>>>>>>>>>>>>>>>>>>>>>>>> update profile >>>>>>>>>>>>>>>>>>>>>>>>>>

  static String postEditProfileApiLink()=> "/api/user-update";
  static String helpCenterApi()=> "/api/social-media";
  static String privacyApiData(String apiLink)=> "$apiLink";

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>> home screen api link >>>>>>>>>>>>>>>>>>>>>>>

static String userInfo()=> "/api/dashboard";
static String resendDocumentsData()=> "/api/dashboard/doucment";
static String homeInvoiceApiLink()=> "/api/dashboard/invoice";


///>>>>>>>>>>>>>>>>>>>>>>>>>>>> Document screen api link >>>>>>>>>>>>>>>>>>>>>>>

static String documentYearApiLink()=>"/api/document/year";
static String allDocumentApiLink()=>"/api/document/year";


///>>>>>>>>>>>>>>>>>> invoice all api link >>>>>>>>>>>>>>

static String invoiceAllDataApiLink()=> "/api/invoice";
static String invoicePayment()=> "/api/stripe/checkout";


}

final class PaymentGateway {
  PaymentGateway._();
  static String gateway() => "/create-payment-intent";
}

final class NetworkConstants {
  NetworkConstants._();
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "pt";
  static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE");
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}
