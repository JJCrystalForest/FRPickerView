# FRPickerView
轻量级封装 UIPickerView，支持单列选择

效果图:

![效果图](https://github.com/JJCrystalForest/FRPickerView/blob/master/%E6%95%88%E6%9E%9C%E5%9B%BE.gif?raw=true)

使用方法:
```swift
let picker = FRPickView(UIScreen.main.bounds, titles, selectIndex) { print("\($0)") }
view.addSubview
```

如果不需要跳转到指定 index，`selectIndex` 可以不填，默认为 0。

提供了两个构造方法：

第一个：

```swift
// 需要自己通过 didFinish 闭包属性去拿到回调的模型
init(_ frame : CGRect, _ titles : [String])
```

第二个，便利构造方法：

```swift
// selectIndex 可以不填，不填不会跳转到指定 index，直接通过参数 didFinish 拿到回调参数
convenience init (_ frame : CGRect, _ titles : [String], _ selectIndex : Int = 0, _ didFinish : ((FRPickerModel) -> ())?)
```



直接将 FRPickerView 拖到项目中即可使用。