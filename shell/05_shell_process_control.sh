:<<eof
    shell流程控制
    介绍if-then-else-fi分支语句,if-then-elif-then-else-fi分支语句,for循环,while循环,until循环,case ...esac多选择语句
eof

#=============================
:<<eof
if-then-else-fi分支语句
    对应分支语句格式:

    if condition
    then
        command1
        command2
    else
        command3
        command4
    fi
    注意:在Bourne Shell和Bourne Again Shell脚本中,如果else分支没有语句执行,就不要写else这个分支

    if语句写成一句
    if [ $(ps -ef | grep -c "ssh") -gt 1 ]; then echo "true"; fi
eof


#========================
:<<eof
if-then-elif-then-else-fi分支语句
    对应分支语句格式

    if condition1
    then
        command1
        command2
    elif condition2
    then
        command3
        command4
    else
        command5
        command6
    fi
eof


#====================================================================================
:<<eof
if else 的 [...] 判断语句中大于使用 -gt，小于使用 -lt。

if [ "$a" -gt "$b" ]; then
    ...
fi
如果使用 ((...)) 作为判断语句，大于和小于可以直接使用 > 和 <。

if (( a > b )); then
    ...
fi
eof


#实例1
a=10
b=20
if [ $a == $b ]
then
   echo "a 等于 b"
elif [ $a -gt $b ]
then
   echo "a 大于 b"
elif [ $a -lt $b ]
then
   echo "a 小于 b"
else
   echo "没有符合的条件"
fi
#使用((...))作为判断句
a=10
b=20
if (( $a == $b ))
then
   echo "a 等于 b"
elif (( $a > $b ))
then
   echo "a 大于 b"
elif (( $a < $b ))
then
   echo "a 小于 b"
else
   echo "没有符合的条件"
fi

#if else 语句经常与 test 命令结合使用，如下所示：
num1=$[2*3]
num2=$[1+5]
if test $[num1] -eq $[num2]
then
    echo '两个数字相等!'
else
    echo '两个数字不相等!'
fi

:<<eof
for 循环
与其他编程语言类似，Shell支持for循环。

for循环一般格式为：

for var in item1 item2 ... itemN
do
    command1
    command2
    ...
    commandN
done
写成一行：

for var in item1 item2 ... itemN; do command1; command2… done;
当变量值在列表里，for 循环即执行一次所有命令，使用变量名获取列表中的当前取值。命令可为任何有效的 shell 命令和语句。in 列表可以包含替换、字符串和文件名。

in列表是可选的，如果不用它，for循环使用命令行的位置参数。

格式2:
    for var in {start..end}
    do
        command
    done
    注意:start为循环范围的起始值,必须为整数;end为循环范围的结束值,必须为整数

格式3
    for((i=start;i<=end;i++))
    do
        command
    done

eof

#实例
for str in This is a string
do
    echo ${str}
done


#=================================================================================
:<<eof
while 语句
while 循环用于不断执行一系列命令，也用于从输入文件中读取数据。其语法格式为：

while condition
do
    command
done
eof
#以下是一个基本的 while 循环，测试条件是：如果 int 小于等于 5，那么条件返回真。int 从 1 开始，每次循环处理时，int 加 1。运行上述脚本，返回数字 1 到 5，然后终止。
int=1
while(( $int<=5 ))
do
    echo $int
    let "int++"
done
#以上实例使用了 Bash let 命令，它用于执行一个或多个表达式，变量计算中不需要加上 $ 来表示变量，具体可查阅：Bash let 命令
#while循环可用于读取键盘信息。下面的例子中，输入信息被设置为变量FILM，按<Ctrl-D>结束循环。
echo '按下 <CTRL-D> 退出'
echo -n '输入你最喜欢的网站名: '
while read FILM
do
    echo "是的！$FILM 是一个好网站"
done


#=========================================================================
:<<eof
无限循环
无限循环语法格式：

while :
do
    command
done
或者

while true
do
    command
done
或者

for (( ; ; ))
eof


#==============================================================
:<<eof
until 循环
until 循环执行一系列命令直至条件为 true 时停止。

until 循环与 while 循环在处理方式上刚好相反。

一般 while 循环优于 until 循环，但在某些时候—也只是极少数情况下，until 循环更加有用。

until 语法格式:

    until condition
    do
        command
    done

condition 一般为条件表达式，如果返回值为 false，则继续执行循环体内的语句，否则跳出循环。
eof
#以下实例我们使用 until 命令来输出 0 ~ 9 的数字：
a=0

until [ ! $a -lt 10 ]
do
   echo $a
   a=`expr $a + 1`
done


#===============================================
:<<eof
case ... esac
case ... esac 为多选择语句，与其他语言中的 switch ... case 语句类似，是一种多分支选择结构，每个 case 分支用右圆括号开始，用两个分号 ;; 表示 break，即执行结束，跳出整个 case ... esac 语句，esac（就是 case 反过来）作为结束标记。

可以用 case 语句匹配一个值与一个模式，如果匹配成功，执行相匹配的命令。

case ... esac 语法格式如下：

    case 值 in
    模式1)
        command1
        command2
        ...
        commandN
        ;;
    模式2)
        command1
        command2
        ...
        commandN
        ;;
    *)
        command1
        command2
        ...
        commandN
        ;;
    esac
case 工作方式如上所示，取值后面必须为单词 in，每一模式必须以右括号结束。取值可以为变量或常数，匹配发现取值符合某一模式后，其间所有命令开始执行直至 ;;。

取值将检测匹配的每一个模式。一旦模式匹配，则执行完匹配模式相应命令后不再继续其他模式。如果无一匹配模式，使用星号 * 捕获该值，再执行后面的命令。
*模式作用类似与Java里switch ... case中的default关键字,上面所有分支豆没有匹配成功,最后将被*模式所匹配,并执行*模式中的command
case ...esac常用的模式匹配正则表达式如下:
格式        说明
*       表示任意字符串均可匹配
[abc]   表示a,b,c三个字符中任意一个
[m-n]   表示从m到n的任意一个字
|       表示多重选择,类似逻辑运算中的或运算
eof

#实例
echo '输入 1 到 4 之间的数字:'
echo '你输入的数字为:'
read aNum
case $aNum in
    1)  echo '你选择了 1'
    ;;
    2)  echo '你选择了 2'
    ;;
    3)  echo '你选择了 3'
    ;;
    4)  echo '你选择了 4'
    ;;
    *)  echo '你没有输入 1 到 4 之间的数字'
    ;;
esac

#======================================================================================

:<<eof
跳出循环
在循环过程中，有时候需要在未达到循环结束条件时强制跳出循环，Shell 使用两个命令来实现该功能：break 和 continue。

break 命令
break 命令允许跳出所有循环（终止执行后面的所有循环）。

eof

#下面的例子中，脚本进入死循环直至用户输入数字大于5。要跳出这个循环，返回到shell提示符下，需要使用break命令。
while :
do
    echo -n "输入 1 到 5 之间的数字:"
    read aNum
    case $aNum in
        1|2|3|4|5) echo "你输入的数字为 $aNum!"
        ;;
        *) echo "你输入的数字不是 1 到 5 之间的! 游戏结束"
            break
        ;;
    esac
done

#====================================================================================

:<<eof
continue
continue 命令与 break 命令类似，只有一点差别，它不会跳出所有循环，仅仅跳出当前循环。

运行代码发现，当输入大于5的数字时，该例中的循环不会结束，语句 echo "游戏结束" 永远不会被执行。
eof

#对上面的例子进行修改：
while :
do
    echo -n "输入 1 到 5 之间的数字: "
    read aNum
    case $aNum in
        1|2|3|4|5) echo "你输入的数字为 $aNum!"
        ;;
        *) echo "你输入的数字不是 1 到 5 之间的!"
            continue
            echo "游戏结束"
        ;;
    esac
done
