//
//  CWInterface.m
//  CarWins
//
//  Created by cheng on 16/3/22.
//  Copyright © 2016年 CarWins Inc. All rights reserved.
//

#import "LXInterface.h"

@implementation LXInterface

#pragma mark - 57.上传文件
///**
// * 27.上传文件
// */
//+ (NSDictionary *)postFileUploadWithFolder:(NSString *)folder   /**< 目录名：car，news，skeleton */
//                                     bytes:(NSArray<__kindof NSData *> *)apifiles
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
//    [dict setObject:kCWHttpPostUrl(@"api/file/PostFormData") forKey:@"url"];
//    [dict setObject:[NSString convertNull:folder] forKey:@"folder"];
//    [dict setObject:apifiles forKey:@"apifiles"];
//    
//    
//    
//    /*
//     
//     {
//        "folder" : "car",
//        "apifiles" : [
//            byte,byte
//        ]
//     }
//     
//     */
//    
//    return dict;
//}
//
//#pragma mark - 2.ResolveVIN
//+ (NSDictionary *)postWorkResolveVINWithVin:(NSString *)vin
//                                     source:(NSString *)source
//                                         ip:(NSString *)ip
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
//    [dict setObject:kCWHttpPostUrl(@"api/ResolveVIN/ResolveVIN") forKey:@"url"];
//    [dict setObject:[NSString convertNull:vin] forKey:@"vin"];
//    [dict setObject:[NSString convertNull:source] forKey:@"source"];
//    [dict setObject:[NSString convertNull:ip] forKey:@"ip"];
//    
//    
//    return dict;
//}
//
//#pragma mark - 3.检验vin是否存在
//+ (NSDictionary *)postWorkCheckVinExistsWithVin:(NSString *)vin
//                                             Id:(NSInteger)Id
//                                           type:(NSString *)type
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
//    [dict setObject:kCWHttpPostUrl(@"api/CarMange/CheckVinExists") forKey:@"url"];
//    [dict setObject:[NSString convertNull:vin] forKey:@"vin"];
//    [dict setObject:kStringByInt(Id) forKey:@"carID"];
//    [dict setObject:type forKey:@"type"];
//    
//    return dict;
//}
//
//#pragma mark -4.根据集团ID获取banner列表
//+ (NSDictionary *)postWorkCheckGetIndexCarousel
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
//    [dict setObject:kCWSaasHttpPostUrl(@"api/PublicData/GetIndexCarouselFigureAppList")
//             forKey:@"url"];
//    [dict setObject:@([CWUserInfoModel shareUser].groupID) forKey:@"groupID"];
//    [dict setObject:[CWUserInfoModel shareUser].businessCategory forKey:@"businessCategory"];
//    [dict setObject:@"app" forKey:@"carouselFigureType"];
//    
//    return dict;
//}
//
//#pragma mark - 5.行驶证识别
//+ (NSDictionary *)postWorkAnalysisDirvingCardWithPath:(NSString *)path
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
//    [dict setObject:kCWSaasHttpPostUrl(@"api/File/OCRDriving") forKey:@"url"];
//    [dict setObject:kStringConvertNull(path) forKey:@"path"];
//    [dict setObject:kStringByInt([CWUserInfoModel shareUser].groupID) forKey:@"groupID"];
//    [dict setObject:kStringByInt([CWUserInfoModel shareUser].carwinsPersonMerchantID) forKey:@"operationalPersonMerchantID"];
//    [dict setObject:@"3" forKey:@"operationalSource"];
//    return dict;
//}
+ (NSDictionary *)postAdvList{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:kLXHttpPostUrl(@"api/Adv/List") forKey:@"url"];
        return dict;
}
+ (NSDictionary *)postMsgListMsgTypeIdArr:(NSArray *)MsgTypeIdArr
                                 pageSize:(NSString *)pageSize
                                pageIndex:(NSString *)pageIndex{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:kLXHttpPostUrl(@"api/Msg/List")  forKey:@"url"];
    [dict setObject:MsgTypeIdArr forKey:@"MsgTypeIdArr"];
    [dict setObject:kStringConvertNull(pageSize)     forKey:@"pageSize"];
    [dict setObject:kStringConvertNull(pageIndex)    forKey:@"pageIndex"];
    return dict;
}
+ (NSDictionary *)postDriverCostLogList:(NSString *)typeId{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:kLXHttpPostUrl(@"api/DriverCostLog/List") forKey:@"url"];
    [dict setObject:typeId forKey:@"CostTypeIdArr"];
    return dict;
}
+ (NSDictionary *)postDriverCostLogRecharge:(NSString *)Cost{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSString stringWithFormat:@"%@?Cost=%@",kLXHttpPostUrl(@"api/DriverCostLog/Recharge"),Cost] forKey:@"url"];
    return dict;
}
+ (NSMutableDictionary *)postDriverInfoGetBaseInfo{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:kLXHttpPostUrl(@"api/DriverInfo/GetBaseInfo") forKey:@"url"];
    return dict;
}

/**
  获取所有投诉类型

 @return return value description
 */
+ (NSMutableDictionary *)postFeedbackTypeList{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:kLXHttpPostUrl(@"api/FeedbackInfo/FeedbackTypeList") forKey:@"url"];
    return dict;
}
+ (NSMutableDictionary *)postFeedbackInfoPost:(NSString *)FeedbackTypeId
                                FeedbackTitle:(NSString *)FeedbackTitle
                              FeedbackContent:(NSString *)FeedbackContent{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:kLXHttpPostUrl(@"api/FeedbackInfo/Post") forKey:@"url"];
    [dict setObject:kStringConvertNull(FeedbackTypeId) forKey:@"FeedbackTypeId"];
    [dict setObject:kStringConvertNull(FeedbackTitle) forKey:@"FeedbackTitle"];
    [dict setObject:kStringConvertNull(FeedbackContent) forKey:@"FeedbackContent"];
    return dict;
}
+ (NSMutableDictionary *)postTollRecordListWithPageSize:(NSString *)pageSize
                                              PageIndex:(NSString *)pageIndex{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:kLXHttpPostUrl(@"api/TollRecord/List") forKey:@"url"];
    [dict setObject:kStringConvertNull(pageSize) forKey:@"pageSize"];
    [dict setObject:kStringConvertNull(pageIndex) forKey:@"pageIndex"];
    return dict;
}
+ (NSMutableDictionary *)postRel_Car_BorrowRequestCarWithPhone:(NSString *)phone
                                                       UseTime:(NSString *)UseTime
                                                    ReturnTime:(NSString *)ReturnTime
                                                        Remark:(NSString *)Remark{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSString stringWithFormat:kLXHttpPostUrl(@"api/Rel_Car_Borrow/RequestCar?phone=%@"),phone] forKey:@"url"];
    [dict setObject:kStringConvertNull(UseTime) forKey:@"UseTime"];
    [dict setObject:kStringConvertNull(ReturnTime) forKey:@"ReturnTime"];
    [dict setObject:kStringConvertNull(Remark) forKey:@"Remark"];
    return dict;
}
+ (NSMutableDictionary *)postRel_Car_BorrowCarWithPhone:(NSString *)phone
                                                  carId:(NSString *)carId
                                                UseTime:(NSString *)UseTime
                                             ReturnTime:(NSString *)ReturnTime
                                                 Remark:(NSString *)Remark{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSString stringWithFormat:kLXHttpPostUrl(@"api/Rel_Car_Borrow/BorrowCar?phone=%@&carId=%@"),phone,carId] forKey:@"url"];
    [dict setObject:kStringConvertNull(UseTime) forKey:@"UseTime"]; 
    [dict setObject:kStringConvertNull(ReturnTime) forKey:@"ReturnTime"];
    [dict setObject:kStringConvertNull(Remark) forKey:@"Remark"];
    return dict;
}
+ (NSMutableDictionary *)postTollFinishUseCarRecordId:(NSString *)RecordId{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSString stringWithFormat:kLXHttpPostUrl(@"Toll/FinishUseCar?RecordId=%@"),RecordId] forKey:@"url"];
    return dict;
}

+ (NSMutableDictionary *)postTollRecordGetId:(NSString *)TollRecordId{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSString stringWithFormat:kLXHttpPostUrl(@"api/TollRecord/Get?id=%@"),TollRecordId] forKey:@"url"]; 
    return dict;
}
+ (NSMutableDictionary *)postMsgInfoMyMsg{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:kLXHttpPostUrl(@"api/MsgInfo/MyMsg") forKey:@"url"];
    return dict;
}
+ (NSMutableDictionary *)postMsgCMSArticleListPageIndex:(NSString *)PageIndex
                                               PageSize:(NSString *)PageSize{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:kLXHttpPostUrl(@"api/CMSArticle/List") forKey:@"url"];
    [dict setObject:kStringConvertNull(PageIndex) forKey:@"PageIndex"];
    [dict setObject:kStringConvertNull(PageSize) forKey:@"PageSize"];
    return dict;
}
+ (NSMutableDictionary *)postRel_Car_BorrowBackCar:(NSString *)carId{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSString stringWithFormat:kLXHttpPostUrl(@"api/Rel_Car_Borrow/BackCar?carId=%@"),carId] forKey:@"url"];
    return dict;
}
@end









