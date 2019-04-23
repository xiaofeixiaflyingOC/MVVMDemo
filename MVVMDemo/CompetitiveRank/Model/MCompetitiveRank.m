//
//  MCompetitiveRank.m


#import "MCompetitiveRank.h"

@implementation MCompetitiveRank

//最小10%
- (NSInteger)att
{
    //四舍五入
    _att = round(_att*0.1) * 10;
    
    if (_att > 100) {
        return 100;
    }else if (_att > 10){
        return _att;
    }
    return 10;
}

@end
