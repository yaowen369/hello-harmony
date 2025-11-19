import { Log } from '../../utils/Log';

// https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-basic-components-navigation#%E7%A4%BA%E4%BE%8B1navigation%E9%A1%B5%E9%9D%A2%E5%B8%83%E5%B1%80
@Entry
@Component
struct NavigationExample_1 {
  private arr: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  @Builder
  NavigationTitle() {
    Column() {
      Text('Title')
        .fontColor('#182431')
        .fontSize(30)
        .lineHeight(41)
        .fontWeight(700)

      Text("subtitle")
        .fontColor('#182431')
        .fontSize(14)
        .lineHeight(19)
        .opacity(0.4)
        .margin({ top: 2, bottom: 20 })

    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  NavigationMenus() {
    Row() {
      Image($r('app.media.icon_add'))
        .width(24)
        .height(24)

      Image('/resources/base/media/icon_shou.png')
        .width(24)
        .height(24)
        .margin({ left: 24 })

      Image($r('app.media.icon_mo'))
        .width(24)
        .height(24)
        .margin({ left: 24 })
    }
  }

  build() {
    Column() {
      Navigation() {
        TextInput({ placeholder: 'search...' })
          .placeholderColor(Color.Blue)
          .width('90%')
          .height(40)
          .backgroundColor('#FFFFFF')
          .margin({ top: 8 })

        List({ space: 12, initialIndex: 0 }) {
          ForEach(this.arr, (item: number) => {
            ListItem() {
              Text('' + item)
                .width('90%')
                .height(72)
                .fontColor(Color.Red)
                .backgroundColor('#FFFFFF')
                .borderRadius(24)
                .fontSize(16)
                .fontWeight(500)
                .textAlign(TextAlign.Center)
            }
          }, (item: number) => item.toString())
        }.height(324)
        .width('100%')
        .margin({ top: 12, left: '10%' })
      }
      .title(this.NavigationTitle())
      .menus(this.NavigationMenus())
      .titleMode(NavigationTitleMode.Full)
      .toolbarConfiguration([
        {
          value: "value1",
          icon: $r('app.media.icon_mine')
        },
        {
          value: "value2",
          icon: $r('app.media.icon_star')
        },
        {
          value: "value3",
          icon: $r('app.media.icon_mine')
        },
      ])
      .hideTitleBar(false)
      .hideToolBar(true)
      .onTitleModeChange((titleModel: NavigationTitleMode) => {
        Log.i(`titleMode:${titleModel}`)
      })
    }.width('100%').height('100%').backgroundColor('#F1F3F5')
  }
}