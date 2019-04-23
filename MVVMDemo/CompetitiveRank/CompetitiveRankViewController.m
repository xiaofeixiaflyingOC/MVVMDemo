//
//  CompetitiveRankViewController.m

#import "CompetitiveRankViewController.h"
#import "CompetitiveRankCell.h"

#import "MCompetitiveRank.h"
#import "CPCompetitiveRankTableView.h"
#import "CPCompetitiveRankTableViewModel.h"

@interface CompetitiveRankViewController ()

@property (nonatomic, strong) NSArray   *rankInfoList;
@property (nonatomic, strong) CPCompetitiveRankTableView *tableView;
@property (nonatomic, strong) CPCompetitiveRankTableViewModel *viewListModel;
@end

@implementation CompetitiveRankViewController

#pragma mark - system methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self p_setupTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - init and load

- (void)p_setupTableView
{
    self.tableView = [[CPCompetitiveRankTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
       @weakify(self);

    self.viewListModel = [[CPCompetitiveRankTableViewModel alloc] init];
    self.viewListModel.seriesId = 614;
    [self.tableView setData:self.viewListModel];
    //请求回调事件
    [[self.viewListModel.requestPageDataCommend.executionSignals switchToLatest] subscribeNext:^(NSMutableArray *result){
        @strongify(self)
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    //执行请求操作，因为不分页不需要传递参数
    [self.viewListModel.requestPageDataCommend execute:nil];
    //点击回调事件
    [[self.viewListModel.didSelectCellCommend.executionSignals switchToLatest] subscribeNext:^(CPCompetitiveRankViewModel *model){
         @strongify(self)
//        //车系综述页
//        SeriesDetailsController *seriesover = [[SeriesDetailsController alloc] init];
//        seriesover.seriesID = model.seriesid;
//        seriesover.sevcarseries = SEVCarSeriesCompetitiveRank;
//        [self.navigationController pushViewController:seriesover animated:YES];
    }];
    //错误处理
    [self.viewListModel.requestPageDataCommend.errors subscribeNext:^(NSError *error){
        
    }];
      
}

@end
