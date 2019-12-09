# TuyaSmartSocketKit 云云对接

>`TuyaSmartSocketKit`主要针对涂鸦云云对接的产品中iOS端开发者。该项目旨在提供iPhone手机（以下简称手机）与硬件设备（以下简称设备）的局域网连接，并在局域网中发送dpCode进行设备控制通信。

涂鸦设备连接与控制流程如下：
https://cdn.nlark.com/yuque/__puml/1de1d74497bdbb14a4debde42f3f3f34.svg

# 对接步骤
`TuyaSmartSocketKit` 使用入口 `TuyaSmartSocket` 。

#### 一 局域网初始化

使用以下方式可以连接局域网。
```
[[TuyaSmartSocket sharedInstance] startSocketService];
```

若需要监听局域网的变化，可以使用以下方法：
```
[TuyaSmartSocket sharedInstance].delegate = self;
```

#### 二 连接设备
设备信息通过  TuyaSmartSocoket  以下方法告知其会对设备进行局域网的连接。
该参数可以通过云云对接的接口 `/v1.0/devices/schema` 获取到。
```
/**
 *  set device info
 *  设置设备的基本信息
 *
 *  @param devInfo   devInfo
 */
- (void)addDeviceInfoWIthDevInfo:(NSDictionary *)devInfo;
```

#### 三 设备通信
在delegate回调中，成功进行连接后可以对设备进行控制。
```
- (void)socketDidTcpConnected:(TuyaSmartSocket *)socket devId:(NSString *)devId;
```

通过以下方式对设备发送dpCode控制设备。
```
/**
*  publish message in lan use standard data point
*
*  使用标准dpCode发送局域网消息
*
*  @param devId    devId
*  @param dpCodeDict   dpCode : dpValue
*  @param success  Success block
*  @param failure  Failure block
*/
- (void)sendRequestWithDevId:(NSString *)devId
                 dpcodeValue:(NSDictionary<NSString */* dpCode */,id/* dpValue */> *)dpCodeDict
                     success:(void(^)(void))success
                     failure:(void(^)(void))failure;
```

`dpCodeValue`组成规则：
要了解dp点的详细信息，可以参考 [设备功能点](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/Device.html#%E8%AE%BE%E5%A4%87%E5%8A%9F%E8%83%BD%E7%82%B9)

`dpCode`是描述设备的功能点，即一个设备支持哪些功能控制。在 " /v1.0/devices/schema" 接口中返回的schema 中会返回的就是设备支持的功能点。以下分别对典型的功能点进行说明。
`dpCodeDict`均以 `dpCode` : `dpValue` 的格式进行。`dpCode`可以从schema中 code 字段获得。`dpValue`需要根据dp点支持的格式发送。
以下将以接口文档中给出的Demo为例，说明dpCode如何构成。
###### 1. 开关
    "type": "bool"
    e.g. {@"switch_led" : YES} 或者 {@"switch_led" : YES}
```
{
    "mode": "rw",
    "code": "switch_led",
    "name": "开关 ",
    "property": {
        "type": "bool"
    },
    "iconname": "icon- dp_power2",
    "id": 20,
    "type": "obj",
    "desc": ""
}
```
###### 2. 模式选择 (单选)

    "type": "enum"
    e.g. dpCode : {@"work_mode" : @"white"} {@"work_mode" : @"colour"}
```
{
    "mode": "rw",
    "code": "work_mode",
    "name": "模式",
    "property": {
        "range": ["white", "colour", "scene", "music"],
        "type": "enum"
    },
    "iconname": "i con-dp_list",
    "id": 21,
    "type": "obj",
    "desc": ""
}
```

###### 3. 亮度值(发送数值)
    "type": "value"
    e.g. dpCode: {@"bright_value": @(400)}
    注意：这里的数值有最大值、最小值、步进值限制。
```
{
    "mode": "rw",
    "code": "bright_value",
    "name": "亮度值",
    "property": {
        "min": 10,
        "max": 1000,
        "scale": 0,
        "step": 1,
        "type": "value"
    },
    "iconname ": "icon-dp_sun",
    "id": 22,
    "type": "obj",
    "desc": ""
}
```
###### 4. 彩光(发送字符串)
    "type": "string"
    e.g. dpCode: {@"colour_data":@"000100010001"} 
    以上方式只是其中一种传递方式，具体的deValue值需要针对具体情况进行分析
```
{
    "mode": "rw",
    "code": "colour_data",
    "name": "彩光",
    "property": {
        "type": "string",
        "maxlen": 255
    },
    "iconname": "icon- dp_light",
    "id": 24,
    "type": "obj",
    "desc": ""
}
```
###### 四 断开连接
```
[[TuyaSmartSocket sharedInstance] closeSocketService];
[TuyaSmartSocket sharedInstance].delegate = nil;
```
