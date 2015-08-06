//
//  lookingCustoerInfoViewViewController.m
//  CRM
//
//  Created by Mac on 15/8/6.
//  Copyright (c) 2015年 crmTeam. All rights reserved.
//

#import "lookingCustoerInfoViewViewController.h"
#import "modifyTableViewController.h"
#import "customerActivitysView.h"
#import "customerDetailInfoVIew.h"
#import "crmSoap.h"
@interface lookingCustoerInfoViewViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *mySegment;
@property (weak, nonatomic) IBOutlet UIView *myDataView;//数据view
@property(strong,nonatomic) customerActivitysView *activityView;//活动记录view
@property (strong,nonatomic)customerDetailInfoVIew *detailsView;//详细资料view
@property (strong,nonatomic)NSMutableArray *activitiesArrary;
@property(strong,nonatomic)NSMutableDictionary *activitysDIc;
@property(strong,nonatomic)NSMutableDictionary *customerDic;
@property(strong,nonatomic)crmSoap *soap;
@property(strong,nonatomic)crmSoap *soap1;
@end

@implementation lookingCustoerInfoViewViewController
- (IBAction)changeDataView:(UISegmentedControl *)sender {
    switch (self.mySegment.selectedSegmentIndex) {
        case 0:
        {
            _detailsView.hidden=YES;
            _activityView.hidden=NO;
           
            break;
        }
        case 1:
        {
            _detailsView.hidden=NO;
            _activityView.hidden=YES;
        }
        default:
            break;
    }
    CATransition *animation=[CATransition animation];
    animation.type=@"cube";
    animation.duration=0.5;
    [self.myDataView.layer addAnimation:animation forKey:nil];
}

-(void)changeVcToModifyVC//通知委托的方法，该方法提供跳转到修改页面
{
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    modifyTableViewController *modifyVc=[mainStoryboard instantiateViewControllerWithIdentifier:@"modifyVc"];
    modifyVc.customerDic=_customerDic;
//    [[NSNotificationCenter defaultCenter] addObserver:modifyVc selector:@selector(showCustomerDic:) name:@"modifyVc" object:nil];

    [self.navigationController pushViewController:modifyVc animated:YES];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"modifyVc" object:nil userInfo:_customerDic];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeVcToModifyVC)  name:@"changeVcToModifyVC" object:nil];
    _soap=[[crmSoap alloc]init];
    _soap.soapDelgate=self;
    
    _detailsView=[[[NSBundle mainBundle] loadNibNamed:@"customerDetailInfoVIew" owner:nil options:nil] lastObject];
    _detailsView.frame=_myDataView.bounds;
    [_myDataView addSubview:_detailsView];
    _soap.getWhatInfo=@"活动记录";
    [_soap getActivityRecordsByCustomerid:_customerId];
    
    crmSoap *soap1=[[crmSoap alloc]init];
    soap1.soapDelgate=self;
    _activityView=[[[NSBundle mainBundle] loadNibNamed:@"customerActivitysView" owner:nil options:nil] lastObject];
    _activityView.frame=_myDataView.bounds;
    [_myDataView addSubview:_activityView];
 
    [soap1 getCustomerInfoByCustomerId:_customerId getWhatInfo:@"详细资料"];
 
    // Do any additional setup after loading the view.
}
#pragma -mark crmdelegate
-(void)doWhenEcardGetInfoFromWebServier:(NSString *)soapresult getWhatInfo:(NSString *)getwhat{
    if (![soapresult isEqualToString:@"失败"]) {
        if ([getwhat isEqualToString:@"活动记录"]) {
            NSData *data=[soapresult dataUsingEncoding:NSUTF8StringEncoding];
            NSError *erro=nil;
            
            _activitysDIc=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&erro];
            if (erro) {
                NSLog(@"%@",[erro localizedDescription]);
            }
            _activityView.dataDic=_activitysDIc;
            _activityView.dataArray=[_activitysDIc objectForKey:@"result"];
            [_activityView.viewsTableview reloadData];
        }
        if([getwhat isEqualToString:@"详细资料"]){
            NSData *data=[soapresult dataUsingEncoding:NSUTF8StringEncoding];
            NSError *erro=nil;
           _customerDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&erro];
            _detailsView.dataDicOFCustomer=_customerDic;
            [_detailsView.viewsTableview reloadData];
        }
    }
}
-(void)doWhenHttpCollecttionFalil:(NSError *)error{
    
}
@end
