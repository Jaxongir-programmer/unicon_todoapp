import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const white = _white;

  static const defaultDark = _fgBase;
  static const dark70 = _fgBaseLight;
  static const placeHolder = _accentSubtl;
  static const buttonPrimaryLight = _accentSubtl;

  static const selectedLocaleAccent = _accentSubtl;
  static const localeButtonText = _accentBold;

  static const primaryColor = _accentModerate;
  static const primaryButtonColor = _accentModerate;

  static const onBoardDesc = _fgMuted;
  static const labelColor = _fgMuted;

  static const dotInactive = _bgMuted;
  static const dotActive = _accentModerate;
  static const dotActiveGray = _bgInteractive;

  static const borderColor = _bgMuted;
  static const dividerColor = _bgMuted;

  static const dropColor = _accentModerate;
  static const hintColor = _fgSubtl;

  static const selectedNavigation = _fgBase;
  static const unSelectedNavigation = _fgMuted;

  static const scaffoldBackground = _bgSubtl;
  static const containerBloc = _bgSubtl;
  static const unselectedButton = _bgSubtl;
  static const error = _fgDanger;

  static const tabSelected = _accentModerate;
  static const tabUnselected = _fgSubtl;

  static const disabledButton = _bgDisabled;
  static const disabledTextColor = _fgSubtl;

  static const successGreen = _fgSuccess;
  static const bgSuccess = _bgSuccess;
  static const infoBlue = _fgInfo;

  static const badgeColor = _yellow40;
  static const dangerColor = _bgDanger;
  static const accentDim = _accentDim;
  static const reservedBG = _yellow10;
  static const inactiveBG = _fgWaring;

  static const buttonGradient = LinearGradient(
    colors: [
      _accentBold,
      _accentModerate,
    ],
    begin: Alignment(0.0, -2.0),
    end: Alignment(0.0, 0.0),
  );

  // https://www.color-blin#7F0E45dness.com/color-name-hue/
  static const _white = Color(0xFFFFFFFF);
  static const _accentSubtl = Color(0xFFF2E7EC);
  static const _accentDim = Color(0xFFAF678A);
  static const _accentModerate = Color(0xFF7F0E45);
  static const _accentBold = Color(0xFF5B0A31);
  static const _yellow40 = Color(0xFFED9B16);
  static const _yellow10 = Color(0xFFFFF9E6);
  static const _fgBase = Color(0xFF131214);
  static const _fgBaseLight = Color(0xB2131214);
  static const _bgMuted = Color(0xFFE6E9EB);
  static const _bgSubtl = Color(0xFFF4F6F7);
  static const _bgInteractive = Color(0xFFC1C4C6);
  static const _fgSubtl = Color(0xFF898D8F);
  static const _fgMuted = Color(0xFF6E7375);
  static const _fgDanger = Color(0xFFCA244D);
  static const _bgDisabled = Color(0xFFDADDDE);
  static const _fgSuccess = Color(0xFF008557);
  static const _bgSuccess = Color(0xFFE8FAF0);
  static const _bgDanger = Color(0xFFD55071);
  static const _fgInfo = Color(0xFF0A69FA);
  static const _fgWaring = Color(0xFFB26205);
}
