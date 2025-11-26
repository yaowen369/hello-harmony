// https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/arkts-navigation-navigation
import { LengthMetrics } from '@kit.ArkUI';

@Entry
@Component
struct NavigationTestPage {
  pageInfos: NavPathStack = new NavPathStack();

  @Builder
  buildNavButton(label: Resource, pathName: string) {
    Button(label, { stateEffect: true, type: ButtonType.Capsule })
      .onClick(() => {
        //Push the NavDestination page information specified by name onto the stack, and pass the data as param.
        this.pageInfos.pushPathByName(pathName, null);
      })
  }

  build() {
    Navigation(this.pageInfos) {
      Flex({
        direction: FlexDirection.Row,
        wrap: FlexWrap.Wrap,
        space: { main: new LengthMetrics(10), cross: new LengthMetrics(10) }
      }) {
        this.buildNavButton($r('app.string.entry_pageOne'), 'pageOne')
        this.buildNavButton($r('app.string.entry_pageTwo'), 'pageTwo')
        this.buildNavButton($r('app.string.harA_pageOne'), 'HarAPageOne')
        this.buildNavButton($r('app.string.harA_pageTwo'), 'HarAPageTwo')
        this.buildNavButton($r('app.string.hspA_pageOne'), 'HspAPageOne')
        this.buildNavButton($r('app.string.hspA_pageTwo'), 'HspAPageTwo')
      }.width('100%')
      .height('100%')

    }
    .title('NavigationTest页面')
  }
}