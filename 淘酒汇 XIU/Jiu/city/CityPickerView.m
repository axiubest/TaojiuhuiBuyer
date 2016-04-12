//
//  CityPickerView.m
//  ECTECTIphone
//
//  Created by Aaroneric on 15/6/17.
//
//

#import "CityPickerView.h"
#import "FMDB.h"

@implementation CityPickerView

+(CityPickerView *)instanceTextView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"CityPickerView" owner:nil options:nil];
    
    return [nibView objectAtIndex:0];
}

- (void)initData
{
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    self.provinceArry = [[NSMutableArray alloc] init];
    self.cityArry = [[NSMutableArray alloc] init];
    self.areaArry = [[NSMutableArray alloc] init];
    self.firstComponentRow = 0;
    self.secondComponentRow = 0;
    self.thirdComponentRow = 0;
    NSString* dbPath = [[NSBundle mainBundle] pathForResource:@"citys.db" ofType:nil];
    //    NSString *dbPath = [self getFilePath:@"citys"];
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    if (![database open]) {
        return;
    }
    FMResultSet *resultSet = [database executeQuery:@"select * from jdp_org where level = 1"];
    while ([resultSet next]) {
        NSString *cityName = [resultSet stringForColumn:@"orgname"];
        NSString *cityCode = [resultSet stringForColumn:@"orgcode"];
        NSString *precityCode = [resultSet stringForColumn:@"porgcode"];
        NSMutableDictionary * infodic = [[NSMutableDictionary alloc] init];
        [infodic setValue:cityName forKey:@"orgname"];
        [infodic setValue:cityCode forKey:@"orgcode"];
        [infodic setValue:precityCode forKey:@"porgcode"];
        [self.provinceArry addObject:infodic];
    }
    
    FMResultSet *resultSet2 = [database executeQuery:@"select * from jdp_org where level = 2 and porgcode = 110000"];
    while ([resultSet2 next]) {
        NSString *cityName = [resultSet2 stringForColumn:@"orgname"];
        NSString *cityCode = [resultSet2 stringForColumn:@"orgcode"];
        NSString *precityCode = [resultSet2 stringForColumn:@"porgcode"];
        NSMutableDictionary * infodic = [[NSMutableDictionary alloc] init];
        [infodic setValue:cityName forKey:@"orgname"];
        [infodic setValue:cityCode forKey:@"orgcode"];
        [infodic setValue:precityCode forKey:@"porgcode"];
        [self.cityArry addObject:infodic];
    }
    
    FMResultSet *resultSet3 = [database executeQuery:@"select * from jdp_org where level = 3 and porgcode = 110100"];
    while ([resultSet3 next]) {
        NSString *cityName = [resultSet3 stringForColumn:@"orgname"];
        NSString *cityCode = [resultSet3 stringForColumn:@"orgcode"];
        NSString *precityCode = [resultSet3 stringForColumn:@"porgcode"];
        NSMutableDictionary * infodic = [[NSMutableDictionary alloc] init];
        [infodic setValue:cityName forKey:@"orgname"];
        [infodic setValue:cityCode forKey:@"orgcode"];
        [infodic setValue:precityCode forKey:@"porgcode"];
        [self.areaArry addObject:infodic];
    }
    [database close];
    
    NSMutableArray *btnArray = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *fixedHead = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedHead.width = 20;
    
    UIBarButtonItem *fixedFoot = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedFoot.width = 20;
    
    UIBarButtonItem *fixedCenter = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.conform = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(onClickSwitch:)];
    
    [btnArray addObject:fixedHead];
    [btnArray addObject:[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonSystemItemCancel target:self action:@selector(onClickCancel:)]];
    
    [btnArray addObject:fixedCenter];
    [btnArray addObject:self.conform];
    
    [btnArray addObject:fixedFoot];
    
    [self.myToolbar setItems:btnArray];
    
    self.pickview.delegate = self;
    self.pickview.dataSource = self;
    [self.pickview reloadAllComponents];
    
//    return cview;
}

- (void)rolltoProvince:(NSString *)provincecode City:(NSString *)citycode Area:(NSString *)areacode
{
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    self.provinceArry = [[NSMutableArray alloc] init];
    self.cityArry = [[NSMutableArray alloc] init];
    self.areaArry = [[NSMutableArray alloc] init];
    self.firstComponentRow = 0;
    self.secondComponentRow = 0;
    self.thirdComponentRow = 0;
    NSString* dbPath = [[NSBundle mainBundle] pathForResource:@"citys" ofType:@"db"];
    //    NSString *dbPath = [self getFilePath:@"citys"];
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    if (![database open]) {
        return;
    }
    
    NSInteger firstindex = 0;
    
    FMResultSet *resultSet = [database executeQuery:@"select * from jdp_org where level = 1"];
    while ([resultSet next]) {
        NSString *cityName = [resultSet stringForColumn:@"orgname"];
        NSString *cityCode = [resultSet stringForColumn:@"orgcode"];
        NSString *precityCode = [resultSet stringForColumn:@"porgcode"];
        NSMutableDictionary * infodic = [[NSMutableDictionary alloc] init];
        [infodic setValue:cityName forKey:@"orgname"];
        [infodic setValue:cityCode forKey:@"orgcode"];
        [infodic setValue:precityCode forKey:@"porgcode"];
        
        [self.provinceArry addObject:infodic];
        if ([cityCode isEqualToString:provincecode]) {
            firstindex = [self.provinceArry indexOfObject:infodic];
            self.firstComponentRow = firstindex;
        }
    }
    
    //    [self.pickview selectRow:firstindex inComponent:0 animated:NO];
    
    NSInteger secondindex = 0;
    
    FMResultSet *resultSet2 = [database executeQuery:[NSString stringWithFormat:@"select * from jdp_org where level = 2 and porgcode = %@",provincecode]];
    while ([resultSet2 next]) {
        NSString *cityName = [resultSet2 stringForColumn:@"orgname"];
        NSString *cityCode = [resultSet2 stringForColumn:@"orgcode"];
        NSString *precityCode = [resultSet2 stringForColumn:@"porgcode"];
        NSMutableDictionary * infodic = [[NSMutableDictionary alloc] init];
        [infodic setValue:cityName forKey:@"orgname"];
        [infodic setValue:cityCode forKey:@"orgcode"];
        [infodic setValue:precityCode forKey:@"porgcode"];
        
        [self.cityArry addObject:infodic];
        if ([cityCode isEqualToString:citycode]) {
            secondindex = [self.cityArry indexOfObject:infodic];
            self.secondComponentRow = secondindex;
        }
    }
    
    //    [self.pickview selectRow:secondindex inComponent:1 animated:NO];
    
    NSInteger thirdindex = 0;
    
    FMResultSet *resultSet3 = [database executeQuery:[NSString stringWithFormat:@"select * from jdp_org where level = 3 and porgcode = %@",citycode]];
    while ([resultSet3 next]) {
        NSString *cityName = [resultSet3 stringForColumn:@"orgname"];
        NSString *cityCode = [resultSet3 stringForColumn:@"orgcode"];
        NSString *precityCode = [resultSet3 stringForColumn:@"porgcode"];
        NSMutableDictionary * infodic = [[NSMutableDictionary alloc] init];
        [infodic setValue:cityName forKey:@"orgname"];
        [infodic setValue:cityCode forKey:@"orgcode"];
        [infodic setValue:precityCode forKey:@"porgcode"];
        [self.areaArry addObject:infodic];
        if ([cityCode isEqualToString:areacode]) {
            thirdindex = [self.areaArry indexOfObject:infodic];
            self.thirdComponentRow = thirdindex;
        }
    }
    
    //    [self.pickview selectRow:thirdindex inComponent:2 animated:NO];
    [database close];
    
    NSMutableArray *btnArray = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *fixedHead = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedHead.width = 20;
    
    UIBarButtonItem *fixedFoot = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedFoot.width = 20;
    
    UIBarButtonItem *fixedCenter = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.conform = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(onClickSwitch:)];
    
    [btnArray addObject:fixedHead];
    [btnArray addObject:[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonSystemItemCancel target:self action:@selector(onClickCancel:)]];
    
    [btnArray addObject:fixedCenter];
    [btnArray addObject:self.conform];
    
    [btnArray addObject:fixedFoot];
    
    [self.myToolbar setItems:btnArray];
    
    self.pickview.delegate = self;
    self.pickview.dataSource = self;
    [self.pickview reloadAllComponents];
}

- (void)onClickCancel:(id)sender
{
    [self removeFromSuperview];
}

- (void)onClickSwitch:(id)sender
{
    if ([_delegate respondsToSelector:@selector(CityPickerViewDidPickProvince:City:Area:cityallname:proviceName:cityName:areaName:)]) {
        NSString * provincecode = [[self.provinceArry objectAtIndex:self.firstComponentRow] objectForKey:@"orgcode"];
        NSString * citycode = self.cityArry.count ? [[self.cityArry objectAtIndex:self.secondComponentRow] objectForKey:@"orgcode"] : @"";
        NSString * areacode = self.areaArry.count ? [[self.areaArry objectAtIndex:self.thirdComponentRow] objectForKey:@"orgcode"] : @"";
        
        NSString * provincename = [[self.provinceArry objectAtIndex:self.firstComponentRow] objectForKey:@"orgname"];
        NSString * cityname = self.cityArry.count ? [[self.cityArry objectAtIndex:self.secondComponentRow] objectForKey:@"orgname"] : @"";
        NSString * areaname = self.areaArry.count ? [[self.areaArry objectAtIndex:self.thirdComponentRow] objectForKey:@"orgname"] : @"";
        
        NSString * cityallname = [NSString stringWithFormat:@"%@ %@ %@",provincename,cityname,areaname];
        
        [_delegate CityPickerViewDidPickProvince:provincecode City:citycode Area:areacode cityallname:cityallname proviceName:provincename cityName:cityname areaName:areaname];
    }
    [self removeFromSuperview];
}

- (void)selectDB:(NSInteger)level andporgcode:(NSString *)porgcode
{
    NSString* dbPath = [[NSBundle mainBundle] pathForResource:@"citys" ofType:@"db"];
    //    NSString *dbPath = [self getFilePath:@"citys"];
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    if (![database open]) {
        return;
    }
    
    switch (level) {
        case 0:
        {
            [self.cityArry removeAllObjects];
            [self.areaArry removeAllObjects];
            [self.pickview reloadComponent:CHComponentArea];
        }
            break;
        case 1:
        {
            [self.areaArry removeAllObjects];
        }
            break;
            
        default:
            break;
    }
    
    //    NSString * sqlstr = [NSString stringWithFormat:@"select * from jdp_org where level = %ld and porgcode = %@",(long)level,porgcode];
    NSString * sqlstr = [NSString stringWithFormat:@"select * from jdp_org where porgcode = %@",porgcode];
    FMResultSet *resultSet = [database executeQuery:sqlstr];
    while ([resultSet next]) {
        NSString *cityName = [resultSet stringForColumn:@"orgname"];
        NSString *cityCode = [resultSet stringForColumn:@"orgcode"];
        NSString *precityCode = [resultSet stringForColumn:@"porgcode"];
        NSMutableDictionary * infodic = [[NSMutableDictionary alloc] init];
        [infodic setValue:cityName forKey:@"orgname"];
        [infodic setValue:cityCode forKey:@"orgcode"];
        [infodic setValue:precityCode forKey:@"porgcode"];
        //        [temparry addObject:infodic];
        switch (level) {
            case 0:
            {
                [self.cityArry addObject:infodic];
                [self pickerView:self.pickview didSelectRow:0 inComponent:1];
                [self.pickview reloadComponent:2];
            }
                break;
            case 1:
            {
                [self.areaArry addObject:infodic];
            }
                break;
                
            default:
                break;
        }
    }
    [database close];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:20]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case CHComponentProvince:
        {
            return [[self.provinceArry objectAtIndex:row] objectForKey:@"orgname"];
        }
            break;
        case CHComponentCity:
        {
            return [[self.cityArry objectAtIndex:row] objectForKey:@"orgname"];
        }
            break;
        case CHComponentArea:
        {
            return [[self.areaArry objectAtIndex:row] objectForKey:@"orgname"];
        }
            break;
            
        default:
            break;
    }
    return 0;;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case CHComponentProvince:
        {
            return [self.provinceArry count];
        }
            break;
        case CHComponentCity:
        {
            return [self.cityArry count];
        }
            break;
        case CHComponentArea:
        {
            return [self.areaArry count];
        }
            break;
            
        default:
        {
            return 0;
        }
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    ischanging
    if (component == CHComponentProvince) {
        if (self.provinceArry.count == 0) {
            return;
        }
        self.firstComponentRow = row;
        self.secondComponentRow = 0;
        self.thirdComponentRow = 0;
        [self selectDB:0 andporgcode:[[self.provinceArry objectAtIndex:row] objectForKey:@"orgcode"]];
        [self.pickview reloadComponent:CHComponentCity];
        [self.pickview selectRow:0 inComponent:CHComponentCity animated:YES];
    }
    else if (component == CHComponentCity)
    {
        if (self.cityArry.count == 0) {
            return;
        }
        self.secondComponentRow = row;
        self.thirdComponentRow = 0;
        [self selectDB:1 andporgcode:[[self.cityArry objectAtIndex:row] objectForKey:@"orgcode"]];
        [self.pickview reloadComponent:CHComponentArea];
        [self.pickview selectRow:0 inComponent:CHComponentArea animated:YES];
    }
    else
    {
        self.thirdComponentRow = row;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
