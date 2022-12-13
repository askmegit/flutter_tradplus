class NativeCustomTemplateItem {
  String name;
  NativeCustomTemplateItemAttr attr;

  NativeCustomTemplateItem(this.name, this.attr);
}

class NativeCustomTemplateItemName {
  NativeCustomTemplateItemName._();

  ///背景
  static final String parent = "parent";

  ///广告图标
  static final String appIcon = "appIcon";

  ///广告大图
  static final String mainImage = "mainImage";

  ///标题
  static final String mainTitle = "mainTitle";

  ///副标题(内容)
  static final String desc = "desc";

  ///广告源logo(角标)
  static final String adLogo = "adLogo";

  ///下载按钮
  static final String cta = "cta";
}

///原生广告自定义模板属性
class NativeCustomTemplateItemAttr {
  ///宽度
  final double width;

  ///高度
  final double height;

  ///横坐标
  final double x;

  ///纵坐标
  final double y;

  ///背景色(16进制eg:#ffffff)
  final String backgroundColorStr;

  ///文字样式
  final String textColorStr;
  final double textSize;

  ///文字是否居中
  final bool textCenter;
  ///文字最大行数,默认-1不限制
  final int textLines;

  ///是否可点击
  final bool isCanClick;

  NativeCustomTemplateItemAttr(
      {this.width = 0,
      this.height = 0,
      this.x = 0,
      this.y = 0,
      this.textCenter = true,
      this.backgroundColorStr = "#00000000",
      this.textColorStr = "#000000",
      this.textLines = -1,
      this.textSize = 14,
      this.isCanClick = true});

  Map toMap() {
    return {
      'x': x,
      'y': y,
      'width': width,
      'height': height,
      'backgroundColorStr': backgroundColorStr,
      'textColorStr': textColorStr,
      'textSize': textSize,
      'textLines': textLines,
      'isCustomClick': isCanClick,
      "textCenter": textCenter,
    };
  }
}
