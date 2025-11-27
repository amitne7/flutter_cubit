export 'dart:async';
export 'dart:convert';
export 'dart:io';
export 'dart:math';

export 'package:flutter/gestures.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:flutter/foundation.dart';
export 'package:flutter/scheduler.dart';
export 'package:flutter/services.dart';
export 'package:flutter_localizations/flutter_localizations.dart';
export 'package:flutter_svg/flutter_svg.dart';
export 'package:package_info_plus/package_info_plus.dart';
export 'package:toastification/toastification.dart';
export 'package:awesome_notifications/awesome_notifications.dart';
export 'package:path_provider/path_provider.dart';
export 'package:share_plus/share_plus.dart';
export 'package:firebase_auth/firebase_auth.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:firebase_messaging/firebase_messaging.dart';
export 'package:url_launcher/url_launcher.dart';
export 'package:version/version.dart';
export 'package:google_maps_flutter/google_maps_flutter.dart';
export 'package:shimmer/shimmer.dart';

// Utils

export '../utils/ui_utils.dart';
export '../utils/constant.dart';
export '../utils/app_extensions.dart';
export '../utils/colors.dart';
export '../utils/validation.dart';
export '../utils/string_extension.dart';
export '../utils/api.dart';
export '../utils/notification/notification_service.dart';
export '../utils/notification/awesome_notifications.dart';
export '../utils/notification/chat_notifications_utils.dart';

// Widgets

export '../widget/custom_text.dart';
export '../widget/custom_container.dart';
export '../widget/custom_size_box.dart';
export '../widget/custom_svg_picture.dart';
export '../widget/custom_ink_well_container.dart';
export '../widget/custom_rounded_button.dart';
export '../widget/not_found_widget.dart';
export '../widget/custom_circular_progress_indicator.dart';
export '../widget/close_and_confirm_dialog.dart';
export '../widget/dialog/custom_dialog_layout.dart';
export '../widget/dialog/layouts/login_account_dialog.dart';
export '../widget/error_container.dart';
export '../widget/custom_check_box.dart';
export '../widget/bottomsheets/bottom_sheet_layout.dart';
export '../widget/bottomsheets/layout/choose_language_bottom_sheet.dart';
export '../widget/custom_divider.dart';
export '../widget/custom_cached_network.dart';
export '../widget/custom_switch.dart';
export '../widget/custom_text_form_feild.dart';
export '../widget/custom_refresh_indicator.dart';


// App theme 
export 'package:personal_security_officer/app/app_theme.dart';

// Data Model
export '../data/model/app_language_model.dart';
export '../data/model/intro_screen_model.dart';
export '../data/model/booking_model.dart';
export '../data/model/system_setting_model.dart';
export '../data/model/chat/chat_message.dart';
export '../data/model/chat/chat_user.dart';
export '../data/model/chat/chat_notification_data.dart';
export '../data/model/home_screen_model.dart';
export '../data/model/address_model.dart';
export '../data/model/get_address_model.dart';
export '../data/model/service_model.dart';
export '../data/model/providers_model.dart';
export '../data/model/places_model.dart';
export '../data/model/user_model.dart';
export '../data/model/payment_model.dart';
export '../data/model/faqs.dart';
export '../data/model/update_user_details_model.dart';
export '../data/model/notification_model.dart';


// Repository
export '../data/repository/hive_repository.dart';
export '../data/repository/booking_repository.dart';
export '../data/repository/authentication_repository.dart';
export '../data/repository/setting_repository.dart';
export '../data/repository/chat/chat_notifications_repository.dart';
export '../data/repository/home_screen_repository.dart';
export '../data/repository/location_repository.dart';
export '../data/repository/address_repository.dart';
export '../data/repository/provider_repository.dart';
export '../data/repository/google_place_repository.dart';
export '../data/repository/system_repository.dart';
export '../data/repository/update_user_repository.dart';
export '../data/repository/notification_repository.dart';


// Cubit
export 'package:personal_security_officer/cubits/add_transaction_cubit.dart';
export 'package:personal_security_officer/cubits/authentication/authentication_cubit.dart';
export 'package:personal_security_officer/cubits/app_theme_cubit.dart';
export 'package:personal_security_officer/cubits/language_cubit.dart';
export 'package:personal_security_officer/cubits/load_country_code_cubit.dart';
export 'package:personal_security_officer/cubits/system_setting_cubit.dart';
export 'package:personal_security_officer/cubits/user_details_cubit.dart';
export 'package:personal_security_officer/cubits/authentication/verify_otp_cubit.dart';
export 'package:personal_security_officer/cubits/authentication/resend_otp_cubit.dart';
export 'package:personal_security_officer/cubits/addresscubit/address_cubit.dart';
export 'package:personal_security_officer/cubits/fetch_user_curtrent_location.dart';
export 'package:personal_security_officer/cubits/check_provider_availability.dart';
export 'package:personal_security_officer/cubits/google_place_cubit.dart';
export 'package:personal_security_officer/cubits/send_query_to_admin_cubit.dart';
export 'package:personal_security_officer/cubits/update_user_cubit.dart';
export 'package:personal_security_officer/cubits/faq_cubit.dart';



// App
export '../app/app_localization.dart';
export '../app/app_assets.dart';
export '../app/routes.dart';



export 'package:hive_flutter/adapters.dart';
export 'package:hive_flutter/hive_flutter.dart';
export 'package:open_filex/open_filex.dart';
export 'package:image_picker/image_picker.dart';
export 'package:mime/mime.dart';
export 'package:http_parser/http_parser.dart';
export 'package:geocoding/geocoding.dart';
export 'package:geolocator/geolocator.dart';

// Screen
export '../screen/bottom_navigation_bar_screen.dart';
export '../screen/splash_screen.dart';
export 'package:personal_security_officer/screen/customer/authentication/login_customer_screen.dart';
export 'package:personal_security_officer/screen/not_available_screen.dart';
export 'package:personal_security_officer/screen/bookings_screen.dart';
export 'package:personal_security_officer/screen/category_screen.dart';
export 'package:personal_security_officer/screen/customer/home/home_screen.dart';
export 'package:personal_security_officer/screen/my_request_list_screen.dart';
export 'package:personal_security_officer/screen/profile_screen.dart';
export 'package:personal_security_officer/screen/app_setting.dart';
export 'package:personal_security_officer/screen/customer/authentication/otp_verification_customer_screen.dart';
export 'package:personal_security_officer/screen/google_map_screen.dart';
export 'package:personal_security_officer/screen/contact_us.dart';
export 'package:personal_security_officer/screen/edit_profile_screen.dart';
export 'package:personal_security_officer/screen/faq_screen.dart';


// export '../ui/widgets/starRating.dart';
// export '../utils/api.dart';
// export '../utils/appQuickActions.dart';

// export '../utils/counter.dart';
// export '../utils/firebaseErrorCode.dart';
// export '../utils/notification/awesomeNotification.dart';
// export '../utils/notification/notificationService.dart';
// export '../utils/stringExtension.dart';
// export '../utils/stripeService.dart';
// export '../utils/time_selector.dart';

// export '../utils/validation.dart';
// export 'package:e_demand/data/model/allCategoryModel.dart';
// export 'package:e_demand/cubits/allCategoryCubit.dart';
