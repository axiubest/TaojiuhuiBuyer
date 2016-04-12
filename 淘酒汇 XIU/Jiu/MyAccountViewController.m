//
//  MyAccountViewController.m
//  Jiu
//
//  Created by 张熔冰 on 15/9/15.
//  Copyright © 2015年 NTTDATA. All rights reserved.
//

#import "MyAccountViewController.h"

#import "SignOut.h"

#import "NetworkingManager.h"
#import "GetDetailOperator.h"
#import "UserModel.h"
@interface MyAccountViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)pressSignOutBtn:(UIButton *)sender;
//@property(nonatomic,strong)NSMutableDictionary* detailData;
@property(nonatomic,strong)UserModel* user;
@end

@implementation MyAccountViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的账户";
    _tableData = @[@[@"头像",@"用户名",@"性别",@"出生日期",],@[@"账户安全",@"我的积分"]];
//    _detailData = [NSMutableDictionary dictionary];
    _user = [[UserModel alloc] init];
    _user.name = @"无";
    _user.gander = @"保密";
    _user.birthday = @"无";
    
    [self requestMyInfo];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_tableData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[_tableData objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
//    if (indexPath.section == 0 && indexPath.row ==0) {
//        UIButton* userImage = [[UIButton alloc] initWithFrame:CGRectMake(cell.contentView.frame.size.width-72, 4, 72, 72)];
//        [userImage.layer setMasksToBounds:YES];
//        [userImage.layer setCornerRadius:36];
//        [userImage setBackgroundColor:[UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:1]];
//        [userImage setImage:[UIImage imageNamed:@"my"] forState:UIControlStateNormal];
//        [cell.contentView addSubview:userImage];
//        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    }
    
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.text = [[_tableData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //cell.detailTextLabel.text = @"111";
    if (indexPath.section == 0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        switch (indexPath.row) {
            case 0:{
                //头像
                UIButton* userImage = [[UIButton alloc] initWithFrame:CGRectMake(cell.contentView.frame.size.width-72, 4, 72, 72)];
                [userImage.layer setMasksToBounds:YES];
                [userImage.layer setCornerRadius:36];
                [userImage setBackgroundColor:[UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:1]];
                [userImage setImage:[UIImage imageNamed:@"my"] forState:UIControlStateNormal];
//                [cell.contentView addSubview:userImage];
                cell.accessoryView = userImage;
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                
                break;
            }
            case 1:{
                cell.detailTextLabel.text = _user.name;
                break;
            }
            case 2:{
                NSString* sex = @"";
                switch ([_user.gander intValue]) {
                    case 1:{
                        sex = @"男";
                        break;
                    }
                    case 2:{
                        sex = @"女";
                        break;
                    }
                    case 3:{
                        sex = @"保密";
                        break;
                    }
                    default:
                        break;
                }
                cell.detailTextLabel.text = sex;
                break;
            }
            case 3:{
                cell.detailTextLabel.text = _user.birthday;
                break;
            }
                
            default:
                break;
        }
    }
//    if (indexPath.section == 0&& indexPath.row == 1) {
//
//        cell.detailTextLabel.text = [_detailData objectForKey:@"telephone"];
//    }
//    
//    if (indexPath.section == 1&& indexPath.row == 1) {
//        cell.detailTextLabel.text = [_detailData objectForKey:@"credit"];
//    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row ==0) {
        return 80.f;
    }
    return 44.f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressSignOutBtn:(UIButton *)sender {
    SignOut* signOut = [[SignOut alloc]init];
    [signOut signOut:self.navigationController thisView:self.view];

}

#pragma mark -public
/**请求获取用户信息
 http://www.taojiuhui.cn/home/Api/manageopenapi?action=getuserinfo&uid=24&json=1
 */
- (void)requestMyInfo{

//    NSString* uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    GetDetailOperator* detailOperator = [[GetDetailOperator alloc]initWithParamsDic:@{@"action":@"getuserinfo",@"uid":_uid,@"json":@"1"}];
    NetworkingManager* manager = [NetworkingManager sharedInstance];
    
    [manager asyncTask:self.view withOperator:detailOperator withSuccessCallBack:^(BaseModel *model) {
        
        //_detailData = detailOperator.detailData;
        _user = detailOperator.user;
        [_tableView reloadData];
    } andFaildCallBack:^(id response) {
        
    }];
    
}
@end


