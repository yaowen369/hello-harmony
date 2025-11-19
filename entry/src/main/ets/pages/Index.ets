import router from '@ohos.router';
import { RouterParam } from '../param/GeneralParam';
import { Log } from '../utils/Log';
import { LengthMetrics } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World2';

  build() {
    Flex({
      direction: FlexDirection.Row,
      wrap: FlexWrap.Wrap,
      space: { main: new LengthMetrics(10), cross: new LengthMetrics(10) }
    }) {
      // 最上方的按钮 - 跳转到NaWebViewPage
      Button('打开本地H5页面')
        .id('naWebViewButton')
        .fontSize(16)
        .onClick(() => {
          router.push({
            url: 'pages/NaWebViewPage'
          });
        })


      Button('打开H5页面')
        .id('webViewButton')
        .fontSize(16)
        .onClick(() => {
          router.push({
            url: 'pages/WebViewPage'
          });
        })

      Button('Router跳转page2')
        .id('secondPageBtn')
        .fontSize(16)
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


      this.buildBuildFieldsButton()

      this.jumpNavigationBtn()

    }
  }

  @Builder
  jumpNavigationBtn() {
    Button('Navigation 测试页面')
      .id('jumpNavigaBtn')
      .fontSize(16)
      .onClick(() => {
        Log.i("Navigation 跳转第二个页面")
        this.getUIContext().getRouter().pushUrl({
          url: 'pages/route/NavigationTestPage'
        })
      })
  }

  @Builder
  buildBuildFieldsButton() {
    Button('跳转编译参数页面')
      .id('buildFieldsPageBtn')
      .fontSize(16)
      .onClick(() => {
        Log.i("点击 跳转编译参数页面")
        this.getUIContext()
          .getRouter()
          .pushUrl({
            url: 'pages/buildFieldsPage'
          })
      })
  }
}