//
//  ViewController.m
//  feqfeef
//
//  Created by 邢行 on 2017/2/23.
//  Copyright © 2017年 XingHang. All rights reserved.
//

#import "ViewController.h"
#import "EaseChineseToPinyin.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *sectionTitles;
/** sortedArray*/
@property (nonatomic,strong) NSMutableArray *sortedArray;

@property (weak, nonatomic) IBOutlet UITableView *tab;

@end

@implementation ViewController

- (NSMutableArray *)sortedArray{
    
    if (!_sortedArray) {
        
        _sortedArray = [[NSMutableArray alloc] init];
        
    }
    return _sortedArray;
    
}

- (NSMutableArray *)sectionTitles{
    
    if (!_sectionTitles) {
        
        _sectionTitles = [[NSMutableArray alloc] init];
        
    }
    return _sectionTitles;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    
    [self loaddata];
}


- (void)loaddata{
    
    
    UILocalizedIndexedCollation *indexCollation = [UILocalizedIndexedCollation currentCollation];
    [self.sectionTitles addObjectsFromArray:[indexCollation sectionTitles]];
    
    
    NSInteger highSection = [self.sectionTitles count];
    NSMutableArray *sortedArray = [NSMutableArray arrayWithCapacity:highSection];
    for (int i = 0; i < highSection; i++) {
        NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
        [sortedArray addObject:sectionArray];
    }
    
    NSArray *hghggs = @[@"你好",@"张丹丹",@"洞丹丹",@"西丹丹",@"张三丰",@"里三丰",@"网三丰",@"找三丰",@"嘎丰",@"人员三丰",@"124",@"东城区",@"西城区",@"丰台区",@"大兴区",@"昌平区",@"245"];
    for (int i = 0 ; i < hghggs.count; i++) {
        
        NSString *name = hghggs[i];
        NSString *firstLetter = [EaseChineseToPinyin pinyinFromChineseString:name];
        NSLog(@"name:%@,newname:%@",name,firstLetter);
        
        NSInteger section = [indexCollation sectionForObject:[firstLetter substringToIndex:1] collationStringSelector:@selector(uppercaseString)];
        
        NSMutableArray *array = [sortedArray objectAtIndex:section];
        [array addObject:name];
    }
    
    //去掉空的section
    for (NSInteger i = [sortedArray count] - 1; i >= 0; i--) {
        NSArray *array = [sortedArray objectAtIndex:i];
        if ([array count] == 0) {
            [sortedArray removeObjectAtIndex:i];
            [self.sectionTitles removeObjectAtIndex:i];
        }
    }
    
    
    NSLog(@"%@",sortedArray);
    
    self.sortedArray = [sortedArray mutableCopy];
    
    
    [_tab reloadData];
    
    
}


#pragma mark- UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.sortedArray.count;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[self.sortedArray objectAtIndex:section] count];
    
};


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    
    NSArray *data = [self.sortedArray objectAtIndex:indexPath.section];
    
    cell.textLabel.text = data[indexPath.row];
    
    
    return cell;
    
    
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    NSArray *data = [self.sortedArray objectAtIndex:section];
    
    NSString *name = data[0];
    NSString *firstLetter = [EaseChineseToPinyin pinyinFromChineseString:name];
    
    NSString *showtext = [firstLetter substringToIndex:1];
    
    if ([self isPureInt:showtext]) {
        
        showtext = @"数字专栏";
    }
    
    return showtext;
    
}

- (BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}


@end
