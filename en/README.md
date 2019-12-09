# TuyaSmartSocketKit Cloud to Tuyayun

> TuyaSmartSocketKit mainly aimed at iOS developers in Tuyayun cloud-connected products.The project aims to provide a local area network connection between an iPhone (hereinafter referred to as a phone) and a hardware device (hereinafter referred to as a device), and send dpCode in the local area network for device control communication.

Tuya device connection and control process is as follows:
https://cdn.nlark.com/yuque/__puml/1de1d74497bdbb14a4debde42f3f3f34.svg

# STEP
#### 1 LAN initialization 
Use the following methods to connect to a LAN.

```
[[TuyaSmartSocket sharedInstance] startSocketService];
```

If you need to monitor LAN changes, you can use the following :
```
[TuyaSmartSocket sharedInstance].delegate = self;
```

#### 2 Connect the device

In the delegate callback, the device can be controlled after a successful connection.
This parameter can be obtained through the cloud-docking interface `/ v1.0 / devices / schema`.
```
/**
 *  set device info
 *  设置设备的基本信息
 *
 *  @param devInfo   devInfo
 */
- (void)addDeviceInfoWIthDevInfo:(NSDictionary *)devInfo;
```

#### 3 Device communication
In the delegate callback, the device can be controlled after a successful connection.
```
- (void)socketDidTcpConnected:(TuyaSmartSocket *)socket devId:(NSString *)devId;
```

Send dpCode to the device to control the device in the following way.
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
`dpCodeValue` composition rules:
To learn more about dp points, you can refer to [Update device information](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/Device.html#update-device-information).
`dpCode` is a function point that describes the device, that is, which function controls a device supports. The schema returned in the `/v1.0/devices/schema` interface will return the feature points supported by the device. The typical function points are described below.
`dpCodeDict` is performed in the format `dpCode` : `dpValue` . `dpCode`  can be obtained from the code field in the schema. `dpValue`  needs to be sent according to the format supported by the `dp point`.
The following will take Demo given in the interface document as an example to explain how dpCode  is structured.

###### 1. Switch
    "type": "bool"
    e.g. {@"switch_led" : YES} or {@"switch_led" : YES}

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

###### 2. Mode option (signal choose)
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

###### 3. Brightness value (send number)
    "type": "value"
    e.g. dpCode: {@"bright_value": @(400)}
    Note: The values here are limited by maximum, minimum and step values.
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
###### 4. Color data (send string)
    "type": "string"
    e.g. dpCode: {@"colour_data":@"000100010001"} 
    The above  is only one of the transmission methods. The specific deValue value needs to be analyzed for specific situations.
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

###### 4 Disconnect
```
[[TuyaSmartSocket sharedInstance] closeSocketService];
[TuyaSmartSocket sharedInstance].delegate = nil;
```
