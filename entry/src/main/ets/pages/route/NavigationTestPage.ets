@Entry
@Component
struct NavigationTestPage {

  pageInfos: NavPathStack = new NavPathStack();

  @Builder
  buildNavButton(label: Resource, pathName: string) {
    Button(label, { stateEffect: true, type: ButtonType.Capsule })
      .width($r('app.string.button_width'))
      .height($r('app.string.button_height'))
      .onClick(() => {
        //Push the NavDestination page information specified by name onto the stack, and pass the data as param.
        this.pageInfos.pushPathByName(pathName, null);
      })
  }

  build() {
    Navigation(this.pageInfos) {
      Column({ space: 12 }) {
        this.buildNavButton($r('app.string.entry_pageOne'), 'pageOne')
        this.buildNavButton($r('app.string.entry_pageTwo'), 'pageTwo')
        this.buildNavButton($r('app.string.harA_pageOne'), 'HarAPageOne')
        this.buildNavButton($r('app.string.harA_pageTwo'), 'HarAPageTwo')
        this.buildNavButton($r('app.string.hspA_pageOne'), 'HspAPageOne')
        this.buildNavButton($r('app.string.hspA_pageTwo'), 'HspAPageTwo')
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