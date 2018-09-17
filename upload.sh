#!/bin/bash
if [ ! $1 ]; then
	#statements
	echo "please enter the release version number."
	exit 1
fi
echo "start mip-plugin-site-template package";

script_path=$(cd `dirname $0` && pwd)
cd $script_path

# mip-plugin-site-template 仓库地址
DEV_MIP_SITE_URL=https://github.com/mipengine/mip-plugin-site-template.git
# 工作目录
compile_path=../mip-plugin-site-template_deploy
# 输出目录
output=../mip-plugin-site-template_output

# 创建 compile_path
rm -rf $compile_path && mkdir -p $compile_path
# 创建 output
rm -rf $output && mkdir -p $output

cd $compile_path

if [ ! -d "site" ]; then
    # env GIT_SSL_NO_VERIFY=true /home/work/.jumbo/bin/git clone $DEV_MIP_SITE_URL site
    git clone $DEV_MIP_SITE_URL site
fi

# 配置为内网镜像
npm config set registry http://registry.npm.baidu.com

# 编译 site
cd site

project_version=$1

git pull origin master

{
    git checkout $project_version
} || {
    exit 1
}

cp -rf . ../$output/

cd ../$output/
rm 'upload.sh'
rm -rf '.git'
zip -r ../mip-plugin-site-template.zip . .[^.]*
rm -rf ./* 
mv ../mip-plugin-site-template.zip ./mip-plugin-site-template.zip

# 清理工作目录
rm -rf ../$compile_path

baidu-bos ./mip-plugin-site-template.zip bos://assets/mip/templates

rm -rf $output

echo "end mip-plugin-site-template package";