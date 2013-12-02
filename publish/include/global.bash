#! /bin/bash

#web根目录
dest_path=/www/web

#操作的用户账户
profile=$1

if [ -z $profile ];then
	echo "usage:"$0" [profile] [project]"
	exit 1
fi

#用户账户home目录
profile_home=/home/${profile}

#上线的项目名称
project=$2

if [ -z $project ];then
        echo "usage:"$0" [profile] [project]"
        exit 1
fi

type=${3-file}

#上线项目的文件存放目录
source_path=/home/$profile/project
test ! -d $source_path && mkdir $source_path

#年
year=$(date +"%Y")

#月
month=$(date +"%m")

#日
day=$(date +"%d")

#年月日
today=$(date +"%Y%m%d")

#小时
hour=$(date +"%H")

test ! -d $dest_path && mkdir -p $dest_path
