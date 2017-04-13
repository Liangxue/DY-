//
//  UIBarButtonItem+Extension.swift
//  DYZB
//
//  Created by xue on 2017/4/10.
//  Copyright © 2017年 liangxue. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    //
//    class func barButtonItem(imageName:String,highlightImageName:String,size:CGSize)->UIBarButtonItem{
//        
//        let btn = UIButton()
//        btn .setImage(UIImage(named:imageName), for: .normal)
//        btn .setImage(UIImage(named:highlightImageName), for: .highlighted)
//        btn .frame = CGRect(origin: CGPoint.zero, size: size)
//        
//        return UIBarButtonItem(customView: btn)
//    }
    //便利构造函数 1  convenience 开头  2 用self
    convenience init(imageName:String,highlightImageName:String = "",size:CGSize = CGSize.zero){
        
        let btn = UIButton()
        btn .setImage(UIImage(named:imageName), for: .normal)
      
        
        if highlightImageName != "" {
            
            btn .setImage(UIImage(named:highlightImageName), for: .highlighted)
        }
        
        if size == CGSize.zero {
            btn .sizeToFit()
        }else{
            btn .frame = CGRect(origin: CGPoint.zero, size: size)

        }

        self.init(customView: btn)
    }
}
