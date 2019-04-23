//
//  CompetitiveRankCell.h

#import <UIKit/UIKit.h>
#import "CPCompetitiveRankViewModel.h"
#define kCompetitiveRankCellId (@"CompetitiveRankCell")
#define kCompetitiveRankCell_Height (105)

@class MCompetitiveRank;

@interface CompetitiveRankCell : UITableViewCell

- (void)loadCellByData:(CPCompetitiveRankViewModel *)viewModel
             rankIndex:(NSInteger)rankIndex;




@end
