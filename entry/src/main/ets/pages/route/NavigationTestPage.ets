@Entry
@Component
struct NavigationTestPage {

  pageInfos: NavPathStack = new NavPathStack();

  build() {
    Navigation(this.pageInfos) {
      Column({ space: 12 }) {
        Button($r('app.string.entry_pageOne'), { stateEffect: true, type: ButtonType.Capsule })
          .width($r('app.string.button_width'))
          .height($r('app.string.button_height'))
          .onClick(() => {
            //Push the NavDestination page information specified by name onto the stack, and pass the data as param.
            this.pageInfos.pushPathByName('pageOne', null);
          })
        Button($r('app.string.entry_pageTwo'), { stateEffect: true, type: ButtonType.Capsule })
          .width($r('app.string.button_width'))
          .height($r('app.string.button_height'))
          .onClick(() => {
            //Push the NavDestination page information specified by name onto the stack, and pass the data as param.
            this.pageInfos.pushPathByName('pageTwo', null);
          })
        Button($r('app.string.harA_pageOne'), { stateEffect: true, type: ButtonType.Capsule })
          .width($r('app.string.button_width'))
          .height($r('app.string.button_height'))
          .onClick(() => {
            //Push the NavDestination page information specified by name onto the stack, and pass the data as param.
            this.pageInfos.pushPathByName('HarAPageOne', null);
          })
        Button($r('app.string.harA_pageTwo'), { stateEffect: true, type: ButtonType.Capsule })
          .width($r('app.string.button_width'))
          .height($r('app.string.button_height'))
          .onClick(() => {
            //Push the NavDestination page information specified by name onto the stack, and pass the data as param.
            this.pageInfos.pushPathByName('HarAPageTwo', null);
          })
        Button($r('app.string.hspA_pageOne'), { stateEffect: true, type: ButtonType.Capsule })
          .width($r('app.string.button_width'))
          .height($r('app.string.button_height'))
          .onClick(() => {
            //Push the NavDestination page information specified by name onto the stack, and pass the data as param.
            this.pageInfos.pushPathByName('HspAPageOne', null);
          })
        Button($r('app.string.hspA_pageTwo'), { stateEffect: true, type: ButtonType.Capsule })
          .width($r('app.string.button_width'))
          .height($r('app.string.button_height'))
          .onClick(() => {
            //Push the NavDestination page information specified by name onto the stack, and pass the data as param.
            this.pageInfos.pushPathByName('HspAPageTwo', null);
          })
      }
      .width($r('app.string.navDestination_width'))
      .height($r('app.string.navDestination_height'))
      .justifyContent(FlexAlign.End)
      .padding({
        bottom: $r('app.string.column_padding'),
        left: $r('app.string.column_padding'),
        right: $r('app.string.column_padding')
      })
    }
    .title($r('app.string.entry_index_title'))
  }
}