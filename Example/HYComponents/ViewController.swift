//
//  ViewController.swift
//  HYComponents
//
//  Created by hengyudianzi on 08/29/2022.
//  Copyright (c) 2022 hengyudianzi. All rights reserved.
//

import UIKit
import HYComponents

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    lazy var ticketCalendarView:CFTicketCalendarView = {
        let bundle = GetResourcePng.getCFBundle()
        return bundle.loadNibNamed("CFTicketCalendarView", owner: nil, options: nil)?.first as! CFTicketCalendarView
//        let views = Bundle.main.loadNibNamed("CFTicketCalendarView", owner: nil, options: nil)?.first as! CFTicketCalendarView
//        return views
    }()

    
    var list = [
        "版本更新",
        "身份证拍照",
        "二维码生成",
        "吐司",
        "日期选择",
        "地图导航（各大地图)",
        "评分",
        "网络检测",
        "",
        "",
        "",
        "",
        ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func takeA(_ sender: Any) {
        self.jumpTakeIDCardVC(false)
    }
    
}


extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell") as! MainTableViewCell
        cell.titleLabel.text = list[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
//            APPID = "231"
            self.updateVersion()
            break
        case 1:
            self.jumpTakeIDCardVC(true)
            break
        case 2:
            let channel = QRCodeViewController(nibName: "QRCodeViewController", bundle: nil)
            self.present(channel, animated: true, completion: nil)
            break
        case 3:
            showToast("test")
            break
        case 4:
            showTicketCalendarView()
            break
        case 5:
            MapNavigation.showMapsAlert(self, targetLat: 39.9, targetLong: 116.0 , targetName: "北京")
            break
        case 6:
            self.initGradeView()
            break
        case 7:
            
            removeUserDefaultsCF("isFrist")
            checkNetwork()
        default:
            break
        }
    }
}

extension ViewController{
    
    //跳转身份证 拍照
    func jumpTakeIDCardVC(_ isFront:Bool) {
        let vc = DDPhotoViewController()
        vc.type = isFront == true ? CardType.init(rawValue: 1):CardType.init(rawValue: 2)
        vc.imageblock = {(image)->Void in
            
        }
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func updateVersion() {
        CFVersionAlert.loadVersion(self,"1.0.0",true)
    }
    
    //添加 购票日历显示
    func showTicketCalendarView()  {
        
        guard (self.view.viewWithTag(1000) == nil) else {
            return
        }

        self.view.addSubview(ticketCalendarView)
        ticketCalendarView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        //日历筛选
        weak var weakSelf = self
        ticketCalendarView.block = {(list,totalList)->Void in
            //日期选择回调
            printLog(message: list)
            printLog(message: totalList)
        }

        //选择月份
        ticketCalendarView.selectBlock = {(monthStr)->Void in
            printLog(message: monthStr)
        }
    }
    
    func initGradeView() {
        
        let startV = XHStarRateView(frame: CGRect(x: 0, y: 250, width: KScreenWidth, height: 40), numberOfStars: 5, rateStyle: .WholeStar, isAnination: true, delegate: self)
        startV?.currentScore = "3".CGFloatValue()
        startV?.isUserInteractionEnabled = false
        startV?.tag = 2231
        startV?.backgroundColor = UIColor.white
        KWindow?.addSubview(startV!)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3) {
            guard (KWindow?.viewWithTag(2231) == nil) else {
                let views = KWindow?.viewWithTag(2231)
                views?.removeFromSuperview()
                return
            }

        }
    }
}

