//
//  RecommendViewController.swift
//  DYZB
//
//  Created by xue on 2017/4/11.
//  Copyright © 2017年 liangxue. All rights reserved.
//

import UIKit

import Alamofire

private let kItemMargin:CGFloat = 10
private let kItemW = (kScreenW - 3*kItemMargin)/2
private let kItemH = kItemW * 0.75

private let kPrettyItemH = kItemW * 4/3


private let recommendNormalCellReuseIdentifier = "recommendNormalCellReuseIdentifier"
private let headerViewReuseIdentifier = "headerViewReuseIdentifier"

private let prettyCellReuseIdentifier = "CollectionViewPrettyCellReuseIdentifier"


private let headerViewH:CGFloat = 60
class RecommendViewController: UIViewController {


    //
    lazy var collectionView:UICollectionView = {[unowned self] in
        
        
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: kItemMargin, left: kItemMargin, bottom: kItemMargin, right: kItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: headerViewH)

        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)

        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: recommendNormalCellReuseIdentifier)
        collectionView.register(UINib(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: prettyCellReuseIdentifier)

        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerViewReuseIdentifier)
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectionView.backgroundColor = UIColor.white

        return collectionView
        
        }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        setupRecommendUI()
        
        NetWorkTools.requestDataWithGet(URLString: "https://httpbin.org/get", parameters: nil) { (json) in
            print("JSON: \(json)")

        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension RecommendViewController{
 
    func setupRecommendUI(){
        
        view.addSubview(collectionView)
        
    }
}

extension RecommendViewController:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerV = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerViewReuseIdentifier, for: indexPath)
        
        headerV.backgroundColor = UIColor.white
        return headerV
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if section == 0 {
            
            return 8
        }else{
            
            return 4
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell : UICollectionViewCell!
        
        
        if indexPath.section == 1 {
             cell = collectionView.dequeueReusableCell(withReuseIdentifier: prettyCellReuseIdentifier, for: indexPath)
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: recommendNormalCellReuseIdentifier, for: indexPath)

        }
        
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1 {
            
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kItemW, height: kItemH)
    }
}


extension RecommendViewController:UICollectionViewDataSource{
    
}
