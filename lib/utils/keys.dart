
import 'package:flutter/material.dart';

class Keys {
  static LabeledGlobalKey<OverlayState> overlayKey = LabeledGlobalKey<OverlayState>('overlay');
  static LabeledGlobalKey<OverlayState> overlayProcessKey = LabeledGlobalKey<OverlayState>('overlayProcess');
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final scaffoldKey = GlobalKey<ScaffoldState>();
}