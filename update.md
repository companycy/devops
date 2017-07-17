# From 8.1 To 8.2
## 参考gitlab.rb.template
### LFS(large file storage)
https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/files/gitlab-config-template/gitlab.rb.template
### gitlab workhorse: handles "large" HTTP requests such as file downloads, file uploads, Git push/pull and Git archive downloads.
https://gitlab.com/gitlab-org/gitlab-workhorse

# From 8.2 to 8.3
## Upgrade redis
https://gitlab.com/gitlab-org/gitlab-ce/blob/8-3-stable/doc/install/installation.md#6-redis
### 官方文档通过源码编译来升级有问题, 会出现redis版本和配置文件不匹配的问题, 所以从 ppa 直接安装最新的3.3, 仍然会有些配置项不匹配, 注释掉, 目前没有影响
#### Bad directive or wrong number of arguments

