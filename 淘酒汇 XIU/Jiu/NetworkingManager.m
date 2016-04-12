

#import "NetworkingManager.h"
#import "UIActivityIndicatorView+AFNetworking.h"
#import "Model.h"
static NetworkingManager* manager = nil;

@implementation NetworkingManager

+(NetworkingManager*) sharedInstance{
    static NetworkingManager *sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSingleton = [[self alloc] initialize];
    });
    return sharedSingleton;
}

-(id)initialize{
    if(self == [super init]){
        _manager = [AFHTTPRequestOperationManager manager];
    }
    return self;
}


/** molly 15/10/30 更新方法 (model里加了一个参数)
 */
-(void) asyncTask:(UIView*)rootView withOperator:(BaseOperator*) operate withSuccessCallBack:(void (^)(BaseModel* model))successCallback andFaildCallBack:(void(^)(id response))faildCallback{
    _jsonDelegate = operate;
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _manager.requestSerializer.timeoutInterval = 30;
    
    [_manager GET:operate.url parameters:operate.paramsDic success:^void(AFHTTPRequestOperation * __nonnull operation, id __nonnull responseObject) {
        
        NSLog(@"url -- %@",operate.url);
        BaseModel* baseModel = [[BaseModel alloc] init];
       // baseModel.retDataStr = requestTmp;
        
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        //判断json转化后是否为字典
        if (resultDic && [resultDic isKindOfClass:[NSDictionary class]]) {
            
            baseModel.data = resultDic;

        }else{
            baseModel.data = @{@"ret":operation.responseString};
            baseModel.retArr = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        }
      
        [_jsonDelegate parseJson:baseModel];

        successCallback(baseModel);
    } failure:^void(AFHTTPRequestOperation * __nonnull operation, NSError * __nonnull error) {
        NSLog(@"Error: %@", error);
        faildCallback(error);
    }];
}
/**接收短信必须用post 所以此处增加POST 方法
 * molly 16/01/21
 */
-(void) asyncPostTask:(UIView*)rootView withOperator:(BaseOperator*) operate withSuccessCallBack:(void (^)(BaseModel* model))successCallback andFaildCallBack:(void(^)(id response))faildCallback{
    _jsonDelegate = operate;
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _manager.requestSerializer.timeoutInterval = 30;
    
    [_manager POST:operate.url parameters:operate.paramsDic success:^void(AFHTTPRequestOperation * __nonnull operation, id __nonnull responseObject) {
        
        NSLog(@"url -- %@",operate.url);
        BaseModel* baseModel = [[BaseModel alloc] init];
        // baseModel.retDataStr = requestTmp;
        
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        //判断json转化后是否为字典
        if (resultDic && [resultDic isKindOfClass:[NSDictionary class]]) {
            
            baseModel.data = resultDic;
            
        }else{
            baseModel.data = @{@"ret":operation.responseString};
            baseModel.retArr = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        }
        
        [_jsonDelegate parseJson:baseModel];
        
        successCallback(baseModel);
    } failure:^void(AFHTTPRequestOperation * __nonnull operation, NSError * __nonnull error) {
        NSLog(@"Error: %@", error);
        faildCallback(error);
    }];
}/** molly 15/10/30
 *
-(void) asyncTask:(UIView*)rootView withOperator:(BaseOperator*) operate withSuccessCallBack:(void (^)(BaseModel* model))successCallback andFaildCallBack:(void(^)(id response))faildCallback{
    _jsonDelegate = operate;
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    _manager.requestSerializer.timeoutInterval = 3;

    [_manager POST:operate.url.absoluteString parameters:operate.paramsDic success:^void(AFHTTPRequestOperation * __nonnull operation, id __nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        BaseModel* baseModel = [[BaseModel alloc] init];
        baseModel.data = resultDic;
        [_jsonDelegate parseJson:baseModel];
        
        successCallback(baseModel);
    } failure:^void(AFHTTPRequestOperation * __nonnull operation, NSError * __nonnull error) {
        NSLog(@"Error: %@", error);
        faildCallback(error);
    }];
}
*/
-(void)quit{
    [_manager.operationQueue cancelAllOperations];
}

@end
