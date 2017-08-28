# getterMake-Xcode
功能：批量生成属性的懒加载 getter，应用场景 ：手写ui代码可以批量生成

#### 更新:
添加8.3 8.2的支持
屏蔽注释和assign属性
修改输出样式

#### 安装方法：
1: 如果你的Xcode没有resigin 请先resign你的Xcode (Xcode8.0+)<br>

resgin方法:
方法1.https://github.com/fpg1503/MakeXcodeGr8Again
方法2.https://github.com/XVimProject/XVim/blob/master/INSTALL_Xcode8.md

2: 下载-Xcode打开-Command+B-重启Xcode  （提示框 点击load bundle）<br>
3: 如果重启Xcode没有提示load bundle 请尝试在终端中运行如下代码
```
find ~/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins -name Info.plist -maxdepth 3 | xargs -I{} defaults write {} DVTPlugInCompatibilityUUIDs -array-add `defaults read /Applications/Xcode.app/Contents/Info.plist DVTPlugInCompatibilityUUID`
```

#### 使用方法：
点击xcode 菜单栏  找到Window-GenGetter-input property window

![Screenshot](https://raw.githubusercontent.com/hackxhj/getterMake-Xcode/master/cap/menu.png)
 
 
#### 效果图

![Screenshot](https://github.com/ame017/getterMake-Xcode/blob/master/cap/1111.gif?raw=true)

Thanks：[ESJsonFormat](https://github.com/EnjoySR/ESJsonFormat-Xcode)

ps. 以前没写过插件  所以很多东西都是从ESJsonFormat直接拿来的 感谢作者 ESJsonFormat很好用 推荐；
