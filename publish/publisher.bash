. /public_repertory/sh/publish/include/global.bash

#不需要覆盖的文件列表(空格隔开)
ignore_files="${source_path}/${project}/conf/application.ini ${source_path}/${project}/index.php"

if [ $type == "tar" ];then 
	#上线项目的tar包存放目录
	tarball_path=/home/${profile}/tarball
	test ! -d $tarball_path  && mkdir $tarball_path

	test ! -d ${source_path} && mkdir -p ${source_path}

	tar -zxvf ${tarball_path}/${project}_${year}-${month}-${day}.tar.gz -C ${source_path}
fi

#解包成功后调用备份脚本对当前web目录进行备份
test $? == 0 && /public_repertory/sh/publish/backup.bash $profile $project

#则执行下面逻辑
if [ $? == 0 ];then
	#删除配置文件放置覆盖服务器的配置
	for f in $ignore_files
	do
		test -f $f && rm -rf $f
	done

	cp -r ${source_path}/${project}/* $dest_path/${project}.xxx.com
	
	if [ $? == 0 ];then
		echo -e "项目发布成功!" 
		find ${source_path}/${project} -type f | xargs rm -f
		chown -R www-data:www-data ${dest_path}/${project}
		chmod -R 0755 ${dest_path}/${project}
	else
		echo -e "项目发布失败!"
	fi
fi
