//
//  AViewController.swift
//  RedreshD
//
//  Created by idea on 2018/8/21.
//  Copyright © 2018年 idea. All rights reserved.
//

import UIKit

class AViewController: UIViewController {

    lazy var textField : UITextField = {
        
        return TextField.hint("plese input you name").border(1, "#9999ff").maxLength(15)
    }()
    lazy var lab: UILabel = {
        
        return Label.color("#00ccff").font("36").str("Click after input").align(.center)
    }()
    lazy var bez: BezierText = {
        let  bez =  BezierText(frame: CGRect(x: 20, y: 300,
                                             width: self.view.bounds.width-40, height: 50))
        
        return bez
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bezier"
        view.bg("white").addSubviews(textField,lab,bez)
        textField.makeCons {
            $0.left.equal(20)
            $0.top.equal(80)
            $0.height.equal(60)
            $0.right.equal(-20)
        }
        textField.addTarget(self, action: #selector(textFieldtolab), for: .editingChanged)
        lab.makeCons { make in
            make.top.equal(textField).bottom.offset(50)
            make.left.right.height.equal(textField)
            }.onClick {[weak self] l in
                self?.bez.show(text: l.text!)
        }
        
    }
    @objc func textFieldtolab(){
        lab.text = textField.text   
    }
    

}

