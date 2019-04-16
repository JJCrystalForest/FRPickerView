//
//  ViewController.swift
//  FRPickerView
//
//  Created by free on 2019/4/16.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    private let titles : [String] = {
        var titles = [String]()
        for index in 0..<100 { titles.append("test_" + "\(index)") }
        return titles
    }()
    
    private var selectIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func displayPicker() {
        let picker = FRPickView(UIScreen.main.bounds, titles, selectIndex) { [weak self] (model) in
            self?.titleLabel.text = "text : " + "\(model.text)" + "   " + "index : " + "\(model.index)"
            self?.selectIndex = model.index
        }
        view.addSubview(picker)
    }
}

