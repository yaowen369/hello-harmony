import { hapTasks } from '@ohos/hvigor-ohos-plugin';
import { getNode } from '@ohos/hvigor'
import { PushCompileHook } from './src/utils/PushCompileHook';
import { customPushMetadataPlugin } from './src/utils/PushCompileHook';

const entryNode = getNode(__filename);
// 设置编译时的 metadata 修改及产物判定 hook
customPushMetadataPlugin(entryNode);

export default {
  system: hapTasks, /* Built-in plugin of Hvigor. It cannot be modified. */
  plugins: []       /* Custom plugin to extend the functionality of Hvigor. */
}