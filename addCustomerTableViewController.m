//
//  addCustomerTableViewController.m
//  CRM
//
//  Created by Mac on 15/8/5.
//  Copyright (c) 2015年 crmTeam. All rights reserved.
//

#import "addCustomerTableViewController.h"
#import "DetailTitleTableViewController.h"
#import "crmSoap.h"
#import "softUser.h"
#import "dateToString.h"
@interface addCustomerTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *customerLevelLabel;//客户级别标签
@property (weak, nonatomic) IBOutlet UILabel *parentCustomerLabel;
@property (weak, nonatomic) IBOutlet UILabel *departmentLabel;//客户部门标签
@property (weak, nonatomic) IBOutlet UILabel *customerTefieldLabel;//客户行业
@property (weak, nonatomic) IBOutlet UITextField *customerNameText;//客户姓名
@property (weak, nonatomic) IBOutlet UITextField *customerAddrText;//客户地址
@property (weak, nonatomic) IBOutlet UITextField *cutomerPhoneText;//客户电话
@property (weak, nonatomic) IBOutlet UITextField *custoemrPostCodeText;//客户邮编
@property (weak, nonatomic) IBOutlet UITextField *companyUrlText;//客户公司网址
@property (weak, nonatomic) IBOutlet UITextField *customerFaxText;//客户传真
@property (weak, nonatomic) IBOutlet UITextField *departmentText;//客户部门
@property (weak, nonatomic) IBOutlet UITextField *customerMoneyText;//客户销售额
@property (weak, nonatomic) IBOutlet UITextView *customerRemarkText;//客户备注

@property(strong,nonatomic)crmSoap *soap;


@property(strong,nonatomic)NSDictionary *customerLevelDic;//包涵一条客户级别的信息
@property(strong,nonatomic)NSDictionary *parentCustomerDic;//包涵一条上级客户的信息
@property(strong,nonatomic)NSDictionary *departmentDic;//包涵一条部门的信息
@property(strong,nonatomic)NSDictionary *customerFieldDic;//包涵一条客户行业的信息
@end

@implementation addCustomerTableViewController

- (IBAction)saveCustomerInfoAndAdd:(id)sender {
    _soap=[[crmSoap alloc]init];
    _soap.soapDelgate=self;
    softUser *Localuser=[softUser sharedLocaluserUserByDictionary:nil];
    NSString *departId=[_departmentDic objectForKey:@"Department_Id"];
    NSString *LevelId=[_customerLevelDic objectForKey:@"CustomerLevel_Id"];
    NSString *feildId=[_customerFieldDic objectForKey:@"CustomerField_Id"];
    int uid=Localuser.userId.intValue;
    NSString *uName=Localuser.userName;
    float money=_customerMoneyText.text.floatValue;
    NSString *cdate=[dateToString dateToString:[NSDate date]];
    
    [_soap addCustomer:65432 Name:_customerNameText.text ParenrCusId:0 userId:uid departId:departId.intValue LevelId:LevelId.intValue feildId:feildId.intValue Money:money compUrl:_companyUrlText.text Tel:_cutomerPhoneText.text Addr:_customerAddrText.text Remark:_customerRemarkText.text postcode:_custoemrPostCodeText.text Fax:_customerFaxText.text cDate:cdate cPerson:uName mDate:cdate mPerson:uName];
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma -mark crmdelegate
-(void)doWhenEcardGetInfoFromWebServier:(NSString *)soapresult getWhatInfo:(NSString *)getwhat
{
    if (![soapresult isEqualToString:@"成功"]) {
        UIAlertView *alrtview=[[UIAlertView alloc]initWithTitle:nil message:@"插入失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alrtview show];
    }
    
}
-(void)doWhenHttpCollecttionFalil:(NSError *)error
{
    UIAlertView *alrtview=[[UIAlertView alloc]initWithTitle:nil message:[error localizedDescription] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alrtview show];
}
#pragma -mark 设置客户级别，行业，部门label的值
-(void)SetCustomerLevelLabelValue:(NSNotification *) notification
{
    _customerLevelDic=[notification userInfo];
    self.customerLevelLabel.text=[_customerLevelDic objectForKey:@"CustomerLevel_Name"];
    
}
//-(void)SetParentCustomerLabelValue:(NSNotification *) notification
//{
//    _parentCustomerDic=[notification userInfo];
//    self.parentCustomerLabel.text=[_parentCustomerDic objectForKey:@"Department_Name"];
//    
//}
-(void)SetcustomerFieldLabelValue:(NSNotification *) notification
{
    _customerFieldDic=[notification userInfo];
    self.customerTefieldLabel.text=[_customerFieldDic objectForKey:@"CustomerField_Name"];
    
}
-(void)SetDepartmentLabelLabelValue:(NSNotification *) notification
{
    _departmentDic=[notification userInfo];
    self.departmentLabel.text=[_departmentDic objectForKey:@"Department_Name"];
}

#pragma -mark viewMethod
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //注册通知，当在detailVc中选择某个值时将发送这些通知，这边注册通知，接受传过来的额数据

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SetcustomerFieldLabelValue:) name:@"CustomerField_Name" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SetCustomerLevelLabelValue:) name:@"CustomerLevel_Name" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SetDepartmentLabelLabelValue:) name:@"Department_Name" object:nil];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


#pragma -mark tableviewdelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
          DetailTitleTableViewController *deVc=[[DetailTitleTableViewController alloc]init];
        if (indexPath.row==1) {
            deVc.getWhat=@"CustomerLevel";
            [self.navigationController pushViewController:deVc animated:YES];
        }
        if (indexPath.row==2) {
            deVc.getWhat=@"CustomerField";
            [self.navigationController pushViewController:deVc animated:YES];
        }
 
       
    }
    if (indexPath.section==4) {
        DetailTitleTableViewController *deVc=[[DetailTitleTableViewController alloc]init];
        if (indexPath.row==0) {
            deVc.getWhat=@"Department";
        }
        [self.navigationController pushViewController:deVc animated:YES];
    }

}

#pragma -mark textfieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
