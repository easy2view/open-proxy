### 一键部署网站反向代理，在无翻墙工具的情况下便捷地获取被封锁的新闻及历史真相

---

##### 演示网站：&nbsp; [大纪元时报](http://78.141.225.112:10080/gb/) &nbsp; | &nbsp; [新唐人电视台](http://78.141.225.112:8808/gb/) &nbsp; | &nbsp; [自由亚洲电台](http://78.141.225.112:9800/mandarin/) &nbsp; | &nbsp; [追查国际](http://78.141.225.112:10010/) &nbsp; | &nbsp; [翻墙必看](http://78.141.225.112:10000/videos/)

##### 鉴于GFW封锁不断升级, 强烈推荐使用 [一键翻墙软件](https://github.com/gfw-breaker/nogfw/blob/master/README.md) 、[禁闻聚合](https://github.com/gfw-breaker/banned-news3/blob/master/README.md) 

##### 安装部署启动脚本
```
#!/bin/bash

yum install -y git
cd /root
git clone https://github.com/gfw-breaker/open-proxy.git

cd open-proxy
bash install.sh
bash scripts/install-bbr.sh

```

