# Seekcy Beacon SDK for iOS#

## Overview ##

Seekcy Beacon SDK for iOS是一个二次开发使用的库，以便与iBeacons进行互动。
该SDK系统要求iOS7及以上，设备要求iphone4S及以上。

[Seekcy SDK for Android](https://github.com/Seekcy/SeekcyBeacon_SDK_Android)这是Android SDK链接地址。

SDK包括的功能:

- Beacon 广播扫描
- Beacon 区域监听
- Beacon 连接、读取、配置

SDK API文档: 

 - [API文档](http://seekcy.github.io/SeekcyBeacon_SDK_IOS)

SDK 示例工程: 

- [示例工程](https://github.com/Seekcy/SeekcyBeacon_SDK_IOS/tree/master/iOS_SDK_Demo/SDKDemo)

公司官网:

 - [苏州寻息电子科技有限公司](http://www.seekcy.com)
 
更新日志:

#2.2.0(2016.7.21)#
- 1. 适配 3-3-0

#1.1.0(2016.6.21)#
- 1. 适配T1U 18-1-0

#1.1.0(2016.4.8)#
- 1. 新增推送接口 startRangedNearBySKYBeaconsInRegions:

#1.0.7(2016.4.5)#
- 1. 修改M0L发射功率不能配置到-21dBm的问题

#1.0.6(2015.11.5)#
- 1. 修改beacon的发送间隔显示问题

#1.0.5(2015.11.2)#
- 1. 在 [[SKYBeaconManager sharedDefaults] startScanForSKYBeaconWithDelegate:self uuids:scanUUIDArray distinctionMutipleID:NO isReturnValueEncapsulation:NO]; 方法中增加distance的返回。

#1.0.4(2015.10.26)#
- 1. 原来是framework动态库，现在改成framework静态库

#1.0.3(2015.10.08)#
- 1. 增加通过硬件版本、主次软件版本获取beacon版本的方法（在SKYBeaconManager中）

#1.0.2(2015.09.14)#
- 1. 增加在读/写beacon的时候增加对beacon版本的判断
- 2. 其他优化

#1.0.1(2015.08.03)#
- 1. 增加取消连接单id beacon时delegate方式
- 2. 其他优化

#1.0.0(2015.07.13)#
- 1. 修改iOS连接beacon区分单id和多id，并且由原来的block改为delegate方式。
- 2. 暂时弃用连接beacon时用block方式，后期会加上。
- 3. 优化内存管理
- 4. 优化错误码
- 5. 其他优化

#1.0.0(2015.07.03)#
- 1.sdk初始版本。




 




