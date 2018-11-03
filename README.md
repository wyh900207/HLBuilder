# HLBuilder
iOS打包工具

#### 配置相关

`Header.h`文件中配置:

- `项目路径`
- `IPA输出路径`
- `workspace名称`
- `项目名称`(实际指代的是`scheme`名称, 同`target`名称`)

#### scheme查看命令

```shell
$ xcodebuild -list
```

#### 打包

运行本工程项目, `.ipa`文件会自动输出到配置好的路径下

#### 可能遇到的相关问题

1. xcrun: error: unable to find utility "PackageApplication", not a developer tool or in PATH
[解决方案, 由于我的懒惰, 在此, 感谢该文章的作者](https://www.jianshu.com/p/88bb51cba34d)

2. 找不到编译生成的`.app`文件, 导致`xcrun`命令执行失败

    删除`/Users/$(username)/Library/Developer/Xcode/DerivedData/`路径下的相关编译文件, 重新运行即可

