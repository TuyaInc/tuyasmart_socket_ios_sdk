//
//  TuyaSmartSocket.h
//  Pods
//
//  Created by XuChengcheng on 2019/8/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class TuyaSmartSocket;

@protocol TuyaSmartSocketDelegate <NSObject>

@optional

#pragma mark - TCP Delegate

/**
 *  TCP connected
 *  设备TCP 连接成功
 *
 *  @param socket instance
 *  @param devId  devId
 */
- (void)socketDidTcpConnected:(TuyaSmartSocket *)socket devId:(NSString *)devId;

/**
*  Receive LAN message
*  接收到消息
*
*  @param socket instance
*  @param dpCodes    message body
*  @param devId  devId
*/
- (void)socket:(TuyaSmartSocket *)socket didReceiveDpCodes:(NSDictionary<NSString */* dpCode */,id/* dpValue */> *)dpCodes devId:(NSString *)devId;

/**
 *  TCP disconnected
 *  设备TCP 断开
 *
 *  @param socket instance
 *  @param devId  devId
 *  @param error  error
 */
- (void)socketDidTcpDisconnect:(TuyaSmartSocket *)socket devId:(NSString *)devId error:(NSError *)error;

@end

@interface TuyaSmartSocket : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, weak) id<TuyaSmartSocketDelegate> delegate;

/// Open debug mode
/// 开启 debug 模式
@property (nonatomic, assign) BOOL debugMode;

/// List of connected devices
/// 连接成功的设备列表
@property (nonatomic, strong) NSArray *connectedList;

/**
 *  start socket service
 *  初始化局域网服务
 */
- (void)startSocketService;

/**
 *  set device info
 *  设置设备的基本信息
 *
 *  @param devInfo   devInfo
 */
- (void)addDeviceInfoWIthDevInfo:(NSDictionary *)devInfo;

/**
 *  remove device info
 *  删除设备的基本信息
 *
 *  @param devId     devId
 */
- (void)removeDeviceInfoWithDevId:(NSString *)devId;

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

// close socket service
- (void)closeSocketService;

@end

NS_ASSUME_NONNULL_END
