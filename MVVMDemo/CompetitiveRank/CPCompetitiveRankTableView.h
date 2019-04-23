//
//  CPCompetitiveRankTableView.h

#import <UIKit/UIKit.h>
#import "CPCompetitiveRankTableViewModel.h"
#import "CPCompetitiveRankViewModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^CompetitiveRankBlock)(CPCompetitiveRankViewModel *model);

@interface CPCompetitiveRankTableView : UITableView

//@property (nonatomic, assign) NSInteger seriesId;
//@property (nonatomic, strong) NSMutableArray *tableViewDataSource;
@property (nonatomic, copy) CompetitiveRankBlock clickCellBlock;
- (void)setData:(CPCompetitiveRankTableViewModel*)model;

@end

NS_ASSUME_NONNULL_END
