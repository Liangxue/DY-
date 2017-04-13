//
//  HomeViewController.swift
//  DYZB
//
//  Created by xue on 2017/4/10.
//  Copyright © 2017年 liangxue. All rights reserved.
//

import UIKit

private let kTitleViewH:CGFloat = 40
private let titles = ["推荐","游戏","娱乐","敢玩"]

class HomeViewController: UIViewController {

        lazy var pageTitleView:PageTitleView = {[weak self] in
       
        let titleFrame = CGRect(x: 0, y: kStatusBarH+kNavigationBarH, width: kScreenW, height: kTitleViewH)
        
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        
            titleView.delegate = self
            return titleView
    }()
    
    lazy var pageContentView:PageContentView = {[weak self] in
        let contentH = kScreenH-kStatusBarH-kNavigationBarH-kTitleViewH-kTabBarH
        let contentViewFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        var childVcs = [UIViewController]()
        
        childVcs.append(RecommendViewController())
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1.0)
            childVcs.append(vc)
            
        }
        
        let contentView = PageContentView(frame: contentViewFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    
}


extension HomeViewController{
    
    func setupUI(){
        
        automaticallyAdjustsScrollViewInsets = false
        setupNav()
        
        view.addSubview(pageTitleView)
        
        view.addSubview(pageContentView)

    }
    private func setupNav(){
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        let size = CGSize(width: 40, height: 40)
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highlightImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highlightImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highlightImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
    }
}

extension HomeViewController:PageTitleViewDelegate{
    
    func pageTitleView(titleView: PageTitleView, seletedIndex index: Int) {
        
        pageContentView.setCurrentIndex(currentIndex: index)
        print(index)
    }
}


extension HomeViewController:PageContentViewDelegate{
    
    func pageContentView(contentView: PageContentView, progess: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        pageTitleView.setTitleViewWithProgress(progress: progess, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
