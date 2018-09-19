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

#修改组件模板变量的三个文件
newContent='所需脚本| {% if: {{name}} %}{% if: {{name}} === "mip2-extensions" %}[https://c.mipcdn.com/static/v2/{{ compName }}/{{ compName }}.js](https://c.mipcdn.com/static/v2/{{ compName }}/{{ compName }}.js){% else %}[https://c.mipcdn.com/extensions/platform/v2/{{name}}/{{ compName }}/{{ compName }}.js](https://c.mipcdn.com/extensions/platform/v2/{{name}}/{{ compName }}/{{ compName }}.js){% /if %}{% /if %}'


#1.mip-example.html
sed -i '' 's/mip-example/\{\{ compName \}\}/g' mip-component/components/mip-example/example/mip-example.html
#2.README.md
sed -i '' 's/mip-example/\{\{ compName \}\}/' mip-component/components/mip-example/README.md
sed -i '' "/所需脚本/ c\ 
${newContent}
" mip-component/components/mip-example/README.md
#3.package.json
sed -i '' 's/\"name\": \"name\"/\"name\": \"\{\{ name \}\}\"/g' package.json
sed -i '' 's/\"description\": \"description\"/\"description\": \"\{\{ description \}\}\"/g' package.json
sed -i '' 's/\"author\": \"yourname\"/\"author\": \"\{\{ author \}\}\"/g' package.json


zip -r ../mip-plugin-site-template.zip . .[^.]*
rm -rf ./* 
mv ../mip-plugin-site-template.zip ./mip-plugin-site-template.zip

# 清理工作目录
rm -rf ../$compile_path

baidu-bos ./mip-plugin-site-template.zip bos://assets/mip/templates

rm -rf $output

echo "end mip-plugin-site-template package";