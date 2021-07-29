#!/usr/bin/python3

import requests
import os
from lxml import etree

dom = None  # 页面text
html = etree.HTML("", etree.HTMLParser())  # 页面结构树


# 清屏
def clear():
    print('\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n')
    os.system('cls')


# 转换 int 捕获错误返回 -1
def be_int(num):
    try:
        return int(num)
    except:
        return -1


# 加载首页
def load_page():
    print('开始读取...')
    global dom, html
    url = "https://www.zxcs.info/"
    headers = {
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.164 Safari/537.36"
    }
    h = requests.get(url=url, headers=headers)
    h.encoding = 'utf-8'
    if h.status_code == 200:
        dom = h.text
        html = etree.HTML(dom, etree.HTMLParser())
    else:
        print('请求出错,错误代码:{}'.format(str(html.status_code)))
        return False
    print('读取完成!')


# 加载的菜单
def loading_menu():
    while True:
        clear()
        print("####################")
        print("## 小说下载器  v1.0 ##")
        print("####################")
        print("--------------------")
        print("[ q ] 退出")
        print("[ s ] 搜索")
        print("[ 0 ] 获取线上页面")
        print("--------------------")
        command = input("请输入: ")
        clear()
        if command == 'cls':
            print("")
        elif command == 'q':
            print("退出")
            return False
        elif command == 's':
            search_book()
        elif command == '0':
            load_page()
            return True
        else:
            input("请输入正确的指令")


# 搜索
def search_book():
    while True:
        clear()
        print("--------------------")
        print("[ b ] 返回")
        print(" 搜索请输入书名 ")
        print("--------------------")
        command = input("请输入书名: ").strip()
        if command == "":
            input("书名不能为空!")
        elif command == 'b':
            return False
        else:
            search_menu(command)


# 主菜单
def main_menu():
    global html
    title_list = html.xpath('.//div[@class="wrap"]//div[@class="title"]/strong/text()')
    while True:
        clear()
        print("--------------------")
        print("[ q ] 退出")
        for i in range(len(title_list) - 1):
            print("[ {} ] {}".format(i, title_list[i]))
        print("--------------------")
        command = input("请输入: ")
        clear()
        if command == 'cls':
            print("")
        elif command == 'q':
            print("再见~")
            return
        elif 0 <= be_int(command) < len(title_list) - 1:
            # print(title_list[be_int(command)-1])
            category_menu(be_int(command))
        else:
            input("请输入正确的指令")


# 分列表菜单 (首页列表)
def category_menu(index):
    global html
    item_box = html.xpath('.//div[@class="wrap"]/div[contains(@class,"mlist")]')[index]
    item_list = item_box.xpath('.//div[@class="box"]/ul/li/a//text()')
    item_url_list = item_box.xpath('.//div[@class="box"]/ul/li/a/@href')
    more_url_list = item_box.xpath('.//div[@class="title"]/a/@href')
    while True:
        clear()
        print("--------------------")
        print("[ b ] 返回")
        # 如果有 more
        if len(more_url_list) > 0:
            print("[ m ] 更多")
        for i in range(len(item_list)):
            print("[ {} ] {}".format(i, item_list[i]))
        print("--------------------")
        command = input("请输入: ")
        clear()
        if command == 'cls':
            print("")
        elif command == 'b':
            return
        elif command == 'm' and len(more_url_list) > 0:
            if more_url_list[0] == "map.html":
                new_menu(more_url_list[0])
            else:
                more_menu(more_url_list[0])
        elif 0 <= be_int(command) < len(item_list):
            detail_menu(item_url_list[be_int(command)])
        else:
            input("请输入正确的指令")


# 最新 页
def new_menu(url):
    print('开始读取...')
    u = "https://www.zxcs.info/map.html"
    headers = {
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.164 Safari/537.36"
    }
    h = requests.get(url=u, headers=headers)
    h.encoding = 'utf-8'
    if h.status_code == 200:
        new_dom = h.text
    else:
        print('请求出错,错误代码:{}'.format(str(html.status_code)))
        return
    # file = open('003new.html', 'r', encoding="UTF-8")
    # new_dom = file.read()
    # file.close()

    new_html = etree.HTML(new_dom, etree.HTMLParser())
    content_list = new_html.xpath('.//div[@class="wrap"]/div[@id="content"]/ul/li')
    print('读取完成!')
    while True:
        clear()
        print("--------------------")
        print("[ b ] 返回")
        print("-------最新列表-------")
        for i in range(len(content_list)):
            print("[ {} ] {}".format(i, content_list[i].xpath('.//a/text()')[0]))
        print("--------------------")
        command = input("请输入: ")
        clear()
        if command == 'cls':
            print("")
        elif command == 'b':
            return
        elif 0 <= be_int(command) < len(content_list):
            detail_menu(content_list[be_int(command)].xpath('.//a/@href')[0])
        else:
            input("请输入正确的指令")


# 更多 页
def more_menu(url):
    print('开始读取...')
    page = 1  # 默认页码是 1

    def more_page(url, page):
        headers = {
            "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.164 Safari/537.36"
        }
        u = url + "/page/{}".format(str(page))
        h = requests.get(url=u, headers=headers)
        h.encoding = 'utf-8'
        if h.status_code == 200:
            return h.text
        else:
            print('请求出错,错误代码:{}'.format(str(html.status_code)))
            return False

    more_dom = more_page(url, page)
    if more_dom:
        more_html = etree.HTML(more_dom, etree.HTMLParser())
        content_list = more_html.xpath('.//dl[@id="plist"]')
    else:
        return False
    print('读取完成!')
    while True:
        clear()
        print("--------------------")
        print("[ b ] 返回")
        for i in range(len(content_list)):
            print("[ {} ] {}".format(i, content_list[i].xpath('.//dt/a/text()')[0]))
        if len(content_list) == 0:
            print("没有更多内容了")
        print("--------------------")
        print("[ p ] p+页码进行翻页 例: p1")
        print("-------page {}-------".format(str(page)))
        command = input("请输入: ")
        clear()
        if command == 'cls':
            print("")
        elif command == 'b':
            return
        elif 0 <= be_int(command) < len(content_list):
            detail_menu(content_list[be_int(command)].xpath('.//dt/a/@href')[0])
        elif command.startswith('p') and 0 < be_int(command[1:]):
            print("正在加载第 {} 页...".format(command[1:]))
            more_dom = more_page(url, be_int(command[1:]))
            if more_dom:
                page = be_int(command[1:])
                more_html = etree.HTML(more_dom, etree.HTMLParser())
                content_list = more_html.xpath('.//dl[@id="plist"]')
            else:
                return False
        else:
            input("请输入正确的指令")


# 搜索 页
def search_menu(keyword):
    print('开始读取...')
    page = 1  # 默认页码是 1

    def search_page(keyword, page):
        headers = {
            "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.164 Safari/537.36"
        }
        params = {
            "keyword": keyword,
            "page": page
        }
        url = "https://www.zxcs.info/index.php"
        h = requests.get(url=url, headers=headers, params=params)
        h.encoding = 'utf-8'
        if h.status_code == 200:
            return h.text
        else:
            print('请求出错,错误代码:{}'.format(str(html.status_code)))
            return False

    search_dom = search_page(keyword, page)
    if search_dom:
        search_html = etree.HTML(search_dom, etree.HTMLParser())
        content_list = search_html.xpath('.//dl[@id="plist"]')
    else:
        return False
    print('读取完成!')
    while True:
        clear()
        print("--------------------")
        print("[ b ] 返回")
        for i in range(len(content_list)):
            print("[ {} ] {}".format(i, content_list[i].xpath('.//dt/a/text()')[0]))
        if len(content_list) == 0:
            print("没有更多内容了")
        print("--------------------")
        print("[ p ] p+页码进行翻页 例: p1")
        print("-------page {}-------".format(str(page)))
        command = input("请输入: ")
        clear()
        if command == 'cls':
            print("")
        elif command == 'b':
            return
        elif 0 <= be_int(command) < len(content_list):
            detail_menu(content_list[be_int(command)].xpath('.//dt/a/@href')[0])
        elif command.startswith('p') and 0 < be_int(command[1:]):
            print("正在加载第 {} 页...".format(command[1:]))
            more_dom = search_page(keyword, be_int(command[1:]))
            if more_dom:
                page = be_int(command[1:])
                more_html = etree.HTML(more_dom, etree.HTMLParser())
                content_list = more_html.xpath('.//dl[@id="plist"]')
            else:
                return False
        else:
            input("请输入正确的指令")


# 详情
def detail_menu(url):
    print("正在加载详情...")
    book_url = url
    if book_url.startswith('/post'):
        book_url = "https://www.zxcs.info" + url
    headers = {
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.164 Safari/537.36"
    }
    h = requests.get(url=book_url, headers=headers)
    h.encoding = 'utf-8'
    if h.status_code == 200:
        detail_dom = h.text
    else:
        print('请求出错,错误代码:{}'.format(str(html.status_code)))
        return False
    detail_html = etree.HTML(detail_dom, etree.HTMLParser())
    detail = detail_html.xpath('.//div[@id="content"]/div[2]/p[2]/text()')
    while True:
        clear()
        print("--------------------")
        print("[ b ] 返回")
        print("[ d ] 下载")
        # if [0].strip() == ""
        print("[ 标题 ] {}".format("".join(detail_html.xpath('.//h1/text()')).strip()))
        print("[ 大小 ] {}".format(detail[0][9:]))
        print("[ 详情 ]")
        for i in range(len(detail)):
            if i > 1 and detail[i].strip() != "":
                print(detail[i].strip())
        print("--------------------")
        command = input("请输入: ")
        clear()
        if command == 'cls':
            print("")
        elif command == 'b':
            return
        elif command == 'd':
            down_url = detail_html.xpath('.//div[@class="pagefujian"]/div[@class="down_2"]/a[@title="点击下载"]/@href')[0]
            download_menu(down_url)
        else:
            input("请输入正确的指令")


# 下载页面
def download_menu(url):
    print("正在加载下载页...")
    down_url = url
    if down_url.startswith('/download'):
        down_url = "https://www.zxcs.info" + url
    headers = {
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.164 Safari/537.36"
    }
    h = requests.get(url=down_url, headers=headers)
    h.encoding = 'utf-8'
    if h.status_code == 200:
        down_dom = h.text
    else:
        print('请求出错,错误代码:{}'.format(str(html.status_code)))
        return False
    down_html = etree.HTML(down_dom, etree.HTMLParser())
    down_list = down_html.xpath('.//div[@class="panel"]/div[@class="panel-body"]/span[@class="downfile"]')
    while True:
        clear()
        print("--------------------")
        print("[ b ] 返回")
        for i in range(len(down_list)):
            print("[ {} ] {}".format(i, down_list[i].xpath('.//a/text()')))
        print("--------------------")
        command = input("请输入: ")
        clear()
        if command == 'cls':
            print("")
        elif command == 'b':
            return
        elif 0 <= be_int(command) < len(down_list):
            # webbrowser.open_new_tab(down_list[be_int(command)].xpath('.//a/@href')[0])
            os.system('start {}'.format(down_list[be_int(command)].xpath('.//a/@href')[0]))
            return
        else:
            input("请输入正确的指令")


# 入口
if __name__ == '__main__':
    if loading_menu():
        main_menu()
