### 一键部署网站反向代理，在无翻墙工具的情况下便捷地获取被封锁的新闻及历史真相

#### 搭建VPS启动脚本
```
#!/bin/bash

yum install -y git
cd /root
git clone https://github.com/gfw-breaker/open-proxy.git

cd open-proxy
bash install.sh
bash scripts/install-bbr.sh

```

##### 鉴于GFW封锁不断升级, 强烈推荐使用 [一键翻墙软件](https://github.com/gfw-breaker/nogfw/blob/master/README.md) 、[禁闻聚合](https://github.com/gfw-breaker/banned-news3/blob/master/README.md) )

##### 安装部署, 请参考 [open-proxy 搭建教程](https://github.com/gfw-breaker/open-proxy/wiki#open-proxy-%E6%90%AD%E5%BB%BA%E6%95%99%E7%A8%8B)

