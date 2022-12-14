//
//  AccidentMapSelectViewController.swift
//  SmartBusJiNanBusERP
//
//  Created by ð² on 2021/12/4.
//

import UIKit
import YBPopupMenu
import BaiduMapAPI_Map
import BaiduMapAPI_Search
import BMKLocationKit
import BaiduMapAPI_Base
import BaiduMapAPI_Utils


typealias AccidentMapSelectBlock = (_ poi:BMKPoiInfo)->Void

public class AccidentMapSelectViewController: CFBaseViewController {

   
    @IBOutlet weak var tableView: UITableView! //tableView
    @IBOutlet weak var mapBKView: UIView!   //å°å¾
    @IBOutlet weak var searchBar: UISearchBar! //æç´¢bar
    @IBOutlet weak var searchTableView: UITableView!//æç´¢ tableView
    
    
    //å°å¾åå§å
    var mapView = BMKMapView(frame: .zero)
    
    //
    lazy var geoCoder: CLGeocoder = {
        return CLGeocoder()
    }()
    
    
    private var selectIndex = 0 //æ è®° éæ©å°å¾çç¹
    private var isReload = true //è®°å½æ¯å¦å·æ°
    private var locationManager : BMKLocationManager? //å®ä½ç®¡ç
    private var geoCodeSearch  :  BMKGeoCodeSearch? //å®ä½è§£æ
    private var mySelfLocation : BMKUserLocation?//å®ä½
    private var annotation : BMKPointAnnotation?//å°å¾æ ç¹
    private var poiSearch : BMKPoiSearch? //å°å¾poiæç´¢
    private var listArray = [BMKPoiInfo]() //éè¿ç«ç¹
    private var searchArray = [BMKSuggestionInfo]() //æç´¢ç«ç¹ç»æ
    var block:AccidentMapSelectBlock?
    var selectPoi:BMKPoiInfo?
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        searchBar.delegate = self
        
        searchTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 320, right: 0)
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "åæ¶"
        
        //åå§åå°å¾
        initMap()
        //åå§åå®ä½
        initLocationManager()
        //æ·»å æå¿
        addGesture()
        //å¼å§å®ä½
        start()
        
        
        showEventsAcessDeniedAlert()
    }
    
    //ç¡®å® æé®çç¹å»äºä»¶å
    @IBAction func sureAction(_ sender: Any) {
        
        if (listArray.count > 0) {
            if selectIndex < listArray.count {
                block?(listArray[selectIndex])
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    //è¿åæé® ç¹å»äºä»¶
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - UITableViewDelegate,UITableViewDataSource
extension AccidentMapSelectViewController:UITableViewDelegate,UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableView.tag == 1 ? searchArray.count:listArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView.tag == 1  {
            let poi = searchArray[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccidentMapSelectCell2") as? AccidentMapSelectTableViewCell
            cell?.titleLab.text = poi.key
            cell?.subLabel.text = poi.address
            return cell!
        }
        let poi = listArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccidentMapSelectCell") as? AccidentMapSelectTableViewCell
        cell?.titleLab.text = poi.name
        cell?.subLabel.text = poi.address
        cell?.selectImage.isHidden = selectIndex == indexPath.row ? false:true
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if tableView.tag == 1 {
            selectIndex = 0
            let poi = searchArray[indexPath.row]
            hiddenTV()
            searchBar.resignFirstResponder()
            searchBar.text = ""
            
            let newPoi = BMKPoiInfo()
            newPoi.name = poi.key
            newPoi.address = poi.address
            newPoi.pt = poi.location
            selectPoi = newPoi
            isReload = true
            
            mapView.setCenter(poi.location, animated: true)
        }else{
            selectIndex = indexPath.row
            isReload = false
            let poi = listArray[indexPath.row]
            selectPoi = poi
            mapView.setCenter(CLLocationCoordinate2D(latitude: poi.pt.latitude , longitude: poi.pt.longitude), animated: true)
            self.tableView.reloadData()

        }
    }
}

//MARK: - æç´¢ çtableView æ¾ç¤ºãéè
extension AccidentMapSelectViewController{
    
    /// æ¾ç¤ºæç´¢ çtableView
    ///
    ///
    ///
    func showTV()  {
        UIView.animate(withDuration: 0.3) {
            self.searchTableView.isHidden = false
        }
    }
    /// éèæç´¢ çtableView
    ///
    ///
    ///
    func hiddenTV()  {
        UIView.animate(withDuration: 0.3) {
            self.searchTableView.isHidden = true
        }
    }
}

//MARK: - ç¾åº¦å°å¾çä»£çåè° BMKMapViewDelegate
extension AccidentMapSelectViewController:BMKMapViewDelegate{
    
    /*
     * åå§å å°å¾
     */
    func initMap(){
        
        self.mapBKView.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mapView.zoomLevel = 16
        mapView.userTrackingMode = BMKUserTrackingModeNone
        mapView.showsUserLocation = true
        mapView.delegate = self
    }
    
    
    func mapview(_ mapView: BMKMapView!, onLongClick coordinate: CLLocationCoordinate2D){
        
        if (annotation != nil) {
            mapView.removeAnnotation(annotation as! BMKAnnotation)
        }
        annotation?.coordinate = coordinate
        let reverseGeoCodeOption = BMKReverseGeoCodeSearchOption()
        reverseGeoCodeOption.location = coordinate
        let flag = geoCodeSearch?.reverseGeoCode(reverseGeoCodeOption)
        if flag == false
        {
            print("åæ è§£æå¤±è´¥")
        }
    
        mapView?.addAnnotation(annotation as! BMKAnnotation)
       
    }

    func mapView(_ mapView: BMKMapView!, regionWillChangeAnimated animated: Bool) {
        
    }
    func mapView(_ mapView: BMKMapView!, regionDidChangeAnimated animated: Bool, reason: BMKRegionChangeReason) {
        
        if isReload {
            selectIndex = 0
            let reverseGeoCodeOption = BMKReverseGeoCodeSearchOption()
            reverseGeoCodeOption.location = CLLocationCoordinate2D(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)

            guard let flg = geoCodeSearch?.reverseGeoCode(reverseGeoCodeOption) else { print("åæ è§£æå¤±è´¥"); return  }
        }
    }
        
}


//MARK: - å®ä½
extension AccidentMapSelectViewController:BMKLocationManagerDelegate{
    
    /*
     * åå§å å®å¶ç®¡çå¨
     */
    func initLocationManager() {
        locationManager = BMKLocationManager()
        geoCodeSearch =  BMKGeoCodeSearch()
        poiSearch = BMKPoiSearch()
        
    }
    
    /*
     * å¼å§å®ä½
     */
    func start() {
        locationManager?.startUpdatingLocation()
        locationManager?.delegate = self
        geoCodeSearch?.delegate = self
    }
    
    /*
     * å®ä½ åè°
     */
    public func bmkLocationManager(_ manager: BMKLocationManager, didUpdate location: BMKLocation?, orError error: Error?) {
        
        var coorDegrees = [[Double]]()
        let lat:Double? = location?.location?.coordinate.latitude ?? 0
        let lon:Double? = location?.location?.coordinate.longitude ?? 0
                
        let lo = BMKCoordTrans(CLLocationCoordinate2D(latitude: lat!, longitude: lon!), BMK_COORD_TYPE.COORDTYPE_COMMON , BMK_COORD_TYPE.COORDTYPE_BD09LL)
        coorDegrees.append([lo.latitude ,lo.longitude])
                
        locationManager?.stopUpdatingLocation()
        
        let reverseGeoCodeOption = BMKReverseGeoCodeSearchOption()
        reverseGeoCodeOption.location = CLLocationCoordinate2D(latitude: lo.latitude, longitude: lo.longitude)

        guard let flg = geoCodeSearch?.reverseGeoCode(reverseGeoCodeOption) else { print("åæ è§£æå¤±è´¥"); return  }
        
 
        let loca = BMKUserLocation()
        loca.location = CLLocation(latitude: lo.latitude, longitude: lo.longitude)
        
        mapView.setCenter(CLLocationCoordinate2D(latitude: lo.latitude , longitude: lo.longitude), animated: true)
        mapView.updateLocationData(loca)
    }
}

//MARK: - éå°çç¼ç  åè°ï¼BMKGeoCodeSearchDelegateï¼
extension AccidentMapSelectViewController:BMKGeoCodeSearchDelegate{
    
    public func onGetReverseGeoCodeResult(_ searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeSearchResult!, errorCode error: BMKSearchErrorCode) {

        printLog(message: error.rawValue)
        guard error.rawValue == BMK_SEARCH_NO_ERROR.rawValue else {
            return
        }

        guard result != nil else {
            return
        }

        
        selectPoi = BMKPoiInfo()
        selectPoi?.name = result.businessCircle
        selectPoi?.address = result.address
        selectPoi?.pt = result.location

        if searchTableView.isHidden {
            self.listArray.removeAll()
            self.listArray.append(contentsOf: result.poiList)
            self.tableView.reloadData()
            self.tableView.layoutIfNeeded()
            if self.listArray.count > 0 {
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }else{
            print(result.poiList.count)
        }
        
    }
    
}

//MARK: - å°åç¼ç 
extension AccidentMapSelectViewController{
    
    func searchAddress(_ addressStr:String) {
        geoCoder.geocodeAddressString(addressStr) { (pls: [CLPlacemark]?, error: Error?)  in
            if error == nil {
                print("å°çç¼ç æå")
                guard let plsResult = pls else {return}
                let firstPL = plsResult.first
                let reverseGeoCodeOption = BMKReverseGeoCodeSearchOption()
                reverseGeoCodeOption.location = CLLocationCoordinate2D(latitude: (firstPL?.location?.coordinate.latitude)!, longitude:(firstPL?.location?.coordinate.longitude)!)
                guard let flg = self.geoCodeSearch?.reverseGeoCode(reverseGeoCodeOption) else { print("åæ è§£æå¤±è´¥"); return }
            }else {
                print("éè¯¯")
            }
        }
    }
}


//MARK: - UISearchBarDelegate
extension AccidentMapSelectViewController:UISearchBarDelegate{
    
    /*
     * è®¾ç½® æç´¢barä¸­ç åæ¶æé® ä¸º ä¸­æ
     */
    public func initCancelBtn() {
        UIView.animate(withDuration: 0.4) {
            self.searchBar.showsCancelButton = true
            for v in self.searchBar.subviews {
                for _v in v.subviews {
                    if let _cls = NSClassFromString("UINavigationButton") {
                        if _v.isKind(of: _cls) {
                            guard let btn = _v as? UIButton else { return }
                            btn.setTitle("åæ¶", for: .normal)
                            btn.setTitleColor(UIColor.red, for: .normal)
                            return
                        }
                    }
                }
            }
        }
    }
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        // è®¾ç½®åæ¶æé®
        showTV()
    }
    
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        hiddenTV()
    }
        
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        hiddenTV()
    }
    
    
        
    public  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //å®æ¶ æç´¢
        guard searchText != "" else {
            return
        }
        let search = BMKSuggestionSearch()
        search.delegate = self
        
        //åå§åè¯·æ±åæ°ç±»BMKSuggestionSearchOptionçå®ä¾
        let suggestionOption = BMKSuggestionSearchOption()
        //åå¸å
        suggestionOption.cityname = "æµå"
        //æ£ç´¢å³é®å­
        suggestionOption.keyword = searchText
        suggestionOption.cityLimit = false
        
        let flag = search.suggestionSearch(suggestionOption)
        if flag {
            print("å³é®è¯æ£ç´¢æå")
        } else {
            print("å³é®è¯æ£ç´¢å¤±è´¥")
        }
        
    }
}

//MARK: - ç»å°å¾æ·»å ææ½ æ
extension AccidentMapSelectViewController{
    
    func addGesture() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.swipeAction))
        gesture.cancelsTouchesInView = false
        gesture.delaysTouchesEnded = false
        self.mapView.addGestureRecognizer(gesture)
    }
    
    @objc func swipeAction(){
        selectIndex = 0
        isReload = true
    }
}

//MARK: - BMKSuggestionSearchDelegate
extension AccidentMapSelectViewController:BMKSuggestionSearchDelegate{
    /**
     å³é®å­æ£ç´¢ç»æåè°
     
     @param searcher æ£ç´¢å¯¹è±¡
     @param result å³é®å­æ£ç´¢ç»æ
     @param error éè¯¯ç ï¼@see BMKCloudErrorCode
     */
    public func onGetSuggestionResult(_ searcher: BMKSuggestionSearch!, result: BMKSuggestionSearchResult!, errorCode error: BMKSearchErrorCode) {
        if (error == BMK_SEARCH_NO_ERROR) {
            //å¨æ­¤å¤çæ­£å¸¸ç»æ
            weak var weakSelf = self
            if result.suggestionList.count > 0 {
                weakSelf?.searchArray = result.suggestionList
                weakSelf?.searchTableView.reloadData()
            }else{
                weakSelf?.searchArray.removeAll()
                weakSelf?.searchTableView.reloadData()
            }
        }else {
            print("æ£ç´¢å¤±è´¥");
        }
    }
}
