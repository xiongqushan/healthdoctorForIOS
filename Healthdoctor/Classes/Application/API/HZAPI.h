//
//  HZAPI.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/5/23.
//  Copyright © 2016年 guokai. All rights reserved.
//

#ifndef HZAPI_h
#define HZAPI_h

// @"http://hz75thbd2:803/api/" 内网测试环境  15601815186   111111
// @"http://hc.ihaozhuo.com:90/api/" 外网生产环境 xhtest01   123456

#define kUrlPrefix @"http://hz75thbd2:803/api/"
#define kVersion @"v1"

/****************** User **********************/
#define kUserBaseURL(str) [NSString stringWithFormat:@"%@_User/%@",kVersion,str]

#define kGetCaptchaURL kUserBaseURL(@"LoginSMSCode")
#define kLoginValidateURL kUserBaseURL(@"LoginValidate")
#define kLoginURL kUserBaseURL(@"Login")
#define kConfirmLoginURL kUserBaseURL(@"ConfirmLogin")
#define kScanLoginURL kUserBaseURL(@"ScanLogin")
#define kGetCusInfoURL kUserBaseURL(@"GetCusInfo")
#define kBasConstListURL kUserBaseURL(@"GetBasConstList")
#define kServiceDeptListURL kUserBaseURL(@"GetServiceDeptList")

/****************** Consult **********************/
#define kConsultBaseURL(str) [NSString stringWithFormat:@"%@_Consult/%@",kVersion,str]

#define kGetPendingURL kConsultBaseURL(@"GetPendingAskData")
#define kGetProcessedURL kConsultBaseURL(@"GetProcessedAskData")
#define kGetFeedbackURL kConsultBaseURL(@"GetFeedbackAskData")
#define kGetAskReplyURL kConsultBaseURL(@"GetAskReplyData")
#define kAddDoctorReplyURL kConsultBaseURL(@"AddDoctorReply")
#define kDefaultExpressionsURL kConsultBaseURL(@"GetDefaultExpressions")
#define kSearchExpressionsURL kConsultBaseURL(@"SearchExpressionsByKeyWord")

/****************** Home **********************/
#define kGetCusGroupURL kUserBaseURL(@"GetCusGroupByDoctorId")
#define kGroupCustInfoListURL kUserBaseURL(@"GetGroupCustInfoList")
#define kGetCusInfoURL kUserBaseURL(@"GetCusInfo")
#define kDeleteGroupURL kUserBaseURL(@"DeleteCustomerGroup")

/****************** Report **********************/
#define kReportBaseURL(str) [NSString stringWithFormat:@"%@_Report/%@",kVersion,str]

#define kReportPhotoListURL kReportBaseURL(@"RequestPhotoReportList")
#define kGetReportListURL kReportBaseURL(@"GetReportParams")
#define kGetHealthReportURL kReportBaseURL(@"GetHealthReport")

#endif /* HZAPI_h */
