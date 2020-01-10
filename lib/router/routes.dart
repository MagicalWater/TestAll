/// page 在此處定義
/// 會自動創建 bloc route_mixin page
class Pages {
  /// 導覽頁(入口頁)
  static const exLaunch = "/exLaunch";

  /// 導覽頁的子頁面
  static const exSubLaunch = "$exLaunch/exSubLaunch";

  /// 首頁
  static const exHome = "/exHome";

  /// 首頁的子頁面
  static const exSubHome = "$exHome/exSubHome";

  /// 首頁的子頁面的子頁面
  static const exSubSubHome = "$exSubHome/exSubSubHome";

  /// 導覽頁
  static const navigation = "/navigation";

  /// 主頁面
  static const main = "/main";

  /// 首頁
  static const home = "$main/home";

  /// 戲劇Drama
  static const drama = "$main/drama";

  /// 電影
  static const movie = "$main/movie";

  /// 綜藝Variety Show
  static const varietyShow = "$main/varietyShow";

  /// 動漫cartoon
  static const cartoon = "$main/cartoon";

  /// 成人Adult Video
  static const adultVideo = "$main/adultVideo";

  /// 戲劇Drama
  static const dramaHot = "$drama/dramaHot";

  /// 戲劇Drama
  static const dramaNew = "$drama/dramaNew";

  Pages._();
}

/// bloc 需要從 router 取用的 query key
class BlocKeys {
  static const exKey = "exKey";

  BlocKeys._();
}

/// page 需要從 router 取用的 query key
class PageKeys {
  static const exKey = "exKey";

  PageKeys._();
}
