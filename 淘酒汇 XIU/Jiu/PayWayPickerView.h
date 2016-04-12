//
//  PayWayPickerView.h
//  Jiu
//
//  Created by Molly on 16/1/27.
//  Copyright © 2016年 NTTDATA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PayWayPickerViewDelegate <NSObject>
- (void)payWayPickerViewDidPick:(NSString *)payway;

@end
@interface PayWayPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIToolbar *myToolbar;
@property (nonatomic) NSInteger firstComponentRow;
@property(nonatomic,strong)NSArray* pickerDataArr;
@property (nonatomic,strong) UIBarButtonItem * conform;
@property(nonatomic,strong)NSString* payWay;
@property (nonatomic,strong) id<PayWayPickerViewDelegate>delegate;


+(PayWayPickerView *)instanceTextView;
- (void)initData;
@end
