#!/usr/bin/python3

import mysql.connector
conn = mysql.connector.connect(user='root', password='shi961124', database='myDb')
cursor = conn.cursor()
cursor.execute('select * from user where id = %s', ('1',))
values = cursor.fetchall()
print(values)
cursor.close()
conn.close()
