
@Entry
@Component
struct buildFieldsPage{
  build() {

    Column() {
      Text('编译参数 页面')
        .fontSize(16)
        .fontColor(Color.White)



    }.width('100%')
    .height('100%')
    .backgroundColor(Color.Gray)
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(HorizontalAlign.Center)

  }
}