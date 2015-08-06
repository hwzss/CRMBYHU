//
//  modifyTableViewController.m
//  CRM
//
//  Created by Mac on 15/8/6.
//  Copyright (c) 2015年 crmTeam. All rights reserved.
//

#import "modifyTableViewController.h"
#import "crmSoap.h"
@interface modifyTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *Customer_NameText;
@property (weak, nonatomic) IBOutlet UITextField *Customer_AddrText;
@property (weak, nonatomic) IBOutlet UITextField *Customer_TelText;
@property (weak, nonatomic) IBOutlet UILabel *CustomerLevel_IdLabel;
@property (weak, nonatomic) IBOutlet UITextField *Post_CodeText;
@property (weak, nonatomic) IBOutlet UITextField *Company_UrlText;
@property (weak, nonatomic) IBOutlet UITextField *FaxText;
@property (weak, nonatomic) IBOutlet UITextField *ParentCustomer_IdText;
@property (weak, nonatomic) IBOutlet UITextField *MoneyText;
@property (weak, nonatomic) IBOutlet UILabel *Department_IdLabel;
@property (weak, nonatomic) IBOutlet UITextView *RemarkTextView;

@property (weak, nonatomic) IBOutlet UILabel *CustomerField_IdLabel;


@property(strong,nonatomic)crmSoap *soap;


@property(strong,nonatomic)NSDictionary *customerLevelDic;//包涵一条客户级别的信息
@property(strong,nonatomic)NSDictionary *parentCustomerDic;//包涵一条上级客户的信息
@property(strong,nonatomic)NSDictionary *departmentDic;//包涵一条部门的信息
@property(strong,nonatomic)NSDictionary *customerFieldDic;//包涵一条客户行业的信息
@end

@implementation modifyTableViewController
- (IBAction)updateCustomerInfo:(id)sender {
    
}
#pragma -mark crmdeldelegate
-(void)doWhenEcardGetInfoFromWebServier:(NSString *)soapresult getWhatInfo:(NSString *)getwhat{
    
}
-(void)doWhenHttpCollecttionFalil:(NSError *)error
{
    
}


-(void)resetView:(NSMutableDictionary *)dic{//将详细资料界面的客户资料详细展示到tableview 上
    
    _Customer_AddrText.text=[dic objectForKey:@"Customer_Addr"];
    _Customer_NameText.text=[dic objectForKey:@"Customer_Name"];
    _Customer_TelText.text=[dic objectForKey:@"Customer_Tel"];
    _CustomerLevel_IdLabel.text=[dic objectForKey:@"CustomerLevel_Id"];
    _Post_CodeText.text=[dic objectForKey:@"Post_Code"];
    _Company_UrlText.text=[dic objectForKey:@"Company_Url"];
    _FaxText.text=[dic objectForKey:@"FaxText"];
    _ParentCustomer_IdText.text=[dic objectForKey:@"ParentCustomer_Id"];
    _MoneyText.text=[dic objectForKey:@"MoneyText"];
    _Department_IdLabel.text=[dic objectForKey:@"Department_Id"];
    _RemarkTextView.text=[dic objectForKey:@"RemarkTextView"];
    _CustomerField_IdLabel.text=[dic objectForKey:@"CustomerField_Id"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetView:_customerDic];
    
}


#pragma -mark  textFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
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
#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    // Return the number of sections.
//    return 5;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (section==0) {
//        return 3;
//    }
//    if (section==1) {
//        return 5;
//    }
//    if (section==2) {
//        return 2;
//    }
//    if (section==3) {
//        return 1;
//    }
//    return 1;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
//    
//    
//    
//    
//    return cell;
//}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
