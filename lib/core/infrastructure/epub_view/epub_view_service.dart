import 'package:vocsy_epub_viewer/epub_viewer.dart';

import '../../theme/app_colors.dart';

class EpubViewService {
  EpubViewService._();

  static EpubViewService get instance => EpubViewService._();

  void config() {
    VocsyEpub.setConfig(
      themeColor: AppColors.primaryColor,
      identifier: 'iosBook',
      allowSharing: true,
      enableTts: true,
      nightMode: true,
    );
  }

  void openAsset(String path) {
    config();
    VocsyEpub.open(
      path,
      lastLocation: EpubLocator.fromJson({
        'bookId': '2239',
        'href': '/OEBPS/ch06.xhtml',
        'created': 1539934158390,
        'locations': {'cfi': 'epubcfi(/0!/4/4[simple_book]/2/2/6)'},
      }),
    );
  }
}
