///广告类型
enum AdType {
  ///开屏
  Splash,

  ///横幅
  Banner,

  ///原生
  Native,


  ///激励
  Reward
}

///广告操作
enum AdOp {
  Load,
  ShowSplash,
}

///加载状态
enum AdLoadStatus {
  Loading,
  Loaded,
  LoadFailed,
}
