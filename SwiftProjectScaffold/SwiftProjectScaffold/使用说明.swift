//
//  使用说明.swift
//  SwiftProjectScaffold
//
//  Created by Jori on 2021/11/15.
//

import Foundation

1. 删除工程中红色标记的文件夹（Group）。注意：仅删除引用
2. 修改 Podfile 中的 target 为正确的名称
3. 修改工程的最低适配版本不低于 iOS 12
4. 安装 cocoapods 依赖
5. 如果报错 “Multiple process *** Info.plist” 请尝试删除如下信息“Build Phase -> Copy Bundle Resources -> Info.plist”
6. 调整 “Build Phase”顺序。"[CP] Check Pods Manifest.lock" -> "R.swift" -> "Compile Sources" -> "SwiftLint"
7. 删除这段说明
