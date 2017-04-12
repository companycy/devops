
# jenkins + gitlab

记录下今天的升级过程, 在gitlab 8.0上enable Gitlab CI
1. 先装gitlab runner, 发现gitlab版本太旧, 装旧版本的gitlab runner 1.11.2.
2. register runnter, 用shell, 即用local shell, https的证书有问题, 有2个办法,
   - 添加  tls-skip-verify = true  到 /etc/gitlab-runner/config.toml
   - 在/etc/hosts里加条记录
3. 增加.gitlab-ci.yml, 把build相关的shell命令写上
4. 这样就完成基本的部分

https://docs.gitlab.com/ce/ci/quick_start/

由于gitlab ce和jenkins的集成比较麻烦.. 最开始想是不是用ssh的办法, 登录到jenkins所在的VM上去build/test.
后来注意到Jenkins应该也有API提供, 用于触发build, 果然有.
所以问题就是在gitlab上去触发Jenkins的build, 并检查build状态, 最后检查build成功与否.
感谢Stackoverflow: http://serverfault.com/questions/309848/how-to-check-the-build-status-of-a-jenkins-build-from-the-command-line

```bash
JOB_URL=http://x.x.x.x:8080/view/devops/job/pitrix-scipts
JOB_STATUS_URL=${JOB_URL}/lastBuild/api/json

GREP_RETURN_CODE=0

# Start the build
curl $JOB_URL/build?delay=0sec

# Poll every thirty seconds until the build is finished
while [ $GREP_RETURN_CODE -eq 0 ]
do
    sleep 30
    # Grep will return 0 while the build is running:
    curl --silent $JOB_STATUS_URL | grep result\":null > /dev/null
    GREP_RETURN_CODE=$?
done

curl --silent $JOB_STATUS_URL | grep result\":\"SUCCESS > /dev/null
GREP_RETURN_CODE=$?
if [ $? -ne 0 ]; then
    echo Build failed
else
    echo Build succeeded
fi
exit $GREP_RETURN_CODE
```
这样就可以了. 也不用考虑升级gitlab的事, 否则需要gitlab >= 8.1

