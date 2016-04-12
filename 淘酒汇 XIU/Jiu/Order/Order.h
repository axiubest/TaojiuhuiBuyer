//
//  Order.h
//  AlixPayDemo
//
//  Created by 方彬 on 11/2/13.
//
//

#import <Foundation/Foundation.h>
#import "AddressModel.h"
@interface Order : NSObject

@property(nonatomic, copy) NSString * partner;
@property(nonatomic, copy) NSString * seller;
//@property(nonatomic, copy) NSString * tradeNO;
@property(nonatomic, copy) NSString * productName;
@property(nonatomic, copy) NSString * productDescription;
//@property(nonatomic, copy) NSString * amount;
@property(nonatomic, copy) NSString * notifyURL;

@property(nonatomic, copy) NSString * service;
@property(nonatomic, copy) NSString * paymentType;
@property(nonatomic, copy) NSString * inputCharset;
@property(nonatomic, copy) NSString * itBPay;
@property(nonatomic, copy) NSString * showUrl;
@property(nonatomic,strong)NSString* total_fee;

@property(nonatomic, copy) NSString * rsaDate;//可选
@property(nonatomic, copy) NSString * appID;//可选

@property(nonatomic, readonly) NSMutableDictionary * extraParams;


//@property(nonatomic,strong)NSString* orderNo;
@property(nonatomic,copy)NSString* orderId;
@property(nonatomic,copy)NSString* address;
@property(nonatomic,copy)NSString* body;
@property(nonatomic,strong)NSMutableArray* productArr;
@property(nonatomic,strong)NSMutableArray* addressArr;
@property(nonatomic,strong)AddressModel* defaultAddress;
@property(nonatomic,strong)NSString* payWay;
@property(nonatomic,strong)NSString* time;
@property(nonatomic,strong)NSString* status;
@end
