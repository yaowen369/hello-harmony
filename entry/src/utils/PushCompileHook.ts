import { OhosHapContext, OhosPluginId } from '@ohos/hvigor-ohos-plugin';
import { hvigor } from '@ohos/hvigor';
import { task, PluginContext } from '@ohos/hvigor';

/**
 * 编译时 Hook 工具类
 * 用于动态修改 module.json5 中的 metadata 项目 配置的 个推AppId, 因为debug和Release时个推AppId 不同, 所以使用插件动态修改
 *
 * 对于metadata中的配置项
 * GETUI_APPID: release环境的个推AppId,
 * DEBUG_GETUI_APPID: debug或Default环境时的个推AppId
 */
export class PushCompileHook {
  public static readonly GETUI_APPID_KEY = "GETUI_APPID";
  public static readonly DEBUG_GETUI_APPID_KEY = "DEBUG_GETUI_APPID";

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
        const metadataItem = moduleJsonOpt['module']['metadata'].find((item: any) => item.name === PushCompileHook.GETUI_APPID_KEY);
        const debugMetaItem = moduleJsonOpt['module']['metadata'].find((item: any) => item.name === PushCompileHook.DEBUG_GETUI_APPID_KEY);

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

/**
 * 兼容hvigor3.x：接收node，自动检测当前构建产物，并根据产物名输出不同逻辑
 */
export function customPushMetadataPlugin(node: any) {
  let productName = 'default';
  let from = 'default';
  try {
    // 推荐方案：优先用hvigor参数API
    const extParams = (typeof hvigor !== 'undefined' && hvigor.getParameter) ? hvigor.getParameter().getExtParams() : undefined;
    if (extParams && extParams.product) {
      productName = extParams.product;
      from = 'hvigor参数';
    } else {
      // 兼容旧法：从 build-profile.json5 判断
      const profilePath = node.projectPaths && node.projectPaths.buildProfile;
      if (profilePath) {
        const fs = require('fs');
        const config = JSON.parse(fs.readFileSync(profilePath, 'utf-8'));
        if (config && config.targets) {
          from = 'build-profile.json5仅可枚举，不可判定当前target';
        }
      }
    }
  } catch (e) {
    console.log('[Push编译hook] 读取当前产品出错:', e);
  }

  node.afterNodeEvaluate((currentNode: any) => {
    try {
      const appContext = hvigor.getRootNode().getContext(OhosPluginId.OHOS_APP_PLUGIN) as any;
      // 获取此节点使用插件的上下文对象 此时为hap插件 获取hap插件上下文对象
      const hapContext = currentNode.getContext(OhosPluginId.OHOS_HAP_PLUGIN) as OhosHapContext;
      // 通过上下文对象获取从module.json5文件中读出来的obj对象
      const moduleJsonOpt = hapContext.getModuleJsonOpt();
      const originalMetadata = moduleJsonOpt['module']['metadata'];
      console.log(`[Push编译hook] 当前product:${productName}(来自${from}), 原始metadata:${JSON.stringify(originalMetadata)}`);
      const metadataItem = moduleJsonOpt['module']['metadata'].find((item: any) => item.name === PushCompileHook.GETUI_APPID_KEY);
      const debugMetaItem = moduleJsonOpt['module']['metadata'].find((item: any) => item.name === PushCompileHook.DEBUG_GETUI_APPID_KEY);
      if ((productName === 'free' || productName === 'default') && metadataItem && debugMetaItem) {
        console.log(`[Push编译hook] product=${productName}, 修改 GETUI_APPID: ${metadataItem.value} => ${debugMetaItem.value}`);
        metadataItem.value = debugMetaItem.value;
      } else {
        console.log(`[Push编译hook] 不修改 GETUI_APPID, 当前product=${productName}，GETUI_APPID=${metadataItem ? metadataItem.value : '未设置'}`);
      }
      console.log('[Push编译hook] 修改后的 GETUI_APPID:', moduleJsonOpt['module']['metadata']);
      hapContext.setModuleJsonOpt(moduleJsonOpt);
    } catch (error) {
      console.error('[Push编译hook] 执行过程中发生错误:', error);
    }
  });

  if (typeof node.task === 'function') {
    node.task('customTask', () => {
      console.log('Building for product: ' + productName);
    }).dependsOn && node.task('customTask').dependsOn('assembleHar');
  }
}


