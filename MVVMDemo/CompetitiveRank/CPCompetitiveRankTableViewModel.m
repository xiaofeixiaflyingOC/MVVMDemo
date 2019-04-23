//
//  CPCompetitiveRankTableViewModel.m

#import "CPCompetitiveRankTableViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <AFNetworking/AFNetworking.h>
#import "AFHTTPSessionManager+ReactiveObjC.h"
#import "MCompetitiveRank.h"
#import "CPCompetitiveRankViewModel.h"

#define STRING(obj) obj?[NSString stringWithFormat:@"%@",obj]:@"";
@interface CPCompetitiveRankTableViewModel()

@property (nonatomic, strong) NSMutableArray *tableViewData;
@property (nonatomic, strong) RACCommand *covertToModelCommend;

@end

@implementation CPCompetitiveRankTableViewModel

- (id)init{
    self = [super init];
    self.tableViewData = [NSMutableArray array];


    
    return self;
}

/** 请求数据信号*/
- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page{
    @weakify(self);
    NSString *url = @"业务url";
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(self.seriesId),@"seriesid", nil];
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
   return  [[[sessionManager rac_GET:url parameters:parameters]
      catch:^RACSignal *(NSError *error) {
          //TODO: 这里可以根据error.code来判断下属于哪种网络异常，分别给出不同的错误提示
          return [RACSignal error:error];
      }]
     reduceEach:^id(id response, id responseObject){
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             @strongify(self)
             NSDictionary *jsonObj = (NSDictionary*)responseObject;
             NSMutableArray *result = [MCompetitiveRank arrayOfModelsFromDictionaries:jsonObj[@"result"][@"list"] error:nil];
             //将model转成对应的viewModel
             NSMutableArray *viewModelArr = [NSMutableArray array];
             if (result.count==0) {
                 //给listmodel的数据源赋值
                 self.tableViewDataSource = viewModelArr;
                 return viewModelArr;
             }else{
                 __block int rankIndex = 0;
                 for(id x in result){
                     //写viewmodel对应的业务逻辑
                     MCompetitiveRank *rank = (MCompetitiveRank*)x;
                     CPCompetitiveRankViewModel *model = [[CPCompetitiveRankViewModel alloc] init];
                     model.seriesid = rank.seriesid;
                     model.seriesname = STRING(rank.seriesname);
                     model.price = STRING(rank.price);
                     model.seriesimageurl = [NSURL URLWithString: rank.seriesimageurl ];
                     model.attImageName =  [NSString stringWithFormat:@"attention_%@",@(rank.att).stringValue];
                     if (rankIndex <= 3) {
                         model.rankImageName = @"icon_rank_red";
                     }
                     else {
                         model.rankImageName =  @"icon_rank_gray";
                     }
                     
                     [viewModelArr addObject:model];
                     if (result.count==(rankIndex+1)) {
                         //给listmodel的数据源赋值
                         self.tableViewDataSource = [viewModelArr copy];
                         return self.tableViewDataSource;
                     }
                     rankIndex++;
                 }
             }
         }
        return (RACDisposable *)nil;
     }];
}


@end
