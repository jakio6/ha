> ### 基础
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

记录更新到仓库
---
- 未跟踪--未修改--修改--暂存
- 跟踪的文件是纳入版本控制的文件
- 检查文件状态: `git status`
	- 紧凑的输出:`-s`或者`--short`
	- 然后有一些表示,左M暂存了,右M修改,A新加暂存文件,??未跟踪
- 跟踪新文件: `git add`
	- 跟踪之后就暂存,暂存的就是下一次要提交的
	- 这个同时也是暂存咯
- 忽略文件: 文件`.gitignore`
	- 所有空行或者以 ＃ 开头的行都会被 Git 忽略
	- 可以使用标准的glob模式匹配
	- 匹配模式可以以`/`开头防止递归
	- 匹配模式可以以`/`结尾指定目录
	- 要忽略指定模式以外的文件或目录，可以在模式前加上惊叹号`!`取反
	- `glob`:`*`任意个字符,`[]`,`?`一个字符,`**`任意中间目录
- 查看差异: `git diff`
	- 本身只显示未暂存的内容
	- `--staged`(`--cached`)显示要提交的修改
- 图形化diff: `git difftool`
	- `--tool`指定使用的工具
	- `--tool-help`支持的tool工具
- 提交更新: `git commit`
	- 不加参数使用编辑器提交信息
	- `-m`命令行指定提交消息
	- `-a -m`跳过暂存
- 移除文件: `git rm`
	- 这个好像没什么用啊
	- 如果已提交的`rm`后`git add`和`git rm`效果好像是一致的
	- 反正就是提交删除操作嘛,直接`git rm`已经暂存的还是需要`-f`
	- 后面可以使用`glob`,但是需要转义(不使用shell的通配符)
	- 好像如果是删除当前没有暂存但是已经跟踪了文件的时候要简单点
	- 随便吧
- 移动文件:`git mv`
	- 和上面那个差不多了
	- 可以直接使用`mv`来完成,不过mv实际上会看做带一个删除操作
	- 使用`git mv`git自己来完成
	- 麻烦,直接使用`mv`再加`add`操作就行了
	- 好像这些命令都可以使用本地命令加上`add`来完成
	- 这个人也说了这个就等于`mv`+`git rm`+`add`
	- (不使用的`git rm`就有一个添加再加一个删除,当然`add`一下两个就抵消了没了,说这么多就是为了熟悉一下啦)

查看提交历史
---
- 查看提交历史: `git log`
	- `-p`显示每次提交的内容差异
	- `-2`仅显示两次提交
	- `--stat`简略的统计信息
	- `--pretty=`指定格式,有內建的,也可以自己指定
	- `--pretty=`常用选项就不写了,抄一个:
	- `%Cgreen%h - %Cred%an, %Cblue%ar : %Cgreen%s`
	- 还有author和committer之分,以后会碰到的吧
	- `--graph`形象地展示分支,合并历史
	- 还有别的就不管了
	- 限制输出长度(筛选?):`--since`,`--until`
	- eg: `--since=2.weeks`
	- 还有`--author`匹配author
	- `--grep`匹配关键词
	- 要同时应用多个匹配项需要使用`--all-match`
	- `-S`匹配添加或者移除了某些字符串的提交

撤销操作
---
- 撤销操作: `git commit --amend`
	- 更改上次的commit
	- 这次的commit合并到上次的应该是
	- 最后只算一次commit
- 取消暂存的文件: `git reset HEAD <file>...`
	- 应该是将文件恢复到HEAD的版本吧
	- 上面这个错了,搞不清,应该只操作暂存区吧,动文件的是下一个
	- 应该是撤销
	- 还有一些选项英文看不懂
- 撤销对文件的修改: `git checkout -- <file>...`
	- 就那个意思,你的改动会丢失
	- 强调:已提交的东西几乎都可以恢复,但是没有提交过的没了就没了

远程仓库的使用
---
- 查看远程仓库: `git remote`
	- 列出你指定的每一个远程服务器的简写
	- git给克隆的仓库服务器的默认名称是origin
	- `-v`显示操作对应的URL
- 添加远程仓库: `git remote add <shortname> <url>`
	- 添加一个新的仓库并指定一个简写
- 从远程仓库中抓取与拉取: 
	- `git fetch [remote-name]` fetch你还没有的数据,需要手动合并
	- `git pull` 自动合并的
- 推送到远程仓库: `git push [remote-name] [branch-name]`
	- 有写入权限并且期间没有别的推送ok
	- 如果期间有别的推送就得先拉取合并之后才能推
- 查看远程仓库: `git remote show [remote-name]`
	- 像我这种几乎没什么好看的,,:
	- push自动推送到哪个远程分支
	- 哪些不在本地
	- 哪些已经从远程服务器上移除
	- 执行`pull`的时候哪些会自动合并xxxd
- 远程仓库的移除和重命名: 
	- `git remote rename`重命名,如:
	- `git remote rename origin fuck`
	- `git remote rm`删除

打标签
---
- 打标签:
	- 给某个历史提交打上个tag,以示重要之类的
- 列出标签: `git tag`
	- 列出已有的标签
	- 可以筛选啦
- 创建标签:
	- 分两种标签,轻量(lightweight)的和附注(annotated)的
	- 轻量标签很像一个不会改变的分支,指示一个特定提交的引用
	- 附注标签是存储在GIT数据库中的一个完整对象,包含打标签的人的名称邮件以及时间,还有一个标签消息,并且可以使用GPG签名于验证
	- 通常建议使用附注标签,这样你可以**拥有**以上所有信息
	- 当然使用轻量的也是可以的
- 附注标签: 
	- 最简单的`git tag -a v0.1 -m '第一个标签'`
	- (`-m`和`commit`那个一个意思)
	- `git show`可以用来看标签信息和对应的提交信息
- 轻量标签: 
	- tagging的时候不给`-a`,`-s`,`-m`这些选项,直接给个标签名就行
	- `git tag v0.2`
- 补打标签: 
	- 在打标签的命令后加上校验和(或者部分和,就是那串数字)来指定过去的版本
- 共享标签:
	- 默认`git push`是不会推送标签的,必须显式推送
	- `git push origin [tagname]`(就像共享分支一样)一次推送一个
	- `--tags`把所有不在远端的标签全部推送
- 检出标签: 
	- 看这个意思检出就是checkout咯
	- 在 Git 中你并不能真的检出一个标签，因为它们并不能像分支一样来回移动
	- 如果你想要工作目录与仓库中特定的标签版本完全一样
	- 可以`git checkout -b [branchname] [tagname]`在特定标签上创建一个分支
	- 这里学的是checkout啊啊啊啊啊
	- 如果这个分支又提交了就又和那个标签有不同了

GIT别名
---
- 抄一点有用的,听说能让我体会到git的小巧强大(用shell的别名也可以了,但是懒得弄,zsh给的实在太短了都分不清(主要是不熟悉git呢))
- `git config --global alias.co checkout`
- `git config --global alias.br branch`
- `git config --global alias.ci commit`
- `git config --global alias.st status`
- `git config --global alias.unstage 'reset HEAD --'`
- `git config --global alias.last 'log -1 HEAD'`
- `git config --global alias.visual '!gitk'`执行外部命令(这个我没有)
- 现在要学习就不用了

----
