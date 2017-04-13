//
//  PageTitleView.swift
//  DYZB
//
//  Created by xue on 2017/4/10.
//  Copyright © 2017年 liangxue. All rights reserved.
//

import UIKit

//协议
protocol PageTitleViewDelegate:class {
    func pageTitleView(titleView:PageTitleView,seletedIndex index:Int)
}

private let kScrollLineH:CGFloat = 2


private let kNormalColor:(CGFloat,CGFloat,CGFloat)=(85,85,85)

private let kSelectedColor:(CGFloat,CGFloat,CGFloat)=(255,128,0)

class PageTitleView: UIView {


    weak var delegate: PageTitleViewDelegate?
     var titles:[String]
    var currentIndex:Int = 0
    
    lazy var titleLabels:[UILabel] = [UILabel]()
     lazy var scrollview:UIScrollView = {
        let scrollV = UIScrollView()
//        scrollV.showsVerticalScrollIndicator = false
        scrollV.showsHorizontalScrollIndicator = false
        scrollV.scrollsToTop = false
        scrollV.bounces = false
        return scrollV
    }()
    
    lazy var scrollLine:UIView = {
       
        let scrollLine = UIView()
        
        scrollLine.backgroundColor = UIColor.orange
        
        
        return scrollLine
    }()
    init(frame: CGRect,titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        
        setupPageTitleViewUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

extension PageTitleView{
    
     func setupPageTitleViewUI(){
        
        addSubview(scrollview)
        scrollview.frame = bounds

        setupTitleLabels()
        
        setupBottomLineAndScrollLine()
    }
    
    
    private func setupTitleLabels(){
        
        let labelW:CGFloat = frame.width/CGFloat(titles.count)
        
        let labelH:CGFloat = frame.height - kScrollLineH
        let labelY:CGFloat = 0
        for (index,title) in titles.enumerated(){
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor(red: (kNormalColor.0)/255.0, green: kNormalColor.1/255.0, blue: kNormalColor.2/255.0, alpha: 1.0)
            label.textAlignment = .center
            let labelX:CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            titleLabels.append(label)
            scrollview.addSubview(label)
            label.isUserInteractionEnabled = true
            
            let tapGes = UITapGestureRecognizer(target: self, action:#selector(self.titleLabelCLick(tapGes:)))
            
            label .addGestureRecognizer(tapGes)
        }
    }
    
    private func setupBottomLineAndScrollLine(){
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height-lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //
        guard let firstLabel = titleLabels.first else {return}
        
        firstLabel.textColor = UIColor(red: kSelectedColor.0/255.0, green: kSelectedColor.1/255.0, blue: kSelectedColor.2/255.0, alpha: 1.0)
        scrollview.addSubview(scrollLine)
        
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height-kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}


//

extension PageTitleView{
    
    @objc  func titleLabelCLick(tapGes:UITapGestureRecognizer){
        
        print("-----")
        
        guard let currentLabel = tapGes.view  as? UILabel  else {
            
            return
        }
        
        let oldLabel = titleLabels[currentIndex]
        
        currentLabel.textColor = UIColor.orange
//        currentLabel.textColor = UIColor(red: kSelectedColor.0/255.0, green: kSelectedColor.1/255.0, blue: kSelectedColor.2/255.0, alpha: 1.0)
        scrollview.addSubview(scrollLine)
        
        oldLabel.textColor = UIColor.darkGray
//        oldLabel.textColor = UIColor(red: kNormalColor.0/255.0, green: kNormalColor.1/255.0, blue: kNormalColor.2/255.0, alpha: 1.0)
        scrollview.addSubview(scrollLine)

        currentIndex = currentLabel.tag
        

        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame .width
        
        UIView.animate(withDuration: 0.15) { 
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //通知代理
        delegate?.pageTitleView(titleView: self, seletedIndex: currentIndex)
    }
}


//外界访问
extension PageTitleView{
    func setTitleViewWithProgress(progress:CGFloat,sourceIndex:Int,targetIndex:Int){
        
        //
        
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x;
        
        let moveX  = moveTotalX * progress
        
        
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
//        let colorDelta = ((kSelectedColor.0-kNormalColor.0)/255.0,(kSelectedColor.1-kNormalColor.1)/255.0,(kSelectedColor.2-kNormalColor.2)/255.0)
        sourceLabel.textColor = UIColor.darkGray;
        targetLabel.textColor = UIColor.orange
//        sourceLabel.textColor = UIColor(red: (kSelectedColor.0-colorDelta.0*progress)/255.0, green: (kSelectedColor.1-colorDelta.1*progress)/255.0, blue: (kSelectedColor.2-colorDelta.2*progress)/255.0, alpha: 1.0)
//        targetLabel.textColor = UIColor(red: (kNormalColor.0+colorDelta.0*progress)/255.0, green: (kNormalColor.1+colorDelta.1*progress)/255.0, blue: (kNormalColor.2+colorDelta.2*progress)/255.0, alpha: 1.0)
        
        currentIndex = targetIndex
    }
}
