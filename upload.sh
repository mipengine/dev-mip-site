#!/bin/bash
if [ ! $1 ]; then
	#statements
	echo "please enter the release version number."
	exit 1
fi
echo "start mip-plugin-site-template package";

script_path=$(cd `dirname $0` && pwd)
cd $script_path

# 输出目录
output=../dev_mip_site_output

# 创建 output
rm -rf $output && mkdir -p $output

# release url
URL="https://github.com/mipengine/mip-plugin-site-template/archive/"$1".zip"

cd $output
# -I show document info only -m max-time 
res=$(curl -I -m 10 -o /dev/null -s -w '%{http_code}\n' $URL)

if [[ $res == 404 ]]; then
	#statements
	echo "404 not found! please enter the right version number."
	exit 1
fi

curl $URL -o mip-plugin-site-template.zip

baidu-bos ./mip-plugin-site-template.zip bos://assets/mip/templates