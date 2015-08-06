//
//  EcardSoap.h
//  EX_EcardSoap
//
//  Created by learner on 15-6-12.
//  Copyright (c) 2015年 learner. All rights reserved.
//



#import "crmDelegate.h"
#import <Foundation/Foundation.h>


@interface crmSoap : NSObject<NSXMLParserDelegate,NSURLConnectionDelegate>
@property(strong,nonatomic)NSString *getWhatInfo;//字符串代表着去网络上获取什么数据
@property(strong,nonatomic)id<crmDelegate> soapDelgate;
@property (strong, nonatomic) NSMutableData *webData;
@property (strong, nonatomic) NSMutableString *soapResults;

@property (strong, nonatomic) NSXMLParser *xmlParser;
@property (nonatomic) BOOL elementFound;
@property (strong, nonatomic) NSString *matchingElement;
@property (strong, nonatomic) NSURLConnection *conn;

-(void)checkAccount:(NSString *)loginCount  Pwd:(NSString *)LooginPwd;//验证用户账号密码
-(void)getUserInfoByUserIdAndUserPWd:(NSString *)userId Pwd:(NSString *)pwd;//通过账号密码获取用户信息
-(void)getCustomerNameAndIdByUserId:(NSString *)userid;//获取用户姓名和id
-(void)getCustomerInfoByCustomerId:(int)customerid getWhatInfo:(NSString *)getwhatinfo;//通过客户id获取客户详细信息
-(void)getActivityRecords;//查询所有活动记录
-(void)getCustomerField;//查询所有行业
-(void)getCustomerLevel;//查询所有客户级别字段
-(void)getAllDepartment;//查询所有部门
-(void)getActivityRecordsByCustomerid:(int)customerId;

-(void)addCustomer:(int) customerId Name:(NSString *)name  ParenrCusId:(int)preCusId  userId:(int)uId departId:(int)depId LevelId:(int)levelId feildId:(int)feildId Money:(float)money compUrl:(NSString *)url Tel:(NSString *)tel Addr:(NSString *)addr Remark:(NSString *)remark postcode:(NSString *)p_code   Fax:(NSString *)fax cDate:(NSString *  )cdate cPerson:(NSString *)cperson mDate:(NSString *)mdate mPerson:(NSString *)mPerson;//添加客户
@end
