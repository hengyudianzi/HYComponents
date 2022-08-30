//
//  LWCalendarSelectView.swift
//  HYBusCustom
//
//  Created by sdhy on 2019/10/19.
//  Copyright © 2019年 sdhy. All rights reserved.
//

import UIKit

protocol LWCalendarSelectViewDelegate:NSObjectProtocol {
    func calendarSelectView(calendarSelectView:LWCalendarSelectView,itemDataReloaded day:LWCalendarDay?,bottomText:String?,item:UIButton,index:Int)
    func calendarSelectView(calendarSelectView:LWCalendarSelectView,didClicked item:UIButton,at index:Int, day:LWCalendarDay?)
    func calendarTopOrNextMonth(_ monthStr:String)
}

public class LWCalendarSelectView: UIView {
    
    let topView = UIView.init(frame: CGRect.zero)
    let calendarTitleView = UIView.init(frame: CGRect.zero)
    let calendarContentView = UIView.init(frame: CGRect.zero)
    var itemLineSpace:CGFloat = 5
    var itemSpace:CGFloat = 0
    var itemSize:CGFloat = 45
    let lineView = UIView.init(frame:CGRect.zero)
    let bottomLineView = UIView.init(frame:CGRect.zero)
    //topView 子视图
    let topTitleView = UIView.init(frame: CGRect.zero)
    let lastButton = UIButton.init(frame: CGRect.zero)
    let nextButton = UIButton.init(frame: CGRect.zero)
    let yearMonthLabel = UILabel.init(frame: CGRect.zero)
    //calendarTitleView 子视图
    var calendarTitleViewItems = [UILabel]()
    //calendarContentView 子视图
    var calendarItems = [UIButton]()
    weak var delegate:LWCalendarSelectViewDelegate?
    
    var month = LWCalendarMonth()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
            self.backgroundColor = UIColor.white
       
        self.addSubViews(views: [topView ,calendarTitleView, calendarContentView,lineView])
       
        topView.addSubview(topTitleView)
        topTitleView.addSubViews(views: [lastButton,nextButton,yearMonthLabel])
        yearMonthLabel.textColor = UIColor.lightGray
        yearMonthLabel.font = UIFont.systemFont(ofSize: 14)
        lastButton.setImage(UIImage.init(named: "jianto_left"), for: UIControl.State.normal)
        nextButton.setImage(UIImage.init(named: "jianto_right"), for: UIControl.State.normal)
        
       
        
      
        for title in ["日","一","二","三","四","五","六"] {
            let label = UILabel.init(frame: CGRect.zero)
            label.text = title
            label.font = UIFont.systemFont(ofSize: 16)
            label.textAlignment = NSTextAlignment.center
            calendarTitleViewItems.append(label)
            calendarTitleView.addSubview(label)
        }
        
       
        for index in 0 ..< 35 {
                let button = UIButton.init(frame:CGRect.zero)
            button.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 5, right: 0)
            button.titleLabel?.textAlignment = NSTextAlignment.center
            button.setBackgroundImage(UIImage.createImageFrom(color: MyColor.MColor, size: CGSize.init(width: itemSize, height: itemSize), radius: itemSize/2), for: UIControl.State.selected)
            button.isEnabled = false
            calendarItems.append(button)
                calendarContentView.addSubview(button)
            button.tag = index
            button.addTarget(self, action: #selector(LWCalendarSelectView.didClickButton(sender:)), for: UIControl.Event.touchUpInside)
          
        }
        
        reloadCalendarData()
        
        self.addTargetForButtons(buttons: [lastButton,nextButton])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadCalendarData() {
        yearMonthLabel.text = month.yearMonthStr
        for (index,button) in calendarItems.enumerated() {
            var day:LWCalendarDay?
            printLog(message: (month.firstDay?.weekIndex!))
            if index > ((month.firstDay?.weekIndex)! - 1)&&index < ((month.firstDay?.weekIndex)! + month.dayNum){
                day = month.days[index - (month.firstDay?.weekIndex!)!]
            }
            button.isSelected = false
            reloadButtonItemData(day: day, bottomText: nil, button: button, index: index)
        }
    }
    
    func reloadButtonItemData(day:LWCalendarDay?,bottomText:String?,button:UIButton,index:Int)  {
           
        setItemData(day:day, bottomText: bottomText, button: button)
        if self.delegate != nil {
            self.delegate?.calendarSelectView(calendarSelectView: self, itemDataReloaded: day, bottomText: bottomText, item: button, index: index)
        }
    }
    func  setItemData(day:LWCalendarDay?,bottomText:String?,button:UIButton)  {
        var  topText = ""
        if day != nil {
            topText = (day?.dateStr)!
        }
        let titleFont = UIFont.systemFont(ofSize: 15)
        let contentFont = UIFont.systemFont(ofSize: 10)
        var titles = [[topText,titleFont]]
        button.isEnabled = false
        if bottomText != nil && bottomText != "" {
            button.isEnabled = true
            titles.append(["\n" + bottomText!,contentFont])
        }
        button.setAttributedTitles(titles:titles, textColor: UIColor.lightGray, for: UIControl.State.disabled)
        button.setAttributedTitles(titles: titles, textColor: UIColor.white, for: UIControl.State.selected)
        button.setAttributedTitles(titles: titles, textColor: UIColor.black, for: UIControl.State.normal)
    }
    
    @objc func didClickButton(sender:UIButton)  {
        let index = sender.tag
        var day:LWCalendarDay?
        if index > ((month.firstDay?.weekIndex)! - 1)&&index < ((month.firstDay?.weekIndex)! + month.dayNum){
            day = month.days[index - (month.firstDay?.weekIndex!)!]
        }
        if self.delegate != nil {
            self.delegate?.calendarSelectView(calendarSelectView: self, didClicked: sender, at:index , day: day)
        }
        
    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        var viewFrame = frame
        viewFrame.origin.x = 0
        viewFrame.origin.y = 0
        viewFrame.size.height = 45
        topView.frame = viewFrame
        viewFrame.size.height = 1
        viewFrame.origin.y = topView.frame.maxY
        lineView.frame = viewFrame
        lineView.backgroundColor = UIColor.groupTableViewBackground
        viewFrame.origin.y = lineView.frame.maxY
        viewFrame.size.height = 40
        calendarTitleView.frame = viewFrame
        
        viewFrame.origin.y = calendarTitleView.frame.maxY
        viewFrame.size.height = itemSize * 5 + itemLineSpace*4
        calendarContentView.frame = viewFrame
        viewFrame = frame
        viewFrame.size.height = calendarContentView.frame.maxY + 10
        
        self.addSubViews(views: [topView ,calendarTitleView, calendarContentView,lineView,bottomLineView])
        
        itemSpace = (frame.size.width - itemSize*7 - 20)/6
        itemSpace = itemSpace > 0 ? itemSpace : 0
        var x:CGFloat = 10
        var y:CGFloat = 0
        var widht = itemSize
        var height = calendarTitleView.frame.size.height
        for item in calendarTitleViewItems {
            
            item.frame = CGRect.init(x: x, y: y, width: widht, height: height)
             x += widht + itemSpace
          
        }
        
        y  = 0
        widht = itemSize
        height = widht
        for (index,item) in calendarItems.enumerated(){
            if (index + 1)%7 == 1{
                 x = 10
            }else{
                x += widht + itemSpace
            }
            item.frame = CGRect.init(x: x, y: y, width: widht, height: height)
           
            if (index + 1)%7 == 0
            {
                y += height + itemLineSpace
            }
          
        }
        
        viewFrame = frame
        viewFrame.size.height = calendarContentView.frame.maxY + 20
        frame = viewFrame
        
        viewFrame = lineView.frame
        viewFrame.origin.y = frame.size.height - 1
        bottomLineView.frame = viewFrame
        bottomLineView.backgroundColor = UIColor.groupTableViewBackground
        
        viewFrame = CGRect.init(x: 0, y: (topView.frame.size.height - 30)/2, width: 30, height: 30)
        lastButton.frame = viewFrame
        viewFrame.origin.x = lastButton.frame.maxX
        viewFrame.origin.y = 0
        viewFrame.size.width = 60
        viewFrame.size.height = topView.frame.size.height
        yearMonthLabel.frame = viewFrame
        viewFrame = lastButton.frame
        viewFrame.origin.x = yearMonthLabel.frame.maxX
        nextButton.frame = viewFrame
        viewFrame.size.width =  nextButton.frame.maxX
        viewFrame.origin.x = topView.frame.size.width -  viewFrame.size.width
        viewFrame.origin.y = 0
        viewFrame.size.height = topView.frame.size.height
        topTitleView.frame = viewFrame
        topTitleView.center = CGPoint(x: KScreenWidth/2, y: topTitleView.center.y)
        yearMonthLabel.text = Date.getCurrentDate(format: "yyyy-MM")
        
       
    }
    
    //MARK:上个月份、下个月份
    override func onClickViewListener(sender: UIView) {
        
        if sender == lastButton {
            month = month.lastMoth
        }else if sender == nextButton{
            month = month.nextMoth
        }
        
        reloadCalendarData()
        
        delegate?.calendarTopOrNextMonth(month.yearMonthStr)

    }
}
