//
//  CPTabieViewViewModel.h

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
NS_ASSUME_NONNULL_BEGIN

@interface CPTabieViewViewModel : NSObject

/** tableView数据源*/
@property (nonatomic, strong) NSMutableArray *tableViewDataSource;
/** cell点击*/
@property (nonatomic, strong, readonly) RACCommand *didSelectCellCommend;
/** 请求列表数据*/
@property (nonatomic, strong, readonly) RACCommand *requestPageDataCommend;

@property (nonatomic, strong) RACSubject *refreshUI;
/** 目前页数*/
@property (nonatomic, assign) NSUInteger currentPage;

/** 请求数据信号*/
- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page;
///** 请求数据失败信号*/
//- (BOOL (^)(NSError *error))requestRemoteDataErrorsFilter;
@end

NS_ASSUME_NONNULL_END
