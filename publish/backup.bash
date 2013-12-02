. /public_repertory/sh/publish/include/global.bash

#当前运行项目的备份目录
backup_path=/www/backup/${project}/${year}/${month}/${today}/${hour}

#备份运行项目的所有文件至备份目录
test ! -d $backup_path && mkdir -p $backup_path

cp -r ${dest_path}/${project}.ylmf.com $backup_path

if [ $? == 0 ];then
	echo -e "备份成功!"
else
	echo -e "备份失败!"
	echo -e "源目录:"${dest_path}/${project}/.ylmf.com
	echo -e "目标目录:"${backup_path}
fi
