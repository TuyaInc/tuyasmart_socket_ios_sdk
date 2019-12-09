//
//  TYViewController.h
//  TuyaSmartSocketKit
//
//  Created by WenMingYan on 12/09/2019.
//  Copyright (c) 2019 WenMingYan. All rights reserved.
//

#import "TYViewController.h"
#import <TuyaSmartSocketKit/TuyaSmartSocketKit.h>

@interface TYViewController () <TuyaSmartSocketDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) BOOL wifiOpen;
@property (nonatomic, assign) BOOL subdeviceOpen;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TYViewController
#pragma mark - dealloc
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - Event Response

- (void)initSocketClient {
    [[TuyaSmartSocket sharedInstance] addDeviceInfoWIthDevInfo:@{
        @"device_info" : @{
                @"device_id" : @"xxx",
                @"capability" : @(1),
                @"local_key" : @"xxx",
                @"standard" : @(YES),
        },
        @"schemas" : @{
                @"functionSchemaList" :@[@{
                        @"relationDpIdMaps": @{@"switch_led" : @(20)},
                        @"standardType" : @"Boolean",
                        @"strategyCode" : @"default",
                        @"strategyValue": @"{\"switch_led\":\"$\"}",
                        @"standardCode" : @"switch_led"
                }],
                @"statusSchemaList" :@[@{
                        @"relationDpIdMaps": @{@"switch_led" : @(20)},
                        @"standardType"    : @"",
                        @"strategyCode"    : @"default",
                        @"strategyValue"   : @"{\"switch_led\":\"$\"}"
                },@{
                        @"relationDpIdMaps": @{@"work_mode" : @(21)},
                        @"dpCode"          : @"work_mode",
                        @"standardType"    : @"",
                        @"strategyCode"    : @"default",
                        @"strategyValue"   : @"{\"switch_led\":\"$\"}"
                }],
                @"schema_info" : @{
                        @"schema" : @"[{\"mode\":\"rw\",\"code\":\"switch_led\",\"name\":\"开关\",\"property\":{\"type\":\"bool\"},\"iconname\":\"icon- dp_power2\",\"id\":20,\"type\":\"obj\",\"desc\":\"\"}, {\"mode\":\"rw\",\"code\":\"work_mode\",\"name\":\"模式\",\"property\": {\"range\": [\"white\",\"colour\",\"scene\",\"music\"],\"type\":\"enum\"},\"iconname\":\"i con-dp_list\",\"id\":21,\"type\":\"obj\",\"desc\":\"\"}, {\"mode\":\"rw\",\"code\":\"bright_value\",\"name\":\"亮度值\",\"property\": {\"min\":10,\"max\":1000,\"scale\":0,\"step\":1,\"type\":\"value\"},\"iconname \":\"icon-dp_sun\",\"id\":22,\"type\":\"obj\",\"desc\":\"\"}, {\"mode\":\"rw\",\"code\":\"temp_value\",\"name\":\"冷暖值\",\"property\": {\"min\":0,\"max\":1000,\"scale\":0,\"step\":1,\"type\":\"value\"},\"iconname\":\"icon-dp_half\",\"id\":23,\"type\":\"obj\",\"desc\":\"\"}, {\"mode\":\"rw\",\"code\":\"colour_data\",\"name\":\"彩光\",\"property\": {\"type\":\"string\",\"maxlen\":255},\"iconname\":\"icon- dp_light\",\"id\":24,\"type\":\"obj\",\"desc\":\"\"}, {\"mode\":\"rw\",\"code\":\"scene_data\",\"name\":\"场景\",\"property\": {\"type\":\"string\",\"maxlen\":255},\"iconname\":\"icon- dp_box2\",\"id\":25,\"type\":\"obj\",\"desc\":\"\"}, {\"mode\":\"rw\",\"code\":\"countdown\",\"name\":\"倒计时剩余时间\",\"property\": {\"min\":0,\"max\":86400,\"scale\":0,\"step\":1,\"type\":\"value\"},\"iconname \":\"icon-timer1\",\"id\":26,\"type\":\"obj\",\"desc\":\"\"}, {\"mode\":\"rw\",\"code\":\"control_data\",\"name\":\"调节\",\"property\": {\"type\":\"string\",\"maxlen\":255},\"iconname\":\"icon- setting\",\"id\":28,\"type\":\"obj\",\"desc\":\"\"}]",
                        @"schemaExt" : @[]
                }
        },
    }];
    [[TuyaSmartSocket sharedInstance] addDeviceInfoWIthDevInfo:@{
        @"device_info" : @{
                @"device_id" : @"xxx",
                @"capability" : @(1),
                @"local_key" : @"xxx",
                @"standard" : @(YES),
        },
        @"schemas" : @{
                @"functionSchemaList" :@[@{
                        @"relationDpIdMaps": @{@"switch_led" : @(20)},
                        @"standardType" : @"Boolean",
                        @"strategyCode" : @"default",
                        @"strategyValue": @"{\"switch_led\":\"$\"}",
                        @"standardCode" : @"switch_led"
                }],
                @"statusSchemaList" :@[@{
                        @"relationDpIdMaps": @{@"switch_led" : @(20)},
                        @"standardType"    : @"",
                        @"strategyCode"    : @"default",
                        @"strategyValue"   : @"{\"switch_led\":\"$\"}"
                },@{
                        @"relationDpIdMaps": @{@"work_mode" : @(21)},
                        @"dpCode"          : @"work_mode",
                        @"standardType"    : @"",
                        @"strategyCode"    : @"default",
                        @"strategyValue"   : @"{\"switch_led\":\"$\"}"
                }],
                @"schema_info" : @{
                        @"schema" : @"[{\"mode\":\"rw\",\"code\":\"switch_led\",\"name\":\"开关\",\"property\":{\"type\":\"bool\"},\"iconname\":\"icon- dp_power2\",\"id\":20,\"type\":\"obj\",\"desc\":\"\"}, {\"mode\":\"rw\",\"code\":\"work_mode\",\"name\":\"模式\",\"property\": {\"range\": [\"white\",\"colour\",\"scene\",\"music\"],\"type\":\"enum\"},\"iconname\":\"i con-dp_list\",\"id\":21,\"type\":\"obj\",\"desc\":\"\"}, {\"mode\":\"rw\",\"code\":\"bright_value\",\"name\":\"亮度值\",\"property\": {\"min\":10,\"max\":1000,\"scale\":0,\"step\":1,\"type\":\"value\"},\"iconname \":\"icon-dp_sun\",\"id\":22,\"type\":\"obj\",\"desc\":\"\"}, {\"mode\":\"rw\",\"code\":\"temp_value\",\"name\":\"冷暖值\",\"property\": {\"min\":0,\"max\":1000,\"scale\":0,\"step\":1,\"type\":\"value\"},\"iconname\":\"icon-dp_half\",\"id\":23,\"type\":\"obj\",\"desc\":\"\"}, {\"mode\":\"rw\",\"code\":\"colour_data\",\"name\":\"彩光\",\"property\": {\"type\":\"string\",\"maxlen\":255},\"iconname\":\"icon- dp_light\",\"id\":24,\"type\":\"obj\",\"desc\":\"\"}, {\"mode\":\"rw\",\"code\":\"scene_data\",\"name\":\"场景\",\"property\": {\"type\":\"string\",\"maxlen\":255},\"iconname\":\"icon- dp_box2\",\"id\":25,\"type\":\"obj\",\"desc\":\"\"}, {\"mode\":\"rw\",\"code\":\"countdown\",\"name\":\"倒计时剩余时间\",\"property\": {\"min\":0,\"max\":86400,\"scale\":0,\"step\":1,\"type\":\"value\"},\"iconname \":\"icon-timer1\",\"id\":26,\"type\":\"obj\",\"desc\":\"\"}, {\"mode\":\"rw\",\"code\":\"control_data\",\"name\":\"调节\",\"property\": {\"type\":\"string\",\"maxlen\":255},\"iconname\":\"icon- setting\",\"id\":28,\"type\":\"obj\",\"desc\":\"\"}]",
                        @"schemaExt" : @[]
                }
        },
    }];
    [[TuyaSmartSocket sharedInstance] addDeviceInfoWIthDevInfo:@{
        @"device_info" : @{
                @"device_id" : @"xxx",
                @"capability" : @(1),
                @"local_key" : @"xxx",
                @"node_id"  : @"xxx",
                @"mesh_id"  : @"xxx",
                @"standard" : @(YES),
        },
        @"schemas" : @{
                @"functionSchemaList" :@[@{
                        @"relationDpIdMaps": @{@"switch_led" : @(20)},
                        @"standardType" : @"Boolean",
                        @"strategyCode" : @"default",
                        @"strategyValue": @"{\"switch_led\":\"$\"}",
                        @"standardCode" : @"switch_led"
                }],
                @"statusSchemaList" :@[@{
                        @"relationDpIdMaps": @{@"switch_led" : @(20)},
                        @"standardType"    : @"",
                        @"strategyCode"    : @"default",
                        @"strategyValue"   : @"{\"switch_led\":\"$\"}"
                },@{
                        @"relationDpIdMaps": @{@"work_mode" : @(21)},
                        @"dpCode"          : @"work_mode",
                        @"standardType"    : @"",
                        @"strategyCode"    : @"default",
                        @"strategyValue"   : @"{\"switch_led\":\"$\"}"
                }],
                @"schema_info" : @{
                        @"schema" : @"[{\"mode\":\"rw\",\"code\":\"switch_led\",\"name\":\"开关\",\"property\":{\"type\":\"bool\"},\"iconname\":\"icon- dp_power2\",\"id\":20,\"type\":\"obj\",\"desc\":\"\"}, {\"mode\":\"rw\",\"code\":\"work_mode\",\"name\":\"模式\",\"property\": {\"range\": [\"white\",\"colour\",\"scene\",\"music\"],\"type\":\"enum\"},\"iconname\":\"i con-dp_list\",\"id\":21,\"type\":\"obj\",\"desc\":\"\"}, {\"mode\":\"rw\",\"code\":\"bright_value\",\"name\":\"亮度值\",\"property\": {\"min\":10,\"max\":1000,\"scale\":0,\"step\":1,\"type\":\"value\"},\"iconname \":\"icon-dp_sun\",\"id\":22,\"type\":\"obj\",\"desc\":\"\"}, {\"mode\":\"rw\",\"code\":\"temp_value\",\"name\":\"冷暖值\",\"property\": {\"min\":0,\"max\":1000,\"scale\":0,\"step\":1,\"type\":\"value\"},\"iconname\":\"icon-dp_half\",\"id\":23,\"type\":\"obj\",\"desc\":\"\"}, {\"mode\":\"rw\",\"code\":\"colour_data\",\"name\":\"彩光\",\"property\": {\"type\":\"string\",\"maxlen\":255},\"iconname\":\"icon- dp_light\",\"id\":24,\"type\":\"obj\",\"desc\":\"\"}, {\"mode\":\"rw\",\"code\":\"scene_data\",\"name\":\"场景\",\"property\": {\"type\":\"string\",\"maxlen\":255},\"iconname\":\"icon- dp_box2\",\"id\":25,\"type\":\"obj\",\"desc\":\"\"}, {\"mode\":\"rw\",\"code\":\"countdown\",\"name\":\"倒计时剩余时间\",\"property\": {\"min\":0,\"max\":86400,\"scale\":0,\"step\":1,\"type\":\"value\"},\"iconname \":\"icon-timer1\",\"id\":26,\"type\":\"obj\",\"desc\":\"\"}, {\"mode\":\"rw\",\"code\":\"control_data\",\"name\":\"调节\",\"property\": {\"type\":\"string\",\"maxlen\":255},\"iconname\":\"icon- setting\",\"id\":28,\"type\":\"obj\",\"desc\":\"\"}]",
                        @"schemaExt" : @[]
                }
        },
    }];
    [[TuyaSmartSocket sharedInstance] startSocketService];
    [TuyaSmartSocket sharedInstance].delegate = self;
}

- (void)sendWifiDevice {
    _wifiOpen = !_wifiOpen;
    NSDictionary *dpCode = @{@"switch_led":@(_wifiOpen)};
    [[TuyaSmartSocket sharedInstance] sendRequestWithDevId:<#devId#> /* wifi device device_id */
                                               dpcodeValue:dpCode
                                                   success:^{
        NSLog(@"send success");
    } failure:^{
        NSLog(@"send failure");
    }];
}

- (void)sendSubdeviceOfGateway {
    _subdeviceOpen = !_subdeviceOpen;
    NSDictionary *dpCode = @{@"switch_led":@(_subdeviceOpen)};
    [[TuyaSmartSocket sharedInstance] sendRequestWithDevId:<#devId#> /* subdevice device_id */
                                               dpcodeValue:dpCode
                                                   success:^{
        NSLog(@"send success");
    } failure:^{
        NSLog(@"send failure");
    }];
}

- (void)stopSocketConnect {
    [[TuyaSmartSocket sharedInstance] closeSocketService];
    [TuyaSmartSocket sharedInstance].delegate = nil;
}

- (NSArray *)titles {
    return @[
        @"init socket connect",
        @"send Wifi device",
        @"send subdevice of gateway",
        @"stop socket connect"
    ];
}

- (NSDictionary *)methods {
    return @{
        @"init socket connect" : @"initSocketClient",
        @"send Wifi device" : @"sendWifiDevice",
        @"send subdevice of gateway" : @"sendSubdeviceOfGateway",
        @"stop socket connect" : @"stopSocketConnect"
    };
}


#pragma mark - UITableViewDelegate , UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = [self.titles objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self titles].count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = [self.titles objectAtIndex:indexPath.row];
    if (title) {
        NSString *selector = [[self methods] objectForKey:title];
        if ([self respondsToSelector:NSSelectorFromString(selector)]) {
            [self performSelector:NSSelectorFromString(selector) withObject:nil];
        }
    }
}

#pragma mark - TuyaSmartSocketDelegate

- (void)socketDidTcpConnected:(TuyaSmartSocket *)socket devId:(NSString *)devId {
    NSLog(@"socket tcp connected with devId : %@", devId);
}

- (void)socket:(TuyaSmartSocket *)socket didReceiveDps:(NSDictionary *)dps devId:(NSString *)devId {
    NSLog(@"socket receive dps with devId : %@, dps : %@", devId, dps);
}

- (void)socketDidTcpDisconnect:(TuyaSmartSocket *)socket devId:(NSString *)devId error:(NSError *)error {
    NSLog(@"socket tcp disconnected with devId : %@, error : %@", devId, error);
}

#pragma mark - getters & setters & init members

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    }
    return _tableView;
}

@end
