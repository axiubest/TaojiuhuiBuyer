//
//  CityPickerView.h
//  ECTECTIphone
//
//  Created by Aaroneric on 15/6/17.
//
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger {
    CHComponentProvince,
    CHComponentCity,
    CHComponentArea
} CHComponentList;

@protocol CityPickerViewDelegate <NSObject>

- (void)CityPickerViewDidPickProvince:(NSString *)provincecode City:(NSString *)citycode Area:(NSString *)areacode cityallname:(NSString *)name proviceName:(NSString *)provicename cityName:(NSString *)cityname areaName:(NSString *)areaname;

@end

@interface CityPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIToolbar *myToolbar;
@property (weak, nonatomic) IBOutlet UIPickerView *pickview;
@property (nonatomic,strong) NSMutableArray * provinceArry;
@property (nonatomic,strong) NSMutableArray * cityArry;
@property (nonatomic,strong) NSMutableArray * areaArry;
@property (nonatomic,strong) UIBarButtonItem * conform;
@property (nonatomic,strong) id<CityPickerViewDelegate>delegate;
@property (nonatomic) BOOL ischanging;
@property (nonatomic) NSInteger firstComponentRow;
@property (nonatomic) NSInteger secondComponentRow;
@property (nonatomic) NSInteger thirdComponentRow;

@property(nonatomic,strong)NSString* proviceName;
@property(nonatomic,strong)NSString* cityName;
@property(nonatomic,strong)NSString* areaName;

+(CityPickerView *)instanceTextView;
- (void)initData;
- (void)rolltoProvince:(NSString *)provincecode City:(NSString *)citycode Area:(NSString *)areacode;


@end
