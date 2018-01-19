# 基于centos6基础镜像
FROM centos:6
MAINTAINER chenyufeng "yufengcode@gmail.com"  
   
WORKDIR /home

# 使用yum的方式安装mysql；
RUN yum install -y mysql-server mysql  

# 安装完成以后，执行以下命令。配置用户名密码相关信息；
RUN /etc/init.d/mysqld start &&\  
    mysql -e "grant all privileges on *.* to 'root'@'%' identified by '123456' WITH GRANT OPTION ;" && \  
    mysql -e "grant all privileges on *.* to 'root'@'localhost' identified by '123456' WITH GRANT OPTION ;" && \ 
    mysql -u root -p123456 -e "show databases;" && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    yum clean all

# 设置环境变量
ENV TZ Asia/Shanghai
   
# 镜像暴露3306端口；
EXPOSE 3306
   
# 容器启动后执行以下命令，启动mysql；
CMD ["/usr/bin/mysqld_safe"]
