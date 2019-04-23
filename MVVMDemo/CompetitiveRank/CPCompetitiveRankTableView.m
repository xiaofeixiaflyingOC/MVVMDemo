//
//  CPCompetitiveRankTableView.m

#import "CPCompetitiveRankTableView.h"
#import "CompetitiveRankCell.h"
#import "MCompetitiveRank.h"

@interface CPCompetitiveRankTableView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) CPCompetitiveRankTableViewModel *viewModel;
@end

@implementation CPCompetitiveRankTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame
                          style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (void)setData:(CPCompetitiveRankTableViewModel*)model{
    self.viewModel = model;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.tableViewDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CompetitiveRankCell *cell = [tableView dequeueReusableCellWithIdentifier:kCompetitiveRankCellId];
    if (cell == nil) {
        cell = [[CompetitiveRankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCompetitiveRankCellId];
    }
    NSInteger rowIndex = indexPath.row;
    CPCompetitiveRankViewModel *rankInfo = [self.viewModel.tableViewDataSource objectAtIndex:rowIndex];
    if (rankInfo) {
        [cell loadCellByData:rankInfo rankIndex:(rowIndex + 1)];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCompetitiveRankCell_Height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CPCompetitiveRankViewModel *rankInfo = [self.viewModel.tableViewDataSource objectAtIndex:indexPath.row];
    if (rankInfo) {
        //执行点击跳转操作
        [self.viewModel.didSelectCellCommend execute:rankInfo];
//        BJ_SAFE_BLOCK(self.clickCellBlock,rankInfo);
        //车系综述页
//        SeriesDetailsController *seriesover = [[SeriesDetailsController alloc] init];
//        seriesover.seriesID = rankInfo.seriesid;
//        seriesover.sevcarseries = SEVCarSeriesCompetitiveRank;
//        [self.navigationController pushViewController:seriesover animated:YES];
    }
}
@end
