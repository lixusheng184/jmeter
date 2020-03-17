podpreset功能目前还是alpha版本,需要修改apiserver配置激活
apiserver启动参数加入：
    - --runtime-config=settings.k8s.io/v1alpha1=true
    
podpreset可以不初始化，template中有写挂载configmap