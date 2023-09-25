
:<<eof
    shell数组(关键字:declare,关联数组,获取关联数组的键)
eof
#Bash shell只支持一组一维数组,初始化时不需要定义数组大小,数组用()表示,数组的下标从0开始,元素以空格分隔,语法如下:

array_name=("1" "2" "3" "4")

#额外:数组中的元素也可以通过变量引用的方式来赋值,如下
A="1"
array_name=(${A} "2" "3" "4")

:<<eof
    通过数字索引读取数组元素
eof
echo "数组的第一个元素为: ${array_name[0]}" #1
echo "数组的第二个元素为: ${array_name[1]}" #2
echo "数组的第三个元素为: ${array_name[2]}" #3
echo "数组的第四个元素为: ${array_name[3]}" #4

#=======================================
:<<eof
    关联数组
eof
# Bash支持关联数组,可以使用任意的字符串或者整数为下表来访问的数组元素,关联数组使用declare命令来声明,格式如下:
declare -a arrayName
:<<eof
    -a 选项就是用于声明一个关联数组
    declare命令还有其他选项:后续进行扩展
    选项类型:
        a:将变量声明为数组型
        i:将变量声明为整数型
        x:将变量声明为环境变量
        r:将变量声明为只读类型
        p:显示指定变量的声明类型
eof
:<<eof
    实例(从实例定义可以看出,declare修饰后的数组的'下标可自定义为任意字符串与数字',类似于Java中的Map集合)
eof
declare -a site=(["google"]="www.google.com" ["taobao"]="www.taobao.com")

#亦可先声明一个关联数组,然后在设置键值对
declare -a site
site["google"]="www.google.com"
site["taobao"]="www.taobao.com"

#输出关联数组中键为google的值
echo ${site["google"]} #www.google.com

:<<eof
    获取数组中的所有元素[关联数组获取所有元素的方式类似于普通数组]
eof
echo "数组的元素为: ${site[@]}"
echo "数组的元素为: ${site[*]}"

echo "数组的键为: ${!site[@]}"
echo "数组的键为: ${!site[*]}"

echo "数组的长度为 ${#site[@]}"
echo "数组的长度为 ${#site[*]}"


:<<eof
    分析 ${arr[*]} 与 ${arr[@]} 的区别
eof
function showArr() {
    arr=$1
    for a in ${arr[*]}
    do
        echo ${a}
    done
    return 0
}
regions=('aa pp' 'bb' 'cc')
showArr $regions
:<<eof
    结果:
        aa
    $regions实际上只引用了数组的第一个元素(这点类似于C语言的指针)
eof