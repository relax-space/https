crontab -e

0 2 * * * /home/xxm/dockerpath/https/mmclue/script/auto_exe.sh


查看任务
crontab -l

```
git config core.filemode true
git add --chmod=+x mmclue/script/auto_exe.sh mmclue/script/mm_nginx_update.sh
git commit -m "更新文件执行权限"

git config core.filemode false


验证权限生效
git ls-files --stage mmclue/script/mm_nginx_update.sh
```

