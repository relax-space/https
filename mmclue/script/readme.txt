crontab -e

0 2 * * * /home/xxm/dockerpath/https/mmclue/script/auto_exe.sh


查看任务
crontab -l

```
git config core.filemode true
git update-index --chmod=+x mmclue/script/auto_exe.sh
git update-index --chmod=+x mmclue/script/mm_nginx_update.sh
验证权限生效
git ls-files --stage mmclue/script/mm_nginx_update.sh
```

