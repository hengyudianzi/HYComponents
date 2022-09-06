//
//  AccidentMapSelectViewController.swift
//  SmartBusJiNanBusERP
//
//  Created by 🐲 on 2021/12/4.
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
    @IBOutlet weak var mapBKView: UIView!   //地图
    @IBOutlet weak var searchBar: UISearchBar! //搜索bar
    @IBOutlet weak var searchTableView: UITableView!//搜索 tableView
    
    
    //地图初始化
    var mapView = BMKMapView(frame: .zero)
    
    //
    lazy var geoCoder: CLGeocoder = {
        return CLGeocoder()
    }()
    
    
    private var selectIndex = 0 //标记 选择地图的点
    private var isReload = true //记录是否刷新
    private var locationManager : BMKLocationManager? //定位管理
    private var geoCodeSearch  :  BMKGeoCodeSearch? //定位解析
    private var mySelfLocation : BMKUserLocation?//定位
    private var annotation : BMKPointAnnotation?//地图标点
    private var poiSearch : BMKPoiSearch? //地图poi搜索
    private var listArray = [BMKPoiInfo]() //附近站点
    private var searchArray = [BMKSuggestionInfo]() //搜索站点结果
    var block:AccidentMapSelectBlock?
    var selectPoi:BMKPoiInfo?
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        searchBar.delegate = self
        
        searchTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 320, right: 0)
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "取消"
        
        //初始化地图
        initMap()
        //初始化定位
        initLocationManager()
        //添加手势
        addGesture()
        //开始定位
        start()
        
        
        showEventsAcessDeniedAlert()
    }
    
    //确定 按钮的点击事件啊
    @IBAction func sureAction(_ sender: Any) {
        
        if (listArray.count > 0) {
            if selectIndex < listArray.count {
                block?(listArray[selectIndex])
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    //返回按钮 点击事件
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

//MARK: - 搜索 的tableView 显示、隐藏
extension AccidentMapSelectViewController{
    
    /// 显示搜索 的tableView
    ///
    ///
    ///
    func showTV()  {
        UIView.animate(withDuration: 0.3) {
            self.searchTableView.isHidden = false
        }
    }
    /// 隐藏搜索 的tableView
    ///
    ///
    ///
    func hiddenTV()  {
        UIView.animate(withDuration: 0.3) {
            self.searchTableView.isHidden = true
        }
    }
}

//MARK: - 百度地图的代理回调 BMKMapViewDelegate
extension AccidentMapSelectViewController:BMKMapViewDelegate{
    
    /*
     * 初始化 地图
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
            print("坐标解析失败")
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

            guard let flg = geoCodeSearch?.reverseGeoCode(reverseGeoCodeOption) else { print("坐标解析失败"); return  }
        }
    }
        
}


//MARK: - 定位
extension AccidentMapSelectViewController:BMKLocationManagerDelegate{
    
    /*
     * 初始化 定制管理器
     */
    func initLocationManager() {
        locationManager = BMKLocationManager()
        geoCodeSearch =  BMKGeoCodeSearch()
        poiSearch = BMKPoiSearch()
        
    }
    
    /*
     * 开始定位
     */
    func start() {
        locationManager?.startUpdatingLocation()
        locationManager?.delegate = self
        geoCodeSearch?.delegate = self
    }
    
    /*
     * 定位 回调
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

        guard let flg = geoCodeSearch?.reverseGeoCode(reverseGeoCodeOption) else { print("坐标解析失败"); return  }
        
 
        let loca = BMKUserLocation()
        loca.location = CLLocation(latitude: lo.latitude, longitude: lo.longitude)
        
        mapView.setCenter(CLLocationCoordinate2D(latitude: lo.latitude , longitude: lo.longitude), animated: true)
        mapView.updateLocationData(loca)
    }
}

//MARK: - 逆地理编码 回调（BMKGeoCodeSearchDelegate）
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

//MARK: - 地址编码
extension AccidentMapSelectViewController{
    
    func searchAddress(_ addressStr:String) {
        geoCoder.geocodeAddressString(addressStr) { (pls: [CLPlacemark]?, error: Error?)  in
            if error == nil {
                print("地理编码成功")
                guard let plsResult = pls else {return}
                let firstPL = plsResult.first
                let reverseGeoCodeOption = BMKReverseGeoCodeSearchOption()
                reverseGeoCodeOption.location = CLLocationCoordinate2D(latitude: (firstPL?.location?.coordinate.latitude)!, longitude:(firstPL?.location?.coordinate.longitude)!)
                guard let flg = self.geoCodeSearch?.reverseGeoCode(reverseGeoCodeOption) else { print("坐标解析失败"); return }
            }else {
                print("错误")
            }
        }
    }
}


//MARK: - UISearchBarDelegate
extension AccidentMapSelectViewController:UISearchBarDelegate{
    
    /*
     * 设置 搜索bar中的 取消按钮 为 中文
     */
    public func initCancelBtn() {
        UIView.animate(withDuration: 0.4) {
            self.searchBar.showsCancelButton = true
            for v in self.searchBar.subviews {
                for _v in v.subviews {
                    if let _cls = NSClassFromString("UINavigationButton") {
                        if _v.isKind(of: _cls) {
                            guard let btn = _v as? UIButton else { return }
                            btn.setTitle("取消", for: .normal)
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
        // 设置取消按钮
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
        //实时 搜索
        guard searchText != "" else {
            return
        }
        let search = BMKSuggestionSearch()
        search.delegate = self
        
        //初始化请求参数类BMKSuggestionSearchOption的实例
        let suggestionOption = BMKSuggestionSearchOption()
        //城市名
        suggestionOption.cityname = "济南"
        //检索关键字
        suggestionOption.keyword = searchText
        suggestionOption.cityLimit = false
        
        let flag = search.suggestionSearch(suggestionOption)
        if flag {
            print("关键词检索成功")
        } else {
            print("关键词检索失败")
        }
        
    }
}

//MARK: - 给地图添加拖拽 手
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
     关键字检索结果回调
     
     @param searcher 检索对象
     @param result 关键字检索结果
     @param error 错误码，@see BMKCloudErrorCode
     */
    public func onGetSuggestionResult(_ searcher: BMKSuggestionSearch!, result: BMKSuggestionSearchResult!, errorCode error: BMKSearchErrorCode) {
        if (error == BMK_SEARCH_NO_ERROR) {
            //在此处理正常结果
            weak var weakSelf = self
            if result.suggestionList.count > 0 {
                weakSelf?.searchArray = result.suggestionList
                weakSelf?.searchTableView.reloadData()
            }else{
                weakSelf?.searchArray.removeAll()
                weakSelf?.searchTableView.reloadData()
            }
        }else {
            print("检索失败");
        }
    }
}
