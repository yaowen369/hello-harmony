import { OhosHapContext, OhosPluginId } from '@ohos/hvigor-ohos-plugin';
import { hvigor } from '@ohos/hvigor';

/**
 * 编译时 Hook 工具类
 * 用于动态修改 module.json5 中的 metadata 配置
 */
export class CompileHook {
  private static readonly GETUI_APPID_KEY = "GETUI_APPID";
  private static readonly DEBUG_GETUI_APPID_KEY = "DEBUG_GETUI_APPID";

  /**
   * 设置编译时的 metadata 修改 hook
   * @param node 当前节点
   */
  public static setupMetadataHook(node: any): void {
    node.afterNodeEvaluate((currentNode: any) => {
      try {
        const appContext = hvigor.getRootNode().getContext(OhosPluginId.OHOS_APP_PLUGIN) as any;
        const buildMode = appContext.getBuildMode();

        // 获取此节点使用插件的上下文对象 此时为hap插件 获取hap插件上下文对象
        const hapContext = currentNode.getContext(OhosPluginId.OHOS_HAP_PLUGIN) as OhosHapContext;
        // 通过上下文对象获取从module.json5文件中读出来的obj对象
        const moduleJsonOpt = hapContext.getModuleJsonOpt();

        // 修改obj对象为想要的，此处修改module中的metadata
        const originalMetadata = moduleJsonOpt['module']['metadata'];
        console.log(`[Push编译hook] 编译类型:${buildMode}, 原始metadata:${JSON.stringify(originalMetadata)}`);

        // 查找并修改 GETUI_APPID 的值
        const metadataItem = moduleJsonOpt['module']['metadata'].find((item: any) => item.name === CompileHook.GETUI_APPID_KEY);
        const debugMetaItem = moduleJsonOpt['module']['metadata'].find((item: any) => item.name === CompileHook.DEBUG_GETUI_APPID_KEY);

        if ((buildMode === 'debug' || buildMode === 'Default') && metadataItem && debugMetaItem) {
          console.log(`[Push编译hook] 找到 GETUI_APPID，原始值: ${metadataItem.value}, 修改为${debugMetaItem.value}`);
          metadataItem.value = debugMetaItem.value;
        } else {
          console.log(`[Push编译hook] 当前编译类型为release，或 没有检测到 GETUI_APPID 或者 DEBUG_GETUI_APPID, 不进行修改, 编译类型: ${buildMode}`);
        }

        console.log('[Push编译hook] 修改后的 GETUI_APPID:', moduleJsonOpt['module']['metadata']);

        hapContext.setModuleJsonOpt(moduleJsonOpt);
      } catch (error) {
        console.error('[Push编译hook] 执行过程中发生错误:', error);
      }
    });
  }
}
