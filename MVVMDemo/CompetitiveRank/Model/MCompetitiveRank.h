//
//  MCompetitiveRank.h

#import <JSONModel/JSONModel.h>

@interface MCompetitiveRank : JSONModel

/* 车系id */
@property (nonatomic, assign) NSInteger seriesid;
/* 车系名称 */
@property (nonatomic, strong) NSString  *seriesname;
/* 车系logo */
@property (nonatomic, strong) NSString  *seriesimageurl;
/* 价格区间 */
@property (nonatomic, strong) NSString  *price;
/* 关注度 */
@property (nonatomic, assign) NSInteger att;

@end
