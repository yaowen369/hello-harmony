import web_webview from '@ohos.web.webview';
import router from '@ohos.router';

@Entry
@Component
struct WebViewPage {
  private controller: web_webview.WebviewController = new web_webview.WebviewController();
  private h5Url: string = 'https://www.wenjuan.com/s/YZbIZ3a/';

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Button('返回')
          .onClick(() => {
            router.back();
          })
          .margin({ left: 16 })
        Text('WebView页面')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .flexGrow(1)
          .textAlign(TextAlign.Center)
        Blank()
          .width(60)
      }
      .height(56)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#f5f5f5')

      // WebView组件
      Web({ src: this.h5Url, controller: this.controller })
        .width('100%')
        .height('100%')
        .multiWindowAccess(false)
        .javaScriptAccess(true)
        .geolocationAccess(true)
        .verticalScrollBarAccess(true)
        .imageAccess(true)
        .onlineImageAccess(true)
        .domStorageAccess(true)
        .fileAccess(true)
        .mediaPlayGestureAccess(true)
        .mixedMode(MixedMode.Compatible)
    }
    .height('100%')
    .width('100%')
  }
}