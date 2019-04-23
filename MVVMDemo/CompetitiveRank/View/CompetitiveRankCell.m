//
//  CompetitiveRankCell.m

#import "CompetitiveRankCell.h"
#import "MCompetitiveRank.h"
#import "UIView+ZFFrame.h"
#import <SDWebImage/SDWebImage.h>
@interface CompetitiveRankCell()

//车系logo
@property (nonatomic, strong) UIImageView    *seriesImageView;
//排名角标
@property (nonatomic, strong) UIImageView    *rankImageView;
//名次
@property (nonatomic, strong) UILabel        *rankLab;
//车系名
@property (nonatomic, strong) UILabel        *seriesLab;
//车系价格区间
@property (nonatomic, strong) UILabel        *priceLab;
//关注度
@property (nonatomic, strong) UIImageView    *attImageView;

@property (nonatomic, strong) CPCompetitiveRankViewModel *viewModel;
@end


@implementation CompetitiveRankCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self p_drawCell];
        [self init_AllView];
        [self bindData];
    }
    return self;
}

- (void)p_drawCell
{
    // 背景色
//    UIView *cellBgView = [[UIView alloc] init];
//    cellBgView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    cellBgView.backgroundColor = FLATSETTINGS.tableViewCellBackGroundColor;
//    self.backgroundView = cellBgView;
//
//    self.contentView.backgroundColor = FLATSETTINGS.tableViewCellBackGroundColor;
//
//    // 点击背景色
////    UIView *cellSelectedimageView = [[UIView alloc] init];
////    cellSelectedimageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
////    cellSelectedimageView.backgroundColor = FLATSETTINGS.tableViewCellSelectedBackGroundColor;
//    self.selectedBackgroundView = cellSelectedimageView;
}

#pragma mark - init

- (void)init_AllView
{
    //车系logo
    CGFloat in_X = 15;
    CGFloat in_Y = 15;
    NSInteger in_Width = 100;
    NSInteger in_Height = 75;
    _seriesImageView = [[UIImageView alloc] initWithFrame:(CGRect){in_X, in_Y, in_Width, in_Height}];
    [_seriesImageView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:_seriesImageView];
    
    //排名角标
    in_X = [UIScreen mainScreen].bounds.size.width - 30;
    in_Y = 0;
    in_Width = 30;
    in_Height = 30;
    _rankImageView = [[UIImageView alloc] initWithFrame:(CGRect){in_X, in_Y, in_Width, in_Height}];
    [_rankImageView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:_rankImageView];
    
    //名次
    in_X = 14;
    in_Y = 2.5;
    in_Width = 17;
    in_Height = 15;
    _rankLab = [[UILabel alloc] initWithFrame:(CGRect){in_X, in_Y, in_Width, in_Height}];
    _rankLab.textColor = [UIColor whiteColor];
    _rankLab.font = [UIFont systemFontOfSize:14];
    _rankLab.textAlignment = NSTextAlignmentCenter;
    _rankLab.backgroundColor = [UIColor clearColor];
    [_rankImageView addSubview:_rankLab];
    
    //车系名
    in_X = _seriesImageView.right + 20;
    in_Y = 15;
    in_Width = [UIScreen mainScreen].bounds.size.width - _seriesImageView.width - 2*15 - 20;
    in_Height = 20;
    _seriesLab = [[UILabel alloc] initWithFrame:(CGRect){in_X, in_Y, in_Width, in_Height}];
//    [UI_Rule style_txt31:_seriesLab];
    _seriesLab.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_seriesLab];
    
    //车系价格区间
    in_X = _seriesLab.left;
    in_Y = _seriesLab.bottom + 5;
    in_Width = _seriesLab.width;
    in_Height = 18;
    _priceLab = [[UILabel alloc] initWithFrame:(CGRect){in_X, in_Y, in_Width, in_Height}];
//    [UI_Rule style_txt19:_priceLab];
    _priceLab.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_priceLab];
    
    //关注度控件
    in_X = _seriesLab.left;
    in_Y = _priceLab.bottom + 5;
    in_Width = 62;
    in_Height = 10;
    _attImageView = [[UIImageView alloc] initWithFrame:(CGRect){in_X, in_Y, in_Width, in_Height}];
    [_attImageView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:_attImageView];
    
    //线
    in_X = 0;
    in_Y = kCompetitiveRankCell_Height - 0.5;
    UIView *line = [[UIView alloc] initWithFrame:(CGRect){in_X, in_Y, [UIScreen mainScreen].bounds.size.width, 1}];
    line.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:line];
}

#pragma mark - data
- (void)loadCellByData:(CPCompetitiveRankViewModel *)viewModel
             rankIndex:(NSInteger)rankIndex
{
    self.viewModel = viewModel;
    //车系logo
    [_seriesImageView sd_setImageWithURL:viewModel.seriesimageurl placeholderImage:nil];
    [_rankImageView setImage:[UIImage imageNamed:viewModel.rankImageName]];
    //排名角标
    _rankLab.text = [NSString stringWithFormat:@"%@",@(rankIndex).stringValue];
    //关注度控件
    _attImageView.image = [UIImage imageNamed:viewModel.attImageName];
    
    //刷新UI
    [self refreshUIMethod];
}

- (void)bindData{
//    [_seriesImageView sd_setImageWithURL:competitiveRankData.seriesimageurl.urlValue placeholderImage:kPlaceHolderImg];
    
//    RAC(self.rankImageView,image) = [[RACObserve(self, viewModel.rankImageName) map:^(NSNumber *imageName){
//        return imageName.stringValue;
//    }]deliverOnMainThread];
    
    RAC(self.seriesLab,text) = RACObserve(self, viewModel.seriesname);
    RAC(self.priceLab, text) = RACObserve(self, viewModel.price);
}

- (void)refreshUIMethod
{
    CGFloat topSpace = (kCompetitiveRankCell_Height - _seriesLab.height - _priceLab.height - _attImageView.height - 2*5)/2.0;
    
    _seriesLab.top = topSpace;
    _priceLab.top = _seriesLab.bottom + 5;
    _attImageView.top = _priceLab.bottom + 5;
}

#pragma mark -

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
