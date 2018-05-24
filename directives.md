# directives
___
所有汇编directives的name都是以poriod(`.`)打头的,对于多数target来说names是写不敏感的,通常是用小写.  
这一章讨论与GAS的target machine配置无关的directives.有些机器有些机器配置提供了额外的directives,参考[machine dependencies](https://sourceware.org/binutils/docs-2.30/as/Machine-Dependencies.html#Machine-Dependencies).
```
• Abort:	  	.abort
• ABORT (COFF):	  	.ABORT


• Align:	  	.align abs-expr , abs-expr
• Altmacro:	  	.altmacro
• Ascii:	  	.ascii "string"…
• Asciz:	  	.asciz "string"…
• Balign:	  	.balign abs-expr , abs-expr
• Bundle directives:	  	.bundle_align_mode abs-expr, etc
• Byte:	  	.byte expressions
• CFI directives:	  	.cfi_startproc [simple], .cfi_endproc, etc.
• Comm:	  	.comm symbol , length
• Data:	  	.data subsection
• Def:	  	.def name
• Desc:	  	.desc symbol, abs-expression
• Dim:	  	.dim


• Double:	  	.double flonums
• Eject:	  	.eject
• Else:	  	.else
• Elseif:	  	.elseif
• End:	  	.end
• Endef:	  	.endef


• Endfunc:	  	.endfunc
• Endif:	  	.endif
• Equ:	  	.equ symbol, expression
• Equiv:	  	.equiv symbol, expression
• Eqv:	  	.eqv symbol, expression
• Err:	  	.err
• Error:	  	.error string
• Exitm:	  	.exitm
• Extern:	  	.extern
• Fail:	  	.fail
• File:	  	.file
• Fill:	  	.fill repeat , size , value
• Float:	  	.float flonums
• Func:	  	.func
• Global:	  	.global symbol, .globl symbol
• Gnu_attribute:	  	.gnu_attribute tag,value
• Hidden:	  	.hidden names


• hword:	  	.hword expressions
• Ident:	  	.ident
• If:	  	.if absolute expression
• Incbin:	  	.incbin "file"[,skip[,count]]
• Include:	  	.include "file"
• Int:	  	.int expressions
• Internal:	  	.internal names


• Irp:	  	.irp symbol,values…
• Irpc:	  	.irpc symbol,values…
• Lcomm:	  	.lcomm symbol , length
• Lflags:	  	.lflags
• Line:	  	.line line-number


• Linkonce:	  	.linkonce [type]
• List:	  	.list
• Ln:	  	.ln line-number
• Loc:	  	.loc fileno lineno
• Loc_mark_labels:	  	.loc_mark_labels enable
• Local:	  	.local names


• Long:	  	.long expressions


• Macro:	  	.macro name args…
• MRI:	  	.mri val
• Noaltmacro:	  	.noaltmacro
• Nolist:	  	.nolist
• Octa:	  	.octa bignums
• Offset:	  	.offset loc
• Org:	  	.org new-lc, fill
• P2align:	  	.p2align abs-expr, abs-expr, abs-expr
• PopSection:	  	.popsection
• Previous:	  	.previous


• Print:	  	.print string
• Protected:	  	.protected names


• Psize:	  	.psize lines, columns
• Purgem:	  	.purgem name
• PushSection:	  	.pushsection name


• Quad:	  	.quad bignums
• Reloc:	  	.reloc offset, reloc_name[, expression]
• Rept:	  	.rept count
• Sbttl:	  	.sbttl "subheading"
• Scl:	  	.scl class
• Section:	  	.section name[, flags]


• Set:	  	.set symbol, expression
• Short:	  	.short expressions
• Single:	  	.single flonums
• Size:	  	.size [name , expression]
• Skip:	  	.skip size , fill


• Sleb128:	  	.sleb128 expressions
• Space:	  	.space size , fill
• Stab:	  	.stabd, .stabn, .stabs


• String:	  	.string "str", .string8 "str", .string16 "str", .string32 "str", .string64 "str"
• Struct:	  	.struct expression
• SubSection:	  	.subsection
• Symver:	  	.symver name,name2@nodename


• Tag:	  	.tag structname


• Text:	  	.text subsection
• Title:	  	.title "heading"
• Type:	  	.type <int | name , type description>


• Uleb128:	  	.uleb128 expressions
• Val:	  	.val addr


• Version:	  	.version "string"
• VTableEntry:	  	.vtable_entry table, offset
• VTableInherit:	  	.vtable_inherit child, parent


• Warning:	  	.warning string
• Weak:	  	.weak names
• Weakref:	  	.weakref alias, symbol
• Word:	  	.word expressions
• Zero:	  	.zero size
• 2byte:	  	.2byte expressions
• 4byte:	  	.4byte expressions
• 8byte:	  	.8byte bignums
```
## .abort
这个伪指令会立即停止汇编,这是为了与其他汇编器的兼容性.最初的想法是汇编代码会piped into汇编器,如果输入源要quit了,它可以用这个伪指令来使汇编器同样quit,不久的将来,这个指令将不再被支持.(好像有点问题,assembler指的是什么嘞?)..
## .ABORT(COFF)
在生成COFF输出时,as接收这个伪指令作为.abort的同义词
## .algin *abs-expr,abs-expr,abs-expr*
填充位置计数器(在当前的subsectiion)到一个指定的内存界限(storage bounary),第一个expresstion(必须是非负数)是对齐所需要的,就像下面描述的这样.  

第二个expresstion(同样是非负数)给出在填充到填充字节中的值,它(包括逗号)可以被省略,如果这样,填充字节通常是0,然而,如果这个section被标记为包含代码并且fill value缺省,填充字节会被合适地填满no-op指令.   

第三个expresstion同样是非负的,并且同样是可选的,如果给出,它表示这个指令这个指令下所能跳过的最大值,如果进行对齐操作需要跳过比这个指定最大值更多的byte,这个对齐操作将不会进行,你可以完全省略填充值值(第二个参数)通过简单地在对齐要求后使用两个逗号(comma)这在需要将对齐空间适当填充为no-op指令时很有用.  


指定alignment要求的方式各种system中是不同的,对于使用ELF, i860, iq2000, m68k, or1k, s390, sparc, tic4x, tic80 and xtensa的arc, hppa, i386来说,第一个expresstion是以bytes给出的alignment request,比如`.algin 8`会增加位置计数器直到它是8的倍数,如果已近是了,就不需要改变(不用再加个8),对于tic53x,第一个表达式以words形式给出.  

对于其他system,包括使用ppc,使用啊a.out格式输出的i386,arm还有strongarm,它(第一个参数)指的是在向前对齐后位置计数器低位0的必须的个数,比如`.algin 3`会增加位置计数器直到它是8的倍数,如果位置计数器已近是8的倍数了,就不需要进行改变.  

这种不一致是由于gas必须仿真这些系统所使用的各种各样的汇编语言的不同行为,gas同样提供了`.balign`和`.p2algin`伪指令(之后会介绍),他们可以在所有不同架构上有一致的效果(but are specific to GAS)(???)
## .altmacro
开启替换宏模式,enabling:  
### LOCAL name[, ...]
一个额外的伪指令,LOCAL,可用.它用为每一个name argument进行string替换,替换串在汇编时是唯一的,而对每一个分开的宏拓展是不同的,LOCAL允许你写定义symbol的宏而不用担心不同宏拓展之间会产生冲突  
### string delimiters
除了"string"之外,你还可以用这些delimited方式来写strings:
- `'string'`单引号
- `<string>`尖括号

### single-character string escape
为了确保在一个字符串中可以包含一个字符(即使这个字符可能有特殊的意义),可以给这个字符前缀一个感叹号`!`,比如:可以通过`'4.3 !> 5.4!!>'`来得到literal text`'4.3 > 5.4!'`.
### expresstion results as strings
可以通过可以通过`%expr`来计算一个expresstion的值并吧结果作为字符串使用.
## .ascii "string"...
.ascii 接收0到多个分号分割的string literals(字面量),并吧他们装载到连续的内存空间(不会自动trailing 0byte (\0?))
## .asciz "string"...
`.asciz`与`.ascii`相似,只是会在每个string字面量后面加一个0,`.asciz`中的"z"指的就是"zero"
## .balign[wl] *abs-expr, abs-expr, abs-expr*
Pad the location counter (in the current subsection) to a particular storage boundary. The first expression (which must be absolute) is the alignment request in bytes. For example ‘.balign 8’ advances the location counter until it is a multiple of 8. If the location counter is already a multiple of 8, no change is needed.

The second expression (also absolute) gives the fill value to be stored in the padding bytes. It (and the comma) may be omitted. If it is omitted, the padding bytes are normally zero. However, on most systems, if the section is marked as containing code and the fill value is omitted, the space is filled with no-op instructions.

The third expression is also absolute, and is also optional. If it is present, it is the maximum number of bytes that should be skipped by this alignment directive. If doing the alignment would require skipping more bytes than the specified maximum, then the alignment is not done at all. You can omit the fill value (the second argument) entirely by simply using two commas after the required alignment; this can be useful if you want the alignment to be filled with no-op instructions when appropriate. 

`.balignw`与`.balgin来`伪指令是`.balgin`的变体,`.balginw`伪指令将填充部分视为两个byte的word值,比如`..balginw 4,0x368d`会4位对齐,如果跳过了两个字节,它将被填充为值0x368d(实际填充的位置视处理器endianness(字节顺序,大小端)而定,如果跳过了一到三个byte,填充值是undefined(???)
## bundle direcitves
### .bundle_align_mode abs-expr
`.bundle_align_mode`使能或者关闭 aligned instruction捆绑模式,在这个模式下相邻指令序列会被归入固定大小的bundles,如果参数是0,这个模式是关闭的(默认的模式),如果参数不是0,它给以2的幂的形式出instruction bundle的大小(至于`.p2align`伪指令,参考,自己找)
对于一些target,it’s an ABI requirement that所有指令都不能跨越特定的对齐界限,A bundle简单的说就是从对齐界限开始的一个指令序列.比如,`如果abs-expr是5那么bundle的大小就是2的五次方:32,所以每32个对齐的byte一组就是一个bundle`当`aligned instruction bundle`模式是有效的话,单个指令都不能跨过bundles间的界限,如果一条指令开始位置离一个bundle的末尾太近而导致那条指令在接下来的地方填不下了,那么那个bundle末尾就会被填充no-op指令,以使这条指令从下一个bundle开始,作为一个常识,单挑指令编码长度超过bundle size是会error的
### .bundle_lock and .bundle_unlock
`.bundle_lock` 与 `.bundle_unlock`伪指令,允许对指令bundle填充的精确控制,这些指令只在已用`.bundle_align_mode`来使能对齐指令bundle模式,如果这个模式未设置而这些指令却出现了的话就是error的,对于某些targets,it’s an ABI requirement that特定的指令只能作为指定的允许的sequences of multiple instructions中的一部分出现,全部都在同一个bundle中,每对`.bundle_lock`与`.bundle_unlock`定义了一个bundle-locked的指令序列,处于对对齐指令bundle模式的考虑,以`.bundle_lock`开始到`.bundle_unlock`结束的序列被当作一条单指令,换句话说,整个序列必须能填进单个的bundle而不至于越过bundle界限,如果需要的话,no-op指令会被查到这个指令序列第一条指令之前(不就是这个序列前吗,为什么说的这么复杂...),以使得整个序列从一个对齐的bundle界限开始,如果这个序列长度比bundle的size要大的或是error的.  
为了在宏内使用使用`.bundle_lock`和`bundle_unlock`的方便,bundle-locked的序列可能是嵌套(nested)的,就是说,在`.bundle_unlock`出现之前可能会出现下一个`.bundle_lock`,此时除非再出现一个关闭的`.bundle_unlock`,否则这个后出现的是无效的???,就是说有lock和unlock的个数要相同.
## .byte expresstions
`.byte`接收0或多个逗号分隔expresstions,每个expresstion都会被装载进下一个byte
## CFI directives
>***CFI:Call Frame instructions框架调用指令***

### .cfi_sections *section_list*
`.chi_sections`可以用来指定CFI是否生成`.eh_frame`section或者`.debug_frame`,如果*section_list*是`.eh_frame`,`.eh_frame`is emitted,如果*section_list*是`.debug_frame`,`.debug_frame`is emitted,要emit两者的话用`.eh_frame`,`.debug_frame`,这个伪指令的缺省值是`.cfi_sections .eh_frame`
On targets that support compact unwinding tables these can be generated by specifying .eh_frame_entry instead of .eh_frame.Some targets may support an additional name, such as .c6xabi.exidx which is used by the target.   
`.cfi_sections`伪指令可以重复,可以带相同或者不同的参数,如果CFI generation还没有开始,一旦他开始section list就固定了,任何attempts to redefine it will result in an error.
### .cfi_startproc [simple] 
`.cfi_stratproc`用在每个需要在`.eh_frame`有入口的函数开始,他会初始化一些内部数据结构,不要忘记用`.chi_endproc`来关闭函数.除非`cfi_startproc`是带simple参数使用的,不然他会产生一些视架构而定的CFI初始化指令.
### .cfi_endproc
`.cfi_endproc`用在函数末尾来关闭先前被`.cfi_startproc`打开的开放的入口,并且emit it into `.eh_frame`
### .cfi_personality encoding [, exp]
.cfi_personality 定义personality routine和its encoding.encoding必须是一个常量,来决定personality因该如何编码,如果是255(DW_EH_PE_omit),第二个参数没有给出,否则第二个参数因该是一个常量或者是一个symbol name.当使用间接编码的时候,给出的symbol因该是personality可以加载的源地址(此时parsonality不从它的routine加载),`.cfi_startproc`后的缺省值是`.cfi_personality 0xff`,没有personality routine
### .cfi_personality_id id
`.cfi_personality_id`通过他的索引定义了compact unwinding format的特征例程,只在生成紧凑EH frames时有效(i.e.(换句话说) with .cfi_sections eh_frame_entry. )
### .cfi_fde_data [opcode1 [, …]]
`.cfi_fde_data `用来描述要用于当前函数的紧凑退绕操作码.这些是生成在`eh_frame_entry`section的,如果足够小并且没有LSDA,否则在`.gnu.extab`section,只在生成紧凑 EH frames有效(i.e. with .cfi_sections eh_frame_entry. )
### .cfi_lsda encoding [,exp]
`.cfi_lsda`定义了LSDA以及它的编码方式,编码方式必须是一个决定LSDA因该被如何编码的常量.如果是255(DW_EH_PE_omit),第二个参数不同给出,否则第二个参数应是一个常量或者是symbol name,`.cfi_startproc`后的缺省值是`.cdi_lsda 0xff`表示没有给出LSDA.
### .cfi_inline_lsda [align]
`.cfi_inline_lsda`标记了一个LSDA data section的开始并转到关联的 `.gnu.extab`section.在这之前必须有一个包含`.cfi_lsda`伪指令的CFI block,只在生成 紧凑 EH frames时有效(i.e. with .cfi_sections eh_frame_entry. )表头和unwinding opcodes会在这个时候生成,所以它们后面会紧跟LSDA数据,通过`.cfi_lsda`伪指令引用的symbol因该保持定义状态以防使用基于fallback FDE的编码,LSDA数据由(任?)一个section伪指令终结(折后面好像排版错了,我有看到上面的东西额了,,,,)
### .cfi_def_cfa register, offset
`.cfi_def_cfa`定义了计算CFA的规则:取寄存器中数据并将offset加到其上.
### .cfi_def_cfa_regisster register
`.cfi_def_cfa_register`修改计算CFA的规则,从这是开始使用 register来代替原来的那个,offset保持不变
### .cfi_def_cfa_offset offset
`.cfi_def_cfa_offset`修改计算CFA的规则,register保持不变,offset更新,需注意的是这是要加到一个定义的register上的用来计算CFA地址的非负数.
### .cfi_adjust_cfa_offset offset
与上一个`.cfi_def_cfa_offset`相似,但是这个offset是从原来的offset上加减的向对值(可为负数..?)
### .cfi_offset register, offset
Previous value of register is saved at offset offset from CFA.
### .cfi_val_offset register, offset
Previous value of register is CFA + offset.
### .cfi_rel_offset register, offset
Previous value of register is saved at offset offset from the current CFA register. This is transformed to .cfi_offset using the known displacement of the CFA register from the CFA. This is often easier to use, because the number will match the code it’s annotating. 
### .cfi_register register1, register2
Previous value of register1 is saved in register register2.
### .cfi_restore register
`.cfi_restore`表示当前的rule for register与刚进入函数的时候是一样的(在`.cfi_startproc`执行初始化指令之后的)
### .cfi_undefined register
从现在开始无法再恢复到先前的值
### .cfi_same_value register
当前寄存器的值与先前的frame是一样的,就是说不用重置
### .cfi_remember_state and .cfi_restore_state
`.cfi_remember_state`每个寄存器的对则压入一个 implicit stack,而`.cfi_restore_state`则将他们取出,并将他们放到current row.这在你需要操作操作由于控制流程需要撤销影响的`.cfi_*`伪指令的时候是很有用的,比如,我们可以这样做(假设CFA是rbp的值):
```
        je label
        popq %rbx
        .cfi_restore %rbx
        popq %r12
        .cfi_restore %r12
        popq %rbp
        .cfi_restore %rbp
        .cfi_def_cfa %rsp, 8
        ret
label:
        /* Do something else */
```
在这里,我们想要 `.cfi`伪指令只影响与`label`之前的指令有关的行.这意味着我们需要在label指令之后加多个`.cfi`伪指令来重建寄存器内原来的数据,就像将CFA重新设为rbp的值一样,这可能会显得有些笨拙,并且会使得二进制文件大小变大,instead,可以这样写:
```
        je label
        popq %rbx
        .cfi_remember_state
        .cfi_restore %rbx
        popq %r12
        .cfi_restore %r12
        popq %rbp
        .cfi_restore %rbp
        .cfi_def_cfa %rsp, 8
        ret
label:
        .cfi_restore_state
        /* Do something else */
```

这样,label后指令的规则会与第一个`.cfi_restore`之前一样,而不用使用多个`.cfi`伪指令(是我眼瞎吗,明明下面这个比较多,还是他忘了删了,偷工减料)
### .cfi_return_column register
change return column register,就是说返回地址不是直接在寄存器中就是可以通过register的规则得到????
### .cfi_signal_frame
标记当前函数作为signal trampoline
### .cfi_window_save
SPARC register window has been saved. 
### .chi_escape expresstion[,...]
允许使用者添加任意的bytes到unwind info,可以使用这个来添加操作系统专门的CFI或者类似的GAS还不支持的CFI opcodes
>终于看到这个的结尾了,玛格及,完全看不懂好吧


### .cfi_val_encoded_addr register,encoding,label
寄存器的当前值是label,label的值会被编码到输出文件根据编码encoding;参看`.cfi_personality`来了解这个encoding的details.  
将一个寄存器等价为一个固定label的用处,is probably limited to the return address register.这里,它能标记一个只有一个返回地址代码段并且通过direct branch访问,内存和寄存器中不会存留任何返回值.
> 玛格及累死了,看了半天完全看不明白的

## .comm symbol , length
`.comm`声明一个叫symbol的common symbol,在链接的时候,一个common symbol 可能会合其他目标文件中的同名的defined的或者common symbol合并,
如果ld没有找到对这个symbol的定义-just one or more symbol-他就会给length长度的字节数未初始化内存,长度必须是非表达式,如果ld发现了多个同名的common symbol,而他们length又不一致,ld会分配这之中最大的一个.  
在使用ELF或者(as a gun extension)PE时,`.comm`伪指令接收可选的第三个参数,这是这个symbol想要的对齐方式,以byte界限的形式为ELF指定(比如,16对齐表示地址最低四个有效位是0),以2的幂的形式为PE指定(比如5的对齐意味着32byte界限的对齐)alignment必须是非负表达式,并且必须是2的倍数(差不多这个意思),如果ld要为common symbol分配未初始化的内存,它会在安置symbol的时候使用这个对齐形式,如果没有指定对齐方式,as会将对齐方式设置为最大的小于或等于这个symbol size的2的平方数,,ELF上的最大值是16,PE的默认值是4(`这不同于ld的--section-alignment选项控制的可执行镜像(image)文件对齐方式,PE中镜像文件中的sections是以4096的整数倍对齐的,这与寻常变量的对齐方式相差甚远, (他同样是目标文件中的默认对齐方式,通常它不怎么严格对齐)It is rather the default alignment for (non-debug) sections within object (‘*.o’) files, which are less strictly aligned.`),在HPPA上的`.comm`的语法有点不同,格式是`symbol .comm,length`;symbol是可选的
 ## .data *subsection*
 `.data`告诉as将接下来的statements装载进编号为*subsection*(非负数)的data subsection的末尾,如果*subsection*缺省,默认值是0.
 ## .def *name*
 开始为symbol *name*定义调试信息,定义展开直到 遇到`.ended`伪指令.
 ## .desc *symbol* , *abs-epxresstion*
 这条伪指令设置一个symbol的描述符设置为一个非负表达式值的低十六位.
 这个伪指令在as输出模式为COFF时不可用,它只对a.out或者b.out目标文件格式有效,在COFF输出格式时处于对兼容性的考虑,as会接受这条指令,但不会产生任何输出(针对这条个指令?)
 ## .dim 
 这个伪指令是编译器生成的用来,用来在symbol表中包含额外的调试信息,它只允许出现在`.def` 与 `.endef`之间.
 ## .double *flonums*
 `.double`接收0到多个逗号隔的浮点数,它装配浮点数,具体产生的浮点数类型视as的配置而定.
 
## .eject
在生成assembly listings时强制在这里page break
## .else
`.else`是as支持的条件编译的一部分,见`.if`节,它标记了一个在`.if`条件不成立的情况下要被汇编的section的起点.
>### 插播,昨天终于听到有人说了,at&t语风格汇编中的section就是intel风格中的segment


## .elseif
`.elseif`是as条件会变得的一部分...,他是在一个`.if`语句中用一个新的`.if`完全填充其`.else`section的简略形式.
## .end
`.end`标记了汇编文件的结尾.as在碰到`.end`伪指令后不会在处理此文件中的任何东西
## .endef
与`.def`配对来进行symbol definition
## .endfunc
`.endfunc`用来与`.func`配对做啥啥啥
## .endif
`.endif`是as支持的条件汇编的一部分,它标记了一只在特定条件下编译的块的结束
## .equ *symbol* , *expresstion*
这个伪指令将*symbol*的值设为*expresstion*,与`.set`是相同的,在HPPA上equ的语法是*symbol* `.equ`*expresstion*,在z80上的语法是symbol equ expresstion,在z80上如果*symbol*是已定义的话使用这个指令会出错
,但是这个情况下这个symbol也是被可以重定义的,
## .equiv *symbol* , *expresstion*
`.equiv`与`.equ` `.set`相似,除了在*symbol*是已定义的的情况下汇编器会报错,注意被引用但未实际定义的symbol认为是未定义的.  
除了错误信息的内容,这个指令大致与下面的形式等价:
```
.ifdef SYM
.err
.endif
.equ SYM,VAL
```
加上它可以防止*symbol*再被重定义??(plus it protects the symbol from later redefinition. )
## .eqv *symbol* ,*expresstion*
`.eqv`伪指令与`.equiv`相似,但是它并不会去管expresstion的值是什么.之后每次这个*symbol*被用在表达式中的时候,它的当前值被被用来计算
## .err
如果as汇编到了一条`.err`伪指令,他会打印一条错误信息,并且,除非使用了`-Z`选型,否则将不会在生成目标文件,者可以用来示意条件编译代码中的一个错误.
## .error "string"
与`.err`相似,这条伪指令会产生一个错误,但是你可以指定要作为错误信息的字符串,如果你没有指定这条信息,他默认是".errot directive invoked in source file"
`.error "this code has not been assembled and tested"`
## .exitm
提前从当前宏定义中退出. 见MACRO
## .extern 
`.extern`在源程序中被接受--为了与其他assembler(这东西到底几个意思>.<)的兼容性--但它会被忽略??as把所有未定义的symbol都看作是external的.
## .fail *expresstion*
生成一个错误或者警告,如果*expresstion*的值大于等于500,as会打印warning,如果值小于500,as会报错.这条信息会包含*expresstion*的值,这在高度条套宏或条件编译时很有用.
## .file 
有两种版本的`.file`伪指令.支持DWARF2 line number 信息的Target使用DWARF2版本的 `.file`,其他的使用默认的.
### default version
这个版本的`.file`伪指令告诉as我们准备要start以个新的逻辑文件,语法是:  
`.file` *string*
*string*是新文件的名字.通常,这个文件名不管带不带""都能被识别,但是如果你想制定文件名为空,就必须要"". This statement may go away in future: it is only recognized to be compatible with old as programs.
### DWRF2 Version
When emitting DWARF2 line number information,`.file`为`.debug_line`文件名表分配文件名,语法是:  
`.file` *fileno* *filename*
*fileno*操作数必须是唯一的正数,来多为表的入口索引.*filename*是一个C字符串字面量.filename索引对使用者是可见的,因为filename table是与DWRF2调试信息中的,因此使用者必须直到表入口的索引`.debug_info`section一起共享的
## .fill *repeat* , *size* ,*value*
三个参数都是非表达式,这条指令会重复生成size bytes的复制,repeat可以是0或着更多,size也是大于等于0,但如果超过了8,他的值就会被看作8,与别人的assembler兼容,每个从负的byte都取自一个8byte的数,高的4为是0,低四位是以as运行机器上整数顺序编排的value,同样,这个怪异的特性与其他人的assembler是兼容的???  
size和value是可选的,如果缺省第二个逗号,value就被当作是0,如果从第一逗号开始省略,size被看作是1.
## .float *flonums*
这个指令装配一个或多个逗号分隔的浮点数.与`.single`作用相同,具体生成的浮点数类型是as配置而定
## .func name[,label]
`.func`生成denote函数名的调试信息,并且如果文件编译时为开启调试这个会被忽略.当前只支持`--gstabs[+]`*label*是函数的入口,并且如果缺省的话会使用预定义的`leading char`,`leading char`通常是\_(blank?)或者nothing,视target而定,All functions are currently defined to have void return type. The function must be terminated with .endfunc.
## .global *symbol* , .globl *symbol*
`.global`使得*symbol*对ld可见,如果你在某个程序文件中定义了*symbol*,这使得他的值将可以在其他与之相连的文件中可用,另一方面,*symbol*可以通过定义在同一程序的定以在不同文件中同名symbol来获得.
Both spellings (‘.globl’ and ‘.global’) are accepted, for compatibility with other assemblers.   
On the HPPA, .global is not always enough to make it accessible to other partial programs. You may need the HPPA-only .EXPORT directive as well. See HPPA Assembler Directives. 
## .gnu_attribute *tag*,*value*
为此文件recoard a GNU object attribute,见哪里哪里
## .hidden *names*
这是ELF的visibility伪指令之一,另外的两个 是`.internal`和`.protected`  
这个伪指令会覆盖named symbols原来的可见性(local,global,weak捆绑设定).在这个伪指令把可见性设置为`hidden`,这意味着它对其他component不可见,这样的symbol通常也被看作是protected.
## .hword *expresstion*
接收0到多个*expresstion*,并为每个接收的生成一个16位的值.这条伪指令是`.short`的同义词,是目标架构而定,同样也是`.word`的同义词.
## .ident
这个伪指令被一些assembler用来在目标文件中设tag.这个伪指令的行为视target不同而有所不同.在使用a.out目标文件格式时,as接受这个通常是为了与其他已有汇编器的源文件的兼容性,但不会为之生成任何东西,,在使用COFF的时候,comments生成在`.comment`或者`rdata`section里视target而定,在使用ELF的时候,comments生成在`.comment`section中
## .if *absolute expresstion*
`.if`标记了一段代码的开始,这段代码只在参数*absolute expresstion*(非负)非0时才编译,这个段的结尾必须有`.endif`注明.,你也可以选择在其他条件下编译另一段代码,由`.else`标注.如果你有好几个条件要校对,`.elseif`可以用来防止嵌套的if/else出现在`.else`块中.  
还下面这几种`.if`的变体:
>讲真接下这些if的后缀有些似曾相识的感觉


### .ifdef *symbol*
如果定义了指定的*symbol*,编译接下来的代码段,注意被引用但是并未显示定义的认为是未定义的.
### .if *text*
如果操作数是空(blank)的,编译接下来的代码段.
### .ifc *string1*,*string2*
如果两个串相同,编译接下来的代码.字符串可以用单引号括起来,如果字符串未带括号,第一个字符串到逗号截至,第二个字符串到行末结束.带空白字符的字符串因该用引号括起来.
### .ifeq *absolute expresstion*
参数为0就编译(不多写了)
### .ifeqs *string1*,*string2*
`.ifc`的临=另一种形式,字符串必须用双引号.
### .ifxx *absolute expresstion*
ge|大于等于0
-|
gt|大于0
le|小于等于
lt|小于
ne|不等于0(与if差不多)

### .ifnb *text*
与`.ifb`相似,条件相反,如果非空则编译
### .ifnc *string1*,*string2*
与`.ifc`相似,条件相反,两个字符串不相等的时候编译
### .ifndef *symbol*
### .ifnotdef *symbol*
如果*symbol*未定义则执行,上述两种形式是相等的,只引用未显示定义的看作为定义的
### .ifnes *string1*,*string2*
与`.ifeqs`相似,条件相反,如果两个字符串不相等时时编译.
## .incbin "*file*"[,*skip*[,count]]
`.incbin`伪指令将文件的字面量全部加到当前位置,你可也通过`-I`命令行选项控制搜索路径,_file_旁的引号是必需的.  
*skip*参数指定跳过文件开头的一定数目的字节(*skip*个?),_count_指定的读取字节的最大数,注意这些数据并未有任何对齐,所以有必要采取措施来保证在`.incbin`前后给出了合适的对齐方式.
## .include "_file_"
这条伪指令提供了在源代码中指定位置包含支持文件的方法.来自_file_中的代码会参与编译,就好像他们就是紧跟在`.include`之后一样.当到达包含文件末尾的时候,原来的编译会继续进行,可以通过命令行选项控制文件搜索路径,_file_ __旁的括号是必需的__
## .int expresstions
接收来自任何section的0到多个expresstion,逗号分隔.对于每个expresstion,生成其运行时当前值,字节顺序视目标target而定
## .internal *names*
这是ELF可见性控制伪指令之一,另外两个是`.hidden`和`.protected`,
This directive overrides the named symbols default visibility (which is set by their binding: local, global or weak). The directive sets the visibility to internal which means that the symbols are considered to be hidden (i.e., not visible to other components), and that some extra, processor specific processing must also be performed upon the symbols as well.(见`.hidden`)
## .irp *symbol*,*values*...
由`.endr`终结,将每个value带入*symbol*进行一次编译,如果没有给出value,将*symbol*当成是空串,编译一次,在statements序列中引用*symbol*,使用`\symbol`  
For example, assembling

        .irp    param,1,2,3
        move    d\param,sp@-
        .endr

is equivalent to assembling

        move    d1,sp@-
        move    d2,sp@-
        move    d3,sp@-
For some caveats with the spelling of symbol, see also Macro.
## .irpc *symbol*,*values*...
逐字符代入,具体见下,自行与上头的比较  
For example, assembling

        .irpc    param,123
        move    d\param,sp@-
        .endr

is equivalent to assembling

        move    d1,sp@-
        move    d2,sp@-
        move    d3,sp@-
## .lcomm *symbol* , *length*
Reserve length (an absolute expression) bytes for a local common denoted by symbol. The section and value of symbol are those of the new local common. The addresses are allocated in the bss section, so that at run-time the bytes start off zeroed(.lcomm定义的变量在bss段中,初值是0). Symbol is not declared global (see .global), so is normally not visible to ld.   (还是不翻译的好)
Some targets permit a third argument to be used with .lcomm. This argument specifies the desired alignment of the symbol in the bss section.  
The syntax for .lcomm differs slightly on the HPPA. The syntax is ‘symbol .lcomm, length’; symbol is optional. 
## .lflags
为了与其他assembler兼容,as接受这个参数,但是会忽略它(就是不改也不报错)
## .line *line-number*
改变逻辑行号,*line-number*必须是非负数,下一行的行号就是那个逻辑行号,因此当前的其他语句都是在逻辑行1,(啥意思啊),One day as will no longer support this directive: it is recognized only for compatibility with existing assembler programs.(看到这个我就明白该怎么做了)  
尽管这个伪指令是与a.out,b.out目标文件格式有关的,as在生成COFF文件是依旧会识别这个指令,并把它当成COFF中的`.ln`,如果他在`.def` `.endef`之外.  
而在`.def`之中`.line`是编译器用来为调试生成额外的符号信息的.
## .linkonce [type]
标记当前的section,使得ld在链接时只会include一次(条好像有点用).这个可以用来在不同目标文件中包含相同的section,但可以保证在最后的输出文件中只包含一次.每次这个section出现的时候都要使用这条伪指令,重复的section是根据名字检测的,所以它必须是独特的????*type*参数是可选的,如果指定,他必须是一下字符串中的一个,比如:  
### .linkonce same_size
不是所有类型都一定在所有目标文件输出格式中被支持.
### discard
默默的扔掉重复的section,缺省值.
### one_only
如果有重复的section,就警告,但依旧值保留一个copy.
### same_size
如果任何重复section大小不一致就警告.
### same_contents
如果任何重复section中内容不一致就警告.
## .list
控制(与`.nolist`一起)是否生成assembly listings, 这两个伪指令maintain一个内部计数器(初始值为0),`.list`会增加它而`.nolist`会减少它,只要其大于0的时候就会生成assembly listing.
listings通常是关闭的,当你打开时(使用-a命令行选项),listing counter的初始值是1.
## .ln *line-number*
`.ln`是`.line`的同义词
## .loc *fileno* *lineno* [column] [options]
在生成DWARF2行号信息时,`.loc`伪指令会在与紧跟的灰汇编指令有关的`.debug_line`行号矩阵后加上一row,*fileno* *lineno*和可选的*column*参数会在row被添加之前应用到`.debug_line`状态机中.  
*option*是任意顺序下列符号组成的序列:
### basic_block
This option will **set** the **basic_block register** in the .debug_line state machine to **true**.
### prologue_end
This option will **set** the **prologue_end register** in the .debug_line state machine to **true**.
### epilogue_begin
his option will **set** the **epilogue_begin register** in the .debug_line state machine to **true**. 
### is_stmt *value*
This option will **set** the **is_stmt register** in the .debug_line state machine to **value**, **which must be either 0 or 1**.
### isa *value*
This directive will **set** the **isa register** in the .debug_line state machine to **value**, **which must be an unsigned integer**.
### descriminator *value*
This directive will **set** the **discriminator register** in the .debug_line state machine to **value**, **which must be an unsigned integer**.
### view *value*
This option causes a row to be added to .debug_line in reference to the current address (which might not be the same as that of the following assembly instruction), and to associate value with the view register in the .debug_line state machine. If value is a label, both the view register and the label are set to the number of prior .loc directives at the same program location. If value is the literal 0, the view register is set to zero, and the assembler asserts that there aren’t any prior .loc directives at the same program location. If value is the literal -0, the assembler arrange for the view register to be reset in this row, even if there are prior .loc directives at the same program location. 
(我觉得这是我永不上的)
## .loc_mark_labels enable
When emitting DWARF2 line number information, the .loc_mark_labels directive makes the assembler emit an entry to the .debug_line line number matrix with the basic_block register in the state machine set whenever a code label is seen. The enable argument should be either 1 or 0, to enable or disable this function respectively.
## .local *names*
这个ELF格式可用的伪指令,标记每个逗号分隔的*names*中的symbol作为一个本地symbol,使其对外不可见,如果某个symbol还不存在,则会创建它,那些`.lcomm`不接收对齐参数的目标文件多是ELF,`.local`可以用来和`.comm`一起定义对齐的本地普通数据.
## .long *expresstion* 
`.long`与`.int`相同.
## .marco
命令`.marco`和`.endm`允许你定义可以产生汇编输出的marco.例如,这个定义指定了可以将一个数字序列写入内存的marco`sum`:
```
        .macro  sum from=0, to=5
        .long   \from
        .if     \to-\from
        sum     "(\from+1)",\to
        .endif
        .endm
```
 这个定义之后,`SUM 0,5`,就等价与以下的汇编输出:
```
        .long   0
        .long   1
        .long   2
        .long   3
        .long   4
        .long   5
```
### .marco *macname*
### .marco *macname* *macargs* ...
开始marco *macname*的定义.如果你的marco需要参数,在marco name之后指定他们的名字,参数之间由逗号或空格分隔.
可以通过修饰marco的参数来指示是否所有的调用都必须指定一个非空值(通过`:req`),或者是否需要所有剩余的参数(通过`:vararg`),通过在参数名后面加`=deflt`可以为参数指定默认值,不能定义两个同名marco,除非在两次定义之间它已经受到了`.purgem`伪指令作用(解除宏定义).
for example,下面都是合法的`.marco` statement:

### `.marco comm`
开始名为comm的marco的定义,这个marco补需要参数.
### `.marco plus1 p, p1`
### `.marco plus1 p p1`
两个语句都开始名为plus1的marco的定义,需要两个参数,在marco定义内,通过`\p` 或`\p1`来取得参数的值.
### `.marco reserve_str p1=0 p2`
开始名为reserve_str的marco的定义,带两个参数,第一个参数有默认值,但第二个没有,在定义完成之后,你可以通过`reserve_str a,b`**(`\p1`取`a`的值)**或者`reserve_str ,b`(`\p1`取默认值,在本例中为0)来调用此marco.
### `.marco m p1:req, p2=0, p3:vararg`
开始名为`m`的marco的定义,需要至少三个参数,第一个参数的值必须指定,而第二个不必,第三个formal会被分配所有在调用(**invocation**)时指定的其他参数.  
在调用marco的时候可以通过位置或关键字指定参数,比如,`sum 9,17`与`sum to=17,from=9`是等价的.

(接下来将的大概是将\ 调用的参数与另外一些可以作为标符一部分的一些符号用在一起可能出现的一些错误及解决办法,差不多嘛,看一下就可以了)
Note that since each of the macargs can be an identifier exactly as any other one permitted by the target architecture, there may be occasional problems if the target hand-crafts special meanings to certain characters when they occur in a special position. For example, if the colon (:) is generally permitted to be part of a symbol name, but the architecture specific code special-cases it when occurring as the final character of a symbol (to denote a label), then the macro parameter replacement code will have no way of knowing that and consider the whole construct (including the colon) an identifier, and check only this identifier for being the subject to parameter substitution. So for example this macro definition:

	.macro label l
\l:
	.endm

might not work as expected. Invoking ‘label foo’ might not create a label called ‘foo’ but instead just insert the text ‘\l:’ into the assembler source, probably generating an error about an unrecognised identifier.

Similarly problems might occur with the period character (‘.’) which is often allowed inside opcode names (and hence identifier names). So for example constructing a macro to build an opcode from a base name and a length specifier like this:

	.macro opcode base length
        \base.\length
	.endm

and invoking it as ‘opcode store l’ will not create a ‘store.l’ instruction but instead generate some kind of error as the assembler tries to interpret the text ‘\base.\length’.

There are several possible ways around this problem:

Insert white space

If it is possible to use white space characters then this is the simplest solution. eg:

    	.macro label l
    \l :
    	.endm

Use ‘\()’

The string ‘\()’ can be used to separate the end of a macro argument from the following text. eg:

    	.macro opcode base length
            \base\().\length
    	.endm

Use the alternate macro syntax mode

In the alternative macro syntax mode the ampersand character (‘&’) can be used as a separator. eg:

    	.altmacro
    	.macro label l
    l&:
    	.endm

Note: this problem of correctly identifying string parameters to pseudo ops also applies to the identifiers used in .irp (see Irp) and .irpc (see Irpc) as well.
### .endm
标记一个marco定义的结尾.
### .exitm
提前退出marco定义
### \@
as maintains 一个统计已近执行了多少marco的计数器in this伪(pseudo)变量,可以通过`\@`将那个值copy到输出,只在marco定义内有效.
### LOCAL *name* [ ,...]
Warning: LOCAL is only available if you select “alternate macro syntax” with ‘--alternate’ or .altmacro. See .altmacro. 
## .mri *val*
如果*val*是非0的,这条伪指令会使as进入MRI模式,如果*val*是0,则会使as退出MRI模式,这个指令会影响直到下一个`.mri`指令的代码,或者到文件结束,
## .noaltmarco
关闭alternate marco模式.
## .nolist
控制assembly listings是否生成,这两个指令maintain 一个内部的计数器(初值是0)`.list`加它,`.nolist`减它,在这个计数器大于0的时候就会进行assembly listing的生成.
## .octa *bignums*
这个伪指令接收0到多个逗号分隔的参数,对每个bignum,生成一个16byte的整数.  
术语*octa*来源与,一个word是2byte,因此一个octa-word就是16byte.
## .offset *loc* 
在absolute section中将位置寄存器设置为*loc*,*loc*必须是非负表达式,这个伪指令在用绝对值定义symbol的时候很有用,别吧这个伪指令与`.org`混淆了???
## .org *new-lc* ,*fill*
将当前section的location counter前移到*new-lc*,*new-lc*可以是非负表达式或者an expression with the same section as the current subsection.这意味着,不能用`.org`来cross section:如果*new-lc*值有误,这条指令会被忽略.为了与先前的assembler兼容,如果*new-lc*(指明?)的section 是absolute的,as会哇让您提示,然后会假设,*new-lc*的section与当前subsection是相同的.  
.org指令只能增加位置寄存器,或者不动它,不能使用`.org`指令后移位置寄存器.因为as要尽可能一遍就编译玩程序,*new-lc*不能是未定义的,如果你真的非常讨厌这个设定的话我们非常希望能使用您改进过的assembler.  
注意相关性是与当前section有关的,不是当前subsection.这与其他人的汇编程序兼容(老谈这东西什么意思)  
当当前subsection的位置寄存器被advance了,其经过的中间byte会用*fill*(非负)填充,缺省值是0.
## .p2algin[wl] *abs-expr*,*abs-expr*,*abs-expr*
填充当前subsection的位置寄存器到一个特定的内存边界,第一个表达式是前移后位置寄存器低位0要有的个数,(3表示8对齐)  
第二个表达式给出填充字节中的填充值(可以省略,缺省值通常是0,如果这个section被注明为包含code,会被填充no-op 指令.  
第三个表达式同样是非负的,可选的,如果给出,它指明这个对齐指令所能跨过byte的最大值,如果进行这个对齐需要跨过超过这个指定最大值的byte,这条指令则不会执行,You can omit the fill value (the second argument) entirely by simply using two commas after the required alignment; this can be useful if you want the alignment to be filled with no-op instructions when appropriate.   
`.p2alignw`与`.p2alignl`是`.p2align`的变体,`.p2alignw`把填充模型看作两字节的值,`p2alignw 2,0x368d`会按4对齐,如果跨过了两个字节,会将其填充上0x368d(实际填充顺序视处理器的端序而定),如果跨过1或3个byte,the fill value is undefined. 
## .popsection
这是ELF佛如section stack操作伪指令之一,另外的是**`.section`**,`.subsection`,`.pushsection`和`.previous`.  
这条指令将使用section stack顶端的section(and subsection)替换当前的section(and subsection),this section is popped off the stack(就是pop嘛)
## .previous
This is one of the ELF section stack manipulation directives. The others are .section (see Section), .subsection (see SubSection), .pushsection (see PushSection), and .popsection (see PopSection).   
这条指令将当前section(and subsection)与其前最近引用过的一个section/subsection pair交换 Multiple .previous directives in a row will flip between two sections (and their subsections). For example:   
```
.section A
 .subsection 1
  .word 0x1234
 .subsection 2
  .word 0x5678
.previous
 .word 0x9abc
 ```
Will place 0x1234 and 0x9abc into subsection 1 and 0x5678 into subsection 2 of section A. Whilst(同时):
```
.section A
.subsection 1
  # Now in section A subsection 1
  .word 0x1234
.section B
.subsection 0
  # Now in section B subsection 0
  .word 0x5678
.subsection 1
  # Now in section B subsection 1
  .word 0x9abc
.previous
  # Now in section B subsection 0
  .word 0xdef0
  ```
  Will place 0x1234 into section A, 0x5678 and 0xdef0 into subsection 0 of section B and 0x9abc into subsection 1 of section B.(可能得先看subsection)
 ## .print *string* 
 as会在编译的时候输出*string*到标准输出,string要带双引号.
 ## .protected *names*
 This is one of the ELF visibility directives. The other two are .hidden (see Hidden) and .internal (see Internal). (到齐了)  
 改变指定named symbol默认的可见性(local,global,weak一起改).The directive sets the visibility to protected which means that在定义了这个symbol的component中对这个symbol的引用一定会是这个component中此symbol的定义,即使在其他component中的定义通常会抢占(preempt).
 ## .psize *lines* ,*columns*
 使用这个伪指令来声明行号,可选的列数用来use for each page, when generating listings.   
 不用`.psize`指令,listing的默认line-count是60,可以缺省逗号和*columns*,默认的宽度是200列.
 在行号越界的时候as会生成formfeeds(换页符,page break分页符)(或者在你使用`.eject`明确指定需要一个的时候)  
 If you specify lines as 0, no formfeeds are generated save those explicitly specified with .eject.
 ## .purgem *name*
 取消marco名定义.
 ## .pushsection *name* [,subsection] [ ,"flags"[,@type [,arguements]]]
 This is one of the ELF section stack manipulation directives. The others are .section (see Section), .subsection (see SubSection), .popsection (see PopSection), and .previous (see Previous). (还差个subsection,哎呀好像还差section)  
将当前section(and subsection)压入section stack顶部,然后用*name*与*subseection*替换当前section和subsection.可选的啥啥啥和section中的一样.
## .quad *bignums*
.quad expects zero or more bignums, separated by commas. For each bignum, it emits an 8-byte integer. If the bignum won’t fit in 8 bytes, it prints a warning message; and just takes the lowest order 8 bytes of the bignum.

The term “quad” comes from contexts in which a “word” is two bytes; hence quad-word for 8 bytes. (四个word的大数)
## reloc *offset*,*reloc_name*[,*expresstion*]
Generate a relocation at offset of type reloc_name with value expression. If offset is a number, the relocation is generated in the current section. If offset is an expression that resolves to a symbol plus offset, the relocation is generated in the given symbol’s section. expression, if present, must resolve to a symbol plus addend or to an absolute value, but note that not all targets support an addend. e.g. ELF REL targets such as i386 store an addend in the section contents rather than in the relocation. This low level interface does not support addends stored in the section. 
## .rept *count*
重复接下来与`.endr`之间的行序列*count*次
比如,编译

        .rept   3
        .long   0
        .endr
与编译

        .long   0
        .long   0
        .long   0
是等价的        
*count*允许是0,但什么都不会生成,不允许是负数,如果碰到了,会被当作是0.
## .subttl "*subheading*"
生成assembly listings时使用*subheading*作为title(third line,immediately after the title line??)  
这个伪指令会影响接下来的paegs,如果出现在当前pege的前十行的话也会影响当前page.
## .scl *class*
设定一个symbol的storage-class值,这个指令不能用与`.def`对中,storage-class标志着一个symbol是static还是external或是包含记录的更多的调试标识信息.
## .section *name*
使用`.section`伪指令来指示将接下来的代码装进名为*name*的section.  
这个指令值在实际支持任意命名section的target上生效,在a.out母校文件爱呢模式下,他不被接受?????(不是一直在用吗.....),即使是使用标准的a.out section名.
### COFF Version
对于COFF目标文件,`.section`伪指令使用方式有以下几种:  
#### `.section name[, "flags"]`
#### `.section name[,subsection]`
如果可选参数带括号,他被看作是用于此section的flags,每个flag都是一个单字符,允许接下来的这些flags:

b|bss section(未初始化的数据)
-|
n|section is not loaded
w|wirtable section
d|data section
e|exclude section from linking
r|read-only section
x|executable section
s|shared section (对PE文件有意义)
a|ignored (为了与ELF版本的兼容性)
y|section is not readable(meaningful for PE targets)
0-9|single-digit power-of-two section alignment (GNU extension)

如果没有指定flags,默认的flags是section名字而定.如果section名字不能识别,the default will be for the section to be loaded and writable. 注意n与w标识会从这个section移除属性,而不是增加他们,so if they are used on their own it will be as if no flags had been specified at all.   
可选参数没带括号时被看作是subsection number.
### ELF Version
This is one of the ELF section stack manipulation directives. The others are .subsection (see SubSection), .pushsection (see PushSection), .popsection (see PopSection), and .previous (see Previous).   
对与ELF目标文件格式,`.section`伪指令的格式是这样使用的:  
#### `.section name [,"flags"[,@type[,flag_specific_arguments]]]`
如果给定了`--section-subset`命令行选项,*name*参数中可以包含替代序列,当前只支持**%S**,and substitutes the current section name.比如:
```
.macro exception_code
.section %S.exception
[exception code here]
.previous
.endm

.text
[code]
exception_code
[...]

.section .init
[init code]
exception_code
[...]
```
这两个`exception_code`的调用分别会创建`.text.execption`section和`.init.section`section.This is useful e.g. to discriminate between ancillary sections that are tied to setup code to be discarded after use from ancillary sections that need to stay resident without having to define multiple exception_code macros just for that purpose.(自己看)  
可选的*flags*参数是由任意以下字符组成的带括号的字符串:  
a

    section is allocatable 
d

    section is a GNU_MBIND section 
e

    section is excluded from executable and shared library. 
w

    section is writable 
x

    section is executable 
M

    section is mergeable 
S

    section contains zero terminated strings 
G

    section is a member of a section group 
T

    section is used for thread-local-storage 
?

	section is a member of the previously-current section’s group, if any 
    
    
< number>

	a numeric value indicating the bits to be set in the ELF section header’s flags field. Note - if one or more of the alphabetic characters described above is also included in the flags field, their bit values will be ORed into the resulting value. 
< target specific>

    some targets extend this list with their own flag characters 

注意,一旦一个section的flags被设置后就不能再修改.然而也有一些例外.处理器和应用特定的flags可以加到已定义的section中去.`.interp`,`.strtab`和`.symtab`section可以在flags设置后重新设置flag(a)(一个?特定的),`.note-GNU-stack`section可以增加可执行(x)flag.

可选的*type*参数可以包含一下常量中的一个:

@progbits

    section contains data 
@nobits

    section does not contain data (i.e., section only occupies space) 
@note

    section contains data which is used by things other than the program 
@init_array

    section contains an array of pointers to init functions 
@fini_array

    section contains an array of pointers to finish functions 
@preinit_array

    section contains an array of pointers to pre-init functions 
@< number>

    a numeric value to be set as the ELF section header’s type field. 
@< target specific>(比如@function?)

    some targets extend this list with their own types 


许多targets只支持最前面的三个section类型.如果需要的话type可以带双引号.

在一些用**`@`**字符作为注释开始符号的target(比如 ARM)上,会使用另一个替代符号,比如ARM ports使用**`%`**符号.
有些特殊section,比如`.text`和`.data`已近有填充的类型了,如果试图取修改的话assembler会报错.  
如果flags里含有M,*type*就必须作为连带一个额外的参数一起指定,像这样:
	
    .section name , "flags"M, @type,entsize
带M flag但不带S flag的section必须包含固定大小的常量,每个entsize八字节(octets)长. (each entsize octets long.)好像错了.  
带M和S flag的必须包含终结字符串,每个字符长*entsize*字节.  
链接器会移除section中名称相同,实体大小相同,标识相同的重叠部分,*entsize*必须是非负的,对每个同时带MS的section,a string which is a suffix of a larger string is considered a duplicate. Thus "def" will be merged with "abcdef"; A reference to the first "def" will be changed to a reference to "abcdef"+3. 

如果*flags*里带了G,那么*同type*参数就必须与另一个额外的field一起给出,像这样:

	.section name , "flags"G, @type ,GroupName[,linkage]
GroupName field指定了这个section所属的section group的名字,可选的linkage field可以包含:
#### comdat
表明这个section有一个???
#### .gnu.linkence
comdat的别名,,,差不多直到什么意思了.

注意,如果同时有`M` `G`,Merge flag的附属参数因该先出现,像这样:

	.section name ,"flags"MG,@type,entsize,GroupName[,linkage]
如果flags里有`?`,则不能带`G`.`?`表明要考虑当前在这个伪指令之前的section,如果那个section带了`G`,那么这个新的section会使用G和相应的相同的参数,,如果没带,那么之歌`?`没有作用.

如果没有指定flag,默认的flag视section的名字而定,如果给出的section名不被识别,默认不会设置任何flag:他不会被分配内存,不可写,不可执行.这个section会包含数据.

对于ELF目标,为了与Solaris 汇编器兼容,本汇编支持另一种形式的`.section`伪指令:
#### .section "name"[,flags...]
注意section名是带引号的,可以带逗号分隔的flag序列:

#alloc

    section is allocatable 
#write

    section is writable 
#execinstr

    section is executable 
#exclude

    section is excluded from executable and shared library. 
#tls

    section is used for thread local storage 
This directive replaces the current section and subsection. See the contents of the gas testsuite directory gas/testsuite/gas/elf for some examples of how this directive and the other section stack directives work. 
## .set *symbol , expresstion*
将*symbol*的值设置为*expresstion*,这会改变symbol的值和value来顺从*expresstion*,如果*symbol*被标记为external,那么它仍然是标记的.  

可以多次`.set`一个symbol,只要给symbol的都是常量,基于带其他symbol的expresstion的值也是允许的,但有些目标形式可能会限制没次汇编只能进行一次,这是因为这些target在assembly的时候并不设置symbol的address,而是直到最后链接的时候才进行,his allows the linker a chance to change the code in the files, changing the location of, and the relative distance between, various different symbols. 

如果你`.set`了一个 global symbol,最终在目标文件中他的值是最后存进它的(这不是肯定的吗...)  
在 Z80上 `set`是一个真正的指令,使用`symbol defl expresstion`来替代.
## .short *expresstion*
`.short`通常与`.word`是一样的(在有些机器上长度是不一的)
## .single *flonums*
这个伪指令分配0到多个由逗号分隔的浮点数,与`.float`效果一样,具体生成视as配置而定.
## .size
这个伪指令用来与symbol有关的大小
### COFF Version
对于 COFF target,`.size`伪指令只允许出现在`.def`对之中,像这样使用:

	.size expresstion
### ELF Version
对于ELF target,`.size`伪指令这样使用:

	.size name ,expresstion
这条伪指令设置与symbol name有关的size,这个size的byte由*expresstion*得出,可以利用label进行算数运算,这个伪指令通常是用来设置函数symbol的size.
## .skip *size* ,*fill*
这条伪指令会生成*size*个byte,每个值都为*fill*,*size*和*fill*都是非负数,如果逗号和*fill*缺省,默认填充值为0,这与`.space`相同.
## .sleb128 expressions
sleb128 stands for “signed little endian base 128.” This is a compact, variable length representation of numbers used by the DWARF symbolic debugging format. See .uleb128. 
## .space *size* ,*fill*
描述与`.skip`相同.Warning: .space has a completely different meaning for HPPA targets; use .block as a substitute. See HP9000 Series 800 Assembly Language Reference Manual (HP 92432-90001) for the meaning of the .space directive. See HPPA Assembler Directives, for a summary.
## .stabd, .stabn, .stabs
There are three directives that begin ‘.stab’. All emit symbols (see Symbols), for use by symbolic debuggers. The symbols are not entered in the as hash table: they cannot be referenced elsewhere in the source file. Up to five fields are required:

string

    This is the symbol’s name. It may contain any character except ‘\000’, so is more general than ordinary symbol names. Some debuggers used to code arbitrarily complex structures into symbol names using this field.
type

    An absolute expression. The symbol’s type is set to the low 8 bits of this expression. Any bit pattern is permitted, but ld and debuggers choke on silly bit patterns.
other

    An absolute expression. The symbol’s “other” attribute is set to the low 8 bits of this expression.
desc

    An absolute expression. The symbol’s descriptor is set to the low 16 bits of this expression.
value

    An absolute expression which becomes the symbol’s value. 

If a warning is detected while reading a .stabd, .stabn, or .stabs statement, the symbol has probably already been created; you get a half-formed symbol in your object file. This is compatible with earlier assemblers!

.stabd type , other , desc

    The “name” of the symbol generated is not even an empty string. It is a null pointer, for compatibility. Older assemblers used a null pointer so they didn’t waste space in object files with empty strings.

    The symbol’s value is set to the location counter, relocatably. When your program is linked, the value of this symbol is the address of the location counter when the .stabd was assembled.
.stabn type , other , desc , value

    The name of the symbol is set to the empty string "".
.stabs string , type , other , desc , value

    All five fields are specified. 
照抄
## .string "*str*",.string8 "*str8*",.string16 "*str*", .string32 "*str*", .string64 "*str*" 
将*str*中的字符copy到目标文件中,你可以用逗号分隔来指定copy多个string,Unless otherwise specified for a particular machine,汇编器会用0byte作为string的结尾标识,你可以用strings中描述的任何逃脱序列.

后面带16,32那些的会把每个8bit的字符加长到16,32个bit,拓展的字符以xxxxxxx顺序排列:
example:

	.string32 "BYE"
expands to:

	.string   "B\0\0\0Y\0\0\0E\0\0\0"  /* On little endian targets.  */
	.string   "\0\0\0B\0\0\0Y\0\0\0E"  /* On big endian targets.  */
## .struct *expresstion*
切换到absolute section,并将section offset 设置为*expresstion*(非负数),像这样:
       
       .struct 0
field1:

        .struct field1 + 4
field2:
       
       .struct field2 + 4
field3:  
这将会使symbol *field*值为0,*field2*值为4,*field3*值为8.汇编会保持在absolute section,进一步汇编之前你需要使用某种形式的`.section`伪指令变更到其他section.
## .subsection *name*
ELF section stack操作伪指令之一, The others are .section (see Section), .pushsection (see PushSection), .popsection (see PopSection), and .previous (see Previous).   
这条伪指令使用*name*替换当前当前的subsection,当前的section不会改变,被替换的subsection会被放到当时stack subsection的顶端.
## .symver
```
Use the .symver directive to bind symbols to specific version nodes within a source file. This is only supported on ELF platforms, and is typically used when assembling files to be linked into a shared library. There are cases where it may make sense to use this in objects to be bound into an application itself so as to override a versioned symbol from a shared library.

For ELF targets, the .symver directive can be used like this:

.symver name, name2@nodename

If the symbol name is defined within the file being assembled, the .symver directive effectively creates a symbol alias with the name name2@nodename, and in fact the main reason that we just don’t try and create a regular alias is that the @ character isn’t permitted in symbol names. The name2 part of the name is the actual name of the symbol by which it will be externally referenced. The name name itself is merely a name of convenience that is used so that it is possible to have definitions for multiple versions of a function within a single source file, and so that the compiler can unambiguously know which version of a function is being mentioned. The nodename portion of the alias should be the name of a node specified in the version script supplied to the linker when building a shared library. If you are attempting to override a versioned symbol from a shared library, then nodename should correspond to the nodename of the symbol you are trying to override.

If the symbol name is not defined within the file being assembled, all references to name will be changed to name2@nodename. If no reference to name is made, name2@nodename will be removed from the symbol table.

Another usage of the .symver directive is:

.symver name, name2@@nodename

In this case, the symbol name must exist and be defined within the file being assembled. It is similar to name2@nodename. The difference is name2@@nodename will also be used to resolve references to name2 by the linker.

The third usage of the .symver directive is:

.symver name, name2@@@nodename

When name is not defined within the file being assembled, it is treated as name2@nodename. When name is defined within the file being assembled, the symbol name, name, will be changed to name2@@nodename. 
```
## .tag structname
这个伪指令是编译器用来在symbol table中生成额外调试信息的,只允许出现在`.def`对中,Tags是用来symbol table中的structure 定义及其实例(instance)
## .text *subsection*
告诉as将接下来的语句汇编到编号为*subsection*(absolute)的text sibsection(了解下),如果 *subsection*缺省,默认值为0.
## .title "*heading*"
在生成assembly listings时使用*heading*作为title(第二行,紧跟在源文件名和pagenumber之后).
如果这条伪指令出现在一个page的前十行的话,它还会影响后面的page.
## .type
这条伪指令用来设置一个symbol的type.  
###COFF Version
对COFF targets,这个伪指令只允许出现在`.def`对之中,用法像这样:
#### .type *int*
这会记录integer *int*作为一个符号表入口的类型属性.
### ELF Version
对于ELF targets,`.type`伪指令用法如下:
#### .type *name* , *type decription*
这回设置symbol *name*的类型为function symbol或者object symbol.*type description*字段支持五种不同的语法,为了与不同的assembler兼容.

由于在这些语法中使用的有些字符(不如`@`和`#`)在某些架构上是注释符,下面的有些语法并不能在所有架构上都支持,The first variant will be accepted by the GNU assembler on all architectures so that variant should be used for maximum portability, if you do not need to assemble your code with other assemblers.

The syntaxes supported are:
```
  .type <name> STT_<TYPE_IN_UPPER_CASE>
  .type <name>,#<type>
  .type <name>,@<type>
  .type <name>,%<type>
  .type <name>,"<type>"
```
The types supported are:

#### STT_FUNC  
#### function
```
    Mark the symbol as being a function name.
```
#### STT_GNU_IFUNC
#### gnu_indirect_function

    Mark the symbol as an indirect function when evaluated during reloc processing. (This is only supported on assemblers targeting GNU systems).
#### STT_OBJECT
#### object

    Mark the symbol as being a data object.
#### STT_TLS
#### tls_object

    Mark the symbol as being a thread-local data object.
#### STT_COMMON
#### common

    Mark the symbol as being a common data object.
#### STT_NOTYPE
#### notype

    Does not mark the symbol in any way. It is supported just for completeness.
#### gnu_unique_object

    Marks the symbol as being a globally unique data object. The dynamic linker will make sure that in the entire process there is just one symbol with this name and type in use. (This is only supported on assemblers targeting GNU systems).
注意:有些targets支持一些额外的type来作为上面列出的这些的补充.
## .uleb128 expressions
uleb128 stands for “unsigned little endian base 128.” This is a compact, variable length representation of numbers used by the DWARF symbolic debugging format. See .sleb128. 
## .val *addr*
这条伪指令只允许出现在`.def`对中,将地址*addr*记录为一个符号表入口的value属性.
## .version "*string*"
This directive creates a .note section and places into it an ELF formatted note of type NT_VERSION. The note’s name is set to string. 
## .vtable_entry *table, offset*
这条伪指令会找到或者创建一个symbol *table*并以加数**offset**为其创建一个**VTABLE_ENTRY**重定位???
## 	.vtable_inherit *child, parent*
这个伪指令寻找符号*child*并找或者创建符号*parent*然后以child symbol的值作为加数为*parent*创建一个重定位.当parent的名字为0的时候,会被特殊处理为指代`*ABS*`section.
## .warning "*string*"
类似于指令`.error`,但是只产生一个warning.
## .weak *names*
这条伪指令为逗号分隔的符号names设置weak属性,如果这个symbol并不存在,则会被创建.  
在COFF targets上,weak symbols是一个GNU拓展(extension)??,这条伪指令会....同上.  
在PE targets上,在带支持weak symbol,作为weak 别称??,当一个weak symbol 创建时that is not an alias,GAS会生成一个替代符号来保存默认值.
## .weakref *alias ,target*
这条伪指令为*target*symbol创建一个别称以使得这个symbol可以weak-symbol语法引用,但并不会真的使得它变为weak.如果给出了这个symbol的直接寻址或者定义,这个符号不会是weak,但如果是所有对它的引用都是通过weak references,这个symbol在符号表中会被标记为weak.

这个效果等同于将所有对这个别称的引用移到一个独立文件中,然后将这个别名重命名为它原来的名字,并在那里将他的类型设置为weak,然后对移除了alias的文件与新加文件进行reloadable的链接.

alias本身丛始至终并不会进入符号表,只在assembler中处理.
## .word *expresstion*
这条伪指令接收来自任意section的由逗号分隔的0到多个expresstion.

生成的number的size和byte order视target computer而定.
>### warning:Special Treatmeent to support Compilers

有32位地址空间,但寻址低于32位的机器,需要一下特殊处理,如果你感兴趣的机器是32位寻址的(or doesn’t require it; see Machine Dependencies),你可以忽略这个问题.  
In order to assemble compiler output into something that works, as occasionally does strange things to ‘.word’ directives. Directives of the form ‘.word sym1-sym2’ are often emitted by compilers as part of jump tables. Therefore, when as assembles a directive of the form ‘.word sym1-sym2’, and the difference between sym1 and sym2 does not fit in 16 bits, as creates a secondary jump table, immediately before the next label. This secondary jump table is preceded by a short-jump to the first byte after the secondary table. This short-jump prevents the flow of control from accidentally falling into the new table. Inside the table is a long-jump to sym2. The original ‘.word’ contains sym1 minus the address of the long-jump to sym2.

If there were several occurrences of ‘.word sym1-sym2’ before the secondary jump table, all of them are adjusted. If there was a ‘.word sym3-sym4’, that also did not fit in sixteen bits, a long-jump to sym4 is included in the secondary jump table, and the .word directives are adjusted to contain sym3 minus the address of the long-jump to sym4; and so on, for as many entries in the original jump table as necessary. 
## .zero *size*
This directive emits size 0-valued bytes.size必须是非负的,这条伪指令实际上是`.skip`的别称,所以它可以带一个可选的第二参数来作为填充值,但是那样用就有点误导人了.
## .2byte *expresstion* [,*expresstion*]\*
这条指令接收0到多个逗号分隔的参数,如果没有就什么都不干,否则就轮流计算每一个expresstion的值然后填充到当前output section的下两个byte,如果这个值表达要大与两个字节,就会警告,然后取低为的两个字节作为实际填充值,如果一个expresstion的值在assembly time不能确定,就会进行relocation在link时确定.  
这条伪指令在填充值的前后都不会进行任何的对齐,as a result of this,如果进行了relocation,they may be different from those used for inserting values with a guaranteed alignment.This directive is only available for ELF targets.
## .4byte* expression [, expression]*\*
与`.2byte`指令类似,除了它在输出中插入unaligned,4byte的值.
## .8byte *expression [, expression]*\*
......不说了.
## Deprecated Directives
有一天这些指令将不再生效,包含他们只是为了与老板的编译器兼容.
### .abort
### .line



___
好了终于尼马抄完了,实在是不想抄了,到后面全是照cole,没办法,不这样做根本看不下去.....