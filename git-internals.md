# GIT内部
---

GIT对象
---
GIT是一个内容寻址的文件系统.什么意思呢?就是说GIT的核心就是一个简单的键值对数据库.这意味着你可以插入任何类型的内容至GIT仓库,然后GIT会返回给你一个唯一的键,之后你可以使用这个键来再次提取那段内容

作为示范,让我们先来看一下底层命令`git hash-object`,它接收数据,将其存储在你的`.git/objects`目录(对象数据库),然后返回给你一个引用那个数据对象的唯一的键

使用`git hash-object`来创建一个新的数据并自动将其存储到你的git数据库中:
```bash
echo 'test content' | git hash-object -w --stdin
-->d670460b4b4aece5915caf5c68d12f560a9fe3e4
```
- `git hash-object`至接收你提供的内容并返回键
	- `-w`选项指定同时将这个对象写入数据库
	- `--stdin`选项指定从标准输入获取内容,本来是接收一个文件参数的
```bash
$ find .git/objects -type f
.git/objects/d6/70460b4b4aece5915caf5c68d12f560a9fe3e4
```
- git将每一份内容存作一个单独的文件,以SHA1校验和命令,子目录以SHA-1的前两个字符命令,文件以后38个字符命名
- 一旦在数据库中有了内容,就可以使用`git cat-file`命令检查那个内容,这个命令是检查GIT对象的利器
	- `-p`选项指定先弄清除内容的类型,再以适当的方式显示
```
$ git cat-file -p d670460b4b4aece5915caf5c68d12f560a9fe3e4
test content
```
- 现在你已经知道如何将内容加入到git然后再将它们取出.这些操作同样可以对文件中的内容进行
- 创建一个文件然后将它的内容存到你的数据库中
```
$ echo 'version 1' > test.txt
$ git hash-object -w test.txt
83baae61804e65cc73a7201a7252750c76066a30
```
- 然后在加一些内容到文件中,再次保存它
```
$ echo 'version 2' > test.txt
$ git hash-object -w test.txt
1f7a7a472abf3dd9643fd615f6da379c4acb3e3a
```
- 现在你的对象数据库有这个文件的两个版本
- 你,可以删除本地的`test.txt`文件,然后使用git从对象数据库中检索出你想要的版本
- 但是要记住每一个文件都SHA1键是不切实的,再加上,你没有在你的系统中存储文件名,只有内容,这个对象类型叫做`blob`
- 可以使用`git cat-file -t`,给出一个git中一个对象键,可以让git告诉你它的类型
```
$ git cat-file -t 1f7a7a472abf3dd9643fd615f6da379c4acb3e3a
blob
```

树对象
---
- 下一个要研究的git对象是`tree`,它解决了存储文件名的问题并且允许你存储一组文件
- git以类似UNIX文件系统的方式存储内容
	- 所有的内容以`tree`和`blob`对象的形式存储
	- `tree`对应UNIX目录条目
	- `blob`对应大致对应`inode`或者文件内容
	- 一个`tree`对象包含一个或者多个条目
	- 每一个条目都是一个`blob`或者子`tree`的SHA1哈希值加上其相关的模式,类型和文件名
- 比如,一个项目中的最新的树可能看起来像这样:
```
$ git cat-file -p master^{tree}
100644 blob a906cb2a4a904a152e80877d4088654daad0c859      README
100644 blob 8f94139338f9404f26296befa88755fc2598c289      Rakefile
040000 tree 99f1a6d12cb4b6f19c8655fca46c3ecf317074e0      lib
```
- `master^{tree}`语法指定你的`master`分支最后一次提交指向的树对象
- GIT通常通过获取你的暂存区域或者索引的状态来创建一个树
- 因此要创建一个`tree`对象,首先得通过暂存一些文件来构建一个index
- 要创建一个包含`test.txt`的第一个版本的单个条目的index,可以使用`git update-index`
	- 使用这个命令来手动地将早期版本的`test.txt`文件加到一个新的暂存区域
	- 必须使用`--add`选项,应为这个文件当前不存在在你的暂存区域(你现在甚至不需要暂存区域)
	- 还有`--cacheinfo`也是必须的,因为你在添加的文件不是在你的目录而是在你的数据库
	- 然后,指定模式,SHA-1,和文件名
```
$ git update-index --add --cacheinfo 100644 \
  83baae61804e65cc73a7201a7252750c76066a30 test.txt
```
- 现在可以使用`git write-tree`来将暂存区域写出到一个树对象
	- 现在需要`-w`选项,如果那个树不存在的话,让这个命令自动从index的状态创建一个树对象
```
$ git write-tree
d8329fc1cc938780ffdd9f94e0d364e0ea74f579
$ git cat-file -p d8329fc1cc938780ffdd9f94e0d364e0ea74f579
100644 blob 83baae61804e65cc73a7201a7252750c76066a30      test.txt
```
- 可以使用先前的命令来验证它是不是一个`tree`对象
```
$ git cat-file -t d8329fc1cc938780ffdd9f94e0d364e0ea74f579
tree
```
- 现在可以一个有着第二个版本`test.txt`和一个新文件的新树
```
$ echo 'new file' > new.txt
$ git update-index --add --cacheinfo 100644 \
  1f7a7a472abf3dd9643fd615f6da379c4acb3e3a test.txt
$ git update-index --add new.txt
```
- 现在你的暂存区域有新版本的`test.txt`以及新文件`new.txt`
- 将这个树写出(记录暂存区域或者index的状态到一个树对象)看看它是什么样子:
```
$ git write-tree
0155eb4229851634a0f03eb265b69f5a2d56f341
$ git cat-file -p 0155eb4229851634a0f03eb265b69f5a2d56f341
100644 blob fa49b077972391ad58037050f2a75f74e3671e92      new.txt
100644 blob 1f7a7a472abf3dd9643fd615f6da379c4acb3e3a      test.txt
```
- 将第一个树作为一个的子目录.可以使用`git read-tree`
	- 使用`--prefix`选项将一个已有的树作为一个子树读入你的暂存区域
```bash
$ git read-tree --prefix=bak d8329fc1cc938780ffdd9f94e0d364e0ea74f579
$ git write-tree
3c4e9cd789d88d8d89c1073707c3585e41b0e614
$ git cat-file -p 3c4e9cd789d88d8d89c1073707c3585e41b0e614
040000 tree d8329fc1cc938780ffdd9f94e0d364e0ea74f579      bak
100644 blob fa49b077972391ad58037050f2a75f74e3671e92      new.txt
100644 blob 1f7a7a472abf3dd9643fd615f6da379c4acb3e3a      test.txt
```
- 如果你从你刚写出的树创建一个工作目录,在你的工作目录顶层将会有两个文件以及一个叫做`bak`的子目录,其中包含`test.txt`文件的第一个版本

提交对象
---
做完上面全部这些之后,现在有你想要跟踪的你项目三个不同快照的三个树,但是还是开始的那个问题: 要回调快照必须记得三个SHA1值,而且还没有保存信息.这些都是提交对象会提供给你的最基本的信息
- 要创建一个提交对象,调用`commit-tree`并且指定单个树的SHA1,以及,它可能的父级
- 从第一个树开始:
```
$ echo 'first commit' | git commit-tree d8329f
fdf4fc3344e67ab068f836878b6c4951e3b15f3d
```
- 你会得到一个不同的哈希值,因为创建的时间和作者数据不同
- 现在你可以使用`git cat-file`来查看你新的提交对象
```
$ git cat-file -p fdf4fc3
tree d8329fc1cc938780ffdd9f94e0d364e0ea74f579
author Scott Chacon <schacon@gmail.com> 1243040974 -0700
committer Scott Chacon <schacon@gmail.com> 1243040974 -0700

first commit
```
- 提交对象的格式很简单:指定那个时候项目快照的顶层树,作者/提交者信息(使用你的config里的),一个空行,然后是提交信息
- 接下来你将会写两个其他的提交对象,每一个都引用它前面那个:
```
$ echo 'second commit' | git commit-tree 0155eb -p fdf4fc3
cac0cab538b970a37ea1e769cbbde608743bc96d
$ echo 'third commit'  | git commit-tree 3c4e9c -p cac0cab
1a410efbd13591db07496601ebc7a059dd55cfe9
```
- 这三个提交对象每个都指向你创建的三个快照之一
- 很奇怪,现在你有了一个真正的GIT历史,你可以使用`git log`查看(指定一个SHA1)
- 难以置信.你刚才完全使用底层操作构建了一个Git历史
- 这实际上就是你在运行`git add`和`git commit`的时候Git所做的:
	- 为已改动的文件保存`blob`,更新index,写出到`tree`,然后写引用顶层树以及其父级提交的提交对象
- 这三个主要的Git对象:blob,tree,commit
	- 最初是作为单独的文件保存在你的`.git/objects`目录中的
- ~~

对象存储
---
- 拿`blob`对象来说
- 对于一段内容,git会先构造一个header,由对象的内容开始,这里是`blob`
- 之后git会加上一个空格然后是内容的字节数,然后加上一个最终的空字节
- 然后Git将头和最开始内容剪接在一起,再计算新内容的SHA-1值
- 然后嘞,SHA-1值头两个做目录,后两个做文件名保存起来
- 然后一个有效的git数据对象就创建了
- 另外两种对象类型的头部信息以`commit`或`tree`开头

GIT引用
---
- 如果你想看你仓库中可以通过提交找到的历史,可以直接`git log [SHA-1]`来找到那个历史
- 但是你还是得记得哪个SHA-1是用于表示那个提交点
- 如果能有一个文件将SHA-1与一个简单的名称对应保存你就可以使用那个简单的名称而不需要使用原始的SHA1值
- 在GIT中,这个简单的名称叫做引用或者`refs`,你可以在`.git/refs`文件中找到这些包含SHA-1值的文件
- 要创建一个新帮助记忆的引用,可以直接像这样手动操作:
```
$ echo 1a410efbd13591db07496601ebc7a059dd55cfe9 > .git/refs/heads/master
```
- 现在可以在你的git命令中直接使用你刚才创建的引用头
```
$ git log --pretty=oneline master
1a410efbd13591db07496601ebc7a059dd55cfe9 third commit
cac0cab538b970a37ea1e769cbbde608743bc96d second commit
fdf4fc3344e67ab068f836878b6c4951e3b15f3d first commit
```
- 不推荐直接编辑引用文件,git专门提供了更加安全的命令`git -updata-ref`
```
git update-ref refs/heads/master 1a410efbd13591db07496601ebc7a059dd55cfe9
```
- 这也就是GIT中分支的实质:一个简单的指向某一处工作的指针或者说引用
- 要创建位于第二次提交的分支,可以:
```
$ git update-ref refs/heads/test cac0ca
```
- 当你运行类似`git branch <branch>`的命令之时,git就是你当前所在的分支的最后一次提交的SHA1加到你想要创建的新的引用中去

HEAD指针
---
- 现在的问题是,当你运行分支命令的时候,git是如何知道最后一次提交的SHA-1值的呢?答案就是HEAD文件
- 是对你当前所有的分支的符号引用
- 符号引用不同于寻常的引用,它所含的是对另一引用的指针
- 大概像这样:
```
$ cat .git/HEAD
ref: refs/heads/master
```
- 如果你运行`git checkout test`,git会将文件更新成这样:
```
$ cat .git/HEAD
ref: refs/heads/test
```
- 当你运行`git commit`的时候,他会创建新的提交对象,并将那个提交对象设置为HEAD指向的引用的SHA-1值
- 你可以手动编辑这个文件,但是还是,有一个跟安全的命令用来干这件事: `git symbolic-ref`
```
$ git symbolic-ref HEAD
refs/heads/master
```
- 设置值:
```
$ git symbolic-ref HEAD refs/heads/test
$ cat .git/HEAD
ref: refs/heads/test
```
- 但是不能将符号引用设置范围超出`refs`

TAGs
---
我们已经讨论完了Git的三个主要对象(blob,tree,commit),还有第四个呢
- tag对象与提交对象非常相似:包含一个便签,一个日期,一个消息,以及一个指针
- 主要的不同是,tag的对象通常是指向一个提交对象而不是指向一个树对象.就像一个分支引用一样,
但是他不会移动,它总是指向相同的提交对象但是给了它一个更加友好的名称
- 有两种类型的tag,轻量级的可以像这样创建
```
$ git update-ref refs/tags/v1.0 cac0cab538b970a37ea1e769cbbde608743bc96d
```
- 轻量级的引用也就是这样,一个永远不会移动的引用
- 另一个附注标签就更加复杂了
- 如果你创建一个附注标签的话,git会创建一个tag对象,然后再写一个引用指向它而不是直接指向提交
- 可以通过创建一个附注标签来看一下: 
```
$ git tag -a v1.1 1a410efbd13591db07496601ebc7a059dd55cfe9 -m 'test tag'
```
- 这是创建的对象的SHA-1值
```
$ cat .git/refs/tags/v1.1
9585191f37f7b0fb9444f35a9bf50de191beadc2
```
- 对这个SHA-1值运行`git cat-file -p`:
```
$ git cat-file -p 9585191f37f7b0fb9444f35a9bf50de191beadc2
object 1a410efbd13591db07496601ebc7a059dd55cfe9
type commit
tag v1.1
tagger Scott Chacon <schacon@gmail.com> Sat May 23 16:48:58 2009 -0700
```
- 这个对象条目指向你打标签的提交SHA-1值.而且它并不需要指向一个提交,你可以给任何GIT对象打标签
- 比如在GIT源码中,维护者已经将他们非GPG公钥作为一个blob加了进去然后给它大了标签
- 你可以在GIT的克隆仓库中查看这个公钥:
```
$ git cat-file blob junio-gpg-pub
```
- linux内核仓库同样有一个非提交指向的tag对象,第一个创建的tag指向源代码导入后的初始树

REMOTES
---
第三个类型的引用: 远端引用
- 如果添加了一个远端并且推送至它,git会将你最后推送的远端的每一个分支的值保存到`ref/remotes`目录
- 比如,你可以添加一个叫做`origin`的远端然后将你的`master`分支推送至它:
```
$ git remote add origin git@github.com:schacon/simplegit-progit.git
$ git push origin master
Counting objects: 11, done.
Compressing objects: 100% (5/5), done.
Writing objects: 100% (7/7), 716 bytes, done.
Total 7 (delta 2), reused 4 (delta 1)
To git@github.com:schacon/simplegit-progit.git
  a11bef0..ca82a6d  master -> master
```
- 然后你可以通过检查`ref/remotes/origin/master`文件查看你最后一次与服务器通信的时候远端的`mater`是怎样的:
```
$ cat .git/refs/remotes/origin/master
ca82a6dff817ec66f44342007202690a93763949
```
- 远端引用和分支不同主要是它是被看做只读的
- 你可以`git checkout`至一个(远端),但是git不会将HEAD指向它,因此你不能通过`commit`命令更新它
- git将他们作为最后远端服务器上分支最后已知状态的分支管理

打包文件
---
- 跟着来的话,现在仓库中应该有11个对象了,四个blob,仨tree,仨commit,和一个tag(我怎么多了一个<<<)
- git使用zlib来压缩这些文件的内容,接下来就不跟着做了,huak
- git可以值保存两个相同的文件中的一个,另一个以delta的形式保存
- git在磁盘上存储文件的初始格式是loose的.为了节省空间,提交效率偶尔也会将这些文件打包进一个单个的二进制文件
- push的时候就对要提交的内容进行了这个操作,delta我还是认识的
- git会在你有太多的loose的对象的时候进行这个操作,你也可以手动运行`git gc`命令让git来执行这个操作
- `gc`之后object中的内容变了(开始的空的info和pack目录中有内容了)
- 当然还是有些没有打包的,哪些你还没有加到任何提交中的blob,被看做是未定的,不会被打包进新的packfile
- 多出来的有packfile,和一个index
	- packfile是包含从你的文件系统中移除的所有文件的单个文件
	- index是包含从packfile中偏移的文件,便于快速查找指定的对象
- git是怎么完成的呢?
	- 在打包对象的时候,git会查找敏恒和大小相近的文件,只保存相对下一个的delta
- 底层命令`git verify-pack`可以查看打包了哪些文件
- 如果有以delta保存的,好像是最后加上链的长度(delta几次),在加上delta所对上一级的引用
- git偶尔会自动重新打包你的数据库,你也可以运行`git gc`手动打包

Refspec
---
- 在这本书中,我们一直使用简单的从远端分支到本地引用的映射,他们还能更加繁复一点
- (省略了一点东西,可能出入哦,还是抄下来)
```
[remote "origin"]
	url = https://github.com/schacon/simplegit-progit
	fetch = +refs/heads/*:refs/remotes/origin/*
```
- 引用规范的格式是
	- 首先,一个可选的`+`,告诉git即使不是fast-forward也更新引用
	- 接下来是`<src>:<dst>`,`<src>`远端上的引用的模式,`<dst>`是要本地跟踪的引用
- 在`git remote add`使用的默认情况中,git会`fetch`服务器端`refs/heads`下的所有引用并将他们写入到本地的`refs/remote/origin/`
- 因此,如果服务器端有一个`master`分支,可以通过以下命令在本地访问那个分支的log:
```
$ git log origin/master
$ git log remotes/origin/master
$ git log refs/remotes/origin/master
```
- 这些都是等价的,应为Git会将那么都展开成`refs/remotes/origin/master`
- 如果你想要git每次只拉取`master`分支,可以将fetch行变为只引用那个分支:
```
fetch = +refs/heads/master:refs/remotes/origin/master
```
- 这只是对那个远端的默认引用指定,你也可以直接在命令行指定引用指定
- 将远端的`master`分支拉取为本地的`origin/mymaster`:
```
git fetch origin master:refs/remotes/origin/mymaster
```
- 还可以指定多个.在命令行,可以像这样拉取多个分支:
```
$ git fetch origin master:refs/remotes/origin/mymaster \
	 topic:refs/remotes/origin/topic
From git@github.com:schacon/simplegit
 ! [rejected]        master     -> origin/mymaster  (non fast forward)
 * [new branch]      topic      -> origin/topic
```
- 这个例子中,`master`分支的拉取被拒绝了,应为它不是一个fast-forward引用,可以在指定前加上`+`覆盖
- 可以在配置文件中指定多个fetch引用指定.如果总是想要从`origin`远端获取`master`和`exteriment`分支:
```
[remote "origin"]
	url = https://github.com/schacon/simplegit-progit
	fetch = +refs/heads/master:refs/remotes/origin/master
	fetch = +refs/heads/experiment:refs/remotes/origin/experiment
```
- 不能在模式中使用部分的glob,下面这个是**非法**的:
```
fetch = +refs/heads/qa*:refs/remotes/origin/qa*
```
- 但是你可以使用命名空间(或者目录)来实现类似的.如果你有一个推送一系列分支的QA组...:
```
[remote "origin"]
	url = https://github.com/schacon/simplegit-progit
	fetch = +refs/heads/master:refs/remotes/origin/master
	fetch = +refs/heads/qa/*:refs/remotes/origin/qa/*
```

推送的引用指定
---
- 通过那种方式获取划分命名空间的引用是极好的,但是如果QA组想要将他们的分支新加入到一个`qa`命名空间怎么怎么?
- 这个时候可以使用push的引用指定
- 如果QA组想要将他们的`master`分支推送到远端服务器上的`qa/master`,他们可以:
```
$ git push origin master:refs/heads/qa/master
```
- 如他们想要git每次在他们运行`git push origin`的时候自动进行,他们可以在他们的配置文件中加入一个`push`值:
```
[remote "origin"]
	url = https://github.com/schacon/simplegit-progit
	fetch = +refs/heads/*:refs/remotes/origin/*
	push = refs/heads/master:refs/heads/qa/master
```
- 同样,这会使用`git push origin`命令默认将本地的`master`分支推送到远端的`qa/master`分支

删除引用
---
- 还可以使用引用指定从远端服务器删出引用:
```
$ git push origin :topic
```
- 留空`<src>`部分,就是说让`topic`分支在远端什么也不是,然后它就被删了(真的删除了远端的?)
- 也可以使用新的语法(自v1.7.0版本可用)
```
$ git push origin --delete topic
```

传输协议
---
bye

维护与数据恢复
---
有时候需要进行一些整理,使仓库更加紧凑,清理导入的库,或者是恢复丢失的工作.本节将介绍一些方案

维护
---
- git有时候会自动运行一个叫做"auto gc"的命令.多数时候,这个命令什么都不会做.
- 但是如果零散的对象(不在打包文件中的对象)或者打包文件太多了的话,git会发起一个完全的`git gc`命令.
- `gc`的意思是垃圾收集,这个命令会做一系列事情:
	- 将零散对象整合尽一个打包文件
	- 将打包文件整合进一个更大的打包文件
	- 移除不可通过任何提交访问并且有数月之久的对象
- 可以手动运行auto gc:
```
$ git gc --auto
```
- 还是那句话,这个通常什么也不做.只有在有大约7000个零散对象或者超过50个打包文件的时候才会导致git进行一次真正的gc
- 可以通过`gc.auto`和`gc.autopacklimit`配置修改这些限制
- `gc`还会将你的引用打包进一个单个文件
- 假设你的库包含下来的分支和标签:
```
$ find .git/refs -type f
.git/refs/heads/experiment
.git/refs/heads/master
.git/refs/tags/v1.0
.git/refs/tags/v1.1
```
- 如果你运行`git gc`,`refs`目录中将不会有这些文件.git会将他们移到一个叫做`.git/packed-refs`的文件中来提高效率,它大概是这样:
```
$ cat .git/packed-refs
# pack-refs with: peeled fully-peeled
cac0cab538b970a37ea1e769cbbde608743bc96d refs/heads/experiment
ab1afef80fac8e34258ff41fc1b867c702daa24b refs/heads/master
cac0cab538b970a37ea1e769cbbde608743bc96d refs/tags/v1.0
9585191f37f7b0fb9444f35a9bf50de191beadc2 refs/tags/v1.1
^1a410efbd13591db07496601ebc7a059dd55cfe9
```
- 如果你更新了一个引用的话,Git不会编辑这个文件,而是将一个新的文件写入`refs/heads`
- 要获得一个给定的引用的正确的SHA1值,git会先在`refs`目录中检查那个引用,然后在`packed-refs`文件中检查作为备用
- 然而,如果你在`refs`目录中找不到一个引用,它可能就在你的`packed-refs`文件中

数据恢复
---
- 在你使用git的某个时候,你可能会意外丢失一个提交
- 通常是应为你强制删除了一个有作业的分支,然后之后你又想要这个分支了
- 或者是,你硬重置了一个分支,因此而丢弃了一些有你需要的东西的提交
- 假设这些情况发生了,如何恢复你的提交?
- 这个是将你的测试仓库中主分支硬重置回一个早先的提交然后恢复丢失的提交的示范
- 首先,先检查一下你的仓库现在处于哪个点:
```
$ git log --pretty=oneline
ab1afef80fac8e34258ff41fc1b867c702daa24b modified repo a bit
484a59275031909e19aadb7c92262719cfcdf19a added repo.rb
1a410efbd13591db07496601ebc7a059dd55cfe9 third commit
cac0cab538b970a37ea1e769cbbde608743bc96d second commit
fdf4fc3344e67ab068f836878b6c4951e3b15f3d first commit
```
- 现在将`master`分支移回中间的提交:
```
$ git reset --hard 1a410efbd13591db07496601ebc7a059dd55cfe9
HEAD is now at 1a410ef third commit
$ git log --pretty=oneline
1a410efbd13591db07496601ebc7a059dd55cfe9 third commit
cac0cab538b970a37ea1e769cbbde608743bc96d second commit
fdf4fc3344e67ab068f836878b6c4951e3b15f3d first commit
```
- 现在你成功丢失了顶端的两个提交,你已经没有可以访问这些提交的分支了
- 你需要找到最近的提交的SHA1值然后在添加一个指向它的分支
- 关键就是要找到最近的提交的SHA1值,你根本记不得,对吧?
- 通常,最简单的方式就是使用一个叫做`git reflog`的工具
- 在你工作的时候,git会悄悄地记录你HEAD指针的走向
- 每次你提交或者改变分支,这个引用日志都会被`git updata-reg`命令更新
	- 这也是为什么使用这个命令要好过直接将SHA1值加入到你的引用文件
- 任何时候你都可以通过运行`git reflog`查看你到过哪里:
```
$ git reflog
1a410ef HEAD@{0}: reset: moving to 1a410ef
ab1afef HEAD@{1}: commit: modified repo.rb a bit
484a592 HEAD@{2}: commit: added repo.rb
```
- 可以看到我们曾经检索出的两个提交,但是这里的信息不多
- 要以跟加有效的方式查看相同的信息,可以运行`git log -g`,这个命令给出信息的形式和寻常的log信息一样
```
$ git log -g
commit 1a410efbd13591db07496601ebc7a059dd55cfe9
Reflog: HEAD@{0} (Scott Chacon <schacon@gmail.com>)
Reflog message: updating HEAD
Author: Scott Chacon <schacon@gmail.com>
Date:   Fri May 22 18:22:37 2009 -0700

		third commit

commit ab1afef80fac8e34258ff41fc1b867c702daa24b
Reflog: HEAD@{1} (Scott Chacon <schacon@gmail.com>)
Reflog message: updating HEAD
Author: Scott Chacon <schacon@gmail.com>
Date:   Fri May 22 18:15:24 2009 -0700

       modified repo.rb a bit
```
- 看其来最底下的那个提交就是你丢失的那个,因此你可以通过在那个提交上创建一个新的分支来恢复它
- 比如,你可以在那个提交上创建一个叫做`recover-branch`分支:
```
$ git branch recover-branch ab1afef
$ git log --pretty=oneline recover-branch
ab1afef80fac8e34258ff41fc1b867c702daa24b modified repo a bit
484a59275031909e19aadb7c92262719cfcdf19a added repo.rb
1a410efbd13591db07496601ebc7a059dd55cfe9 third commit
cac0cab538b970a37ea1e769cbbde608743bc96d second commit
fdf4fc3344e67ab068f836878b6c4951e3b15f3d first commit
```
- 哇哦,好像ok了
- 接下来,假设你丢失的东西由于某些原因不在reglog中(比如你现在手动删除`recover`分支和reflog)
- 现在,头两个提交再也看不到了:
```
$ git branch -D recover-branch
$ rm -Rf .git/logs/
```
- 因为reflog数据是保存在`.git/logs`目录中,你成功地失去了所有reflog
- 现在该怎么恢复那个提交呢?
	- 一种方式是使用`git fsck`工具,它会检查数据库的一致性
- 如果你带`--full`选项运行它的话,它会展示所有没有被其他对象指向的对象:
```
$ git fsck --full
Checking object directories: 100% (256/256), done.
Checking objects: 100% (18/18), done.
dangling blob d670460b4b4aece5915caf5c68d12f560a9fe3e4
dangling commit ab1afef80fac8e34258ff41fc1b867c702daa24b
dangling tree aea790b9a58f6cf6f2804eeac9f0abbe9631e4c9
dangling blob 7108f7ecb345ee9d0084193f147cdad4d2998293
```
- 这种情况下,你可以在字符串"dangling commit"(丢失指针)后看到你丢失的期缴.然后可以通过相同的方式恢复

恢复对象
---
- 一个会导致问题的特性是,`git clone`会下载整个项目的历史,包括每一个文件的每一个版本
- 如果全部都是源码自然是没有问题的.但是,如果某些有些人在你的项目的历史中的某个点加入了一个很大的单个文件,每一次clone都会强制下载那个大文件,及时它在最近的提交中已经移除了.因为它可以通过历史访问到,它总是会处于下载列表中
- 下面将展示如何找到并且移除大文件
- warning : **这会改变你的提交历史**
- `git count-objects -v`快速查看你使用了多少空间
- `git verify-pack`并且使用`sort`排序输出的第三段,文件大小,然后使用`tail`查看最后几个:
```
$ git verify-pack -v .git/objects/pack/pack-29…69.idx \
  | sort -k 3 -n \
  | tail -3
```
- 查看最大的文件到底是那个:
```
git rev-list --objects --all | grep 82c99a3
82c99a3e86bb1267b236a4b6eff7868d97489af1 git.tgz
```
- 看哪个提交编辑了这个文件:
```
$ git log --oneline --branches -- git.tgz
dadf725 oops - removed large tarball
7b30847 add git tarball
```
- 从`7b30847`开始重写提交来完全将这个文件移出你的提交历史.使用`filter-branch`
```
$ git filter-branch --index-filter \
  'git rm --ignore-unmatch --cached git.tgz' -- 7b30847^..
Rewrite 7b30847d080183a1ab7d18fb202473b3096e9f34 (1/2)rm 'git.tgz'
Rewrite dadf7258d699da2c8d89b09ef6670edb7d5f91b4 (2/2)
Ref 'refs/heads/master' was rewritten
```
- `--index-filter`类似`--tree-filter`,这个是修改index,tree那个是修改检出到磁盘的文件
- `git rm --cached`来删除,必须将它从index中删除而不是磁盘
- 使用`git rm`使得在运行你的filter之前不必将每一个版本都检出到磁盘中
- 当然如果你想的话也可以使用`--tree-filter`来完成咯
- `git rm`的`--ignore-unmatch`选项使得它忽略未匹配到的情况
- 最后,告诉`filter-branch`,从`faaaaaaac`开始重写提交
- 因为你知道从那里开始的从头开始是不必要的
- 现在你的历史没有那个文件的引用了.但是,你的reflog和git在你进行`filter-branch`添加的`.git/refs/original`文件中仍然有
- 因此你需要删除他们然后重新打包数据库,在你重新打包之前需要干掉所有有这些旧提交的指针的家伙
```
$ rm -Rf .git/refs/original
$ rm -Rf .git/logs/
$ git gc
Counting objects: 15, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (11/11), done.
Writing objects: 100% (15/15), done.
Total 15 (delta 1), reused 12 (delta 0)
```
- (删除reflog有点过分吧)
- 这样删除那个文件还是在你的零散对象中,但是不会再在接下来的push或者clone中传输了
- 如果你想要删除的话,可以使用`git prune --expire`
```
$ git prune --expire now
$ git count-objects -v
count: 0
size: 0
in-pack: 15
packs: 1
size-pack: 8
prune-packable: 0
garbage: 0
size-garbage: 0
```
- 干干净净,舒服

环境变量
---
git总是运行在`bash`之中(?),xxx

- `GIT_EXEC_PATH`: git查找它的子程序(像`git-commit`)的路径,`git --exec-path`检查
- ......一顿省略
- `GIT_COMMITTER_DATE`: 同于提交者域的时间戳
- `GIT_MERGE_VERBOSITY`: 递归合并策略输出控制(0-5)
- `GIT_TRACE`: 控制一般的跟踪
- `GIT_TRACE_PACK_ACCESS`: 打包文件访问跟踪
- (是不是我的git不支持调试啊....)
- 再见

