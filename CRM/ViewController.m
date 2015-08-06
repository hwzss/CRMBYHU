//
//  ViewController.m
//  CRM
//
//  Created by hezi on 15/7/28.
//  Copyright (c) 2015年 crmTeam. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path=[[NSBundle mainBundle] pathForResource:@"customerTableList" ofType:@"plist"];
    NSDictionary *dic=[NSDictionary dictionaryWithContentsOfFile:path];
    NSLog(@"%@",[dic objectForKey:@"客户名称"]);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
