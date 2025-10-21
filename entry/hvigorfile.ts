import { hapTasks, OhosHapContext, OhosPluginId  } from '@ohos/hvigor-ohos-plugin';
import { getNode } from '@ohos/hvigor'


const entryNode = getNode(__filename);
// 为此节点添加一个afterNodeEvaluate hook 在hook中修改module.json5的内容并使能
entryNode.afterNodeEvaluate(node => {
  // 获取此节点使用插件的上下文对象 此时为hap插件 获取hap插件上下文对象
  const hapContext = node.getContext(OhosPluginId.OHOS_HAP_PLUGIN) as OhosHapContext;

  // 通过上下文对象获取从module.json5文件中读出来的obj对象
  const moduleJsonOpt = hapContext.getModuleJsonOpt();
  // console.log('[Hvigor Hook] 获取到module.json5配置对象:', JSON.stringify(moduleJsonOpt, null, 2));
  
  // 修改obj对象为想要的，此处修改module中的metadata
  const originalMetadata = moduleJsonOpt['module']['metadata'];
  console.log('[Hvigor Hook] 原始metadata:', originalMetadata);

  // 查找并修改metadata_key的值
  let metadataItem = moduleJsonOpt['module']['metadata'].find(item => item.name === 'metadata_key');
  if (metadataItem) {
    console.log(`[Hvigor Hook] 找到metadata_key，原始值: ${metadataItem.value}`);
    metadataItem.value = '2222';
    console.log(`[Hvigor Hook] 修改后的值: ${metadataItem.value}`);
  } else {
    // 如果不存在，则添加新的metadata项
    moduleJsonOpt['module']['metadata'].push({ name: 'metadata_key', value: '2222' });
    console.log('[Hvigor Hook] 添加新的metadata项: { name: "metadata_key", value: "2222" }');
  }
  
  console.log('[Hvigor Hook] 修改后的metadata:', moduleJsonOpt['module']['metadata']);
  
  // 将obj对象设置回上下文对象以使能到构建的过程与结果中
  hapContext.setModuleJsonOpt(moduleJsonOpt);

  console.log('[Hvigor Hook] 配置已更新到构建上下文');
})

export default {
  system: hapTasks, /* Built-in plugin of Hvigor. It cannot be modified. */
  plugins: []       /* Custom plugin to extend the functionality of Hvigor. */
}