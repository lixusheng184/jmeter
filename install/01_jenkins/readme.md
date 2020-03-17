手动安装
master上执行：  
1）docker login registry.innodealing.com  
Username: fengming  
Password:   
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded

2）chown -R 1000 /var/lib/jenkins

3）将jenjins.yml放入/etc/kubernetes/manifests