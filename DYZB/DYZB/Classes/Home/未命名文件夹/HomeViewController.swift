//
//  HomeViewController.swift
//  DYZB
//
//  Created by xue on 2017/4/10.
//  Copyright © 2017年 liangxue. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        setupUI()
    
    }

    

}

//设置UI界面

extension HomeViewController{
    
     func setupUI(){
        
        setupNav()
    }
    
    private func setupNav(){
        
        //左侧的logo
        let btn = UIButton()
        btn.setImage(UIImage(named:"logo"), for: .normal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        btn .sizeToFit()

    //右侧的items
        let historyBtn = UIButton()
        historyBtn.setImage(UIImage(named:""), for: .normal)
        historyBtn.setImage(UIImage(named:""), for: .highlighted)
        historyBtn.sizeToFit()
        let historyItem = UIBarButtonItem(customView: historyBtn)
        
        let searchBtn = UIButton()
        searchBtn.setImage(UIImage(named:""), for: .normal)
        searchBtn.setImage(UIImage(named:""), for: .highlighted)
        searchBtn.sizeToFit()
        let searchItem = UIBarButtonItem(customView: searchBtn)
        
        let qrcodeBtn = UIButton()
        qrcodeBtn.setImage(UIImage(named:""), for: .normal)
        qrcodeBtn.setImage(UIImage(named:""), for: .highlighted)
        qrcodeBtn.sizeToFit()
        let qrcodeItem = UIBarButtonItem(customView: historyBtn)
        

    }
}
