
import 'package:flutter/widgets.dart';

class Icons {

  // This class is not meant to be instatiated or extended; 
  // this constructor prevents instantiation and extension.
  Icons._();

  // fonts/MainIcons.ttf
  static const _family = 'FontIcons';

  static const IconData dashboard = IconData(0xe808, fontFamily: _family);
  static const IconData dashboard_outline = IconData(0xe801, fontFamily: _family);

  static const IconData community = IconData(0xe80b, fontFamily: _family);
  static const IconData community_outline = IconData(0xe800, fontFamily: _family);
  
  static const IconData settings = IconData(0xe809, fontFamily: _family);
  static const IconData settings_outline = IconData(0xe804, fontFamily: _family);

}