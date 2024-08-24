import 'package:flutter_test/flutter_test.dart';
import 'package:qr_attendance_system/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('ClassAttendanceViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
