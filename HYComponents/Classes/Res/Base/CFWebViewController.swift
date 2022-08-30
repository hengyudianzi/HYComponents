//
//  CFWebViewController.swift
//  Smartbus_ChiFeng
//
//  Created by 🐲 on 2022/4/22.
//

import UIKit
import WebKit


public class CFWebViewController: UIViewController {
    
    @IBOutlet weak var wkWeb: WKWebView!
    @IBOutlet weak var titleLab: CFNavigationBarTitleLabel!
        
    public var path : String?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLab.text = self.title
        loadData()
    }
    
    
    public func loadData() {
        
        printLog(message: path ?? "")
        
        let p = path ?? ""
        
        guard p.count > 5 else {
            requestHtml()
            return
        }
        
        let tps = (p as NSString).substring(to: 4)
        guard tps == "http" else {
            requestHtml()
            return
        }
        
        guard let url = URL(string: path ?? "") else {
            requestHtml()
            return
        }
        wkWeb.load(URLRequest(url: url))
    }
    
    //请求html
    public func requestHtml() {
        let html = "<html><body><font size=\"18\">\(path ?? "")</font></body></html>"
        wkWeb.loadHTMLString(html, baseURL: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
