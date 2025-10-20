import BuildProfile from 'entry/BuildProfile'

@Entry
@Component
struct buildFieldsPage{

  @State productValue:string = BuildProfile.productValue
  @State productBuildModeValue:string = BuildProfile.productBuildModeValue


  build() {

    Column() {
      Text('编译参数 页面2')
        .fontSize(16)
        .fontColor(Color.White)

      Text(this.productValue)
        .fontSize(16)

      Text(this.productBuildModeValue)
        .fontSize(16)

    }.width('100%')
    .height('100%')
    .backgroundColor(Color.Gray)
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(HorizontalAlign.Center)

  }
}