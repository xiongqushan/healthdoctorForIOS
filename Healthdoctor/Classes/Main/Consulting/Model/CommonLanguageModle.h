//
//  CommonLanguageModle.h
//  Heath
//
//  Created by 郭凯 on 16/4/22.
//  Copyright © 2016年 TY. All rights reserved.
//

#import <Foundation/Foundation.h>
/*            
 CntSn = "<null>";
 Content = 56;
 CreatedBy = "<null>";
 CreatedOn = "2016-06-17T09:49:35";
 Descriptions = "<null>";
 Guid = "0ef0cb1c-bffc-4648-87bc-50dc1b1739f0";
 Id = 2235;
 IsDefault = 1;
 IsDelete = 0;
 IsEnabled = 1;
 ItemName = 8;
 ItemSpell = "<null>";
 KetWordSpell = "<null>";
 KeyWord = 23;
 ModifiedBy = "<null>";
 ModifiedOn = "2016-06-17T09:49:35";
 Version = 2;
 */
@interface CommonLanguageModle : NSObject

//@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *isClick;

@property (nonatomic, copy)NSString *cntSn;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *createdBy;
@property (nonatomic, copy)NSString *createdOn;
@property (nonatomic, copy)NSString *Descriptions;
@property (nonatomic, copy)NSString *guid;
@property (nonatomic, copy)NSString *Id;
@property (nonatomic, copy)NSString *isDefault;
@property (nonatomic, copy)NSString *isDelete;
@property (nonatomic, copy)NSString *isEnabled;
@property (nonatomic, copy)NSString *itemName;
@property (nonatomic, copy)NSString *itemSpell;
@property (nonatomic, copy)NSString *ketWordSpell;
@property (nonatomic, copy)NSString *keyWord;
@property (nonatomic, copy)NSString *modifiedBy;
@property (nonatomic, copy)NSString *modifiedOn;
@property (nonatomic, copy)NSString *version;


@end
