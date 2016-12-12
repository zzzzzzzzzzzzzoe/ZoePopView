//
//  ZoePopUpMenuView.swift
//  qiangtoubao
//
//  Created by zhou on 16/7/26.
//  Copyright © 2016年 Polesapp. All rights reserved.
//

import Foundation
import UIKit
//屏幕宽度
let kScreenWidth = UIScreen .main.bounds.size.width
//屏幕高度
let kScreenHeight = UIScreen .main.bounds.size.height

public protocol ZoePopUpViewDelegate:class{
    func zoeDropDownMenu(text:String, didChoose index:Int)
}

public class ZoePopUpMenuView: UIView, UITableViewDataSource ,UITableViewDelegate {
    
    public var options:Array<String> = []
    
    public weak var delegate:ZoePopUpViewDelegate?
    
    public lazy var optionsList:UITableView = {
        let table = UITableView(frame: CGRect(x:0, y:64 ,width:kScreenWidth, height:0), style: .plain)
        table.showsVerticalScrollIndicator = false;
        table.bounces = false
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        table.layer.borderColor = UIColor.lightGray.cgColor
        table.layer.borderWidth = 0.5
        table.rowHeight = 45
        table.separatorStyle = UITableViewCellSeparatorStyle.none
        return table
    }()
    
    public var SelectIndex : Int?
    
    private var blackClick : UIButton?
    
    override init(frame: CGRect) {
        let mainFrame = CGRect(x:0,y: 0,width: kScreenWidth, height:kScreenHeight )
        super.init(frame: mainFrame)
        initView()

    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(){
        SelectIndex = 0
        blackClick = UIButton(frame:self.frame)
        blackClick!.addTarget(self, action:  #selector(ZoePopUpMenuView.dismiss), for: .touchUpInside)
        self.addSubview(blackClick!)
        backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
        self.addSubview(optionsList)
        
    
    }
    func showView(){
        optionsList.reloadData()
        let window = UIApplication.shared.keyWindow
        window! .addSubview(self)
        self.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
            if self.options.count>6 {
                self.optionsList.frame = CGRect(x:0, y:64,width: kScreenWidth, height:6 * 45)
            }else{
                self.optionsList.frame = CGRect(x:0, y:64, width:kScreenWidth, height: CGFloat(self.options.count) * 45)
            }
            
            }, completion: {
                finished in
        })

    }
    func dismiss() -> Void {
        dismissView()
    }
    func dismissView(){
        self.alpha = 1
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
            self.optionsList.frame = CGRect(x:0, y:64, width:kScreenWidth,height:0)
            }, completion: {
            finished in
                self.removeFromSuperview()

        })
    }
    
    
    @nonobjc public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "")
        cell.selectionStyle = UITableViewCellSelectionStyle.default
        cell.textLabel?.text = options[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        if SelectIndex == indexPath.row {
            cell.backgroundColor = UIColor.init(red: 0.906, green: 0.906, blue: 0.906, alpha: 1.00)
//            cell.textLabel?.textColor = UIColor.init(hex:"35BFD3")
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        SelectIndex = indexPath.row
        dismissView()
        delegate?.zoeDropDownMenu(text: options[indexPath.row],didChoose:indexPath.row)
        
    }
   

}
