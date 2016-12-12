//
//  ViewController.swift
//  ZoePopView
//
//  Created by mac on 2016/12/12.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

     let popview  = ZoePopUpMenuView.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let right = UIButton.init(frame: CGRect(x:kScreenWidth - 100 , y : 64 ,width:60,height:30))
        right.backgroundColor = UIColor.red;
        right.addTarget(self, action: #selector(clickright), for: .touchUpInside )
        view.addSubview(right)
        
        popview.options = ["成都","北京","美国","东京","新疆","新加坡","广东"]
        // Do any additional setup after loading the view, typically from a nib.
    }
    func clickright(){
        popview.showView()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

