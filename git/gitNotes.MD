# git命令学习笔记

### 查看提交记录

```shell
    $ git show
    #or
    $ git log -n1 -p
```

### 更改commit message
如果还没有push到远端，可以使用amend来进行修改本次commit
```shell
    $ git commit --amend only
    # 也可以用一条命令一次完成
    $ git commit --amend --only -m 'xxxxxx'
```
如果已经push了这次提交，可以修改这次提交（commit）然后强推（force push） 但不推荐。

### 更改commit的邮箱和用户名
单词commit的修改可以使用
```shell
    $ git commit --amend -author 'New AuthorName <authoremail@mydomain.com>'
```

### 从一个commit里移除一个文件
将文件从git中删除
```shell
    $ git rm --cached TheRemoveFilePath
    # 修改此次提交
    $ git commit --amend
```
不将文件从git中删除,只不提交至此次commit
```shell
    $ git checkout HEAD^ TheRemoveFilePath
    $ git add -A
    $ git commit --amend
```