import router from '@ohos.router';
import { RouterParam } from '../param/GeneralParam';
import { Log } from '../utils/Log';

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
        .padding({
          left: 20,
          right: 20,
          top: 10,
          bottom: 10
        })
        .alignRules({
          bottom: { anchor: '__container__', align: VerticalAlign.Bottom },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          router.push({
            url: 'pages/WebViewPage'
          });
        })
        .width("90%")

      Button('Router跳转page2')
        .id('secondPageBtn')
        .fontSize(16)
        .margin({
          bottom: 20
        })
        .alignRules({
          bottom: { anchor: 'webViewButton', align: VerticalAlign.Top },
          left: { anchor: 'webViewButton', align: HorizontalAlign.Start },
          right: { anchor: 'webViewButton', align: HorizontalAlign.End }
        })
        .onClick(() => {
          this.getUIContext()
            .getRouter()
            .pushUrl({
              url: 'pages/SecondPage',
              params: new RouterParam("从第一页传递值", [12, 34, 56])
            })
            .then(() => {
              Log.i("跳转seccond页面 then结果");
            })
            .catch((err: ESObject) => {
              Log.i(`跳转Second页面, code is ${(err as BusinessError<number>).code},
                    message is ${(err as BusinessError<string>).message}`)
            })
        })

    }
    .height('100%')
    .width('100%')
  }
}