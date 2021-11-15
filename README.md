# iOS 基于 Swift 的项目脚手架

项目由两部分组成：CodeSnippets 和 Project Template

前者用于在 Xcode 开发时的快速输入，后者用于创建 iOS Swift 项目。

## Project Template

通过 Project Template 的方式实现带代码复用。主要包括：

1. 通用工具代码
2. 常用三方库的集成及初始化


使用方法如下：

1. 将 **SwiftProjectScaffold.xctemplate、SwiftProjectScaffold、Podfile** 复制到 `~/Library/Developer/Xcode/Templates`
2. 打开 Xcode 新建 Project 选择 “SwiftProjectScaffold” 模板（京剧熊猫图标）
3. 在弹出的对话框中输入项目名称（语言一定要选择 Swift）
4. 参照新建项目中的文档完成初始化即可

项目创建完成后有两部分需要初始化：
1. 三方库工具初始化（如：R.swift）
2. 三方库参数初始化。初始化参数在 **Support/SDKConfig.plist** 中