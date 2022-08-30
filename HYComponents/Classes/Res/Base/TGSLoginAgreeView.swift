//
//  TGSLoginAgreeView.swift
//  Smartbus_ChiFeng
//
//  Created by 🐲 on 2022/6/1.
//

import UIKit
import UIKit

/// 同意协议view
public class TGSLoginAgreeView: UIView,UITextViewDelegate{

    ///点击类型
    public enum ClickLinkType {
        ///用户协议
        case userProtocol
        ///隐私条款
        case privacyPolicy
    }
 
    ///点击事件
    public var clickHandle:((_ clickType:ClickLinkType)->())?
     
    ///同意View
    private lazy var agreeTextView : UITextView = {
        let textStr = "为了更好的保障您的个人权益，请务必在使用前，认真阅读《用户协议》和《隐私条款》的全部内容。如果您同意，请点击”同意并继续“开始接受我们的服务。"
        let textView = UITextView()
        textView.delegate = self
        textView.font =  UIFont.systemFont(ofSize: 25.0, weight: .regular)
        textView.textColor = UIColor.init(hexString: "#666666")
        textView.textAlignment = .center
 
        ///设为true 在代理里面禁掉所有的交互事件
        textView.isEditable = false
         
//        textView.autoresizingMask =  UIView.AutoresizingMask.flexibleHeight
        textView.isScrollEnabled = false
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.alignment = .justified
        
        let attStr = NSMutableAttributedString(string: textStr)
        
        attStr.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSMakeRange(0, textStr.count))
        
        //点击超链接
        attStr.addAttribute(NSAttributedString.Key.link, value: "userProtocol://", range: (textStr as NSString).range(of: "《用户协议》"))
        //点击超链接
        attStr.addAttribute(NSAttributedString.Key.link, value: "privacyPolicy://", range: (textStr as NSString).range(of: "《隐私条款》"))
 
        attStr.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 15.0, weight: .regular), range:(textStr as NSString).range(of: textStr))
        
        textView.attributedText = attStr
        ///只能设置一种颜色
        textView.linkTextAttributes =  [
            NSAttributedString.Key.foregroundColor: UIColor(hexString: navigation_BKColor)
        ]
         
        return textView
    }()
     
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
 
extension TGSLoginAgreeView{
    
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
     
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.scheme  ==  "userProtocol"{
            self.clickHandle?(.userProtocol)
            return false
        }else if URL.scheme == "privacyPolicy"{
            self.clickHandle?(.privacyPolicy)
            return false
        }
        return true
    }
}
 
extension TGSLoginAgreeView{
    private func configUI(){
        ///同意view
        self.addSubview(agreeTextView)
        agreeTextView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
