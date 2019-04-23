//
//  CPCompetitiveRankViewModel.h

#import <Foundation/Foundation.h>
#import "CPTabieViewViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CPCompetitiveRankViewModel : NSObject

/* 车系id */
@property (nonatomic, assign) NSInteger seriesid;
/* 车系名称 */
@property (nonatomic, strong) NSString  *seriesname;
/* 车系logo */
@property (nonatomic, strong) NSURL  *seriesimageurl;
/* 价格区间 */
@property (nonatomic, strong) NSString  *price;
/* 关注度图片 */
@property (nonatomic, strong) NSString *attImageName;
/** 排名图片名称*/
@property (nonatomic, strong) NSString *rankImageName;
@end

NS_ASSUME_NONNULL_END
