//
//  PageContentView.swift
//  DYZB
//
//  Created by xue on 2017/4/11.
//  Copyright © 2017年 liangxue. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate:class {
    
    func pageContentView(contentView:PageContentView,progess:CGFloat,sourceIndex:Int,targetIndex:Int)
}

private var layoutSize:CGSize = CGSize()
private let  kTitleViewH:CGFloat = 40

private let reuseIdentifier = "cellReuseIdentifier"

class PageContentView: UIView {

    var isForbidScrollDelegate:Bool = false
    weak var delegate:PageContentViewDelegate?
    var startOffsetX:CGFloat = 0
    
     var childVcs : [UIViewController]
    weak var parentViewController:UIViewController?
    
    lazy var collectionView:UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = layoutSize
        layout.minimumLineSpacing = 0
        
        layout.minimumInteritemSpacing = 0
        
        layout.scrollDirection = .horizontal
        let contentH = kScreenH-kStatusBarH-kNavigationBarH-kTitleViewH
        let collectionViewFrame = CGRect(x: 0, y: kStatusBarH+kNavigationBarH+kTitleViewH, width: kScreenW, height: contentH)
        let collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: layout)
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled  = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView .register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        return collectionView
        
    }()
    
    init(frame: CGRect,childVcs:[UIViewController],parentViewController:UIViewController?) {
        self.childVcs = childVcs
        
        self.parentViewController = parentViewController
        super.init(frame: frame)
        layoutSize = frame.size

        setupPageContentViewUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension PageContentView{
    
    func setupPageContentViewUI() {
        
        for childVc in  childVcs{
            
            parentViewController?.addChildViewController(childVc)
        }
        
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}


extension PageContentView:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
     
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}


extension PageContentView:UICollectionViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isForbidScrollDelegate {return}
        
        var progess:CGFloat = 0
        
        var sourceIndex:Int = 0
        
        var targetIndex:Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if currentOffsetX > startOffsetX {
            
            progess = currentOffsetX/scrollViewW - floor(currentOffsetX / scrollViewW)
            
            sourceIndex = Int(currentOffsetX/scrollViewW)
            
            targetIndex = sourceIndex + 1
            
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            
            if currentOffsetX - startOffsetX == scrollViewW {
                
                progess = 1
                targetIndex = sourceIndex
            }
        }else{
            progess = 1 - (currentOffsetX/scrollViewW - floor(currentOffsetX / scrollViewW))
            targetIndex = Int(currentOffsetX/scrollViewW)

        
            sourceIndex = targetIndex + 1
            
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        
        }
        
        delegate?.pageContentView(contentView: self, progess: progess, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
}

//对外暴露的方法
extension PageContentView{
    
    func setCurrentIndex(currentIndex:Int){
        
        isForbidScrollDelegate = true
        let offsetX = CGFloat(currentIndex)*collectionView.frame.width
    
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
