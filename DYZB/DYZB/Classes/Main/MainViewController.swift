//
//  MainViewController.swift
//  DYZB
//
//  Created by xue on 2017/4/10.
//  Copyright © 2017年 liangxue. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVc(storyName: "Home")
        addChildVc(storyName: "Live")
        addChildVc(storyName: "Follow")
        addChildVc(storyName: "Profile")

    }


    private func addChildVc(storyName:String){
        
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVc)
    }
}
