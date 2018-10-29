# GIT工具

选择版本
---
- 简短的SHA-1
- 分支引用
- 引用日志
	- `HEAD@{n}`
	- `master@{yesterday}`
	- `HEAD@{2.months.ago}`
- 先级引用
	- `^`上一级
	- `^^`上上
	- `^2`这个只适用于**合并提交**
	- `~`父级
	- `~2`父级的父级
	- `~3^2`组合使用
- 提交区间
	- `..`,选出在一个分支而不在另一个分支中的提交
	- `master..experiment`: 在`exp`中而不在`master`中的提交
	- 前缀`^` == `--not`,不在选中的
	- `...`,选出不共有的提交
	- `--left-right`显示提交到底处于哪一侧

交互式暂存
---
- `git add -i`

储存与清理
---
- `git stash`,暂时储存工作(不想提交,但是需要切换工作)
- 查看储存的东西: `git stash list`
	- 修改储存在栈上
- 应用储存的东西: `git stash apply`
- (储存应该就是delta了)
- `git stash save --keep-index`
	- 不要储藏通过`git add`命令已经暂存(stage)的东西
- `--include-untracked`或者`-u`
	- 储藏任何创建的未跟踪文件
- 从储藏创建一个分支: `git stash branch`
- 清理工作目录: `git clean`
	- 注意,会移除为跟踪的文件
	- `-n`演示
	- `-f`强制
	- `-d`目录
> 讲真的觉得这个管的太多了,不是do onething吗

签署工作
---
- 配置GPG
	- `gpg --gen-key`,生成
	- `gpg --list-keys`,列出
	- `git config --global user.signingkey x`
	- 妈的不行,是不是我得,没错得给全公钥
	- `git tag -v`,验证
	- `git commit -S`,签署提交
	- `git merge -S`,啥都有

搜索
---
- `git grep`
	- 还可以搜索任意GIT树
- 日志搜索
	- `git log -Sstringwhatever`,查找涉及串增删的提交
	- `-G`正则表达式
- 行日志搜索
	- `git log -L :git_deflate_bound:zlib.c`
	- 看`zlib.c`中这个函数的每次变更

重写历史
---
- 修改最后一次提交: `git commit --amend`
- 修改多个提交信息
	- git没有改变历史的工具,但是可以rebase一系列提交
	- `git rebase -i`,交互式,不管了
- 重新排序提交
	- 就是上面那个,砍了这个说明好像很明了了,但是算了吧
	- 还是来吧
	- `pick`开头的行交换顺序,交换提交顺序
	- 删除`pick`行移除提交
- 压缩提交
	- `squash`合并进前一个
- 拆分提交
	- `edit`然后fuck翻译的看不懂
- 这些改动了所有在列表中的提交的SHA-1校验和,确保列表中的提交没有推送到共享仓库

- `filter-branch`
- 通过脚本的方式改写大量提交
	- `--tree-filter`,提供命令,检出每一个提交后运行命令后重新提交
- 使用子目录作为新的项目根目录
	- `--subdirectory-filter`,使用(子目录)新的根目录,删除不影响的提交
- 全局修改邮箱地址
	- `--commit-filter`,然后是一个脚本,再见

重置揭秘
---
讨论一下`reset`和`checkout`
- 三棵数
	- `HEAD`: 上次提交
	- `Index`: 下一提交(暂存区域)
	- `Working Directory`: 工作目录
- 显示树中文件: `git ls-tree -r`
- `git cat-file`: 不知道啥
- `git ls-files -s`: 显示暂存(index)区域
- 暂存区域最开始是上次提交,然后你的改动替换掉了一些
- 确切来说索引是扁平的,不过当做树就行了
- 工作目录(本地树),在你提交之前随意更改咯
```
	检出		暂存		提交
HEAD ------> 工作目录 ------->索引区 -------> HEAD
```
- 看不下去
- `reset`移动HEAD指向的分支,`checkout`移动HEAD
- `git reset`
	1. `--soft`: 移动分支,不改变Index和工作目录,在commit和`--amend`差不多
	2. `--mixed`: 使用HEAD指向的快照内容更新Index
	3. `--hard`: 更新工作目录
- 通常不带这些选项的就是使用`--mixed`,更新索引后就停了
- 如果执行reset至HEAD,就等于是取消暂存了
- 使用这个来压缩提交
	- 草拟吗
- `checkout`差不多啦,检出HEAD提交的时候会做检查~~~
- 差不多理解行为就行了

高级合并
---
- 中断一次合并: `git merge --abort`
- ok了

调试
---
- `git blame`
- `git bisect`
	- 这个版本没问题,这个版本有问题,中间找问题

子模块
---
- `git bundle`

替换
---
- `git replace`

凭据存储
---
- http xd

老毛病又犯了,接下来的看不进了
