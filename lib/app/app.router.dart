// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i7;

import 'package:flutter/material.dart' as _i6;
import 'package:flutter/material.dart';
import 'package:qr_attendance_system/ui/views/auth/screens/auth_view.dart'
    as _i3;
import 'package:qr_attendance_system/ui/views/class_attendance/screens/class_attendance_view.dart'
    as _i5;
import 'package:qr_attendance_system/ui/views/profile/screens/profile_view.dart'
    as _i4;
import 'package:qr_attendance_system/ui/views/startup/startup_view.dart' as _i2;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i8;

class Routes {
  static const startupView = '/startup-view';

  static const authView = '/auth-view';

  static const profileView = '/profile-view';

  static const classAttendanceView = '/class-attendance-view';

  static const all = <String>{
    startupView,
    authView,
    profileView,
    classAttendanceView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.startupView,
      page: _i2.StartupView,
    ),
    _i1.RouteDef(
      Routes.authView,
      page: _i3.AuthView,
    ),
    _i1.RouteDef(
      Routes.profileView,
      page: _i4.ProfileView,
    ),
    _i1.RouteDef(
      Routes.classAttendanceView,
      page: _i5.ClassAttendanceView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.StartupView: (data) {
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.StartupView(),
        settings: data,
      );
    },
    _i3.AuthView: (data) {
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.AuthView(),
        settings: data,
      );
    },
    _i4.ProfileView: (data) {
      final args = data.getArgs<ProfileViewArguments>(nullOk: false);
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i4.ProfileView(key: args.key, text: args.text, color: args.color),
        settings: data,
      );
    },
    _i5.ClassAttendanceView: (data) {
      final args = data.getArgs<ClassAttendanceViewArguments>(nullOk: false);
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.ClassAttendanceView(
            key: args.key, text: args.text, color: args.color),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class ProfileViewArguments {
  const ProfileViewArguments({
    this.key,
    required this.text,
    required this.color,
  });

  final _i6.Key? key;

  final String text;

  final _i7.Color color;

  @override
  String toString() {
    return '{"key": "$key", "text": "$text", "color": "$color"}';
  }

  @override
  bool operator ==(covariant ProfileViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.text == text && other.color == color;
  }

  @override
  int get hashCode {
    return key.hashCode ^ text.hashCode ^ color.hashCode;
  }
}

class ClassAttendanceViewArguments {
  const ClassAttendanceViewArguments({
    this.key,
    required this.text,
    required this.color,
  });

  final _i6.Key? key;

  final String text;

  final _i7.Color color;

  @override
  String toString() {
    return '{"key": "$key", "text": "$text", "color": "$color"}';
  }

  @override
  bool operator ==(covariant ClassAttendanceViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.text == text && other.color == color;
  }

  @override
  int get hashCode {
    return key.hashCode ^ text.hashCode ^ color.hashCode;
  }
}

extension NavigatorStateExtension on _i8.NavigationService {
  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAuthView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.authView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileView({
    _i6.Key? key,
    required String text,
    required _i7.Color color,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.profileView,
        arguments: ProfileViewArguments(key: key, text: text, color: color),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToClassAttendanceView({
    _i6.Key? key,
    required String text,
    required _i7.Color color,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.classAttendanceView,
        arguments:
            ClassAttendanceViewArguments(key: key, text: text, color: color),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAuthView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.authView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileView({
    _i6.Key? key,
    required String text,
    required _i7.Color color,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.profileView,
        arguments: ProfileViewArguments(key: key, text: text, color: color),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithClassAttendanceView({
    _i6.Key? key,
    required String text,
    required _i7.Color color,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.classAttendanceView,
        arguments:
            ClassAttendanceViewArguments(key: key, text: text, color: color),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
