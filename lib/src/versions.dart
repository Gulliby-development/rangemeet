/// Parsing, comparison and formatting helpers for versions.
library;

import 'registry.dart';

/// Parses a canonical ASCII decimal number in the supported input range.
int? parseNumber(String text) {
  if (text.isEmpty || (text.length > 1 && text.codeUnitAt(0) == 0x30)) {
    return null;
  }

  var value = 0;
  for (final codeUnit in text.codeUnits) {
    if (codeUnit < 0x30 || codeUnit > 0x39) {
      return null;
    }
    final digit = codeUnit - 0x30;
    if (value > (maxNumber - digit) ~/ 10) {
      return null;
    }
    value = value * 10 + digit;
  }
  return value;
}

/// Parses exactly three canonical, dot-separated version components.
Version? parseVersion(String text) {
  final parts = text.split('.');
  if (parts.length != 3) {
    return null;
  }

  final major = parseNumber(parts[0]);
  final minor = parseNumber(parts[1]);
  final patch = parseNumber(parts[2]);
  if (major == null || minor == null || patch == null) {
    return null;
  }
  return Version(major, minor, patch);
}

/// Compares versions by their numeric major, minor and patch components.
int compareVersions(Version a, Version b) {
  final major = a.major.compareTo(b.major);
  if (major != 0) {
    return major;
  }
  final minor = a.minor.compareTo(b.minor);
  if (minor != 0) {
    return minor;
  }
  return a.patch.compareTo(b.patch);
}

/// Writes all three numeric components, including generated endpoints of 10000.
String versionText(Version version) => '${version.major}.${version.minor}.${version.patch}';
