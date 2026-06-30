import 'package:flutter/material.dart';

abstract final class AppColors {
  // ── Backgrounds ───────────────────────────────────────────────────────────
  static const background = Color(0xFF080D1A);
  static const surface = Color(0xFF0F1628);
  static const surfaceContainer = Color(0xFF172035);
  static const surfaceContainerHigh = Color(0xFF1E2B44);

  // ── Primary ───────────────────────────────────────────────────────────────
  static const primary = Color(0xFF4B8EF0);
  static const primaryDim = Color(0xFF2D6BCF);
  static const onPrimary = Color(0xFF0A1428);

  // ── Semantic ──────────────────────────────────────────────────────────────
  static const online = Color(0xFF34C759);
  static const offline = Color(0xFF636E82);
  static const warning = Color(0xFFFF9F0A);
  static const error = Color(0xFFFF453A);

  // ── Content ───────────────────────────────────────────────────────────────
  static const onSurface = Color(0xFFDDE4F0);
  static const onSurfaceMuted = Color(0xFF7A8BA8);
  static const border = Color(0x1AFFFFFF); // 10% white

  // ── Meter type accents ────────────────────────────────────────────────────
  static const electricity = Color(0xFFF5C842);
  static const gas = Color(0xFFFF6B35);
  static const water = Color(0xFF4FC3F7);
}
