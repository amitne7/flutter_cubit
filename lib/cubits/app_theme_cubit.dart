import 'package:personal_security_officer/app/general_imports.dart';

class AppThemeCubit extends Cubit<ThemeState> {
  AppThemeCubit(this.settingRepository) : super(ThemeState(AppTheme.light));
  SettingRepository settingRepository;

  void changeTheme(final AppTheme appTheme) {
    emit(ThemeState(appTheme));
  }
}

class ThemeState {
  ThemeState(this.appTheme);
  final AppTheme appTheme;
}
