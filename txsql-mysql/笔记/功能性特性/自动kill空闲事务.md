# 自动kill空闲事务

Kill超过一定市场的空闲事务，即使释放资源。

## 适用场景

对于处于开启事务状态的链接（显示使用 begin、start transaction 或者隐式开启事务），如果超过时间内没有下一条语句执行，kill连接。

## 使用说明

通过参数 cdb_kill_idle_trans_timeout控制是否开启该功能，0为不用，非0为启用，与 session 的 wait_timeout 值相比取较小值。

<table><tbody><tr><td>参数名</td><td>动态</td><td>类型</td><td>默认</td><td>参数值范围</td><td>说明</td></tr><tr><td>cdb_kill_idle_trans_timeout</td><td>YES</td><td>ulong</td><td>0</td><td>[0,31536000]</td><td>0代表关闭该功能，否则代表会kill掉cdb_kill_idle_trans_timeout秒的空闲事务</td></tr></tbody></table>
