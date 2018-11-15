# WGET
用于通过HTTP,HTTPS,FTP,FTPS协议提取文件,它是非交互的,因此很容易在脚本中调用
- GUN get利于提取大文件或者镜像整个web或者FTP站点的特性:
	- 可以恢复中断的瞎子啊,使用REST或者RANGE
	- 可以使用文件名通配符并且可以递归镜像目录
	- 为许多不同的语言提供基于NLS的消息文件(?)
	- 可以将下载文件中的绝对链接转换成相对链接,使得下载的文件可以本地互相链接
	- 多数类UNIX系统上都可以运行
	- 支持HTTP代理
	- 支持HTTP cookie
	- 支持持久HTTP连接
	- 后台自动操作
	- 在镜像的时候使用本地文件时间戳来决定是否需要重新下载文件
	- 使用GPL协议发布

调用
---
基本语法:
```
wget [option]… [URL]…
```
- 下载命令行中指定的所有URL(Uniform Resource Locator)
- 如果想要改变默认参数,可以编辑`.wgetrc`或者在命令行指定

URL格式
---
URL是统一资源定位符的缩写,是表示互联网上可用资源的字符串.wget可以识别RFC1738的URL语法.下面是使用最广的格式:
```
http://host[:port]/directory/file
ftp://host[:port]/directory/file
```
- 还可以URL中嵌入你的用户名和密码:
```
ftp://user:password@host/path
http://user:password@host/path
```
- 如果留空了HTTP密码和用户名,就不会发送验证,如果留空了FTP用户名,会使用`anonymous`,如果留空了FTP密码,会使用你的邮件作为默认密码
- 还支持两种可选的URL规范,由于历史原因他们使用广泛
- FTP专有(NcFTP支持):
```
host:/dir/file
```
- HTTP专有(Netscape引进)
```
host[:port]/dir/file
```

基本启动选项
---
- `V`,`--version`,显示wget版本
- `-h`,`--help`,帮助
- `-b`,`--background`,启动后后台运行,如果没有使用`-o`指定输出文件,输出重定向到`wget-log`
- `-e`,`--execute command`,执行命令(`.wgetrc`之后执行)

日志和输入文件选项
---
- `-o`,`--output-file=logfile`,所有消息记录到logfile,这些消息通常是送到标准错误的
- `-a`,`--append-output=logfile`,追加到
- `-d`,`--debug`,开启调试输出
- `-q`,`--quiet`,关闭wget的输出
- `-v`,`--verbose`,开启详细输出,默认就是
- `-nv`,`--no-verbose`,关闭
- `--report-speed=type`,以type输出带宽,只接受bits
- `-i`,`--input-file=file`,从本地或者外部文件读取URL
- `--input-metalink=file`,下载本地元连接file中涉及的文件
- `--metalink-over-http`,发起HTTP HEAD请求取代GET请求并且从响应头中提取元链接元数据,然后切换到元连接下载,如果没有合法元连接,回滚到使用默认HTTP下载
- `--prefered-location`,设置元连接资源优先位置
- `-F`,`--force-html`,输入是从文件读取的时候,强制将其当做HTML文件,可以从本地HTML文件中提取相对链接
- `-B`,`--base=URL`,使用URL作为相对连接引用点
- `--config=FILE`,执行你想使用的启动文件的位置
- `--rejected-log=logfile`,将所有被拒绝的URL记录到logfile,逗号分隔,包括拒绝原因,URL和其父URL

下载选项
---
- `-t`尝试次数
- `-c`,`--continue`,继续下载

目录选项
---
- `-nd`,`--no-directories`,递归提取的时候不创建目录,所有文件都保存在当前目录下
- `-x`,`--force-directories`,与上一个相反
- `-nH`,关闭host前缀目录生成
- `--protocol-directories`,本地目录级次中加入协议名
- `--cut-dirs=number`,
```
No options        -> ftp.xemacs.org/pub/xemacs/
-nH               -> pub/xemacs/
-nH --cut-dirs=1  -> xemacs/
-nH --cut-dirs=2  -> .

--cut-dirs=1      -> ftp.xemacs.org/xemacs/
...
```
- `-P`,`--directory-prefix=prefix`,默认是`.`,懂了吧

HTTP选项
---
- `--default-page=name`,默认的文件名,比如,对以`/`结尾的URL,默认是`index.html`
- `-E`,??
- `--http-user=user`,`--http-password=password`
- `--no-http-keep-alive`
- `--no-cache`
- `--no-cookies`
- `--load-cookies file`,从file中加载cookie
- `--save-cookies file`
- `--ignore-length`
- `--header=header-line`
- 草拟吗我会个鸡儿

HTTPS (SSl/TLS)选项
---
wget必须带外部SSL库编译才能支持加密HTTP(HTTPS)下载
caocaocaonima

- `-r`递归下载
- `-l`,递归最大层级

放弃
