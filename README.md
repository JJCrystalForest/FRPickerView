# FRPickerView
轻量级封装 UIPickerView，支持单列选择

效果图:

![效果图](https://github.com/JJCrystalForest/FRPickerView/blob/master/%E6%95%88%E6%9E%9C%E5%9B%BE.gif?raw=true)

使用方法:
```swift
let picker = FRPickView(UIScreen.main.bounds, titles, selectIndex) { print("\($0)") }
view.addSubview
```

直接将 FRPickerView 拖到项目中即可使用
