//
//  CPTabieViewViewModel.m

#import "CPTabieViewViewModel.h"

@interface CPTabieViewViewModel()

/** 请求列表数据*/
@property (nonatomic, strong, readwrite) RACCommand *requestPageDataCommend;
@end

@implementation CPTabieViewViewModel

- (id)init{
    
    self = [super init];
    self.currentPage = 0;
    @weakify(self)
    self.requestPageDataCommend = [[RACCommand alloc] initWithSignalBlock:^(NSNumber *page){
        @strongify(self)
        return [[self requestRemoteDataSignalWithPage:page.unsignedIntegerValue] takeUntil:self.rac_willDeallocSignal];
    }];
    
    //列表点击事件
    _didSelectCellCommend = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:input];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    return self;
}

/** 请求数据信号*/
- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page{
    return [RACSignal empty];
}
@end
