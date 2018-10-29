# 分布式GIT
---

集中式工作流
---
- 合作者同一个公共仓库进行同步
- fetch--> merge --> push

集成管理者工作流
---
1. 项目维护者推送到主仓库
2. 贡献者克隆此仓库,做出修改
3. 贡献者将数据推送到自己的公开仓库
4. 贡献者给维护者发送邮件,请求拉取自己的更新(**pull request**)
5. 维护者在自己本地的仓库中,将贡献者的仓库加为远程仓库并合并修改
6. 维护者将合并后的修改推送到主仓库

司令官与副官工作流
---
上面那个的嵌套


贡献过程
---
- `git diff --check`检查空白问题
- 提交信息
	- 第一行是提交信息(50个字符,25个汉字)
	- 一个空行之后详细信息
- 手动请求: `git request-pull`
	- 从那个分支开始
	- 有哪些改变
	- 到哪里拉取
- 压缩: `git merge --squash`
- 通过邮件
	- `git format-patch`
	- xxd
	- `git`提供了imap工具来发送
	- 还有别的什么

维护项目
---
- 应用来自邮件的补丁
- `apply`
	- `git apply [*.patch]`
	- `--check`检查补丁
	- `diff`生成的补丁
- `am`
	- `git am`
	- 应用`format-patch`命令生成的补丁
	- 也可能会出现冲突,解决和合并冲突一样
	- 手动编辑解决冲突,暂存文件,之后`git am --resolved`继续下个
	- `-3`尝试三方合并
	- `-i`交互式
- 检出远程分支
- 确认引入了哪些东西
	- ..
	- ...
	- (.......)
- 很多很多看不懂的
- `Rerere`: 重用已记录的冲突解决方案
- 为发布打标签
	- xxx
	- `git describe`
- 准备一次发布
	- `git archive`
```
git archive master --prefix='project/' | gzip > `git describe master`.tar.gz</code>
```
```
 git archive master --prefix='project/' --format=zip > `git describe master`.zip
```
- 生成提交简报: `git shortlog`

- 不舒服
