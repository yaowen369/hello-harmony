import router from '@ohos.router';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World2';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('HelloWorld')
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          this.message = 'Welcome';
        })
      
      Button('打开H5页面')
        .id('webViewButton')
        .fontSize(16)
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })
        .alignRules({
          bottom: { anchor: '__container__', align: VerticalAlign.Bottom },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          router.push({
            url: 'pages/WebViewPage'
          });
        })
    }
    .height('100%')
    .width('100%')
  }
}