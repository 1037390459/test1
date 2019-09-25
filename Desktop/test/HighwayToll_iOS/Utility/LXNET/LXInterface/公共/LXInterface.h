//
//  CWInterface.h
//  CarWins
//
//  Created by Dandre on 16/3/22.
//  Copyright © 2016年 CarWins Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXInterface+Enum.h"

/**
 *  网络接口类
 */
@interface LXInterface : NSObject

/**
 *  1.上传文件
 */
+ (NSDictionary *)postFileUploadWithFolder:(NSString *)folder   /**< 目录名：car，news，skeleton */
                                     bytes:(NSArray<__kindof NSData *> *)bytes      /**< 二进制文件流 */;

/**
 *  2.Vin码查询
 *
 *  @param vin    <#vin description#>
 *  @param source <#source description#>
 *  @param ip     <#ip description#>
 *
 *  @return <#return value description#>
 */
+ (NSDictionary *)postWorkResolveVINWithVin:(NSString *)vin
                                     source:(NSString *)source
                                         ip:(NSString *)ip;

/**
 *  3.Vin码检验 ，是否存在
 *
 *  @param vin vin码
 *
 *  @param Id 工单ID 或者carId
 *
 *  @param type 1评估工单 2车辆
 *
 *  @return return value description
 */
+ (NSDictionary *)postWorkCheckVinExistsWithVin:(NSString *)vin
                                             Id:(NSInteger)Id
                                           type:(NSString *)type;
/**
 *  @return <#return value description#>
 */
+ (NSDictionary *)postWorkCheckGetIndexCarousel;

/**
 *  5.行驶证识别
 *
 *  @param path            图片路径
 *  @return return value description
 */
+ (NSDictionary *)postWorkAnalysisDirvingCardWithPath:(NSString *)path;

/**
    获取首页广告

 @return <#return value description#>
 */
+ (NSDictionary *)postAdvList;

/**
    消息列表
 
 */
+ (NSDictionary *)postMsgListMsgTypeIdArr:(NSArray *)MsgTypeIdArr
                                 pageSize:(NSString *)pageSize
                                pageIndex:(NSString *)pageIndex;

/**
   司机话费列表

 @return return value description
 */
+ (NSDictionary *)postDriverCostLogList;

/**
   交易
 
 */
+ (NSDictionary *)postDriverCostLogList:(NSString *)typeId;

/**
 充值

 @param Cost  充值金额
 @return <#return value description#>
 */
+ (NSDictionary *)postDriverCostLogRecharge:(NSString *)Cost;

/**
   获取金额 车辆 
 */
+ (NSMutableDictionary *)postDriverInfoGetBaseInfo;
/**
 获取所有投诉类型
 
 @return return value description
 */
+ (NSMutableDictionary *)postFeedbackTypeList;

/**
  提交投诉

 @param FeedbackTypeId FeedbackTypeId description
 @param FeedbackTitle FeedbackTitle description
 @return <#return value description#>
 */
+ (NSMutableDictionary *)postFeedbackInfoPost:(NSString *)FeedbackTypeId
                                FeedbackTitle:(NSString *)FeedbackTitle
                              FeedbackContent:(NSString *)FeedbackContent;

/**
 根据条件获取 用户订单

 @param pageSize pageSize description
 @param pageIndex pageIndex description
 @return return value description
 */
+ (NSMutableDictionary *)postTollRecordListWithPageSize:(NSString *)pageSize
                                              PageIndex:(NSString *)pageIndex;

/**
 向朋友借车

 @param phone 电话
 @param UseTime 用车时间
 @param ReturnTime 还车时间
 @param Remark 备注
 @return return value description
 */
+ (NSMutableDictionary *)postRel_Car_BorrowRequestCarWithPhone:(NSString *)phone
                                                       UseTime:(NSString *)UseTime
                                                    ReturnTime:(NSString *)ReturnTime
                                                        Remark:(NSString *)Remark;

/**
 借车给朋友

 @param phone 电话
 @param carId 车辆id
 @param UseTime 用车时间
 @param ReturnTime 还车时间
 @param Remark 备注
 @return return value description
 */
+ (NSMutableDictionary *)postRel_Car_BorrowCarWithPhone:(NSString *)phone
                                                  carId:(NSString *)carId
                                                UseTime:(NSString *)UseTime
                                             ReturnTime:(NSString *)ReturnTime
                                                 Remark:(NSString *)Remark;

/**
   结束用车

 @param RecordId 记录id
 @return return value
 */
+ (NSMutableDictionary *)postTollFinishUseCarRecordId:(NSString *)RecordId;

/**
   查询单个

 @param TollRecordId <#TollRecordId description#>
 @return <#return value description#>
 */
+ (NSMutableDictionary *)postTollRecordGetId:(NSString *)TollRecordId;

/**
   查询所有消息列表

 @return return value description
 */
+ (NSMutableDictionary *)postMsgInfoMyMsg;

/**
   消息列表

 @param PageIndex PageIndex description
 @param PageSize PageSize description
 @return return value description
 */
+ (NSMutableDictionary *)postMsgCMSArticleListPageIndex:(NSString *)PageIndex
                                               PageSize:(NSString *)PageSize;

/**
   还车

 @param carId 车辆id
 @return
 */
+ (NSMutableDictionary *)postRel_Car_BorrowBackCar:(NSString *)carId;
@end
