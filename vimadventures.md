# vim-adventures!!!
# 冒险开始
当赛达尔碰上文本编辑
>你操作一个某一天突然出叫这个做textland的基于半文本的世界的光标,这里居住着一些小人,但却由bug统治,很快你便发现你的到来是一个古老的预言,这个世界的秩序由你来恢复(除非你现在还没有达到两级..)

好,冒险开始:

上下左右`k` `j` `h` `l`为什么什么就只有这几个...走来走去发现有个向的梯子走不过去,试了好久,表上有个小东西表示,从长行到短行会到那行的末尾,此时如果继续,我试一下,好ok,继续到另一个行就和从最开始那个行到到这个行一样的,如果这个行比最开始那个短就到最后,不然保持在相同的列.(搞错了,因该是最初换行时的列而不是最初行的长度,差不多啦)

恍然大悟,到上面那个最长的行尾巴上去,一直下下下就跳过那个挡路的了>.<  

继续

又碰到个告诉我什么是word的小人(因为我马上要捡到`w`啦,开心,终于不是lv1了):
>word是字母数字和下划线组成的序列(汉字包括在这里面,后面那个理解错了),或者是标点符号(~~准确的应该是是其他非空字符~~)的序列,或者是一个空行,找到`w` `b` `e`就能在words中穿梭自如啦

好啦捡到`w`啦,现在可以借助word向后越过石块了,好多宝藏等我发现.......

轻松得到`e`,可以跳到word末尾,不会在空行白处停下,所以可以借用空白来越过一些`w`跳不过的地方,新技能get.

`b`get,可以反向`w`了,哦耶.

集齐钥匙见到了下一个引路人,她叫我小心???

总算见到了bug,多出来的字符,红色方框标识

又捡到了`B`好像看起来和`b`一样啊,试了下再看了看帮助,`B`的是`WORD`
>WORD 是非空字符序列,就是说word中前两种合并了~~~  

___
>传说在文本大陆之下有着禁忌的删除能力但是还没有人能得到它,他们被困在一个讨厌的循环中,消失了,马的这家伙说没三十秒就会把我传回来防止我迷失在片大陆,,,,,怕怕

一路`w` `e`捡到了好像是`x`还好他把我传送回来了,不然就回不去了

>`x`是command,前面的是motion,有什么不一样呢

`x`删除从当前光标到之后的指定个字符,比如`x2`删两个,`x`就是一个嘛.

删了多余字符,又有人来报信
>我有个紧急信息要告诉你:我们终于发现了bugs可怕计划,你一定要复原迷宫中丢失的aritfact(啥玩意)并尽快回到这里(ASAP)!

好的回到迷宫打开宝箱,整个世界暗了下了
## there is more
## for more information click here
玛格集要钱,拜拜