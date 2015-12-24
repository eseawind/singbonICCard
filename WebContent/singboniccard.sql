/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : singboniccard

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2015-12-24 18:36:55
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `authgroup`
-- ----------------------------
DROP TABLE IF EXISTS `authgroup`;
CREATE TABLE `authgroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `groupName` varchar(11) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  `roles` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of authgroup
-- ----------------------------
INSERT INTO `authgroup` VALUES ('1', '1', '管理员', '', 'ROLE_SYSTEMMANAGER,ROLE_SYSTEMSETTING,ROLE_SYSTEMPARAM,ROLE_SYSTEMPARAM_SAVE,ROLE_BATCH,ROLE_BATCH_ADD,ROLE_BATCH_EDIT,ROLE_BATCH_DEL,ROLE_USERDEPT,ROLE_USERDEPT_ADD,ROLE_USERDEPT_EDIT,ROLE_USERDEPT_DEL,ROLE_DEPT,ROLE_DEPT_ADD,ROLE_DEPT_EDIT,ROLE_DEPT_DEL,ROLE_MEAL,ROLE_MEAL_SAVE,ROLE_COOKBOOK,ROLE_COOKBOOK_SAVE,ROLE_ORDERTIME,ROLE_ORDERTIME_SAVE,ROLE_DISCOUNT,ROLE_DISCOUNT_SAVE,ROLE_CONSUMEPARAM,ROLE_CONSUMEPARAM_SAVE,ROLE_POSPARAMGROUP,ROLE_POSPARAMGROUP_ADD,ROLE_POSPARAMGROUP_EDIT,ROLE_POSPARAMGROUP_DEL,ROLE_POSPARAMGROUP_SAVE,ROLE_WATERRATEGROUP,ROLE_WATERRATEGROUP_ADD,ROLE_WATERRATEGROUP_EDIT,ROLE_WATERRATEGROUP_DEL,ROLE_WATERRATEGROUP_SAVE,ROLE_CARDPARAM,ROLE_CARDPARAM_SAVE,ROLE_CARDPARAM,ROLE_CARDPARAM_SAVE,ROLE_ENTRANCEGUARD,ROLE_ENTRANCEGUARD_SAVE,ROLE_DEVICEMANAGER,ROLE_DEVICEMANAGER_POS,ROLE_DEVICEMANAGER_POS_ADD,ROLE_DEVICEMANAGER_POS_EDIT,ROLE_DEVICEMANAGER_POS_DEL,ROLE_DEVICEMANAGER_TRANSFER,ROLE_DEVICEMANAGER_TRANSFER_ADD,ROLE_DEVICEMANAGER_TRANSFER_EDIT,ROLE_DEVICEMANAGER_TRANSFER_DEL,ROLE_DEVICEMANAGER_CARDREADER,ROLE_DEVICEMANAGER_CARDREADER_ADD,ROLE_DEVICEMANAGER_CARDREADER_EDIT,ROLE_DEVICEMANAGER_CARDREADER_DEL,ROLE_SYSUSER,ROLE_SYSUSER_ADD,ROLE_SYSUSER_EDIT,ROLE_SYSUSER_DEL,ROLE_USERROLES,ROLE_USERROLES_GROUP,ROLE_SYSUSER_ADD,ROLE_SYSUSER_EDIT,ROLE_SYSUSER_DEL,ROLE_USERROLES_USER,ROLE_USERROLES_USER_SAVE,ROLE_SUBSIDY,ROLE_SUBSIDY_USER,ROLE_SUBSIDY_USER_ADDUSER,ROLE_SUBSIDY_GENERATE,ROLE_SUBSIDY_GENERATE_ADDFARE,ROLE_SUBSIDY_GENERATE_EDIT,ROLE_SUBSIDY_GENERATE_AUTO,ROLE_SUBSIDY_GENERATE_DEL,ROLE_SUBSIDY_GENERATE_TRANSFER,ROLE_SUBSIDY_GENERATE_GENERATE,ROLE_CARDMANAGER,ROLE_MAINCARD,ROLE_MAINCARD_INFO,ROLE_MAINCARD_EDIT,ROLE_MAINCARD_DEPT,ROLE_MAINCARD_SINGLE,ROLE_MAINCARD_INFOCARD,ROLE_MAINCARD_BATCH,ROLE_MAINCARD_READCARD,ROLE_MAINCARD_LOSS,ROLE_MAINCARD_UNLOSS,ROLE_MAINCARD_REMAKECARD,ROLE_MAINCARD_OFFWITHCARD,ROLE_MAINCARD_CHARGE,ROLE_MAINCARD_DELETE,ROLE_FUNCCARD,ROLE_CARDREADER,ROLE_ACCOUNTCENTER,ROLE_MONITOR,');
INSERT INTO `authgroup` VALUES ('2', '1', '出纳员', null, 'ROLE_CARDMANAGER,ROLE_MAINCARD,ROLE_MAINCARD_INFO,ROLE_MAINCARD_EDIT,ROLE_MAINCARD_DEPT,ROLE_MAINCARD_SINGLE,ROLE_MAINCARD_INFOCARD,ROLE_MAINCARD_BATCH,ROLE_MAINCARD_READCARD,ROLE_MAINCARD_LOSS,ROLE_MAINCARD_UNLOSS,ROLE_MAINCARD_REMAKECARD,ROLE_MAINCARD_CHANGECARD,ROLE_MAINCARD_OFFWITHCARD,ROLE_MAINCARD_OFFNOCARD,ROLE_MAINCARD_CHARGE,ROLE_MAINCARD_DELETE,ROLE_FUNCCARD,ROLE_CARDREADER,ROLE_ACCOUNTCENTER,ROLE_MONITOR,');

-- ----------------------------
-- Table structure for `authgroupbase`
-- ----------------------------
DROP TABLE IF EXISTS `authgroupbase`;
CREATE TABLE `authgroupbase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupName` varchar(11) DEFAULT NULL,
  `roles` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of authgroupbase
-- ----------------------------
INSERT INTO `authgroupbase` VALUES ('1', '管理员', 'ROLE_SYSTEMMANAGER,ROLE_SYSTEMSETTING,ROLE_SYSTEMPARAM,ROLE_SYSTEMPARAM_SAVE,ROLE_BATCH,ROLE_BATCH_ADD,ROLE_BATCH_EDIT,ROLE_BATCH_DEL,ROLE_USERDEPT,ROLE_USERDEPT_ADD,ROLE_USERDEPT_EDIT,ROLE_USERDEPT_DEL,ROLE_DEPT,ROLE_DEPT_ADD,ROLE_DEPT_EDIT,ROLE_DEPT_DEL,ROLE_MEAL,ROLE_MEAL_SAVE,ROLE_COOKBOOK,ROLE_COOKBOOK_SAVE,ROLE_ORDERTIME,ROLE_ORDERTIME_SAVE,ROLE_DISCOUNT,ROLE_DISCOUNT_SAVE,ROLE_CONSUMEPARAM,ROLE_CONSUMEPARAM_SAVE,ROLE_POSPARAMGROUP,ROLE_POSPARAMGROUP_ADD,ROLE_POSPARAMGROUP_EDIT,ROLE_POSPARAMGROUP_DEL,ROLE_POSPARAMGROUP_SAVE,ROLE_WATERRATEGROUP,ROLE_WATERRATEGROUP_ADD,ROLE_WATERRATEGROUP_EDIT,ROLE_WATERRATEGROUP_DEL,ROLE_WATERRATEGROUP_SAVE,ROLE_CARDPARAM,ROLE_CARDPARAM_SAVE,ROLE_CARDPARAM,ROLE_CARDPARAM_SAVE,ROLE_ENTRANCEGUARD,ROLE_ENTRANCEGUARD_SAVE,ROLE_DEVICEMANAGER,ROLE_DEVICEMANAGER_POS,ROLE_DEVICEMANAGER_POS_ADD,ROLE_DEVICEMANAGER_POS_EDIT,ROLE_DEVICEMANAGER_POS_DEL,ROLE_DEVICEMANAGER_TRANSFER,ROLE_DEVICEMANAGER_TRANSFER_ADD,ROLE_DEVICEMANAGER_TRANSFER_EDIT,ROLE_DEVICEMANAGER_TRANSFER_DEL,ROLE_DEVICEMANAGER_CARDREADER,ROLE_DEVICEMANAGER_CARDREADER_ADD,ROLE_DEVICEMANAGER_CARDREADER_EDIT,ROLE_DEVICEMANAGER_CARDREADER_DEL,ROLE_SYSUSER,ROLE_SYSUSER_ADD,ROLE_SYSUSER_EDIT,ROLE_SYSUSER_DEL,ROLE_USERROLES,ROLE_USERROLES_GROUP,ROLE_SYSUSER_ADD,ROLE_SYSUSER_EDIT,ROLE_SYSUSER_DEL,ROLE_USERROLES_USER,ROLE_USERROLES_USER_SAVE,ROLE_SUBSIDY,ROLE_SUBSIDY_USER,ROLE_SUBSIDY_USER_ADDUSER,ROLE_SUBSIDY_GENERATE,ROLE_SUBSIDY_GENERATE_ADDFARE,ROLE_SUBSIDY_GENERATE_EDIT,ROLE_SUBSIDY_GENERATE_AUTO,ROLE_SUBSIDY_GENERATE_DEL,ROLE_SUBSIDY_GENERATE_TRANSFER,ROLE_SUBSIDY_GENERATE_GENERATE,');
INSERT INTO `authgroupbase` VALUES ('2', '出纳员', 'ROLE_CARDMANAGER,ROLE_MAINCARD,ROLE_MAINCARD_INFO,ROLE_MAINCARD_EDIT,ROLE_MAINCARD_DEPT,ROLE_MAINCARD_SINGLE,ROLE_MAINCARD_INFOCARD,ROLE_MAINCARD_BATCH,ROLE_MAINCARD_READCARD,ROLE_MAINCARD_LOSS,ROLE_MAINCARD_UNLOSS,ROLE_MAINCARD_REMAKECARD,ROLE_MAINCARD_CHANGECARD,ROLE_MAINCARD_OFFWITHCARD,ROLE_MAINCARD_OFFNOCARD,ROLE_MAINCARD_CHARGE,ROLE_MAINCARD_DELETE,ROLE_FUNCCARD,ROLE_CARDREADER,ROLE_ACCOUNTCENTER,ROLE_MONITOR,');

-- ----------------------------
-- Table structure for `authgroupuser`
-- ----------------------------
DROP TABLE IF EXISTS `authgroupuser`;
CREATE TABLE `authgroupuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operId` int(11) DEFAULT NULL,
  `groupId` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of authgroupuser
-- ----------------------------
INSERT INTO `authgroupuser` VALUES ('1', '1', '1');

-- ----------------------------
-- Table structure for `batch`
-- ----------------------------
DROP TABLE IF EXISTS `batch`;
CREATE TABLE `batch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `batchName` varchar(255) DEFAULT NULL,
  `beginDate` varchar(50) DEFAULT NULL,
  `endDate` varchar(50) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of batch
-- ----------------------------
INSERT INTO `batch` VALUES ('1', '11', '2015-12-22', '2015-12-31', '1', '0');

-- ----------------------------
-- Table structure for `batchblack`
-- ----------------------------
DROP TABLE IF EXISTS `batchblack`;
CREATE TABLE `batchblack` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `batchId` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of batchblack
-- ----------------------------

-- ----------------------------
-- Table structure for `cardblack`
-- ----------------------------
DROP TABLE IF EXISTS `cardblack`;
CREATE TABLE `cardblack` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `cardNO` bigint(11) DEFAULT NULL,
  `blackType` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cardblack
-- ----------------------------
INSERT INTO `cardblack` VALUES ('1', '1', '2', '0');
INSERT INTO `cardblack` VALUES ('2', '1', '3', '0');

-- ----------------------------
-- Table structure for `cardparam`
-- ----------------------------
DROP TABLE IF EXISTS `cardparam`;
CREATE TABLE `cardparam` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `cardDeposit` int(11) DEFAULT NULL,
  `prepayFare` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cardparam
-- ----------------------------
INSERT INTO `cardparam` VALUES ('1', '1', '0', '0');

-- ----------------------------
-- Table structure for `cardparambase`
-- ----------------------------
DROP TABLE IF EXISTS `cardparambase`;
CREATE TABLE `cardparambase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cardCost` int(11) DEFAULT NULL,
  `cardDeposit` int(11) DEFAULT NULL,
  `prepayFare` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cardparambase
-- ----------------------------
INSERT INTO `cardparambase` VALUES ('1', '0', '0', '0');

-- ----------------------------
-- Table structure for `cardrecord`
-- ----------------------------
DROP TABLE IF EXISTS `cardrecord`;
CREATE TABLE `cardrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `operId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `cardNO` int(11) DEFAULT NULL,
  `cardSN` varchar(50) DEFAULT NULL,
  `recordType` int(11) DEFAULT NULL,
  `opFare` int(11) DEFAULT NULL,
  `oddFare` bigint(11) DEFAULT NULL,
  `subsidyOddFare` bigint(11) DEFAULT NULL,
  `cardOddFare` bigint(11) DEFAULT NULL,
  `cardSubsidyOddFare` bigint(11) DEFAULT NULL,
  `opCount` int(11) DEFAULT NULL,
  `subsidyOpCount` int(11) DEFAULT NULL,
  `cardOpCount` int(11) DEFAULT NULL,
  `cardSubsidyOpCount` int(11) DEFAULT NULL,
  `opTime` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cardrecord
-- ----------------------------
INSERT INTO `cardrecord` VALUES ('1', '1', '1', '1', '1', 'd4841941', '0', '10000', '0', '0', '0', '0', '1', '0', '1', '0', '2015-12-23 17:12:25');
INSERT INTO `cardrecord` VALUES ('2', '1', '0', '1', '1', 'D4841941', '10', '0', '9900', '0', '9900', '10000', '2', '3', '2', '1', '2015-12-23 17:15:58');
INSERT INTO `cardrecord` VALUES ('3', '1', '0', '1', '1', 'D4841941', '10', '0', '9900', '9900', '9900', '19900', '2', '3', '2', '3', '2015-12-23 17:42:48');
INSERT INTO `cardrecord` VALUES ('4', '1', '0', '1', '1', 'D4841941', '10', '0', '9900', '9900', '9900', '19900', '2', '4', '2', '3', '2015-12-23 17:42:48');
INSERT INTO `cardrecord` VALUES ('5', '1', '0', '1', '1', 'D4841941', '10', '0', '9900', '9900', '9900', '19900', '2', '5', '2', '3', '2015-12-23 17:42:48');
INSERT INTO `cardrecord` VALUES ('6', '1', '0', '1', '1', 'D4841941', '10', '0', '9900', '29900', '9900', '29900', '2', '4', '2', '4', '2015-12-23 17:49:12');
INSERT INTO `cardrecord` VALUES ('7', '1', '1', '2', null, '', '4', '0', null, '0', '0', '0', null, '0', '0', '0', '2015-12-24 16:10:39');
INSERT INTO `cardrecord` VALUES ('8', '1', '1', '3', null, '', '4', '0', null, '0', '0', '0', null, '0', '0', '0', '2015-12-24 16:10:59');
INSERT INTO `cardrecord` VALUES ('9', '1', '1', '6', '6', '90d24626', '0', '100000', '0', '0', '0', '0', '1', '0', '1', '0', '2015-12-24 17:02:04');
INSERT INTO `cardrecord` VALUES ('10', '1', '0', '6', '6', '90D24626', '10', '0', '98500', '10000', '98500', '10000', '10', '1', '10', '1', '2015-12-24 17:17:29');
INSERT INTO `cardrecord` VALUES ('11', '1', '0', '6', '6', '90D24626', '10', '0', '98500', '20000', '98500', '20000', '10', '2', '10', '2', '2015-12-24 18:26:11');
INSERT INTO `cardrecord` VALUES ('12', '1', '1', '7', '7', 'a48a2a41', '0', '10000', '0', '0', '0', '0', '1', '0', '1', '0', '2015-12-24 18:27:55');

-- ----------------------------
-- Table structure for `company`
-- ----------------------------
DROP TABLE IF EXISTS `company`;
CREATE TABLE `company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyName` varchar(255) DEFAULT NULL,
  `serialNumber` varchar(50) DEFAULT NULL,
  `authNumber` varchar(50) DEFAULT NULL,
  `baseSection` int(11) DEFAULT NULL,
  `heartInterval` int(11) DEFAULT NULL,
  `uploadInterval` int(11) DEFAULT NULL,
  `uploadErrTime` int(11) DEFAULT NULL,
  `accessTimeout` int(11) DEFAULT NULL,
  `transferInterval` int(11) DEFAULT NULL,
  `blackInterval` int(11) DEFAULT NULL,
  `invalidDate` varchar(255) DEFAULT NULL,
  `enable` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of company
-- ----------------------------
INSERT INTO `company` VALUES ('1', '郑州兴邦科技有限公司', '12345678', '0371', '1', '10', '2', '1', '10', '500', '1000', '', '');

-- ----------------------------
-- Table structure for `consumeparam`
-- ----------------------------
DROP TABLE IF EXISTS `consumeparam`;
CREATE TABLE `consumeparam` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `cardMinFare` int(11) DEFAULT NULL,
  `cardMinFareCardTypes` varchar(50) DEFAULT NULL,
  `dayLimitFare` int(11) DEFAULT NULL,
  `dayLimitFareCardTypes` varchar(50) DEFAULT NULL,
  `timeLimitFare` int(11) DEFAULT NULL,
  `timeLimitFareCardTypes` varchar(50) DEFAULT NULL,
  `userPwd` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of consumeparam
-- ----------------------------
INSERT INTO `consumeparam` VALUES ('1', '1', '0', ',,', '0', ',,', '0', ',,', '8888');

-- ----------------------------
-- Table structure for `consumeparambase`
-- ----------------------------
DROP TABLE IF EXISTS `consumeparambase`;
CREATE TABLE `consumeparambase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cardMinFare` int(11) DEFAULT NULL,
  `cardMinFareCardTypes` varchar(50) DEFAULT NULL,
  `dayLimitFare` int(11) DEFAULT NULL,
  `dayLimitFareCardTypes` varchar(50) DEFAULT NULL,
  `timeLimitFare` int(11) DEFAULT NULL,
  `timeLimitFareCardTypes` varchar(50) DEFAULT NULL,
  `userPwd` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of consumeparambase
-- ----------------------------
INSERT INTO `consumeparambase` VALUES ('1', '0', ',,', '0', ',,', '0', ',,', '8888');

-- ----------------------------
-- Table structure for `consumerecord`
-- ----------------------------
DROP TABLE IF EXISTS `consumerecord`;
CREATE TABLE `consumerecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `cardNO` int(11) DEFAULT NULL,
  `cardSeq` int(11) DEFAULT NULL,
  `cardSN` varchar(8) DEFAULT NULL,
  `deviceId` int(11) DEFAULT NULL,
  `sumFare` bigint(11) DEFAULT NULL,
  `oddFare` bigint(11) DEFAULT NULL,
  `subsidyOddFare` bigint(11) DEFAULT NULL,
  `discountFare` int(11) DEFAULT NULL,
  `opFare` int(11) DEFAULT NULL,
  `subsidyOpFare` int(11) DEFAULT NULL,
  `mealId` int(11) DEFAULT NULL,
  `opTime` varchar(20) DEFAULT NULL,
  `collectTime` varchar(20) DEFAULT NULL,
  `opCount` int(11) DEFAULT NULL,
  `subsidyOpCount` int(11) DEFAULT NULL,
  `recordNO` int(11) DEFAULT NULL,
  `consumeType` int(11) DEFAULT NULL,
  `cookbookCode` int(11) DEFAULT NULL,
  `cookbookNum` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `onlyone` (`userId`,`cardNO`,`cardSeq`,`cardSN`,`deviceId`,`sumFare`,`oddFare`,`opFare`,`subsidyOpFare`,`opCount`,`subsidyOpCount`,`recordNO`,`consumeType`,`opTime`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=236 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of consumerecord
-- ----------------------------
INSERT INTO `consumerecord` VALUES ('1', '1', '1', '1', '1', 'D4841941', '1', '10000', '9900', '0', '0', '100', '0', '3', '2015-12-23 17:12:35', '2015-12-23 17:12:35', '2', '0', '1', '1', null, null);
INSERT INTO `consumerecord` VALUES ('198', '1', '1', '1', '1', 'D4841941', '1', '20000', '9900', '9900', '0', '0', '100', '3', '2015-12-23 17:31:27', '2015-12-23 17:31:33', '2', '2', '3', '2', null, null);
INSERT INTO `consumerecord` VALUES ('208', '1', '1', '1', '1', 'D4841941', '1', '30000', '9900', '19900', '0', '0', '10000', '3', '2015-12-23 17:42:48', '2015-12-23 17:42:49', '2', '3', '4', '9', null, null);
INSERT INTO `consumerecord` VALUES ('211', '1', '1', '1', '1', 'D4841941', '1', '40000', '9900', '29900', '0', '0', '10000', '3', '2015-12-23 17:49:12', '2015-12-23 17:49:13', '2', '4', '5', '9', null, null);
INSERT INTO `consumerecord` VALUES ('212', '1', '1', '1', '1', 'D4841941', '1', '40000', '9900', '29800', '0', '0', '100', '3', '2015-12-23 17:50:18', '2015-12-23 17:50:19', '2', '5', '6', '2', null, null);
INSERT INTO `consumerecord` VALUES ('213', '1', '1', '1', '1', 'D4841941', '1', '40000', '9900', '29600', '0', '0', '200', '3', '2015-12-23 17:53:36', '2015-12-23 17:53:38', '2', '6', '7', '2', null, null);
INSERT INTO `consumerecord` VALUES ('217', '1', '1', '1', '1', 'D4841941', '1', '40000', '9900', '29500', '0', '0', '100', '3', '2015-12-23 17:54:47', '2015-12-23 17:54:48', '2', '7', '8', '2', null, null);
INSERT INTO `consumerecord` VALUES ('218', '1', '1', '1', '1', 'D4841941', '1', '40000', '9900', '29400', '0', '0', '100', '3', '2015-12-23 17:55:01', '2015-12-23 17:55:02', '2', '8', '9', '2', null, null);
INSERT INTO `consumerecord` VALUES ('219', '1', '1', '1', '1', 'D4841941', '1', '40000', '9900', '29300', '0', '0', '100', '3', '2015-12-23 17:55:36', '2015-12-23 17:55:36', '2', '9', '10', '2', null, null);
INSERT INTO `consumerecord` VALUES ('221', '1', '1', '1', '1', 'D4841941', '1', '40000', '9900', '29200', '0', '0', '100', '3', '2015-12-23 17:56:06', '2015-12-23 17:56:06', '2', '10', '11', '2', null, null);
INSERT INTO `consumerecord` VALUES ('222', '1', '1', '1', '1', 'D4841941', '1', '40000', '9900', '29000', '0', '0', '200', '3', '2015-12-23 17:56:08', '2015-12-23 17:56:08', '2', '11', '12', '2', null, null);
INSERT INTO `consumerecord` VALUES ('223', '1', '1', '1', '1', 'D4841941', '1', '40000', '9900', '28900', '0', '0', '100', '3', '2015-12-23 17:56:18', '2015-12-23 17:56:18', '2', '12', '13', '2', null, null);
INSERT INTO `consumerecord` VALUES ('224', '1', '1', '1', '1', 'D4841941', '1', '40000', '9900', '28700', '0', '0', '200', '3', '2015-12-23 17:56:22', '2015-12-23 17:56:22', '2', '13', '14', '2', null, null);
INSERT INTO `consumerecord` VALUES ('225', '1', '6', '6', '1', '90D24626', '4', '100000', '99900', '0', '0', '100', '0', '3', '2015-12-24 17:02:17', '2015-12-24 17:02:21', '2', '0', '1', '1', null, null);
INSERT INTO `consumerecord` VALUES ('226', '1', '6', '6', '1', '90D24626', '5', '100000', '99700', '0', '0', '200', '0', '3', '2015-12-24 17:02:25', '2015-12-24 17:02:30', '3', '0', '1', '1', null, null);
INSERT INTO `consumerecord` VALUES ('227', '1', '6', '6', '1', '90D24626', '4', '100000', '99600', '0', '0', '100', '0', '3', '2015-12-24 17:02:33', '2015-12-24 17:02:35', '4', '0', '2', '1', null, null);
INSERT INTO `consumerecord` VALUES ('228', '1', '6', '6', '1', '90D24626', '4', '100000', '99500', '0', '0', '100', '0', '3', '2015-12-24 17:02:38', '2015-12-24 17:02:42', '5', '0', '3', '1', null, null);
INSERT INTO `consumerecord` VALUES ('229', '1', '6', '6', '1', '90D24626', '4', '100000', '99300', '0', '0', '200', '0', '3', '2015-12-24 17:02:43', '2015-12-24 17:02:48', '6', '0', '4', '1', null, null);
INSERT INTO `consumerecord` VALUES ('230', '1', '6', '6', '1', '90D24626', '4', '100000', '99200', '0', '0', '100', '0', '3', '2015-12-24 17:02:50', '2015-12-24 17:02:55', '7', '0', '5', '1', null, null);
INSERT INTO `consumerecord` VALUES ('231', '1', '6', '6', '1', '90D24626', '4', '100000', '99100', '0', '0', '100', '0', '3', '2015-12-24 17:02:54', '2015-12-24 17:02:56', '8', '0', '6', '1', null, null);
INSERT INTO `consumerecord` VALUES ('232', '1', '6', '6', '1', '90D24626', '4', '100000', '98900', '0', '0', '200', '0', '3', '2015-12-24 17:03:00', '2015-12-24 17:03:02', '9', '0', '7', '1', null, null);
INSERT INTO `consumerecord` VALUES ('233', '1', '6', '6', '1', '90D24626', '4', '100000', '98500', '0', '0', '400', '0', '3', '2015-12-24 17:03:03', '2015-12-24 17:03:09', '10', '0', '8', '1', null, null);
INSERT INTO `consumerecord` VALUES ('234', '1', '6', '6', '1', '90D24626', '4', '110000', '98500', '10000', '0', '0', '10000', '3', '2015-12-24 17:17:29', '2015-12-24 17:39:14', '10', '1', '9', '9', null, null);
INSERT INTO `consumerecord` VALUES ('235', '1', '6', '6', '1', '90D24626', '4', '120000', '98500', '20000', '0', '0', '10000', '3', '2015-12-24 18:26:11', '2015-12-24 18:26:18', '10', '2', '10', '9', null, null);

-- ----------------------------
-- Table structure for `cookbook`
-- ----------------------------
DROP TABLE IF EXISTS `cookbook`;
CREATE TABLE `cookbook` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `cookbookCode` int(11) DEFAULT NULL,
  `cookbookName` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  `enable` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cookbook
-- ----------------------------
INSERT INTO `cookbook` VALUES ('1', '1', '1', '杏鲍菇肉片', '1200', '', '');
INSERT INTO `cookbook` VALUES ('2', '1', '2', '青椒鸡蛋', '1000', '', '');

-- ----------------------------
-- Table structure for `dept`
-- ----------------------------
DROP TABLE IF EXISTS `dept`;
CREATE TABLE `dept` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deptName` varchar(255) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dept
-- ----------------------------
INSERT INTO `dept` VALUES ('1', '111', '1', '0');

-- ----------------------------
-- Table structure for `device`
-- ----------------------------
DROP TABLE IF EXISTS `device`;
CREATE TABLE `device` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `deptId` int(11) DEFAULT NULL,
  `paramGroupId` int(11) DEFAULT NULL,
  `deviceName` varchar(255) DEFAULT NULL,
  `deviceNum` int(11) DEFAULT NULL,
  `deviceType` int(11) DEFAULT '0' COMMENT '1读卡器,2点餐机,3水控,4手持机',
  `transferId` int(11) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `sn` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of device
-- ----------------------------
INSERT INTO `device` VALUES ('1', '1', '1', '1', '100', '100', '2', '0', '1', '01010101010101010101010101010101');
INSERT INTO `device` VALUES ('2', '1', null, null, '读卡机', '12345678', '8', null, '0', '4159A96E838E4DF5BDECD4E2D8E940F1');
INSERT INTO `device` VALUES ('3', '1', null, null, '200', '200', '1', null, '1', '02020202020202020202020202020202');
INSERT INTO `device` VALUES ('4', '1', '1', '1', '2001', '2001', '2', '3', '1', '00000000000000000000000000002001');
INSERT INTO `device` VALUES ('5', '1', '1', '1', '2002', '2002', '2', '3', '1', '00000000000000000000000000002002');

-- ----------------------------
-- Table structure for `discount`
-- ----------------------------
DROP TABLE IF EXISTS `discount`;
CREATE TABLE `discount` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `discountType` int(255) DEFAULT NULL,
  `rate` int(11) DEFAULT NULL,
  `subsidy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of discount
-- ----------------------------
INSERT INTO `discount` VALUES ('1', '1', '0', '100', '0');
INSERT INTO `discount` VALUES ('2', '1', '1', '100', '0');
INSERT INTO `discount` VALUES ('3', '1', '2', '100', '0');
INSERT INTO `discount` VALUES ('4', '1', '3', '100', '0');
INSERT INTO `discount` VALUES ('5', '1', '4', '100', '0');
INSERT INTO `discount` VALUES ('6', '1', '5', '100', '0');
INSERT INTO `discount` VALUES ('7', '1', '6', '100', '0');
INSERT INTO `discount` VALUES ('8', '1', '7', '100', '0');
INSERT INTO `discount` VALUES ('9', '1', '8', '100', '0');
INSERT INTO `discount` VALUES ('10', '1', '9', '100', '0');
INSERT INTO `discount` VALUES ('11', '1', '10', '100', '0');
INSERT INTO `discount` VALUES ('12', '1', '11', '100', '0');
INSERT INTO `discount` VALUES ('13', '1', '12', '100', '0');
INSERT INTO `discount` VALUES ('14', '1', '13', '100', '0');
INSERT INTO `discount` VALUES ('15', '1', '14', '100', '0');
INSERT INTO `discount` VALUES ('16', '1', '15', '100', '0');

-- ----------------------------
-- Table structure for `discountbase`
-- ----------------------------
DROP TABLE IF EXISTS `discountbase`;
CREATE TABLE `discountbase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discountType` int(255) DEFAULT NULL,
  `rate` int(11) DEFAULT NULL,
  `subsidy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of discountbase
-- ----------------------------
INSERT INTO `discountbase` VALUES ('1', '0', '100', '0');
INSERT INTO `discountbase` VALUES ('2', '1', '100', '0');
INSERT INTO `discountbase` VALUES ('3', '2', '100', '0');
INSERT INTO `discountbase` VALUES ('4', '3', '100', '0');
INSERT INTO `discountbase` VALUES ('5', '4', '100', '0');
INSERT INTO `discountbase` VALUES ('6', '5', '100', '0');
INSERT INTO `discountbase` VALUES ('7', '6', '100', '0');
INSERT INTO `discountbase` VALUES ('8', '7', '100', '0');
INSERT INTO `discountbase` VALUES ('9', '8', '100', '0');
INSERT INTO `discountbase` VALUES ('10', '9', '100', '0');
INSERT INTO `discountbase` VALUES ('11', '10', '100', '0');
INSERT INTO `discountbase` VALUES ('12', '11', '100', '0');
INSERT INTO `discountbase` VALUES ('13', '12', '100', '0');
INSERT INTO `discountbase` VALUES ('14', '13', '100', '0');
INSERT INTO `discountbase` VALUES ('15', '14', '100', '0');
INSERT INTO `discountbase` VALUES ('16', '15', '100', '0');

-- ----------------------------
-- Table structure for `entranceguard`
-- ----------------------------
DROP TABLE IF EXISTS `entranceguard`;
CREATE TABLE `entranceguard` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `openDelay` int(11) DEFAULT NULL,
  `cardPwdType` int(11) DEFAULT NULL,
  `recordType` int(11) DEFAULT NULL,
  `authType` int(11) DEFAULT NULL,
  `openStatus` int(11) DEFAULT NULL,
  `operPwd` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of entranceguard
-- ----------------------------

-- ----------------------------
-- Table structure for `entranceguardbase`
-- ----------------------------
DROP TABLE IF EXISTS `entranceguardbase`;
CREATE TABLE `entranceguardbase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `openDelay` int(11) DEFAULT NULL,
  `cardPwdType` int(11) DEFAULT NULL,
  `recordType` int(11) DEFAULT NULL,
  `authType` int(11) DEFAULT NULL,
  `openStatus` int(11) DEFAULT NULL,
  `operPwd` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of entranceguardbase
-- ----------------------------
INSERT INTO `entranceguardbase` VALUES ('1', '10', '1', '0', '0', '0', '000000');

-- ----------------------------
-- Table structure for `meal`
-- ----------------------------
DROP TABLE IF EXISTS `meal`;
CREATE TABLE `meal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `mealName` varchar(255) DEFAULT NULL,
  `beginTime` varchar(8) DEFAULT NULL,
  `endTime` varchar(8) DEFAULT NULL,
  `timeLimit` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of meal
-- ----------------------------
INSERT INTO `meal` VALUES ('1', '1', '早餐', '06:30', '10:30', '0');
INSERT INTO `meal` VALUES ('2', '1', '午餐', '10:30', '15:30', '0');
INSERT INTO `meal` VALUES ('3', '1', '晚餐', '15:30', '18:30', '0');
INSERT INTO `meal` VALUES ('4', '1', '夜宵', '18:30', '20:30', '0');
INSERT INTO `meal` VALUES ('5', '1', '加班一', '20:30', '22:30', '0');
INSERT INTO `meal` VALUES ('6', '1', '加班二', '22:00', '23:59', '0');

-- ----------------------------
-- Table structure for `mealbase`
-- ----------------------------
DROP TABLE IF EXISTS `mealbase`;
CREATE TABLE `mealbase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mealName` varchar(255) DEFAULT NULL,
  `beginTime` varchar(8) DEFAULT NULL,
  `endTime` varchar(8) DEFAULT NULL,
  `timeLimit` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mealbase
-- ----------------------------
INSERT INTO `mealbase` VALUES ('1', '早餐', '06:30', '10:30', '0');
INSERT INTO `mealbase` VALUES ('2', '午餐', '10:30', '15:30', '0');
INSERT INTO `mealbase` VALUES ('3', '晚餐', '15:30', '18:30', '0');
INSERT INTO `mealbase` VALUES ('4', '夜宵', '18:30', '20:30', '0');
INSERT INTO `mealbase` VALUES ('5', '加班一', '20:30', '22:30', '0');
INSERT INTO `mealbase` VALUES ('6', '加班二', '22:00', '23:59', '0');

-- ----------------------------
-- Table structure for `multiwaterrategroup`
-- ----------------------------
DROP TABLE IF EXISTS `multiwaterrategroup`;
CREATE TABLE `multiwaterrategroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `groupName` varchar(50) DEFAULT NULL,
  `consumeType` int(11) DEFAULT NULL,
  `waterPrecision` int(11) DEFAULT NULL,
  `rate1Fare` int(11) DEFAULT NULL,
  `rate1Cycle` int(11) DEFAULT NULL,
  `rate1Water` int(11) DEFAULT NULL,
  `rate1Status` int(11) DEFAULT NULL,
  `rate2Fare` int(11) DEFAULT NULL,
  `rate2Cycle` int(11) DEFAULT NULL,
  `rate2Water` int(11) DEFAULT NULL,
  `rate2Status` int(11) DEFAULT NULL,
  `rate3Fare` int(11) DEFAULT NULL,
  `rate3Cycle` int(11) DEFAULT NULL,
  `rate3Water` int(11) DEFAULT NULL,
  `rate3Status` int(11) DEFAULT NULL,
  `rate4Fare` int(11) DEFAULT NULL,
  `rate4Cycle` int(11) DEFAULT NULL,
  `rate4Water` int(11) DEFAULT NULL,
  `rate4Status` int(11) DEFAULT NULL,
  `rate4BeginTime` varchar(255) DEFAULT NULL,
  `pwd` int(11) DEFAULT NULL,
  `bound` int(11) DEFAULT NULL,
  `subsidyReset` int(11) DEFAULT NULL,
  `subsidyFirst` int(11) DEFAULT NULL,
  `enableCheckTime` int(11) DEFAULT NULL,
  `enableCharge` int(11) DEFAULT NULL,
  `updateNum` int(11) DEFAULT NULL,
  `deviceNum` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of multiwaterrategroup
-- ----------------------------

-- ----------------------------
-- Table structure for `multiwaterrategroupbase`
-- ----------------------------
DROP TABLE IF EXISTS `multiwaterrategroupbase`;
CREATE TABLE `multiwaterrategroupbase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `consumeType` int(11) DEFAULT NULL,
  `waterPrecision` int(11) DEFAULT NULL,
  `rate1Fare` int(11) DEFAULT NULL,
  `rate1Cycle` int(11) DEFAULT NULL,
  `rate1Water` int(11) DEFAULT NULL,
  `rate1Status` int(11) DEFAULT NULL,
  `rate2Fare` int(11) DEFAULT NULL,
  `rate2Cycle` int(11) DEFAULT NULL,
  `rate2Water` int(11) DEFAULT NULL,
  `rate2Status` int(11) DEFAULT NULL,
  `rate3Fare` int(11) DEFAULT NULL,
  `rate3Cycle` int(11) DEFAULT NULL,
  `rate3Water` int(11) DEFAULT NULL,
  `rate3Status` int(11) DEFAULT NULL,
  `rate4Fare` int(11) DEFAULT NULL,
  `rate4Cycle` int(11) DEFAULT NULL,
  `rate4Water` int(11) DEFAULT NULL,
  `rate4Status` int(11) DEFAULT NULL,
  `rate4BeginTime` varchar(255) DEFAULT NULL,
  `pwd` int(11) DEFAULT NULL,
  `bound` int(11) DEFAULT NULL,
  `subsidyReset` int(11) DEFAULT NULL,
  `subsidyFirst` int(11) DEFAULT NULL,
  `enableCheckTime` int(11) DEFAULT NULL,
  `enableCharge` int(11) DEFAULT NULL,
  `updateNum` int(11) DEFAULT NULL,
  `deviceNum` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of multiwaterrategroupbase
-- ----------------------------
INSERT INTO `multiwaterrategroupbase` VALUES ('1', '97', '2', '0', '0', '100', '0', '0', '0', '100', '0', '0', '0', '100', '0', '0', '0', '100', '0', '00:00', '8888', '3', '0', '0', '0', '0', '0', '1');

-- ----------------------------
-- Table structure for `ordertime`
-- ----------------------------
DROP TABLE IF EXISTS `ordertime`;
CREATE TABLE `ordertime` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `orderTimeName` varchar(50) DEFAULT NULL,
  `beginTime` varchar(50) DEFAULT NULL,
  `endTime` varchar(50) DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL,
  `enable` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ordertime
-- ----------------------------
INSERT INTO `ordertime` VALUES ('1', '1', '早餐', '06:00', '08:30', null, '');
INSERT INTO `ordertime` VALUES ('2', '1', '中餐', '11:30', '14:00', null, '');
INSERT INTO `ordertime` VALUES ('3', '1', '晚餐', '17:00', '19:00', null, '');
INSERT INTO `ordertime` VALUES ('4', '1', '夜宵', '19:01', '20:30', null, '');
INSERT INTO `ordertime` VALUES ('5', '1', '加班1', '20:31', '23:59', null, '');
INSERT INTO `ordertime` VALUES ('6', '1', '加班2', '00:00', '00:00', null, '');
INSERT INTO `ordertime` VALUES ('7', '1', '加班3', '00:00', '00:00', null, '');
INSERT INTO `ordertime` VALUES ('8', '1', '加班4', '00:00', '00:00', null, '');
INSERT INTO `ordertime` VALUES ('9', '1', '加班5', '00:00', '00:00', null, '');
INSERT INTO `ordertime` VALUES ('10', '1', '加班6', '00:00', '00:00', null, '');
INSERT INTO `ordertime` VALUES ('11', '1', '加班7', '00:00', '00:00', null, '');
INSERT INTO `ordertime` VALUES ('12', '1', '加班8', '00:00', '00:00', null, '');

-- ----------------------------
-- Table structure for `ordertimebase`
-- ----------------------------
DROP TABLE IF EXISTS `ordertimebase`;
CREATE TABLE `ordertimebase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderTimeName` varchar(50) DEFAULT NULL,
  `beginTime` varchar(50) DEFAULT NULL,
  `endTime` varchar(50) DEFAULT NULL,
  `enable` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ordertimebase
-- ----------------------------
INSERT INTO `ordertimebase` VALUES ('1', '早餐', '06:00', '08:30', '');
INSERT INTO `ordertimebase` VALUES ('2', '中餐', '11:30', '14:00', '');
INSERT INTO `ordertimebase` VALUES ('3', '晚餐', '17:00', '19:00', '');
INSERT INTO `ordertimebase` VALUES ('4', '夜宵', '19:01', '20:30', '');
INSERT INTO `ordertimebase` VALUES ('5', '加班1', '20:31', '23:59', '');
INSERT INTO `ordertimebase` VALUES ('6', '加班2', '00:00', '00:00', '');
INSERT INTO `ordertimebase` VALUES ('7', '加班3', '00:00', '00:00', '');
INSERT INTO `ordertimebase` VALUES ('8', '加班4', '00:00', '00:00', '');
INSERT INTO `ordertimebase` VALUES ('9', '加班5', '00:00', '00:00', '');
INSERT INTO `ordertimebase` VALUES ('10', '加班6', '00:00', '00:00', '');
INSERT INTO `ordertimebase` VALUES ('11', '加班7', '00:00', '00:00', '');
INSERT INTO `ordertimebase` VALUES ('12', '加班8', '00:00', '00:00', '');

-- ----------------------------
-- Table structure for `posparamgroup`
-- ----------------------------
DROP TABLE IF EXISTS `posparamgroup`;
CREATE TABLE `posparamgroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `groupName` varchar(50) DEFAULT NULL,
  `subsidyReset` int(11) DEFAULT NULL,
  `subsidyFirst` int(11) DEFAULT NULL COMMENT '补助钱包、大钱包、先补助后大钱包',
  `enableCardMinFare` int(11) DEFAULT NULL,
  `enableTimeLimitFare` int(11) DEFAULT NULL,
  `enableDayLimitFare` int(11) DEFAULT NULL,
  `enableDiscount` int(11) DEFAULT NULL,
  `enableMeal` int(11) DEFAULT NULL,
  `bound` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of posparamgroup
-- ----------------------------
INSERT INTO `posparamgroup` VALUES ('1', '1', '消费机默认参数分组', '1', '0', '1', '1', '1', '1', '1', '3');

-- ----------------------------
-- Table structure for `posparamgroupbase`
-- ----------------------------
DROP TABLE IF EXISTS `posparamgroupbase`;
CREATE TABLE `posparamgroupbase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subsidyReset` int(11) DEFAULT NULL,
  `subsidyFirst` int(11) DEFAULT NULL COMMENT '补助钱包、大钱包、先补助后大钱包',
  `enableCardMinFare` int(11) DEFAULT NULL,
  `enableTimeLimitFare` int(11) DEFAULT NULL,
  `enableDayLimitFare` int(11) DEFAULT NULL,
  `enableDiscount` int(11) DEFAULT NULL,
  `enableMeal` int(11) DEFAULT NULL,
  `bound` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of posparamgroupbase
-- ----------------------------
INSERT INTO `posparamgroupbase` VALUES ('1', '1', '0', '1', '1', '1', '1', '1', '3');

-- ----------------------------
-- Table structure for `singbon`
-- ----------------------------
DROP TABLE IF EXISTS `singbon`;
CREATE TABLE `singbon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loginName` varchar(255) DEFAULT NULL,
  `loginPwd` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of singbon
-- ----------------------------
INSERT INTO `singbon` VALUES ('1', 'c66fc61212bbc6ed', 'a9e28c83699391f8');

-- ----------------------------
-- Table structure for `subsidy`
-- ----------------------------
DROP TABLE IF EXISTS `subsidy`;
CREATE TABLE `subsidy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `companyId` int(11) DEFAULT NULL,
  `subsidyFare` float DEFAULT NULL,
  `subsidyVersion` int(255) DEFAULT NULL,
  `invalidDate` varchar(50) DEFAULT NULL,
  `subsidyStatus` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of subsidy
-- ----------------------------
INSERT INTO `subsidy` VALUES ('5', '6', '1', '100', '4', '2015-12-24', '2');

-- ----------------------------
-- Table structure for `subsidyhistory`
-- ----------------------------
DROP TABLE IF EXISTS `subsidyhistory`;
CREATE TABLE `subsidyhistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `companyId` int(11) DEFAULT NULL,
  `subsidyFare` float DEFAULT NULL,
  `subsidyVersion` int(255) DEFAULT NULL,
  `invalidDate` varchar(50) DEFAULT NULL,
  `subsidyStatus` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of subsidyhistory
-- ----------------------------
INSERT INTO `subsidyhistory` VALUES ('1', '1', '1', '100', '1', '2015-12-24', '2');
INSERT INTO `subsidyhistory` VALUES ('2', '1', '1', '100', '2', '2015-12-24', '2');

-- ----------------------------
-- Table structure for `sysuser`
-- ----------------------------
DROP TABLE IF EXISTS `sysuser`;
CREATE TABLE `sysuser` (
  `operId` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `loginName` varchar(255) DEFAULT NULL,
  `loginPwd` varchar(255) DEFAULT NULL,
  `deviceId` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`operId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sysuser
-- ----------------------------
INSERT INTO `sysuser` VALUES ('1', '1', 'c66fc61212bbc6ed', 'a9e28c83699391f8', '2', null);

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userId` bigint(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `deptId` int(11) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `shortName` varchar(255) DEFAULT NULL,
  `userNO` varchar(255) DEFAULT NULL,
  `cardID` varchar(255) DEFAULT NULL,
  `cardNO` bigint(255) DEFAULT NULL,
  `cardSN` varchar(255) DEFAULT NULL,
  `cardSeq` int(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '0未发卡、241正常、243挂失、244注销卡，其他都是异常卡',
  `sex` int(11) DEFAULT NULL,
  `cardTypeId` int(11) DEFAULT NULL,
  `beginDate` varchar(50) DEFAULT NULL,
  `endDate` varchar(50) DEFAULT NULL,
  `cardMakeDate` varchar(50) DEFAULT NULL,
  `consumePwd` varchar(255) DEFAULT NULL,
  `totalFare` bigint(11) DEFAULT '0',
  `opCount` int(11) DEFAULT '0',
  `oddFare` bigint(11) DEFAULT '0',
  `subsidyOpCount` int(11) DEFAULT '0',
  `subsidyOddFare` bigint(11) DEFAULT '0',
  `cardDeposit` int(11) DEFAULT NULL,
  `giveFare` int(11) DEFAULT NULL,
  `preOpFare` int(11) DEFAULT NULL,
  `lastConsumeTime` varchar(50) DEFAULT NULL,
  `lastSubsidyConsumeTime` varchar(50) DEFAULT NULL,
  `subsidydaySum` int(11) DEFAULT '0',
  `subsidyVersion` int(11) DEFAULT '0',
  `subsidyInvalidDate` varchar(50) DEFAULT NULL,
  `daySumFare` int(11) DEFAULT '0',
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '1', '1', '001', '001', '001', '123456789012345678', '1', 'd4841941', '1', '241', '0', '0', '2015-12-22', '2015-12-31', null, '8888', '40000', '2', '9900', '13', '28700', '0', '0', '100', null, null, '0', '3', '2015-12-23', '0');
INSERT INTO `user` VALUES ('2', '1', '1', '002', '002', '002', '123456789012345678', '2', '', null, '243', '0', '0', '2015-12-22', '2015-12-31', null, '8888', null, null, null, '0', '0', '0', '0', '0', null, null, '0', '0', null, '0');
INSERT INTO `user` VALUES ('3', '1', '1', '003', '003', '003', '123456789012345678', '3', '', null, '243', '0', '0', '2015-12-22', '2015-12-31', null, '8888', null, null, null, '0', '0', '0', '0', '0', null, null, '0', '0', null, '0');
INSERT INTO `user` VALUES ('4', '1', '1', '004', '004', '004', '123456789012345678', '4', '', null, '241', '0', '0', '2015-12-22', '2015-12-31', null, '8888', null, null, null, '0', '0', '0', '0', '0', null, null, '0', '0', null, '0');
INSERT INTO `user` VALUES ('5', '1', '1', '005', '005', '005', '123456789012345678', '5', '', null, '241', '0', '0', '2015-12-22', '2015-12-31', null, '8888', null, null, null, '0', '0', '0', '0', '0', null, null, '0', '0', null, '0');
INSERT INTO `user` VALUES ('6', '1', '1', '006', '006', '006', '123456789012345678', '6', '90d24626', '1', '241', '0', '0', '2015-12-22', '2015-12-31', null, '8888', '120000', '10', '98500', '2', '20000', '0', '0', '1000', null, null, '0', '2', '2015-12-24', '0');
INSERT INTO `user` VALUES ('7', '1', '1', '007', '007', '007', '123456789012345678', '7', 'a48a2a41', '1', '241', '0', '0', '2015-12-22', '2015-12-31', null, '8888', '10000', '1', '10000', '0', '0', '0', '0', '100', null, null, '0', '0', null, '0');

-- ----------------------------
-- Table structure for `userdept`
-- ----------------------------
DROP TABLE IF EXISTS `userdept`;
CREATE TABLE `userdept` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deptName` varchar(255) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  `batchId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userdept
-- ----------------------------
INSERT INTO `userdept` VALUES ('1', '11', '1', '0', '1');

-- ----------------------------
-- Table structure for `waterrategroup`
-- ----------------------------
DROP TABLE IF EXISTS `waterrategroup`;
CREATE TABLE `waterrategroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `groupName` varchar(50) DEFAULT NULL,
  `consumeType` int(11) DEFAULT NULL,
  `goWaterType` int(11) DEFAULT NULL,
  `stopWaterType` int(11) DEFAULT NULL,
  `rate1Fare` int(11) DEFAULT NULL,
  `rate1Cycle` int(11) DEFAULT NULL,
  `rate1Water` int(11) DEFAULT NULL,
  `rate1NextDayReset` int(11) DEFAULT NULL,
  `rate1Status` int(11) DEFAULT NULL,
  `rate1CardTypes` varchar(255) DEFAULT NULL,
  `rate2Fare` int(11) DEFAULT NULL,
  `rate2Cycle` int(11) DEFAULT NULL,
  `rate2Water` int(11) DEFAULT NULL,
  `rate2BeginTime` varchar(255) DEFAULT NULL,
  `rate2EndTime` varchar(255) DEFAULT NULL,
  `rate2CardTypes` varchar(255) DEFAULT NULL,
  `rate3Fare` int(11) DEFAULT NULL,
  `rate3Cycle` int(11) DEFAULT NULL,
  `rate3Water` int(11) DEFAULT NULL,
  `rate3BeginTime` varchar(255) DEFAULT NULL,
  `rate3EndTime` varchar(255) DEFAULT NULL,
  `rate3CardTypes` varchar(255) DEFAULT NULL,
  `rate4Fare` int(11) DEFAULT NULL,
  `rate4Cycle` int(11) DEFAULT NULL,
  `rate4Water` int(11) DEFAULT NULL,
  `rate4BeginTime` varchar(255) DEFAULT NULL,
  `rate4EndTime` varchar(255) DEFAULT NULL,
  `rate4CardTypes` varchar(255) DEFAULT NULL,
  `rate5Fare` int(11) DEFAULT NULL,
  `rate5Cycle` int(11) DEFAULT NULL,
  `rate5Water` int(11) DEFAULT NULL,
  `pwd` int(11) DEFAULT NULL,
  `bound` int(11) DEFAULT NULL,
  `subsidyReset` int(11) DEFAULT NULL,
  `subsidyFirst` int(11) DEFAULT NULL,
  `enableCheckTime` int(11) DEFAULT NULL,
  `enableCardMinFare` int(11) DEFAULT NULL,
  `enableTimeLimitFare` int(11) DEFAULT NULL,
  `enableDayLimitFare` int(11) DEFAULT NULL,
  `enableDiscount` int(11) DEFAULT NULL,
  `enableMeal` int(11) DEFAULT NULL,
  `updateNum` int(11) DEFAULT NULL,
  `deviceNum` int(11) DEFAULT NULL,
  `waterLimit` int(11) DEFAULT NULL,
  `cycleLimit` int(11) DEFAULT NULL,
  `waterPrecision` int(11) DEFAULT NULL,
  `enableAutoCalcRate` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of waterrategroup
-- ----------------------------
INSERT INTO `waterrategroup` VALUES ('1', '1', '水控默认参数分组', '73', '0', '1', '0', '0', '100', '1', '0', ',,', '0', '0', '100', '00:00', '00:00', ',,', '0', '0', '100', '00:00', '00:00', ',,', '0', '0', '100', '00:00', '00:00', ',,', '0', '0', '0', '8888', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '100', '10', '2', '1');

-- ----------------------------
-- Table structure for `waterrategroupbase`
-- ----------------------------
DROP TABLE IF EXISTS `waterrategroupbase`;
CREATE TABLE `waterrategroupbase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `consumeType` int(11) DEFAULT NULL,
  `goWaterType` int(11) DEFAULT NULL,
  `stopWaterType` int(11) DEFAULT NULL,
  `rate1Fare` int(11) DEFAULT NULL,
  `rate1Cycle` int(11) DEFAULT NULL,
  `rate1Water` int(11) DEFAULT NULL,
  `rate1NextDayReset` int(11) DEFAULT NULL,
  `rate1Status` int(11) DEFAULT NULL,
  `rate1CardTypes` varchar(255) DEFAULT NULL,
  `rate2Fare` int(11) DEFAULT NULL,
  `rate2Cycle` int(11) DEFAULT NULL,
  `rate2Water` int(11) DEFAULT NULL,
  `rate2BeginTime` varchar(255) DEFAULT NULL,
  `rate2EndTime` varchar(255) DEFAULT NULL,
  `rate2CardTypes` varchar(255) DEFAULT NULL,
  `rate3Fare` int(11) DEFAULT NULL,
  `rate3Cycle` int(11) DEFAULT NULL,
  `rate3Water` int(11) DEFAULT NULL,
  `rate3BeginTime` varchar(255) DEFAULT NULL,
  `rate3EndTime` varchar(255) DEFAULT NULL,
  `rate3CardTypes` varchar(255) DEFAULT NULL,
  `rate4Fare` int(11) DEFAULT NULL,
  `rate4Cycle` int(11) DEFAULT NULL,
  `rate4Water` int(11) DEFAULT NULL,
  `rate4BeginTime` varchar(255) DEFAULT NULL,
  `rate4EndTime` varchar(255) DEFAULT NULL,
  `rate4CardTypes` varchar(255) DEFAULT NULL,
  `rate5Fare` int(11) DEFAULT NULL,
  `rate5Cycle` int(11) DEFAULT NULL,
  `rate5Water` int(11) DEFAULT NULL,
  `pwd` int(11) DEFAULT NULL,
  `bound` int(11) DEFAULT NULL,
  `subsidyReset` int(11) DEFAULT NULL,
  `subsidyFirst` int(11) DEFAULT NULL,
  `enableCheckTime` int(11) DEFAULT NULL,
  `enableCardMinFare` int(11) DEFAULT NULL,
  `enableTimeLimitFare` int(11) DEFAULT NULL,
  `enableDayLimitFare` int(11) DEFAULT NULL,
  `enableDiscount` int(11) DEFAULT NULL,
  `enableMeal` int(11) DEFAULT NULL,
  `updateNum` int(11) DEFAULT NULL,
  `deviceNum` int(11) DEFAULT NULL,
  `waterLimit` int(11) DEFAULT NULL,
  `cycleLimit` int(11) DEFAULT NULL,
  `waterPrecision` int(11) DEFAULT NULL,
  `enableAutoCalcRate` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of waterrategroupbase
-- ----------------------------
INSERT INTO `waterrategroupbase` VALUES ('1', '73', '0', '1', '0', '0', '100', '1', '0', ',,', '0', '0', '100', '00:00', '00:00', ',,', '0', '0', '100', '00:00', '00:00', ',,', '0', '0', '100', '00:00', '00:00', ',,', '0', '0', '0', '8888', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '100', '10', '2', '1');

-- ----------------------------
-- Procedure structure for `delInitData`
-- ----------------------------
DROP PROCEDURE IF EXISTS `delInitData`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delInitData`()
BEGIN

delete from batch where companyId not in (select id from company);
delete from cardblack where companyId not in (select id from company);
delete from cardparam where companyId not in (select id from company);
delete from consumerecord where companyId not in (select id from company);
delete from consumeparam where companyId not in (select id from company);
delete from cookbook where companyId not in (select id from company);
delete from dept where companyId not in (select id from company);
delete from device where companyId not in (select id from company);
delete from discount where companyId not in (select id from company);
delete from entranceguard where companyId not in (select id from company);
delete from meal where companyId not in (select id from company);
delete from ordertime where companyId not in (select id from company);
delete from posparamgroup where companyId not in (select id from company);

delete from sysuser where companyId not in (select id from company);
delete from `user` where companyId not in (select id from company);
delete from userdept where companyId not in (select id from company);
delete from waterrategroup where companyId not in (select id from company);
delete from authgroup where companyId not in (select id from company);
delete from authgroupuser where operId not in (select operId from sysUser);
delete from subsidy where companyId not in (select id from company) or userId not in (select userId from `user`);
delete from batchblack where companyId not in (select id from company);
delete from cardrecord where companyId not in (select id from company);
delete from subsidyhistory where companyId not in (select id from company);
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `insertConsumeRecord`
-- ----------------------------
DROP PROCEDURE IF EXISTS `insertConsumeRecord`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertConsumeRecord`(IN `tcompanyId` int,IN `tuserId` int,IN `tcardNO` int,IN `tcardSeq` int,IN `tcardSN` varchar(8),IN `tdeviceId` int,IN `tsumFare` bigint,IN `toddFare` bigint,IN `tsubsidyOddFare` bigint,IN `tdiscountFare` int,IN `topFare` int,IN `tsubsidyOpFare` int,IN `tmealId` int,IN `topTime` datetime,IN `topCount` int,IN `tsubsidyOpCount` int,IN `trecordNO` int,IN `tconsumeType` int,IN `tcookbookCode` int,IN `tcookbookNum` int,OUT `tresult` int,OUT `tuserNO` varchar(20),OUT `tusername` varchar(20),OUT `tcookbookName` varchar(20))
BEGIN
		declare cardRecordType int;
    declare dbOddFare bigint;
		declare dbSubsidyOddFare bigint;
		declare dbOpCount int;
		declare dbSubsidyOpCount int;
    declare tsubsidyInvalidDate varchar(20);
		DECLARE EXIT HANDLER FOR SQLSTATE '23000' SET tresult = 2;
		DECLARE EXIT HANDLER FOR SQLEXCEPTION set tresult=0;
		set tresult=1;		

		insert into consumerecord (companyId,userId,cardNO,cardSeq,cardSN,deviceId,sumFare,oddFare,subsidyOddFare,discountFare,opFare,subsidyOpFare,mealId,opTime,collectTime,opCount,subsidyOpCount,recordNO,consumeType,cookbookCode,cookbookNum)
		values (tcompanyId,tuserId,tcardNO,tcardSeq,tcardSN,tdeviceId,tsumFare,toddFare,tsubsidyOddFare,tdiscountFare,topFare,tsubsidyOpFare,tmealId,topTime,NOW(),topCount,tsubsidyOpCount,trecordNO,tconsumeType,tcookbookCode,tcookbookNum);
		select userNO,username into tuserNO,tusername from user where userId=tuserId;
	
    #领取补助
		if tconsumeType = 9 or tconsumeType = 109
		then
			select invalidDate into tsubsidyInvalidDate from subsidy where companyId=tcompanyId and userId=tuserId and subsidyStatus=1;
			update subsidy set subsidyStatus=2 where companyId=tcompanyId and userId=tuserId and subsidyStatus=1;
			update user set totalFare=totalFare+tsubsidyOpFare,subsidyOddFare=subsidyOddFare+tsubsidyOpFare,subsidyOpCount=subsidyOpCount+1,subsidyVersion=subsidyVersion+1,subsidyInvalidDate=tsubsidyInvalidDate where userId=tuserId;
			
    #补助清零
		else if tconsumeType = 39 or tconsumeType = 139
		then
			update user set subsidyOddFare=0,subsidyOpCount=subsidyOpCount+1 where userId=tuserId;
			
		#普通消费
		else
			update user set oddFare=oddFare-topFare,opCount=topCount,subsidyOddFare=subsidyOddFare-tsubsidyOpFare,subsidyOpCount=tsubsidyOpCount where userId=tuserId;
		end if;
		end if;

		#补助卡操作记录
		if tconsumeType = 9 or tconsumeType = 109 or tconsumeType = 39 or tconsumeType = 139
		then
			if tconsumeType = 9
			then set cardRecordType=10;
			else if tconsumeType = 109
			then set cardRecordType=12;
      else if tconsumeType = 39
			then set cardRecordType=11;
			else if tconsumeType = 139
			then set cardRecordType=13;
			end if;
			end if;
			end if;
			end if;

			select oddFare,subsidyOddFare,opCount,subsidyOpCount into dbOddFare,dbSubsidyOddFare,dbOpCount,dbSubsidyOpCount from user where userId=tuserId;
			insert cardrecord(companyId,operId,userId,cardNO,cardSN,recordType,opFare,oddFare,subsidyOddFare,cardOddFare,cardSubsidyOddFare,opCount,subsidyOpCount,cardOpCount,cardSubsidyOpCount,opTime) values
			(tcompanyId,0,tuserId,tcardNO,tcardSN,cardRecordType,topFare,dbOddFare,dbSubsidyOddFare,toddFare,tsubsidyOddFare,dbOpCount,dbSubsidyOpCount,topCount,tsubsidyOpCount,topTime);
    end if;

		#查询菜单名称
		if tcookbookCode is not null
		then
			select cookbookName into tcookbookName from cookbook where companyId=tcompanyId and cookbookCode=tcookbookCode;
		end if;
		
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `insertInit`
-- ----------------------------
DROP PROCEDURE IF EXISTS `insertInit`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertInit`(IN `cId` int)
BEGIN
	-- 授权分组
	insert into authgroup(companyId,groupName,roles) select cId,groupName,roles from authgroupbase;
	-- 管理员admin
	insert into sysUser (companyId,loginName,loginPwd) values(cId,'c66fc61212bbc6ed','a9e28c83699391f8');
	-- 添加管理员权限
	insert into authgroupuser(operId,groupId) select (select operId from sysUser where companyId=cId),(select id from authgroup where companyId=cId and groupName='管理员');
	-- 消费机默认参数分组
	insert into posParamGroup (companyId,groupName,subsidyReset,subsidyFirst,enableCardMinFare,enableTimeLimitFare,enableDayLimitFare,enableDiscount,enableMeal,bound) 
	select cId,'消费机默认参数分组',subsidyReset,subsidyFirst,enableCardMinFare,enableTimeLimitFare,enableDayLimitFare,enableDiscount,enableMeal,bound from posParamGroupBase;
	-- 水控默认参数分组
	insert into waterRateGroup (companyId,groupName,consumeType,goWaterType,stopWaterType,rate1Fare,rate1Cycle,rate1Water,rate1NextDayReset,rate1Status,rate1CardTypes,rate2Fare,rate2Cycle,rate2Water,rate2BeginTime,rate2EndTime,rate2CardTypes,rate3Fare,rate3Cycle,rate3Water,rate3BeginTime,rate3EndTime,rate3CardTypes,rate4Fare,rate4Cycle,rate4Water,rate4BeginTime,rate4EndTime,rate4CardTypes,rate5Fare,rate5Cycle,rate5Water,pwd,bound,subsidyReset,subsidyFirst,enableCheckTime,enableCardMinFare,enableTimeLimitFare,enableDayLimitFare,enableDiscount,enableMeal,updateNum,deviceNum,waterLimit,cycleLimit,waterPrecision,enableAutoCalcRate) 
	select cId,'水控默认参数分组',consumeType,goWaterType,stopWaterType,rate1Fare,rate1Cycle,rate1Water,rate1NextDayReset,rate1Status,rate1CardTypes,rate2Fare,rate2Cycle,rate2Water,rate2BeginTime,rate2EndTime,rate2CardTypes,rate3Fare,rate3Cycle,rate3Water,rate3BeginTime,rate3EndTime,rate3CardTypes,rate4Fare,rate4Cycle,rate4Water,rate4BeginTime,rate4EndTime,rate4CardTypes,rate5Fare,rate5Cycle,rate5Water,pwd,bound,subsidyReset,subsidyFirst,enableCheckTime,enableCardMinFare,enableTimeLimitFare,enableDayLimitFare,enableDiscount,enableMeal,updateNum,deviceNum,waterLimit,cycleLimit,waterPrecision,enableAutoCalcRate from waterRateGroupBase;
	-- 制卡参数
	insert into cardParam (companyId,cardDeposit,prepayFare) select cId,cardDeposit,prepayFare from cardParamBase;
  -- 消费参数
  insert into consumeParam (companyId,cardMinFare,cardMinFareCardTypes,dayLimitFare,dayLimitFareCardTypes,timeLimitFare,timeLimitFareCardTypes,userPwd)
			select cId,cardMinFare,cardMinFareCardTypes,dayLimitFare,dayLimitFareCardTypes,timeLimitFare,timeLimitFareCardTypes,userPwd from consumeParamBase;
  -- 优惠方案
  insert into discount (companyId,discountType,rate,subsidy) select cId,discountType,rate,subsidy from discountBase;
  -- 餐别限次
  insert into meal (companyId,mealName,beginTime,endTime,timeLimit) select cId,mealName,beginTime,endTime,timeLimit from mealBase;
  -- 订餐时间段
  insert into orderTime (companyId,orderTimeName,beginTime,endTime,enable) select cId,orderTimeName,beginTime,endTime,1 from orderTimeBase;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `getSubIds`
-- ----------------------------
DROP FUNCTION IF EXISTS `getSubIds`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getSubIds`(pId INT,tType INT) RETURNS varchar(4000) CHARSET utf8
BEGIN

declare tempIds varchar(4000);
declare tempSubIds varchar(4000);

set tempIds = '';
set tempSubIds = cast(pId as char);

while tempSubIds is not null do
	set tempIds = concat(tempIds,',',tempSubIds);
	if tType=0
	then
		select group_concat(id) into tempSubIds from userDept where find_in_set(parentId,tempSubIds)>0;
	else
		select group_concat(id) into tempSubIds from dept where find_in_set(parentId,tempSubIds)>0;
	end if;
end while;
return tempIds;

END
;;
DELIMITER ;
