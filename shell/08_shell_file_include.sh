:<<eof
shell文件包含
    shell可以通过文件包含的方式,很方便的封装一些公用的代码作为一个独立文件

#shell文件包含的语法格式如下:
. filename   # 注意点号(.)和文件名中间有一空格
或
source filename

eof

#实例
#test1.sh文件里代码如下
:<<eof
    url="Lio9@qq.com"
eof

#test2文件代码如下
:<<eof
    #使用 . 号来引用test1.sh 文件
. ./test1.sh

# 或者使用以下包含文件代码
# source ./test1.sh

echo "我的邮箱地址为：$url"
eof

#接下来，我们为 test2.sh 添加可执行权限并执行：
:<<eof
chmod +x test2.sh
./test2.sh
我的邮箱地址为：Lio9@qq.com
eof