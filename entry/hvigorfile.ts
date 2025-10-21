import { hapTasks, OhosHapContext, OhosPluginId  } from '@ohos/hvigor-ohos-plugin';
import { getNode } from '@ohos/hvigor'
import { hvigor } from '@ohos/hvigor';

const debug_getui_appid = '1111'
const KEY_GETUI_APPID = 'metadata_key'

const entryNode = getNode(__filename);
entryNode.afterNodeEvaluate(node => {

  const appContext = hvigor.getRootNode().getContext(OhosPluginId.OHOS_APP_PLUGIN) as OhosAppContext;
  const buildMode = appContext.getBuildMode();

  // 获取此节点使用插件的上下文对象 此时为hap插件 获取hap插件上下文对象
  const hapContext = node.getContext(OhosPluginId.OHOS_HAP_PLUGIN) as OhosHapContext;
  // 通过上下文对象获取从module.json5文件中读出来的obj对象
  const moduleJsonOpt = hapContext.getModuleJsonOpt();
  
  // 修改obj对象为想要的，此处修改module中的metadata
  const originalMetadata = moduleJsonOpt['module']['metadata'];
  console.log(`[八维通编译hook] 编译类型:${buildMode}, 原始metadata:${JSON.stringify(originalMetadata)}, ` );

  // 查找并修改metadata_key的值
  let metadataItem = moduleJsonOpt['module']['metadata'].find(item => item.name === KEY_GETUI_APPID);
  if ((buildMode === 'debug' || buildMode === 'Default') && metadataItem) {
    console.log(`[八维通编译hook] 找到metadata_key，原始值: ${metadataItem.value}, 为修改${debug_getui_appid}`);
    metadataItem.value = debug_getui_appid;
  } else {
    console.log(`[八维通编译hook] 当前编译类型为release，或 没有检测到 metadata_key, 不修改, 编译类型: ${buildMode}`);
  }
  
  console.log('[八维通编译hook] 修改后的metadata:', moduleJsonOpt['module']['metadata']);

  hapContext.setModuleJsonOpt(moduleJsonOpt);
})

export default {
  system: hapTasks, /* Built-in plugin of Hvigor. It cannot be modified. */
  plugins: []       /* Custom plugin to extend the functionality of Hvigor. */
}