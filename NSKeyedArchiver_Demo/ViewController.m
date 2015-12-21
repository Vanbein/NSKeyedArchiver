//
//  ViewController.m
//  NSKeyedArchiver_Demo
//
//  Created by 王斌 on 15/9/17.
//  Copyright (c) 2015年 Changhong electric Co., Ltd. All rights reserved.
//

#import "ViewController.h"
#import "CHStudent.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextField *nameLabel;

@property (strong, nonatomic) IBOutlet UITextField *ageLabel;

@property (strong, nonatomic) IBOutlet UITextField *scoreLabel;

@property (strong, nonatomic) IBOutlet UITableView *listTalelView;


@property(nonatomic, strong)NSString *filePath; //保存文件路径

@property(nonatomic, strong)NSMutableArray *allInfoArray;

@property(nonatomic, assign)NSInteger cellIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取文档路径
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    self.filePath = [documentsPath stringByAppendingPathComponent:@"file.archive"];
    
    //    self.allInfoArray = [NSMutableArray array];
    //
    //    [NSKeyedArchiver archiveRootObject:_allInfoArray toFile:_filePath];
    //
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - IBAction

- (IBAction)saveButtonClicked:(UIButton *)sender {
    
    //对信息完整度进行判断，提示
    if ([self.nameLabel.text isEqualToString:@""] || [self.ageLabel.text isEqualToString:@""] || [self.scoreLabel.text isEqualToString:@""]) {
        //NSLog(@"信息不完整");
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"信息不完整，请输入完整信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    CHStudent *student = [[CHStudent alloc]initWithName:self.nameLabel.text age:[self.ageLabel.text integerValue] score:[self.scoreLabel.text integerValue]];
    
    //1.读取出已有的数据
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:_filePath];
    NSLog(@"%@",array);
    self.allInfoArray = [NSMutableArray arrayWithArray:array];
    //2.添加数据
    [self.allInfoArray addObject:student];
    //3.归档保存
    [NSKeyedArchiver archiveRootObject:_allInfoArray toFile:_filePath];
    
    //刷新
    [self.listTalelView reloadData];
    
    //清楚输入的数据
    self.nameLabel.text = @"";
    self.ageLabel.text = @"";
    self.scoreLabel.text = @"";
    
}

- (IBAction)showButtonClicked:(UIButton *)sender {
    
    //读取
    //1.读取出已有的数据
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:_filePath];
    self.allInfoArray = [NSMutableArray arrayWithArray:array];
    
    [self.listTalelView reloadData];
}

#pragma mark - table view delegate

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allInfoArray.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"数据列表";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //获得这个cell的数据的index
    self.cellIndex = indexPath.row;
    
    //显示提示信息
    CHStudent *stu = [_allInfoArray objectAtIndex:indexPath.row];
    NSString *message = [NSString stringWithFormat:@"是否删除数据：name:%@ age:%ld score:%ld", stu.name, stu.age, stu.score];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell_id"];
    }
    
    CHStudent *stu = [_allInfoArray objectAtIndex:indexPath.row];
    cell.textLabel.text = stu.name;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    NSString *tempStr = [[NSString alloc]initWithFormat:@"age:%ld  score: %ld",stu.age, stu.score];
    cell.detailTextLabel.text = tempStr;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    
    return cell;
    
}


#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //buttonIndex,从0开始，
    //点击确定，删除数据
    if (buttonIndex == 1) {
        [self deleteSelectedCellDataInPlistWithIndex:_cellIndex];
    }
}

#pragma mark - Custom Method

- (void) deleteSelectedCellDataInPlistWithIndex:(NSInteger )index{
    
    //1.读取出已有的数据
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:_filePath];
    self.allInfoArray = [NSMutableArray arrayWithArray:array];
    
    //删除数组中index对应的数据
    [self.allInfoArray removeObjectAtIndex:index];
    //重新归档保存
    [NSKeyedArchiver archiveRootObject:_allInfoArray toFile:_filePath];
    //刷新
    [self.listTalelView reloadData];
    
}





@end
