//
//  customerActivitysView.m
//  CRM
//
//  Created by Mac on 15/8/6.
//  Copyright (c) 2015年 crmTeam. All rights reserved.
//

#import "customerActivitysView.h"

@implementation customerActivitysView

#pragma -mark tableviewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataArray) {
        return _dataArray.count;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
   
    NSMutableDictionary *dic=[_dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text=[dic objectForKey:@"Activity_Content"];
    return cell;
}
@end
