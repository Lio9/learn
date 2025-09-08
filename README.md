# 这是一个笔记
python笔记出自于[菜鸟教程](https://www.runoob.com/python3/)

## 同时push到GitHub和Gitee

```bash
git remote add github https://gitee.com/Lio9/learn.git
git remote add gitee https://gitee.com/Lio9/learn.git
```
查看仓库
```bash
git remote -v
```

git的config
```bash
[core]
	repositoryformatversion = 0
	filemode = false
	bare = false
	logallrefupdates = true
	symlinks = false
	ignorecase = true
[remote "origin"]
	url = https://github.com/Lio9/learn.git
	url = https://gitee.com/Lio9/learn.git
	fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
	remote = origin
	merge = refs/heads/master
```