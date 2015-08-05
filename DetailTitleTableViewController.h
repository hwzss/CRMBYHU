//
//  DetailTitleTableViewController.h//客户级别，部门，上级客户选择视图
//  CRM
//
//  Created by Mac on 15/8/4.
//  Copyright (c) 2015年 crmTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "crmDelegate.h"

@interface DetailTitleTableViewController : UITableViewController<crmDelegate>
@property(strong,nonatomic)NSString *getWhat;//判断该视图是显示那种类型数据
@end
