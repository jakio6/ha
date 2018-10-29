# 分支
---

分支简介
---
- 提交`commit`包含提交信息,以及`tree`对象的指针
- `tree`对象包含`blob`对象的指针
- `blob`对象是一个版本的文件的`snapshot`
- 再次提交会包含上一级`commit`对象的指针

分支创建
---
- 创建新分支: `git branch testing`
	- 在当前提交对象上创建一个指针
	- 特殊指针HEAD指向当前的分支指针
	- 使用这个命令创建分支不会自动切换到那个分支
	- `git log`的`--decorate`选项

分支切换
---
- 分支切换: `git checkout`
	- `git checkout testing`使HEAD指向`testing`分支
	- 切回分支除了改动HEAD指针外,还会恢复对应分支所指的`snapshot`
	- 如果当前工作区不是`clean`的话,会禁止切换分区
	- GIT的分支实质是仅包含所指对象checksum的文件
	- (checksum到底是个什么玩意)

分支新建与合并
--
- 新建并切换: `git checkout -b`
	- 创建分支并切换到对应分支
- 合并: `git merge`
	- 如果要合并的分支是当前分支的直接上游,`fast forward`
	- 也就是直接移动当前分支指针到要合并的分支上
	- 三方合并: 
	- 将两个要合并的分支基于共同先级进行合并
	- 当然可能会出现冲突,然后会标记出冲突让你修改最后再commit一次完成合并
	- 冲突后可以使用`git status`来查看xxd
	- 也可以使用`git mergetool`来帮助解决冲突
- 删除: `git branch -d`
	- 合并之后不在需要了可以删除了
	- 删除有未合并工作的分支会失败

分支管理
---
- 分支列表: `git branch`
	- 前面有`*`的分支是当前分支(HEAD指向的分支)
	- `-v`查看每一个分支的最后一次提交
	- 还有一些筛选项

远程分支
---
- 远程引用(refs)列表: `git ls-remote`
	- 包括分支,标签等
- 远程信息: `git remote show (remote)`
- 设置上游: `git branch -u`
	- 当然还有`git push --set-upstream`
	- `-u`等于`--set-upstream-to`
	- 设置后可以通过`@{upstream}`或`@{u}`来引用
- 推送分支: `git push (remote) (branch)`
	- 推送本地branch到remote
	- git会自动做一些展开工作,branch处可以使用branch:namewhatever
	- 来指定推送到远端的引用
- 跟踪分支: `git checkout -b [branch] [remotename]/[branch]`
	- 创建一个跟踪xx分支的分支
	- `--track`可以代替`-b [branch]`?
- 查看跟踪(上游)分支: `git branch -vv`
	- 这个只告诉你本地缓存的数据
	- 可以先`git fetch --all`一下
- 拉取: `git fetch`
	- 获取数据,等你合并
- 删除远程分支: `git push --delete`
	- 也可以用`-d`
	- 指示移除服务器上的指针
- `git clone`的时候本地只有一个master分支
	- (也许是我使用的方式的问题)

变基
---
- 变基: `git rebase`
	- `git rebase --onto master server client`
	- 这个将client不和server公共的部分rebase至master
	- rebase之后可以快速合并
- 不要对在你的仓库外有副本的分支执行变基
- 找麻烦(像这个东西太麻烦了,听他的)

