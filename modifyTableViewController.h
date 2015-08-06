//
//  modifyTableViewController.h
//  CRM
//
//  Created by Mac on 15/8/6.
//  Copyright (c) 2015年 crmTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "crmDelegate.h"

@interface modifyTableViewController : UITableViewController<crmDelegate,UITextFieldDelegate>
@property(strong,nonatomic)NSMutableDictionary *customerDic;

@end
