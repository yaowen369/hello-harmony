import router from '@ohos.router';
import { RouterParam } from '../param/GeneralParam';
import { Log } from '../utils/Log';
import { LengthMetrics, PromptAction } from '@kit.ArkUI';

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

      this.buildButton("测试", () => {
        try {
          this.getUIContext().getPromptAction().showToast({ message: '测试内容' })
        } catch (error) {
          // TODO: Implement error handling.
        }
      })


      this.buildButton('打开本地H5页面', () => {
        router.push({
          url: 'pages/NaWebViewPage'
        });
      })

      this.buildButton('打开H5页面', () => {
        router.push({
          url: 'pages/WebViewPage'
        });
      })

      this.buildButton('Router跳转page2', () => {
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
    this.buildButton('Navigation 测试页面', () => {
      Log.i("Navigation 跳转第二个页面")
      this.getUIContext().getRouter().pushUrl({
        url: 'pages/route/NavigationTestPage'
      })
    })
  }

  @Builder
  buildBuildFieldsButton() {
    this.buildButton('跳转编译参数页面', () => {
      Log.i("点击 跳转编译参数页面")
      this.getUIContext()
        .getRouter()
        .pushUrl({
          url: 'pages/buildFieldsPage'
        })
    })
  }

  @Builder
  buildButton(content: string, event: () => void) {
    Button(content)
      .fontSize(16)
      .onClick(() => {
        event()
      })
  }
}