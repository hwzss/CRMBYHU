//
//  customerDetailInfoVIew.m
//  CRM
//
//  Created by Mac on 15/8/6.
//  Copyright (c) 2015年 crmTeam. All rights reserved.
//

#import "customerDetailInfoVIew.h"

@implementation customerDetailInfoVIew

-(void)awakeFromNib
{
    _arrayofSection=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"detailCustomer" ofType:@"plist"]];
    NSLog(@"%lu",(unsigned long)_arrayofSection.count);
    
    _dicOfCustomerTable=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"customerTableList" ofType:@"plist"]];
    
}
- (IBAction)modifyCustomerInfo:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeVcToModifyVC" object:nil userInfo:nil];
}
#pragma -amrk tableview 
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    NSLog(@"%ld",(long)section);
    NSDictionary *dic= [_arrayofSection objectAtIndex:section];
    NSString *headert=[dic objectForKey:@"sectionName"];
    return headert;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _arrayofSection.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (_dataArray) {
//        return _dataArray.count;
//    }
    NSDictionary *dic=[_arrayofSection objectAtIndex:section];
    NSArray *arry=[dic objectForKey:@"sectionData"];
//    NSLog(@"%@%d",[arry description],section);
//    NSLog(@"%s%lu",__func__ ,(unsigned long)arry.count);
    return arry.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    NSDictionary *dic=[_arrayofSection objectAtIndex:indexPath.section];
    NSArray *arry=[dic objectForKey:@"sectionData"];
    NSString *mainStr=[arry objectAtIndex:indexPath.row];
    cell.textLabel.text=mainStr;
    NSString *str=[_dataDicOFCustomer objectForKey:[_dicOfCustomerTable objectForKey:mainStr]];
    cell.detailTextLabel.text=str;
    return cell;
}
@end
