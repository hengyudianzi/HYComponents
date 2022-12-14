//
//  TGSLoginAgreeView.swift
//  Smartbus_ChiFeng
//
//  Created by ð² on 2022/6/1.
//

import UIKit
import UIKit

/// åæåè®®view
public class TGSLoginAgreeView: UIView,UITextViewDelegate{

    ///ç¹å»ç±»å
    public enum ClickLinkType {
        ///ç¨æ·åè®®
        case userProtocol
        ///éç§æ¡æ¬¾
        case privacyPolicy
    }
 
    ///ç¹å»äºä»¶
    public var clickHandle:((_ clickType:ClickLinkType)->())?
     
    ///åæView
    private lazy var agreeTextView : UITextView = {
        let textStr = "ä¸ºäºæ´å¥½çä¿éæ¨çä¸ªäººæçï¼è¯·å¡å¿å¨ä½¿ç¨åï¼è®¤çéè¯»ãç¨æ·åè®®ãåãéç§æ¡æ¬¾ãçå¨é¨åå®¹ãå¦ææ¨åæï¼è¯·ç¹å»âåæå¹¶ç»§ç»­âå¼å§æ¥åæä»¬çæå¡ã"
        let textView = UITextView()
        textView.delegate = self
        textView.font =  UIFont.systemFont(ofSize: 25.0, weight: .regular)
        textView.textColor = UIColor.init(hexString: "#666666")
        textView.textAlignment = .center
 
        ///è®¾ä¸ºtrue å¨ä»£çéé¢ç¦æææçäº¤äºäºä»¶
        textView.isEditable = false
         
//        textView.autoresizingMask =  UIView.AutoresizingMask.flexibleHeight
        textView.isScrollEnabled = false
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.alignment = .justified
        
        let attStr = NSMutableAttributedString(string: textStr)
        
        attStr.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSMakeRange(0, textStr.count))
        
        //ç¹å»è¶é¾æ¥
        attStr.addAttribute(NSAttributedString.Key.link, value: "userProtocol://", range: (textStr as NSString).range(of: "ãç¨æ·åè®®ã"))
        //ç¹å»è¶é¾æ¥
        attStr.addAttribute(NSAttributedString.Key.link, value: "privacyPolicy://", range: (textStr as NSString).range(of: "ãéç§æ¡æ¬¾ã"))
 
        attStr.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 15.0, weight: .regular), range:(textStr as NSString).range(of: textStr))
        
        textView.attributedText = attStr
        ///åªè½è®¾ç½®ä¸ç§é¢è²
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
        ///åæview
        self.addSubview(agreeTextView)
        agreeTextView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
