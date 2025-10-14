import { innerParam, RouterParam } from '../param/GeneralParam'

@Entry
@Component
struct SecondPage {

  @State text:string = (this.getUIContext().getRouter().getParams() as RouterParam).text
  @State data:innerParam = (this.getUIContext().getRouter().getParams() as RouterParam).data



  build() {
    Column() {
      Text('第二个page')
        .fontSize(16)
        .fontColor(Color.Red)

      Text(this.text)
        .fontColor(Color.Blue)

      Text(this.data.toString())
        .fontColor(Color.Yellow)

    }.width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(HorizontalAlign.Center)
  }
}