# 服务器
---

协议
---
- 四中主要的传输资料的协议:
	- local本地协议
	- HTTP协议
	- SSH协议
	- Git协议
- 本地协议
	- `git clone /opt/git/project.git`
	- 或者`git clone file:///opt/git/project.git`
	- 指定filee的时候会触发用于网路传输资料的进程
	- 但是他说好像是有用的
- HTTP协议
	- dump HTTP协议
	- 智能HTTP协议
- SSH协议
	- `git clone ssh://user@server/project.git`
	- 简短的scp式的`git clone user@server:project.git`
- Git协议
	- Git中的一个守护进程,监听端口9418

搭建Git
---
- 导出现有仓库
	- 通过克隆现有仓库:
	- `git clone --bare my_project my_project.git`
	- `git init --bare --shared`会自动修改仓库目录权限

- SSH
- 复制到服务器
- ssh密钥对生成: `ssh-keygen`
	- 先确认密钥存储位置(默认`.ssh/id_rsa`)
	- 然后要求输入两次密钥口令,如果不想在使用时输入口令,可以留空
- 添加用户
- 将公钥加入到用户的`authorized_keys`文件末尾
- 目前所有用户都可以通过`git`用户的身份访问一个普通shell
- 如果想要限制可以将其默认shell配置为`git-shell`

- Git协议
- `git daemon --reuseaddr --base-path=/opt/git/ /opt/git/`
- `--reuseaddr`允许服务器在无需等待旧连接超时的情况下重启
- `--base-path`选项允许用户在未完全指定路径的条件下克隆项目
- 结尾的路径将告诉 Git 守护进程从何处寻找仓库来导出
- 这个进程是运行在9418端口的,所以..

- HTTP
- CGIxxd
- `http://httpd.apache.org/docs/current/howto/auth.html`

- GITWEB
- 500

- GITLAB

- 第三方托管
