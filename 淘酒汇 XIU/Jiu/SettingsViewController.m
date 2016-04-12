//
//  SettingsViewController.m
//  Jiu
//
//  Created by A-XIU on 15/9/14.
//  Copyright (c) 2015年 NTTDATA. All rights reserved.
//
#warning 检测版本功能暂时取消


#import "SettingsViewController.h"

#import "SignOut.h"
@interface SettingsViewController ()
- (IBAction)pressSignOutBtn:(UIButton *)sender;

@end

@implementation SettingsViewController

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
    self.title = @"设置";
    _tableData = @[@[@"关于我们"],@[@"清除缓存",@"APP评分",@"意见反馈"]];
    
    
}
#pragma mark - UItableViewdelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_tableData[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_tableData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    NSString* text = _tableData[indexPath.section][indexPath.row];
    
    cell.textLabel.text = text;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 1 && indexPath.row == 0) {
        cell.detailTextLabel.text = @"包括图片、数据等";
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressSignOutBtn:(UIButton *)sender {
    SignOut* signOut = [[SignOut alloc]init];
    [signOut signOut:self.navigationController thisView:self.view];
//    UILabel* lbl = [[UILabel alloc]init];
//    lbl.frame = CGRectMake(0, 0, 200, 50);
//    lbl.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
//    lbl.textColor = [UIColor whiteColor];
//    lbl.textAlignment = NSTextAlignmentCenter;
//    lbl.backgroundColor = [UIColor blackColor];
//    lbl.alpha = 0.0;
//
//    if([[NSUserDefaults standardUserDefaults] objectIsForcedForKey:@"uid"]){
//    
//        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"系统提示" message:@"您确定要退出吗?" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"uid"];
//            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"tele"];
//        }];
//        UIAlertAction* cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            
//        }];
//        [alert addAction:confirmAction];
//        [alert addAction:cancleAction];
//    
//        [self.navigationController presentViewController:alert animated:YES completion:^{
//           
//            lbl.text = @"您已成功退出";
//            [self.view addSubview:lbl];
//            [UIView animateWithDuration:1.0 animations:^{
//                lbl.alpha = 0.7;
//            } completion:^(BOOL finished) {
//                
//                [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
//                    lbl.alpha = 0.0;
//                } completion:^(BOOL finished) {
//                    [lbl removeFromSuperview];
//                }];
//                
//            }];
//
//        }];
//
//    }else{
//       
//        lbl.text = @"尚未登录";
//        [self.view addSubview:lbl];
//        [UIView animateWithDuration:1.0 animations:^{
//            
//        } completion:^(BOOL finished) {
//           [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
//               lbl.alpha = 0.0;
//           } completion:^(BOOL finished) {
//               [lbl removeFromSuperview];
//           }];
//        }];
//        
//    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

        NSString* text = [[_tableData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if ([text isEqualToString:@"清除缓存"] ||[text  isEqualToString:@"清除缓存"] ) {
        
        
            NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        NSLog(@"%@", documentPath);
    }
}


@end
