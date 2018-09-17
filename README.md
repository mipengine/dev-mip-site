执行命令 `mip2 site init` 时初始化的项目模板

主项目链接：[https://github.com/mipengine/mip-cli-plugin-site](https://github.com/mipengine/mip-cli-plugin-site)

## 发布流程

将开发分支的内容合到release分支，在release分支，打tag，执行发布操作之后，再切换回master分支执行下面的发布命令。

## 发布命令

`npm run publish 1.0.0` 其中 1.0.0 是发布版本的版本号，执行这个命令即可将模板上传到 bos，bos 是默认设置好的。
