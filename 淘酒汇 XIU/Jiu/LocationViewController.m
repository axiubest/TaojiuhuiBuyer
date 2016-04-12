//
//  LocationViewController.m
//  Jiu
//
//  Created by zhangrongbing on 15/9/15.
//  Copyright (c) 2015年 NTTDATA. All rights reserved.
//

#import "LocationViewController.h"
#import <CoreLocation/CoreLocation.h>


#import <MapKit/MapKit.h>


#import "GetLocationOperator.h"
#import "NetworkingManager.h"
#import "AddressPickView.h"
//#import "AddressPick/AddressPickView.h"

@interface LocationViewController ()<CLLocationManagerDelegate, MKMapViewDelegate>{

//    CLLocationManager* _locationManager;
}


/**
 *  选择当前位置按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *NowLocation;


@property(nonatomic,strong)NSString* agentId;
@property(nonatomic,strong)NSString* provice;
@property(nonatomic,strong)NSString* district;
@property(nonatomic,strong)NSString* city;


@property(nonatomic,strong)MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *mgr;




@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"切换地址";
    UIBarButtonItem* backBarBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(pressBackBtn:)];
    
    self.navigationItem.leftBarButtonItem = backBarBtn;
}

-(CLLocationManager *)mgr {
    if (_mgr == nil) {
        _mgr = [[CLLocationManager alloc] init];
    }
    return _mgr;
}
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //    反地理编码
    [geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count == 0 || error) {
            NSLog(@"找不到位置");
            return;
        }
        
        CLPlacemark *pm = [placemarks firstObject];
        _city = pm.locality;
        _provice = pm.administrativeArea;
        _district = pm.subLocality;
        NSLog(@"🍎省＝%@,  市＝%@,  区 ＝ %@",_provice , _city, _district);
        NSUserDefaults *cityDefaults = [NSUserDefaults standardUserDefaults];
        [cityDefaults setObject:_city forKey:@"city"];
        [cityDefaults synchronize];
        
        if (!_city) {
            //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
            _city = pm.administrativeArea;
        }
        NSLog(@"city = %@", _city);
        [self requestLocation];
        
        
        
    }];
    
    
}







-(void)pressBackBtn:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)pressLocatedBtn:(UIButton *)sender {
    
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height * 0.5, self.view.frame.size.height, self.view.frame.size.height * 0.5)];
    self.mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    
    //        设置追踪模式
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    if ([self.mgr respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.mgr requestAlwaysAuthorization];
    }


    
    
    

    // 初始化定位管理器
//    _locationManager = [[CLLocationManager alloc] init];
//    // 设置代理
//    _locationManager.delegate = self;
//    // 设置定位精确度到米
//    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    // 设置过滤器为无
//    _locationManager.distanceFilter = kCLDistanceFilterNone;
//    // 开始定位
//    // 取得定位权限，有两个方法，取决于你的定位使用情况
//    // 一个是requestAlwaysAuthorization，一个是requestWhenInUseAuthorization
//    [_locationManager requestAlwaysAuthorization];//这句话ios8以上版本使用。
//    [_locationManager startUpdatingLocation];
    
}
#pragma mark - 定位
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{

    NSLog(@"newLocation = %@", newLocation);


    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];

    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
#warning ! 没有执行    array值为空
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            
            //获取城市
            _city = placemark.locality;
            _provice = placemark.administrativeArea;
            _district = placemark.subLocality;
            
            
            if (!_city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                _city = placemark.administrativeArea;
            }
            NSLog(@"city = %@", _city);
        }
        else if (error == nil && [array count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
       
        [self requestLocation];

    }];

    
    
    
    
//    系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
    
}
#pragma mark - 请求定位
/**请求定位
 http://www.taojiuhui.cn/home/Api/manageopenapi?
 action=getagentid&region=辽宁省&area=沈阳市&qu=法库县&json=1
 */
- (void)requestLocation{

    NSString* region = [_provice stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString* area = [_city stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString* qu = [_district stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    


    
    
    GetLocationOperator* locationOperator = [[GetLocationOperator alloc] initWithParamsDic:@{@"action":@"getagentid",@"region":region,@"area":area,@"qu":qu,@"json":@"1"}];

    
    NetworkingManager* manager = [NetworkingManager sharedInstance];
    
    [manager asyncTask:self.view withOperator:locationOperator withSuccessCallBack:^(BaseModel *model) {
        
        NSString* agentId = locationOperator.agentId;
        if ([agentId isEqualToString:@"false"]) {
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"系统提示" message:@"对不起该地区暂无信息!" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* cancleAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
                }];
                [alert addAction:cancleAction];
                [self.navigationController presentViewController:alert animated:YES completion:^{
                }];
        }
        else{
            //_agentId = locationOperator.agentId;
            [[NSUserDefaults standardUserDefaults]setObject:agentId forKey:@"agentId"];
//            [[NSUserDefaults standardUserDefaults]setObject:region forKey:@"area"];
            if (self.block) {
                self.block(_city);
            }
             [self dismissViewControllerAnimated:YES completion:nil];
        }
    } andFaildCallBack:^(id response) {
        
    }];
}








#pragma mark 点击选择当前位置
- (IBAction)chickedNowLocationBtn:(UIButton *)sender {
    
    sender.titleLabel.numberOfLines = 0;

    AddressPickView *addressPickView = [AddressPickView shareInstance];
    [self.view addSubview:addressPickView];
    addressPickView.block = ^(NSString *province,NSString *city,NSString *town){

        _city = city;
        _provice = province;
        _district = town;
        
        
        NSUserDefaults *cityDefaults = [NSUserDefaults standardUserDefaults];
        [cityDefaults setObject:_city forKey:@"city"];
        [cityDefaults synchronize];

        
        [self requestLocation];
        
        
        
        _NowLocation.titleLabel.text = [NSString stringWithFormat:@"%@ %@ %@",province,city,town] ;
        
        
    };

    
}




@end
