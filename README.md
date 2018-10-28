起步
---
- 配置: `git config`
	- 全局,带`--system`,从/etc配置读取修改配置文件
	- 当前用户,带`--global`,从`~`相关的目录读取修改配置文件
	- 当前仓库,`.git/config`文件
	- 用户名:`user.name`
	- 邮箱:`user.email`
	- 默认编辑器: `core.editor`
	- 配置列表: `--list` (会有重复,应为是从多个配置文件读的)
	- 检查某一项: 给出`key`不给值

- 获取帮助: 
	- `git help <verb>`
	- `git <verb> --help`
	- `man git-<verb>`

获取仓库
---
- 从现有目录中初始化仓库: `git init`
	- 这个时候还只进行了初始化
	- 还需要自己`add`在`commit`
- 克隆已有的仓库: `git clone`
	- 这里专门说明了`clone`和`checkout`的区别
	- 我觉得应该是`clone`复制整个仓库,`checkout`提取某个版本
	- 可以指定文件夹名
