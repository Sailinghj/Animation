//
//  ViewController.m
//  Animation
//
//  Created by Sailinghj on 16/1/12.
//  Copyright © 2016年 Sailinghj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)NSArray *viewControllers;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _viewControllers = @[@"GoogleLoading", @"UIViewAnimation"];
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewControllers.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath   {
    UITableViewCell *cell = [UITableViewCell new];
    cell.textLabel.text = _viewControllers[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath   {
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    Class viewClass = NSClassFromString([_viewControllers[indexPath.row] stringByAppendingString:@"ViewController"]);
    if (viewClass != nil) {
        [self.navigationController pushViewController:[viewClass new] animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
