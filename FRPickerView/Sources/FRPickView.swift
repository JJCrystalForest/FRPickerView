//
//  FRPickView.swift
//  FRKit
//
//  Created by free on 2019/4/15.
//  Copyright © 2019 free. All rights reserved.
//

/**
 单列 pickerView
 传入 titles，[String] 类型
 通过 didFinish 回调获取选中的数据模型
 
 example:
 override func viewDidLoad() {
    var titles = [String]()
    for index in 0..<100 { titles.append("test_" + "\(index)") }
    let picker = FRPickView(UIScreen.main.bounds, titles) {print("\($0)")} }
    view.addSubview(picker)
 }

 */

import UIKit

/// PickerView 对应模型
struct FRPickerModel {
    /// 下标
    var index : Int
    /// 内容
    var text : String
}

class FRPickView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    /// 传入的数据模型
    var pickerTitles : [String]
    /// 选中后的回调
    var didFinish : ((_ pickerModel : FRPickerModel) -> ())?
    
    /// 背景 view
    private let backView = UIView()
    /// pickerView
    private let pickerView = UIPickerView()
    /// 选中的模型
    private var selectedModel : FRPickerModel? = {
        let model = FRPickerModel(index: 0, text: "")
        return model
    }()
    /// 工具条
    private let toolView = UIView()
    /// 工具条高度
    private let toolViewHieght : CGFloat = 44
    
    /// 构造方法，自行使用 didFinish 属性拿到回调数据
    ///
    /// - Parameters:
    ///   - frame: frame
    ///   - titles: titles
    init(_ frame : CGRect, _ titles : [String]) {
        self.pickerTitles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    /// 便利构造方法，使用这个方法进行初始化
    ///
    /// - Parameters:
    ///   - frame: frame
    ///   - titles: titles
    ///   - selectIndex: 当前下标
    ///   - didFinish: 回调
    convenience init (_ frame : CGRect, _ titles : [String], _ selectIndex : Int = 0, _ didFinish : ((FRPickerModel) -> ())?) {
        self.init(frame, titles)
        self.didFinish = didFinish
        if selectIndex > 0 && selectIndex < pickerTitles.count { pickerView.selectRow(selectIndex, inComponent: 0, animated: true) }
    }
    
    /// 不支持 xib 创建
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        backgroundColor = .clear
        
        // 背景 view
        backView.frame = UIScreen.main.bounds
        backView.backgroundColor = UIColor.black.withAlphaComponent(0.7)  // 防止子控件透明
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(displayBackView))
        backView.addGestureRecognizer(tap)
        addSubview(backView)
        
        // pickerView
        pickerView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.frame = CGRect(x: 0, y: self.bounds.size.height - pickerView.bounds.size.height, width: self.bounds.size.width, height: pickerView.bounds.size.height)
        backView.addSubview(pickerView)
        
        // 工具条
        toolView.frame = CGRect(x: pickerView.bounds.origin.x, y: self.bounds.size.height - pickerView.bounds.size.height - toolViewHieght, width: pickerView.bounds.size.width, height: toolViewHieght)
        toolView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        backView.addSubview(toolView)
        
        // 取消按钮
        let cancelBtn = UIButton(type: .system)
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.frame = CGRect(x: toolView.bounds.origin.x, y: 0, width: 60, height: toolViewHieght)
        cancelBtn.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        cancelBtn.backgroundColor = toolView.backgroundColor
        toolView.addSubview(cancelBtn)
        
        // 确认按钮
        let confirmBtn = UIButton(type: .system)
        confirmBtn.setTitle("确定", for: .normal)
        confirmBtn.frame = CGRect(x: toolView.bounds.size.width - 60, y: 0, width: 60, height: toolView.bounds.size.height)
        confirmBtn.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        confirmBtn.backgroundColor = toolView.backgroundColor
        toolView.addSubview(confirmBtn)
        
        // 分割线
        let line = UIView(frame: CGRect(x: toolView.bounds.origin.x, y: toolViewHieght - 1, width: toolView.bounds.size.width, height: 1))
        line.backgroundColor = .groupTableViewBackground
        toolView.addSubview(line)
    }
    
    @objc private func displayBackView() {
        if !backView.isHidden {
            self.removeFromSuperview()
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerTitles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerTitles[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedModel!.index = row
        selectedModel!.text = pickerTitles[row]
    }
    
    /// 取消
    @objc private func cancel() {
        displayBackView()
    }
    
    /// 确定
    @objc private func confirm() {
        displayBackView()
        if selectedModel!.text.isEmpty { selectedModel!.text = pickerTitles.first! }
        didFinish?(selectedModel!)
    }
    
    
}
