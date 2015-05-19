# SNSegmentControl 加载不同的两个viewcontroller

比如：在主的MainViewController界面上加载不同的TestAViewController和TestBViewController

1：首先你把MainViewController改为继承SNSegmentViewController，并导入TestAViewController和TestBViewController。

#2：使用方法

UIStoryboard *tempSB = [UIStoryboard storyboardWithName:@"你的故事板名" bundle:nil];
    TestAViewController *testACtl = [ticketSB instantiateViewControllerWithIdentifier:@"TestAViewController"];
    TestBViewController *testBCtl = [ticketSB instantiateViewControllerWithIdentifier:@"TestBViewController"];
    NSArray *ctlArr = @[testACtl,testBCtl];
    [self loadSetViewController:ctlArr andSegementTitle:@[@"TestA",@"TestB"] andCompleteHandler:^(NSInteger selectSegmentIndex) {
        selectIndex = selectSegmentIndex;
    }];
