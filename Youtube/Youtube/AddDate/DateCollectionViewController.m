//
//  DateCollectionViewController.m
//  Youtube
//
//  Created by New on 2020/7/6.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import "DateCollectionViewController.h"
#import "DatecellCollectionViewCell.h"
#import "DateHeaderCollectionReusableView.h"
#import "DateBottomView.h"
#import <Masonry.h>
@interface DateCollectionViewController ()

@end

@implementation DateCollectionViewController

static NSString * const reuseIdentifier = @"Date";
static NSString * const headerIdentifier = @"Header";


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Home";
    //初始化数组
    self.selectPathArray = NSMutableArray.new;
    self.inGapArray = NSMutableArray.new;
    self.forbiddenselectPathArray = NSMutableArray.new;

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    [self setCollection];
    [self setBottom];
    //加载UIBarButtonItem
    self.clear = [[UIBarButtonItem alloc] initWithTitle:@"clear" style:UIBarButtonItemStylePlain target:self action:@selector(clearSelectedDate)];
    self.clear.title = @"clear";
    self.navigationItem.rightBarButtonItem = self.clear;
    
    // Do any additional setup after loading the view.
}

-(void)setBottom{
    _bottomView = [[DateBottomView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 100)];
    _bottomView.backgroundColor = UIColor.whiteColor;
    _bottomView.layer.borderColor = UIColor.blackColor.CGColor;
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).with.offset(800);
    }];
}
-(void)setCollection{
    UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.new;
    //设置section内的cell的间距
    layout.minimumInteritemSpacing = 0;
    //设置section内部的行间距
    layout.minimumLineSpacing = 5;
    //设置section之间的距离
    layout.sectionInset = UIEdgeInsetsMake(0, 30, 0, 30);
    //设置header的size
    layout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 80);
    _subCollectionView = [[UICollectionView alloc] initWithFrame:UIScreen.mainScreen.bounds collectionViewLayout:layout];
    //设置支持多选
       _subCollectionView.allowsMultipleSelection = true;
       _subCollectionView.backgroundColor = UIColor.whiteColor;
       // Register cell classes
       [_subCollectionView registerClass:DatecellCollectionViewCell.class forCellWithReuseIdentifier:reuseIdentifier];
       [_subCollectionView registerClass:DateHeaderCollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    _subCollectionView.delegate = self;
    _subCollectionView.dataSource = self;
    [self.view addSubview:_subCollectionView];
}
//导航栏一键清除按钮
-(void)clearSelectedDate{
    //声明一个临时变量来存path，防止出现枚举过程中修改set而崩溃的情况
    //先清除以选中的
    NSIndexPath *temp = [self.selectPathArray copy];
    for(NSIndexPath *path in temp)
    {
        DatecellCollectionViewCell *cell = [_subCollectionView cellForItemAtIndexPath:path];
        cell.selected = false;
        cell.backgroundColor = UIColor.whiteColor;
        cell.title.textColor = UIColor.blackColor;
        [self.selectPathArray removeObject:path];
    }
    //再清除中间的
    temp = [_inGapArray copy];
    for(NSIndexPath *path in temp)
    {
        DatecellCollectionViewCell *cell = [_subCollectionView cellForItemAtIndexPath:path];
        cell.selected = false;
        cell.backgroundColor = UIColor.whiteColor;
        cell.title.textColor = UIColor.blackColor;
        [self.inGapArray removeObject:path];
    }
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 50;
}

//获取当前月份有多少天
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = NSDate.new;
    NSDate *newdate = [calendar dateByAddingUnit:NSCalendarUnitMonth value:section toDate:date options:0];
    NSDateFormatter *formatter = NSDateFormatter.new;
    [formatter setDateFormat:@"yyyy-MM--dd"];
    NSUInteger unitFlags = NSCalendarUnitMonth;//月份
    NSDateComponents *cmp = [calendar components:unitFlags fromDate:newdate];
    NSRange range =  [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:newdate];
    //当前月份的天数
    
    
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday fromDate:newdate];
    // 直接调用自己weekDay属性
    NSInteger weekday = [comps weekday];
    
    if (weekday == 7) {
        return range.length;
    }
    else
    return range.length + weekday;
}

- (DatecellCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DatecellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    [cell setUpPath:indexPath];

    //移除子视图
    for(UIView *v in cell.subviews){
        [v removeFromSuperview];
    }
    //判断是否是中间的cell
    if ([self.inGapArray containsObject:cell.indexpath]) {
        cell.inGap = true;
    }
    else{
        cell.inGap = false;
    }
    //日期相关操作
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = NSDate.new;
    NSDate *newdate = [calendar dateByAddingUnit:NSCalendarUnitMonth value:indexPath.section toDate:date options:0];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday fromDate:newdate];
     //直接调用自己weekDay属性
    NSInteger weekday = [comps weekday];
    if (weekday == 7) {
        weekday = 0;
    }
    //如果禁止选择的全局变量中包含这个indexPath，则禁止交互,同时将其设为未选中
    if([self.forbiddenselectPathArray containsObject:indexPath]){
        cell.userInteractionEnabled = false;
        cell.selected = false;
    }
    //如果禁止选择的全局变量中未包含这个indexPath，分两种情况，一种是正常的日期cell，一种是每月第一天前面的空白cell
    else if(!(indexPath.row +1-weekday > 0)){
        //如果是空白cell，则将cell的indexPath加入到全局变量，并禁止交互
        cell.selected = false;
        cell.userInteractionEnabled = false;
        cell.backgroundColor = UIColor.whiteColor;
        [self.forbiddenselectPathArray addObject:indexPath];
    }
    //如果是普通的日期cell则允许交互，且加上对应的日期
    else{
        [cell setUpLabelWithDate:indexPath.row +1-weekday];
        cell.userInteractionEnabled = true;
        if ([self.selectPathArray containsObject:indexPath]) {
//            NSLog(@"这个时候的selectArray是 %@",self.selectPathArray);
//            NSLog(@"让我康康，%@",indexPath);
            cell.selected = true;
        }
        else{
            cell.selected = false;
        }
    }
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DatecellCollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    NSLog(@"select cell 's indexpath is %@",indexPath);
    //如果单击时没有已经选中的cell，将当前indexPath添加到全局变量
    if (self.selectPathArray.count == 0) {
        [self.selectPathArray addObject:indexPath];
    }
    //如果单击的时候已经有了一个选中的cell，分两种情况，在已选择日期之前与已选择日期之后
    //在已选择日期之前则放弃之前选择
    //
    else if(self.selectPathArray.count == 1){
        //如果选择日期在已选择日期之前，取消之前的选择，将已选择日期更新为新的选择的日期
        NSIndexPath *firstindexpath = [self.selectPathArray firstObject] ;
        //如果在已选择日期之前
        if ([firstindexpath compare:indexPath] ==NSOrderedDescending) {
            [self collectionView:collectionView didDeselectItemAtIndexPath:firstindexpath];
            [self.selectPathArray addObject:indexPath];
        }
        //如果在已选择日期之后
        else{
            //如果全局变量不包含当前点击的indexpath则添加
             if (![self.selectPathArray containsObject:indexPath]) {
                 [self.selectPathArray addObject:indexPath];
             }
            NSIndexPath *firstindexpath = [self.selectPathArray firstObject] ;
            NSIndexPath *lastindexpath = [self.selectPathArray lastObject] ;
            for (DatecellCollectionViewCell __strong *visiblecell in _subCollectionView.visibleCells) {
                if ([visiblecell.indexpath compare:firstindexpath] == NSOrderedDescending && [visiblecell.indexpath compare:lastindexpath] == NSOrderedAscending) {
                    [self.inGapArray addObject:visiblecell.indexpath];
//                    NSLog(@"the cell's path is %@",visiblecell.indexpath);
                }
            }
        }
    }
    else if(self.selectPathArray.count == 2){
        NSIndexPath *temp = [self.selectPathArray copy];
        for (NSIndexPath *path in temp) {
            cell = [collectionView cellForItemAtIndexPath:path];
            [self collectionView:collectionView didDeselectItemAtIndexPath:path];
        }
        temp = [self.inGapArray copy];
        for (NSIndexPath *path in temp) {
            cell = [collectionView cellForItemAtIndexPath:path];
            cell.inGap = false;
        }
        [self.inGapArray removeAllObjects];
        [self.selectPathArray addObject:indexPath];
        cell = [collectionView cellForItemAtIndexPath:indexPath];
        cell.selected = true;
    }

    [_subCollectionView reloadData];
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    DatecellCollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = false;
    [self.selectPathArray removeObject:indexPath];
}
//设置cell大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = UIScreen.mainScreen.bounds.size.width;
    CGFloat cellWidth = ( width - 30 * 2 ) / 7;
//    NSLog(@"%d",cellWidth);
    return CGSizeMake(cellWidth, cellWidth);
}

-(NSInteger)getCurrentYearOrMonthOrDay:(NSString *) param{
    // 创建一个日期类对象(当前月的calendar对象)
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | //年
    NSCalendarUnitMonth | //月份
    NSCalendarUnitDay;//日
    NSDateComponents *cmp = [calendar components:unitFlags fromDate:[[NSDate alloc] init]];
    if ([param  isEqual: @"year"]) {
        return cmp.year;
    }
    else if([param  isEqual: @"month"]){
        return cmp.month;
    }
    else
    {
        return cmp.day;
    }
}
//设置headerview
-(DateHeaderCollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    DateHeaderCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
    for(UIView *v in header.subviews)
    {
        [v removeFromSuperview];
    }
    header.backgroundColor = UIColor.whiteColor;
    
    NSInteger *month = [self getCurrentYearOrMonthOrDay:@"month"] -1;
    NSString *tempmonth = [@((((int)month + (int)indexPath.section) )%12 + 1) stringValue];
    NSInteger *year = [self getCurrentYearOrMonthOrDay:@"year"];
    NSString *tempyear =[@((((int)month + (int)indexPath.section) )/12 + (int)year) stringValue];
    
    NSString *title = [[NSString alloc] initWithFormat:@"%@ / %@",tempmonth,tempyear];
    [header setMonth:title];
    return header;
}
//获取每个月的第一天是星期几
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{

    NSCalendar *calendar = [NSCalendar currentCalendar];

    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];

    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];

    return firstWeekday-1;

}
@end
