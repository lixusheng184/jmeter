recommended.yaml 为https安装
alternative.yaml 为http安装，http安装需要在请求头中注入Authorization: Bearer <token>，详见官网
https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/README.md#authorization-header
此次安装使用https方式，token可在本项目的jenkins输出中查看