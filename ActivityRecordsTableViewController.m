//
//  ActivityRecordsTableViewController.m
//  CRM
//
//  Created by Mac on 15/8/5.
//  Copyright (c) 2015年 crmTeam. All rights reserved.
//

#import "ActivityRecordsTableViewController.h"
#import "softUser.h"
#import "crmSoap.h"
@interface ActivityRecordsTableViewController ()
@property(strong,nonatomic)crmSoap *soap;
@property(strong,nonatomic)NSMutableArray *dataOfResults;//包涵多条活动记录信息数据数组，每天数组是一个字典
@property(strong,nonatomic)NSMutableDictionary *dataDic;
@property(strong,nonatomic)UIAlertView *myalertview;
@end

@implementation ActivityRecordsTableViewController

#pragma -mark crmdelegate
-(void)doWhenEcardGetInfoFromWebServier:(NSString *)soapresult getWhatInfo:(NSString *)getwhat{
    if ([soapresult isEqualToString:@"失败"]) {
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"" message:@"加载失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alertview show];
    }
    else{
        NSData *data=[soapresult dataUsingEncoding:NSUTF8StringEncoding];
        NSError *erro=nil;
        NSMutableDictionary *dataDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&erro];
        if (dataDic) {
            _dataOfResults=[dataDic objectForKey:@"result"];
            [self.tableView reloadData];
            
        }
        else{
            UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"" message:soapresult delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertview show];
        }
    }
    [self.myalertview dismissWithClickedButtonIndex:0 animated:YES];
    
}
-(void)doWhenHttpCollecttionFalil:(NSError *)error{
    UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"加载失败,网络错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertview show];
    [self.myalertview dismissWithClickedButtonIndex:0 animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _soap=[[crmSoap alloc]init];
    _soap.soapDelgate =self;
    [_soap getActivityRecords];
    
    self.myalertview=[[UIAlertView alloc]initWithTitle:@"" message:@"正在加载...." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [self.myalertview show];
   
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return self.dataOfResults.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indentifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    
    NSDictionary *dic=[self.dataOfResults objectAtIndex:indexPath.row];
    cell.textLabel.text=[dic objectForKey:@"Activity_Content"];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

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
