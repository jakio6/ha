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

