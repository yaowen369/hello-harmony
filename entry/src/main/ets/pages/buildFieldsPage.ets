import BuildProfile from 'entry/BuildProfile'
import bundleManager from '@ohos.bundle.bundleManager'
import { Log } from '../utils/Log'

@Entry
@Component
struct buildFieldsPage {
  @State productValue: string = BuildProfile.productValue
  @State productBuildModeValue: string = BuildProfile.productBuildModeValue
  @State metadataValue: string = 'meta初始化值'

  aboutToAppear() {
    this.getMetadataValue2()
  }

  async getMetadataValue2() {
    let bundleFlags = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION |
    bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_METADATA;

    try {
      const data = await bundleManager.getBundleInfoForSelf(bundleFlags);
      const metaArary = data.appInfo.metadataArray;

      metaArary.forEach((item) => {
        item.metadata.forEach((item2) => {
          if (item2.name === "metadata_key") {
            this.metadataValue = item2.value;
          }
        })
      });
    } catch (err) {
      Log.i(`2222， 错误, ${JSON.stringify(err)}`)
    }
  }

  build() {

    Column() {
      Text('编译参数 页面2')
        .fontSize(16)
        .fontColor(Color.White)

      Text(this.productValue)
        .fontSize(16)

      Text(this.productBuildModeValue)
        .fontSize(16)

      Text(this.metadataValue)
        .fontSize(16)

    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Gray)
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(HorizontalAlign.Center)

  }
}