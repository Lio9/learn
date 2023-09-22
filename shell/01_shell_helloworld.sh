#!/bin/bash
:<<eof
    Shell介绍(关键字:shell解释器,执行脚本命令)
eof
:<<eof
Linux的shell种类众多,常见的有:
 -Bourne Shell (/usr/bin/sh或/bin/sh)
 -Bourne Again Shell (/bin/bash)
 -C Shell (/usr/bin/csh)
 -K Shell (/usr/bin/ksh)
 -Shell for Root (/sbin/sh)
较为常用的是Bourne Again Shell, Bash也是大多数Linux系统默认的Shell
在一般情况下人们并不区分Bourne Shell与Bourne Again Shell, 所以一般情况'#!/bin/sh' 可以改为 '#!/bin/bash'
'#!' 告诉系统其后路径所指定的解释器程序是解释此脚本文件的shell程序
eof

echo "Hello World!"
# echo用于向窗口输出文本


# =======================================================================
:<<eof
下述用到的脚本内容:
#!/bin/bash
echo "Hello World!"

运行shell脚本有两种方式:
    1.作为可执行程序
        (1)将上述脚本内容保存为text.sh,并cd到相应目录下
        (2)chmod +x ./text.sh #使脚本具有执行权限
        (3)./text.sh #执行脚本
            *执行命令语句区别
            ./text.sh -> 在当前目录虚招text.sh文件并执行
            text.sh -> 在PATH中寻找text.sh文件并执行(我们要执行的文件通常不在PATH目录下因此不要使用这种方式执行脚本文件)
    2.作为解释器参数
        直接运行解释器,其参数就是shell脚本的文件名,如:
        (1)将上述脚本内容保存为text.sh
        /bin/sh text.sh
        /bin/bash text.sh
        注意作为解释器参数运行脚本是,不需要在第一行指定解释器信息了(去除'#!/bin/bash')
eof