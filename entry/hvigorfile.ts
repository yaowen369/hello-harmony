import { hapTasks } from '@ohos/hvigor-ohos-plugin';
import { getNode } from '@ohos/hvigor'
import { CompileHook } from './src/utils/CompileHook';

const entryNode = getNode(__filename);
// 设置编译时的 metadata 修改 hook
CompileHook.setupMetadataHook(entryNode);

export default {
  system: hapTasks, /* Built-in plugin of Hvigor. It cannot be modified. */
  plugins: []       /* Custom plugin to extend the functionality of Hvigor. */
}