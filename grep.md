# grep
---
正则什么的都是差不多的,主要就是选项了

命令行选项
---
- `--help`
- `-V`,`--version`

匹配控制
---
- `-e`,`--regexp=pattern`
- `-f`,`--file=file`: 从文件中获取模,我刚才把这个当成指定文件了......
- `-i`,`-y`,`--ignore-case` : 忽略大小写
- `-v`,`--invert-match`: 反转匹配含义,选择不匹配的行
- `-w`,`--word-regexp`: 整个单词匹配的行
- `-x`,`--line-regexp`: 整行匹配的行

一般输出控制
---
- `-c`,`--count`: 抑制正常输出,打印每一个文件匹配的行数统计
- `--color=[WHEN]`,`--colour[=WHEN]`: 什么使用使用环境变量`GREP_COLORS`定义的色彩
- `-L`,`--files-without-match`: 打印没有匹配的文件名,压制正常输出
- `-l`,`--files-with-matches`: 压制正常输出,打印匹配的文件名
- `-m`,`--max-count=num`: 在匹配`num`个行之后停止读取文件
- `-o`,`--only-matching`: 只打印匹配的行匹配的部分
- `-q`,`--quiet`,`--silent`: 不打印任何消息至标准输出,找到任何匹配之后立即退出
- `-s`,`--no-messages`: 压制关于不存在或者不可读文件的错误消息

行输出前缀控制
---
在打印多个前缀域的时候,顺序总是文件名,行号,字节偏移,不管这些选项的指定顺序是如何
- `-b`,`--byte-offset`: 在行中的字节偏移
- `-H`,`--with-filename`: 打印文件名,在多个文件的时候是默认的
- `-h`,`--no-filename`,抑制前缀文件名的输出,在只有一个文件的时候是默认的
- `--label=LABEL`,将来自标准输入的输入看左边是来自文件`LABEL`
- `-n`,`--line-number`, 为每一行输出前缀行号
- `-T`,`--initial-tab`, 缩进
- `-u`,`--unix-byte-offset`,unix风格的字节偏移,没有用`-b`的时候是没有用的
- `-Z`,`--null`,输出一个空字符而不空格

上下文行控制
---
- 上下文行是在匹配行附近的没有匹配的行,只在使用了下面这些选项的时候输出
- `-A`,`--after-context=num`,打印匹配行后的`num`行
- `-B`,`--before-context=num`,前
- `-C`,`--context=num`,前+后
- `--group-separator=string`,在行组之间打印`string`替换`--`
- `--no-group-separator`,在组界限之间不打印分隔符号

文件和目录选择
---
- `-a`,`--text`: 将二进制文件当做文本处理
- `--binary-files=type`,如果文件数据或者元数据表明它是二进制文件,看做`type`类型的文件
- `-D`,`--devices=action`,如果输入文件是设备,FIFO,或者socket,使用`action`来处理它
- `d`,`--directories=action`,如果输入文件是目录,使用`action`来处理它,默认是`read`
- `--exclude=glob`,跳过命令行文件
- `--exclude-from=file`,跳过匹配来自`file`文件的模式的文件
- `--exclude-dir=glob`
- `-I`,处理二进制文件,就好像它没有包含匹配的元数据
- `--include=glob`,值搜有这些文件
- `-r`,`--recursive`,递归搜索,跟进命令行中的符号连接,但是跳过递归过程中的符号连接,没有给文件,搜索工作目录
- `-R`,`--dereference-recursive`,跟进符号连接的

其他选项
---
- `--line-buffered`,对输出使用行缓冲,会降低性能
- `-U`,`--binary`,将文件当做二进制文件
- `-z`,`--null`,将输出和输出数据当做`\0`终结的行序列

漏了点
---
- `-G`,`--basic-regexp`
- `-E`,`--extended-regexp`
- `-F`,`--fixed-tring`,不用正则
- `-P`,`--perl-regexp`
- 
