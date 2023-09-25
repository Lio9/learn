:<<eof
    Shell变量(关键字:变量,自定义变量命令,变量分类,环境变量,本地变量,位置参数变量,特殊变量,数组变量,字符串,字符串操作)
eof

#shell script中变量名定义方式如下
your_name='lio9@qq.com' #注意:变量名与等号之间不能有空格

:<<eof
变量名的命名必须遵顼如下规范:
    1.命名只能使用英文字符,数字和下划线,首个字符不能以数字开头
    2.变量名字符之间不能有空格,可以使用下划线'_'
    3.不能使用标点符号
    4.不能使用bash中的关键字(可以使用help命令查看保留关键字)

* 有效的shell变量名如下:
    DRINK
    LD_LIBRARY_PATH
    _var
    var2
* 无效变量名
    ?var
    user,your
    2password
eof

#除了显示地直接赋值,还可以用语句给变量赋值,如:(通过for循环将/etc下目录的文件名循环出来并赋值给file变量)
for file in `ls /etc`
do
    # 方法体
done
# 或者
for file in $(ls /etc)
do
    #方法体
done



:<<eof
    使用变量
eof
#使用一个定义过的变量,只要在变量名前面加美元符号($)
your_name="lio9@qq.com"
echo $your_name
echo ${your_name}
#注:变量名外的花括号是可选的,加花括号是为了帮助解释器识别变量的边界,例如如下情况:(因此在使用变量名时推荐加上{})
for skill in Ada Coffe Action Java
do
    echo "I am good at ${skill}Script"
done


:<<eof
    只读变量
eof
#使用readonly命令可将变量定义为只读变量,只读变量的值不能被改变
myEmail="lio9@qq.com"
readonly myEmail

#由于只读变量无法被重新赋值,因此下列操作会报错(/bin/bash: NAME: This variable is read only)
myEmail="liousad9@gmail.com"

:<<eof
    删除变量
eof
#使用unset命令可以喊出变量
your_name="lio9@qq.com"
unset your_name
echo your_name

:<<eof
    变量类型

    运行shell时,会同时存在三种变量:
    1.环境变量(Environment Variable):所有的程序,包括shell启动的程序,都能访问环境变量,有些程序需要环境变量来保证其正常运行,常用的环境变量包括PATH,HOME,USER
    2.局部(本地)变量(Local Variable):局部变量在脚本或者命令里定义,仅在当前shell实例中有效,其他shell启动的程序不能访问局部变量,本地变量可以通过=符号来定义和赋值.
    3.位置参数变量(Positional Variable):位置参数变量是用来存储shell脚本的命令行参数的,他们包括$1,$2,$3等,例如运行 一个shell脚本并且传递了两个参数,那么这两个参数会被分别赋值给$1和$2
    4.特殊变量(Special Variable):特殊变量是由shell程序预定义的,用于存储一些特定的值和状态,例如,$?用于存储上一个命令返回的值,$$用于存储当前shell进程的pid,$IFP用于存储当前shell的字段分隔符
eof

:<<eof
    shell字符串
eof
#字符串可以使用双引号,也可以使用单引号,也可以不使用引号
#单引号字符串
str='this is a string'
:<<eof
    单引号字符串的特性:
    1.单引号里任何字符串都会原样输出,单引号字符串中的变量是无效的
    2.单引号字符串不能出现单独一个的单引号(对单引号使用转义符也不行),但可以成对出现
eof

#双引号字符串
your_name="lio9@qq.com"
str="Hello, I know you are \"${your_name}\"!"
echo -e ${str} #-e选项含义为激活转义字符
:<<eof
    双引号字符串的特性:
    1.双引号字符串可以包含变量
    2.双引号字符串可以出现转义字符
eof

#拼接字符串
your_name="lio9@qq.com"
#使用双引号拼接
greeting="hello, "$your_name" !"
greeting_1="hello, ${your_name} !"
echo $greeting,$greeting_1

#使用单引号拼接
greeting='hello, '$your_name' !'
greeting_1='hello, ${your_name} !'
echo $greeting,$greeting_1



#获取字符串长度
string="abcd"
echo ${#string} #输出4
#变量为字符串时,${#string}等价于${#string[0]}

#提取子字符串
#以下实例从字符串第 2 个字符开始截取 4 个字符：
string="runoob is a great site"
echo ${string:1:4} # 输出 unoo
#注意：第一个字符的索引值为 0。

#查找子字符串
#查找字符 i 或 o 的位置(哪个字母先出现就计算哪个)：
string="runoob is a great site"
echo `expr index "$string" io`  # 输出 4
#注意： 以上脚本中 ` 是反引号，而不是单引号 '，不要看错了哦。

:<<eof
    Shell数组
    bash支持一维数组（不支持多维数组），并且没有限定数组的大小。
    类似于 C 语言，数组元素的下标由 0 开始编号。获取数组中的元素要利用下标，下标可以是整数或算术表达式，其值应大于或等于 0。
eof

:<<eof
    定义数组
    #在 Shell 中，用括号来表示数组，数组元素用"空格"符号分割开。定义数组的一般形式为：
    数组名=(值1 值2 ... 值n)
    例如：

    array_name=(value0 value1 value2 value3)
    或者

    array_name=(
    value0
    value1
    value2
    value3
    )
    还可以单独定义数组的各个分量：

    array_name[0]=value0
    array_name[1]=value1
    array_name[n]=valuen
    可以不使用连续的下标，而且下标的范围没有限制。
eof

:<<eof
读取数组
读取数组元素值的一般格式是：

${数组名[下标]}
例如：

valuen=${array_name[n]}
使用 @ 符号可以获取数组中的所有元素，例如：

echo ${array_name[@]}
eof

:<<eof
获取数组的长度
获取数组长度的方法与获取字符串长度的方法相同，例如：

实例
# 取得数组元素的个数
length=${#array_name[@]}
# 或者
length=${#array_name[*]}
# 取得数组单个元素的长度
length=${#array_name[n]}
eof

:<<eof
Shell 注释
以 # 开头的行就是注释，会被解释器忽略。

通过每一行加一个 # 号设置多行注释，像这样：

实例
#--------------------------------------------
# 这是一个注释
# author：菜鸟教程
# site：www.runoob.com
# slogan：学的不仅是技术，更是梦想！
#--------------------------------------------
##### 用户配置区 开始 #####
#
#
# 这里可以添加脚本描述信息
#
#
##### 用户配置区 结束  #####
如果在开发过程中，遇到大段的代码需要临时注释起来，过一会儿又取消注释，怎么办呢？

每一行加个#符号太费力了，可以把这一段要注释的代码用一对花括号括起来，定义成一个函数，没有地方调用这个函数，这块代码就不会执行，达到了和注释一样的效果。

多行注释
使用 Here 文档

多行注释还可以使用以下格式：

:<<EOF
注释内容...
注释内容...
注释内容...
EOF
以上例子中，: 是一个空命令，用于执行后面的 Here 文档，<<'EOF' 表示开启 Here 文档，COMMENT 是 Here 文档的标识符，在这两个标识符之间的内容都会被视为注释，不会被执行。
EOF 也可以使用其他符号:

实例
: <<'COMMENT'
这是注释的部分。
可以有多行内容。
COMMENT

:<<'
注释内容...
注释内容...
注释内容...
'

:<<!
注释内容...
注释内容...
注释内容...
!
直接使用 : 号

我们也可以使用了冒号 : 命令，并用单引号 ' 将多行内容括起来。由于冒号是一个空命令，这些内容不会被执行。

格式为：: + 空格 + 单引号。

实例
: '
这是注释的部分。
可以有多行内容。
'
eof