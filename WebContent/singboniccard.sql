/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : singboniccard

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2015-11-06 11:06:35
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
INSERT INTO `authgroup` VALUES ('1', '1', '管理员', '', 'ROLE_SYSTEMMANAGER,ROLE_SYSTEMSETTING,ROLE_SYSTEMPARAM,ROLE_SYSTEMPARAM_SAVE,ROLE_BATCH,ROLE_BATCH_ADD,ROLE_BATCH_EDIT,ROLE_BATCH_DEL,ROLE_USERDEPT,ROLE_USERDEPT_ADD,ROLE_USERDEPT_EDIT,ROLE_USERDEPT_DEL,ROLE_DEPT,ROLE_DEPT_ADD,ROLE_DEPT_EDIT,ROLE_DEPT_DEL,ROLE_MEAL,ROLE_MEAL_SAVE,ROLE_COOKBOOK,ROLE_COOKBOOK_SAVE,ROLE_ORDERTIME,ROLE_ORDERTIME_SAVE,ROLE_DISCOUNT,ROLE_DISCOUNT_SAVE,ROLE_CONSUMEPARAM,ROLE_CONSUMEPARAM_SAVE,ROLE_POSPARAMGROUP,ROLE_POSPARAMGROUP_ADD,ROLE_POSPARAMGROUP_EDIT,ROLE_POSPARAMGROUP_DEL,ROLE_POSPARAMGROUP_SAVE,ROLE_WATERRATEGROUP,ROLE_WATERRATEGROUP_ADD,ROLE_WATERRATEGROUP_EDIT,ROLE_WATERRATEGROUP_DEL,ROLE_WATERRATEGROUP_SAVE,ROLE_CARDPARAM,ROLE_CARDPARAM_SAVE,ROLE_CARDPARAM,ROLE_CARDPARAM_SAVE,ROLE_ENTRANCEGUARD,ROLE_ENTRANCEGUARD_SAVE,ROLE_DEVICEMANAGER,ROLE_DEVICEMANAGER_POS,ROLE_DEVICEMANAGER_GROUP,ROLE_DEVICEMANAGER_GROUP_ADD,ROLE_DEVICEMANAGER_GROUP_EDIT,ROLE_DEVICEMANAGER_GROUP_DEL,ROLE_DEVICEMANAGER_POS,ROLE_DEVICEMANAGER_POS_ADD,ROLE_DEVICEMANAGER_POS_EDIT,ROLE_DEVICEMANAGER_POS_DEL,ROLE_DEVICEMANAGER_CARDREADER,ROLE_DEVICEMANAGER_CARDREADER_ADD,ROLE_DEVICEMANAGER_CARDREADER_EDIT,ROLE_DEVICEMANAGER_CARDREADER_DEL,ROLE_SYSUSER,ROLE_SYSUSER_ADD,ROLE_SYSUSER_EDIT,ROLE_SYSUSER_DEL,ROLE_USERROLES,ROLE_USERROLES_GROUP,ROLE_SYSUSER_ADD,ROLE_SYSUSER_EDIT,ROLE_SYSUSER_DEL,ROLE_USERROLES_USER,ROLE_USERROLES_USER_SAVE,ROLE_SUBSIDY,ROLE_ADDSUBSIDY,ROLE_ADDSUBSIDY_ADD_SUBSIDYFARE,ROLE_ADDSUBSIDY_AUTO_SUBSIDYFARE,ROLE_ADDSUBSIDY_ADD_SUBSIDY,ROLE_GENERATESUBSIDY,ROLE_GENERATESUBSIDY_EDIT_SUBSIDYFARE,ROLE_GENERATESUBSIDY_DEL,ROLE_GENERATESUBSIDY_GENERATE,ROLE_MONITOR,');
INSERT INTO `authgroup` VALUES ('2', '1', '出纳员', '', 'ROLE_CARDMANAGER,ROLE_MAINCARD,ROLE_FUNCCARD,ROLE_CARDREADER,ROLE_ACCOUNTCENTER,ROLE_MONITOR,');

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
INSERT INTO `authgroupbase` VALUES ('1', '管理员', 'ROLE_SYSTEMMANAGER,ROLE_SYSTEMSETTING,ROLE_SYSTEMPARAM,ROLE_SYSTEMPARAM_SAVE,ROLE_BATCH,ROLE_BATCH_ADD,ROLE_BATCH_EDIT,ROLE_BATCH_DEL,ROLE_USERDEPT,ROLE_USERDEPT_ADD,ROLE_USERDEPT_EDIT,ROLE_USERDEPT_DEL,ROLE_DEPT,ROLE_DEPT_ADD,ROLE_DEPT_EDIT,ROLE_DEPT_DEL,ROLE_MEAL,ROLE_MEAL_SAVE,ROLE_COOKBOOK,ROLE_COOKBOOK_SAVE,ROLE_ORDERTIME,ROLE_ORDERTIME_SAVE,ROLE_DISCOUNT,ROLE_DISCOUNT_SAVE,ROLE_CONSUMEPARAM,ROLE_CONSUMEPARAM_SAVE,ROLE_POSPARAMGROUP,ROLE_POSPARAMGROUP_ADD,ROLE_POSPARAMGROUP_EDIT,ROLE_POSPARAMGROUP_DEL,ROLE_POSPARAMGROUP_SAVE,ROLE_WATERRATEGROUP,ROLE_WATERRATEGROUP_ADD,ROLE_WATERRATEGROUP_EDIT,ROLE_WATERRATEGROUP_DEL,ROLE_WATERRATEGROUP_SAVE,ROLE_CARDPARAM,ROLE_CARDPARAM_SAVE,ROLE_CARDPARAM,ROLE_CARDPARAM_SAVE,ROLE_ENTRANCEGUARD,ROLE_ENTRANCEGUARD_SAVE,ROLE_DEVICEMANAGER,ROLE_DEVICEMANAGER_POS,ROLE_DEVICEMANAGER_GROUP,ROLE_DEVICEMANAGER_GROUP_ADD,ROLE_DEVICEMANAGER_GROUP_EDIT,ROLE_DEVICEMANAGER_GROUP_DEL,ROLE_DEVICEMANAGER_POS,ROLE_DEVICEMANAGER_POS_ADD,ROLE_DEVICEMANAGER_POS_EDIT,ROLE_DEVICEMANAGER_POS_DEL,ROLE_DEVICEMANAGER_CARDREADER,ROLE_DEVICEMANAGER_CARDREADER_ADD,ROLE_DEVICEMANAGER_CARDREADER_EDIT,ROLE_DEVICEMANAGER_CARDREADER_DEL,ROLE_SYSUSER,ROLE_SYSUSER_ADD,ROLE_SYSUSER_EDIT,ROLE_SYSUSER_DEL,ROLE_USERROLES,ROLE_USERROLES_GROUP,ROLE_SYSUSER_ADD,ROLE_SYSUSER_EDIT,ROLE_SYSUSER_DEL,ROLE_USERROLES_USER,ROLE_USERROLES_USER_SAVE,ROLE_SUBSIDY,ROLE_ADDSUBSIDY,ROLE_ADDSUBSIDY_ADD_SUBSIDYFARE,ROLE_ADDSUBSIDY_AUTO_SUBSIDYFARE,ROLE_ADDSUBSIDY_ADD_SUBSIDY,ROLE_GENERATESUBSIDY,ROLE_GENERATESUBSIDY_EDIT_SUBSIDYFARE,ROLE_GENERATESUBSIDY_DEL,ROLE_GENERATESUBSIDY_GENERATE,');
INSERT INTO `authgroupbase` VALUES ('2', '出纳员', 'ROLE_CARDMANAGER,ROLE_MAINCARD,ROLE_FUNCCARD,ROLE_CARDREADER,ROLE_ACCOUNTCENTER,ROLE_MONITOR,');

-- ----------------------------
-- Table structure for `authgroupuser`
-- ----------------------------
DROP TABLE IF EXISTS `authgroupuser`;
CREATE TABLE `authgroupuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operId` int(11) DEFAULT NULL,
  `groupId` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of authgroupuser
-- ----------------------------
INSERT INTO `authgroupuser` VALUES ('6', '13', '1');
INSERT INTO `authgroupuser` VALUES ('11', '21', '2');

-- ----------------------------
-- Table structure for `batch`
-- ----------------------------
DROP TABLE IF EXISTS `batch`;
CREATE TABLE `batch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `batchName` varchar(255) DEFAULT NULL,
  `beginDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `invalidDate` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of batch
-- ----------------------------
INSERT INTO `batch` VALUES ('1', '批次1', '2015-11-02 00:00:00', '2015-11-30 00:00:00', null, '1', '0');

-- ----------------------------
-- Table structure for `cardloss`
-- ----------------------------
DROP TABLE IF EXISTS `cardloss`;
CREATE TABLE `cardloss` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `cardNO` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cardloss
-- ----------------------------

-- ----------------------------
-- Table structure for `cardparam`
-- ----------------------------
DROP TABLE IF EXISTS `cardparam`;
CREATE TABLE `cardparam` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `cardCost` int(11) DEFAULT NULL,
  `cardDeposit` int(11) DEFAULT NULL,
  `prepayFare` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cardparam
-- ----------------------------
INSERT INTO `cardparam` VALUES ('1', '1', '10', '5', '20');

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
  `subsidyVersion` int(11) DEFAULT NULL,
  `enableSubsidyReset` int(11) DEFAULT NULL,
  `subsidyInvalidDate` varchar(50) DEFAULT NULL,
  `invalidDate` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of company
-- ----------------------------
INSERT INTO `company` VALUES ('1', '郑州兴邦科技有限公司', '12345678', '0371', '1', '5', '5', '5', '7', '0', '2015-11-30', '');

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
INSERT INTO `consumeparam` VALUES ('1', '1', '10', ',1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,,', '100', ',1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,,', '12', ',1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,,', '88888');

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
INSERT INTO `consumeparambase` VALUES ('1', '0', ',,', '0', ',,', '0', ',,', '88888');

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
  `deviceId` int(11) DEFAULT NULL,
  `sumFare` int(11) DEFAULT NULL,
  `oddFare` int(11) DEFAULT NULL,
  `subsidyOddFare` int(11) DEFAULT NULL,
  `discountFare` int(11) DEFAULT NULL,
  `opFare` int(11) DEFAULT NULL,
  `subsidyOpFare` int(11) DEFAULT NULL,
  `mealId` int(11) DEFAULT NULL,
  `opTime` datetime DEFAULT NULL,
  `collectTime` datetime DEFAULT NULL,
  `opCount` int(11) DEFAULT NULL,
  `subsidyOpCount` int(11) DEFAULT NULL,
  `recordNO` int(11) DEFAULT NULL,
  `consumeType` int(11) DEFAULT NULL,
  `cookbookCode` int(11) DEFAULT NULL,
  `cookbookNum` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userId` (`userId`,`cardNO`,`recordNO`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of consumerecord
-- ----------------------------
INSERT INTO `consumerecord` VALUES ('55', '1', '9', '1', '1', '2', '100000', '99800', '0', '0', '100', '0', '0', '2015-11-05 04:35:54', '2015-11-05 04:35:54', '3', '0', '3', '1', null, null);
INSERT INTO `consumerecord` VALUES ('59', '1', '9', '1', '1', '2', '100000', '99700', '0', '0', '100', '0', '0', '2015-11-05 04:39:29', '2015-11-05 04:39:29', '4', '0', '4', '1', null, null);
INSERT INTO `consumerecord` VALUES ('60', '1', '9', '1', '1', '2', '100000', '99500', '0', '0', '200', '0', '0', '2015-11-05 04:39:34', '2015-11-05 04:39:34', '5', '0', '5', '1', null, null);
INSERT INTO `consumerecord` VALUES ('61', '1', '9', '1', '1', '2', '100000', '99400', '0', '0', '100', '0', '0', '2015-11-05 04:39:39', '2015-11-05 04:39:39', '6', '0', '6', '1', null, null);
INSERT INTO `consumerecord` VALUES ('62', '1', '9', '1', '1', '2', '100000', '99300', '0', '0', '100', '0', '0', '2015-11-05 04:39:44', '2015-11-05 04:39:44', '7', '0', '7', '1', null, null);
INSERT INTO `consumerecord` VALUES ('63', '1', '9', '1', '1', '2', '100000', '99200', '0', '0', '100', '0', '0', '2015-11-05 04:40:09', '2015-11-05 04:40:09', '8', '0', '8', '1', null, null);
INSERT INTO `consumerecord` VALUES ('64', '1', '9', '1', '1', '2', '100000', '99100', '0', '0', '100', '0', '0', '2015-11-05 04:40:34', '2015-11-05 04:40:34', '9', '0', '9', '1', null, null);
INSERT INTO `consumerecord` VALUES ('65', '1', '9', '1', '1', '2', '100000', '99000', '0', '0', '100', '0', '0', '2015-11-05 04:40:49', '2015-11-05 04:40:49', '10', '0', '10', '1', null, null);
INSERT INTO `consumerecord` VALUES ('66', '1', '9', '1', '1', '2', '100000', '98900', '0', '0', '100', '0', '0', '2015-11-05 04:42:39', '2015-11-05 04:42:39', '11', '0', '11', '1', null, null);
INSERT INTO `consumerecord` VALUES ('67', '1', '9', '1', '1', '2', '100000', '98800', '0', '0', '100', '0', '0', '2015-11-05 04:43:19', '2015-11-05 04:43:19', '12', '0', '12', '1', null, null);
INSERT INTO `consumerecord` VALUES ('68', '1', '9', '1', '1', '2', '100000', '98700', '0', '0', '100', '0', '0', '2015-11-05 04:46:20', '2015-11-05 04:46:20', '13', '0', '13', '1', null, null);
INSERT INTO `consumerecord` VALUES ('69', '1', '9', '1', '1', '2', '100000', '98500', '0', '0', '200', '0', '0', '2015-11-05 04:47:50', '2015-11-05 04:47:50', '14', '0', '14', '1', null, null);
INSERT INTO `consumerecord` VALUES ('70', '1', '10', '2', '1', '2', '100000', '99900', '0', '0', '100', '0', '0', '2015-11-05 04:48:20', '2015-11-05 04:48:20', '2', '0', '15', '1', null, null);
INSERT INTO `consumerecord` VALUES ('71', '1', '9', '1', '1', '2', '100000', '98400', '0', '0', '100', '0', '0', '2015-11-05 04:48:30', '2015-11-05 04:48:30', '15', '0', '16', '1', null, null);
INSERT INTO `consumerecord` VALUES ('72', '1', '9', '1', '1', '2', '100000', '98390', '0', '0', '10', '0', '0', '2015-11-05 04:49:00', '2015-11-05 04:49:00', '16', '0', '17', '1', null, null);
INSERT INTO `consumerecord` VALUES ('73', '1', '9', '1', '1', '2', '100000', '98380', '0', '0', '10', '0', '0', '2015-11-05 04:49:10', '2015-11-05 04:49:10', '17', '0', '18', '1', null, null);
INSERT INTO `consumerecord` VALUES ('74', '1', '9', '1', '1', '2', '100000', '98280', '0', '0', '100', '0', '0', '2015-11-05 04:50:15', '2015-11-05 04:50:15', '18', '0', '19', '1', null, null);
INSERT INTO `consumerecord` VALUES ('75', '1', '9', '1', '1', '2', '100000', '98260', '0', '0', '20', '0', '0', '2015-11-05 04:50:26', '2015-11-05 04:50:26', '19', '0', '20', '1', null, null);
INSERT INTO `consumerecord` VALUES ('76', '1', '9', '1', '1', '2', '100000', '98259', '0', '0', '1', '0', '0', '2015-11-05 04:50:40', '2015-11-05 04:50:40', '20', '0', '21', '1', null, null);
INSERT INTO `consumerecord` VALUES ('77', '1', '9', '1', '1', '2', '100000', '98257', '0', '0', '2', '0', '0', '2015-11-05 04:50:50', '2015-11-05 04:50:50', '21', '0', '22', '1', null, null);
INSERT INTO `consumerecord` VALUES ('78', '1', '9', '1', '1', '2', '100000', '98157', '0', '0', '100', '0', '0', '2015-11-05 04:53:05', '2015-11-05 04:53:05', '22', '0', '23', '1', null, null);
INSERT INTO `consumerecord` VALUES ('79', '1', '9', '1', '1', '2', '100000', '98057', '0', '0', '100', '0', '0', '2015-11-05 04:53:15', '2015-11-05 04:53:15', '23', '0', '24', '1', null, null);
INSERT INTO `consumerecord` VALUES ('80', '1', '9', '1', '1', '2', '100000', '97957', '0', '0', '100', '0', '0', '2015-11-05 04:54:31', '2015-11-05 04:54:31', '24', '0', '25', '1', null, null);
INSERT INTO `consumerecord` VALUES ('81', '1', '9', '1', '1', '2', '100000', '97956', '0', '0', '1', '0', '0', '2015-11-05 04:56:01', '2015-11-05 04:56:01', '25', '0', '26', '1', null, null);
INSERT INTO `consumerecord` VALUES ('82', '1', '9', '1', '1', '2', '100000', '97856', '0', '0', '100', '0', '0', '2015-11-05 04:56:16', '2015-11-05 04:56:16', '26', '0', '27', '1', null, null);
INSERT INTO `consumerecord` VALUES ('83', '1', '9', '1', '1', '2', '100000', '97756', '0', '0', '100', '0', '0', '2015-11-05 04:58:21', '2015-11-05 04:58:21', '27', '0', '28', '1', null, null);
INSERT INTO `consumerecord` VALUES ('84', '1', '9', '1', '1', '2', '100000', '97656', '0', '0', '100', '0', '0', '2015-11-05 04:59:36', '2015-11-05 04:59:36', '28', '0', '29', '1', null, null);
INSERT INTO `consumerecord` VALUES ('85', '1', '9', '1', '1', '2', '100000', '97556', '0', '0', '100', '0', '0', '2015-11-05 05:01:21', '2015-11-05 05:01:21', '29', '0', '30', '1', null, null);
INSERT INTO `consumerecord` VALUES ('86', '1', '9', '1', '1', '2', '100000', '97456', '0', '0', '100', '0', '0', '2015-11-05 05:04:02', '2015-11-05 05:04:02', '30', '0', '31', '1', null, null);
INSERT INTO `consumerecord` VALUES ('87', '1', '9', '1', '1', '2', '100000', '97356', '0', '0', '100', '0', '0', '2015-11-05 05:05:42', '2015-11-05 05:05:42', '31', '0', '32', '1', null, null);
INSERT INTO `consumerecord` VALUES ('88', '1', '9', '1', '1', '2', '100000', '97256', '0', '0', '100', '0', '0', '2015-11-05 05:06:02', '2015-11-05 05:06:02', '32', '0', '33', '1', null, null);
INSERT INTO `consumerecord` VALUES ('89', '1', '9', '1', '1', '2', '100000', '95156', '0', '0', '2100', '0', '0', '2015-11-05 05:06:07', '2015-11-05 05:06:07', '33', '0', '34', '1', null, null);
INSERT INTO `consumerecord` VALUES ('92', '1', '10', '2', '1', '2', '100000', '99699', '0', '0', '1', '0', '18', '2015-11-05 06:46:37', '2015-11-05 06:46:34', '5', '0', '37', '1', null, null);
INSERT INTO `consumerecord` VALUES ('93', '1', '10', '2', '1', '2', '100000', '99599', '0', '0', '100', '0', '18', '2015-11-05 07:44:44', '2015-11-05 07:45:43', '6', '0', '38', '1', null, null);

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
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cookbook
-- ----------------------------
INSERT INTO `cookbook` VALUES ('1', '1', '1', '胡辣汤frist', '1', '', '');
INSERT INTO `cookbook` VALUES ('2', '1', '2', '胡辣汤2', '2', '', '');
INSERT INTO `cookbook` VALUES ('3', '1', '3', '胡辣汤3', '2', null, '');
INSERT INTO `cookbook` VALUES ('4', '1', '4', '胡辣汤4', '15', null, '');
INSERT INTO `cookbook` VALUES ('5', '1', '5', '胡辣汤5', '20', null, '');
INSERT INTO `cookbook` VALUES ('6', '1', '6', '胡辣汤6', '28', null, '');
INSERT INTO `cookbook` VALUES ('7', '1', '7', '胡辣汤7', '18', null, '');
INSERT INTO `cookbook` VALUES ('8', '1', '8', '胡辣汤8', '3', null, '');
INSERT INTO `cookbook` VALUES ('9', '1', '9', '胡辣汤9', '3', null, '');
INSERT INTO `cookbook` VALUES ('10', '1', '10', '胡辣汤10', '3', null, '');
INSERT INTO `cookbook` VALUES ('11', '1', '11', '胡辣汤11', '3', null, '');
INSERT INTO `cookbook` VALUES ('12', '1', '12', '胡辣汤12', '6', null, '');
INSERT INTO `cookbook` VALUES ('13', '1', '13', '胡辣汤13', '9', null, '');
INSERT INTO `cookbook` VALUES ('14', '1', '14', '胡辣汤14', '12', null, '');
INSERT INTO `cookbook` VALUES ('15', '1', '15', '胡辣汤15', '15', null, '');
INSERT INTO `cookbook` VALUES ('16', '1', '16', '胡辣汤16', '18', null, '');
INSERT INTO `cookbook` VALUES ('17', '1', '17', '胡辣汤17', '21', null, '');
INSERT INTO `cookbook` VALUES ('18', '1', '18', '胡辣汤18', '22', null, '');
INSERT INTO `cookbook` VALUES ('19', '1', '19', '胡辣汤19', '24', null, '');
INSERT INTO `cookbook` VALUES ('20', '1', '20', '胡辣汤20', '26', null, '');
INSERT INTO `cookbook` VALUES ('21', '1', '21', '胡辣汤21', '28', null, '');
INSERT INTO `cookbook` VALUES ('22', '1', '22', '胡辣汤22', '29', null, '');
INSERT INTO `cookbook` VALUES ('23', '1', '23', '胡辣汤23', '30', null, '');
INSERT INTO `cookbook` VALUES ('24', '1', '24', '胡辣汤24', '31', null, '');
INSERT INTO `cookbook` VALUES ('25', '1', '25', '胡辣汤25', '32', null, '');
INSERT INTO `cookbook` VALUES ('26', '1', '26', '胡辣汤26', '33', null, '');
INSERT INTO `cookbook` VALUES ('27', '1', '27', '胡辣汤27', '34', null, '');
INSERT INTO `cookbook` VALUES ('28', '1', '28', '胡辣汤28', '36', null, '');
INSERT INTO `cookbook` VALUES ('29', '1', '29', '胡辣汤29', '37', null, '');
INSERT INTO `cookbook` VALUES ('30', '1', '30', '胡辣汤30', '38', null, '');
INSERT INTO `cookbook` VALUES ('31', '1', '31', '胡辣汤31', '39', null, '');
INSERT INTO `cookbook` VALUES ('32', '1', '32', '胡辣汤32', '40', null, '');
INSERT INTO `cookbook` VALUES ('33', '1', '33', '胡辣汤33', '10', null, '');
INSERT INTO `cookbook` VALUES ('34', '1', '34', '胡辣汤34', '30', null, '');
INSERT INTO `cookbook` VALUES ('35', '1', '35', '胡辣汤35', '10', null, '');
INSERT INTO `cookbook` VALUES ('36', '1', '36', '胡辣汤36', '15', null, '');
INSERT INTO `cookbook` VALUES ('37', '1', '37', '胡辣汤37', '15', null, '');
INSERT INTO `cookbook` VALUES ('38', '1', '38', '胡辣汤38', '20', null, '');
INSERT INTO `cookbook` VALUES ('39', '1', '39', '胡辣汤39', '25', null, '');
INSERT INTO `cookbook` VALUES ('40', '1', '40', '胡辣汤40', '25', null, '');
INSERT INTO `cookbook` VALUES ('41', '1', '41', '胡辣汤41', '10', null, '');
INSERT INTO `cookbook` VALUES ('42', '1', '42', '胡辣汤42', '5', null, '');
INSERT INTO `cookbook` VALUES ('43', '1', '43', '胡辣汤43', '30', null, '');
INSERT INTO `cookbook` VALUES ('44', '1', '44', '胡辣汤44', '30', null, '');
INSERT INTO `cookbook` VALUES ('45', '1', '45', '胡辣汤45', '10', null, '');
INSERT INTO `cookbook` VALUES ('46', '1', '46', '胡辣汤46', '30', null, '');
INSERT INTO `cookbook` VALUES ('47', '1', '47', '胡辣汤47', '20', null, '');
INSERT INTO `cookbook` VALUES ('48', '1', '48', '胡辣汤48', '25', null, '');
INSERT INTO `cookbook` VALUES ('49', '1', '49', '胡辣汤49', '25', null, '');
INSERT INTO `cookbook` VALUES ('50', '1', '50', '胡辣汤50', '15', null, '');
INSERT INTO `cookbook` VALUES ('51', '1', '51', '胡辣汤51', '15', null, '');
INSERT INTO `cookbook` VALUES ('52', '1', '52', '胡辣汤52', '15', null, '');
INSERT INTO `cookbook` VALUES ('53', '1', '53', '胡辣汤53', '25', null, '');
INSERT INTO `cookbook` VALUES ('54', '1', '54', '胡辣汤54', '25', null, '');
INSERT INTO `cookbook` VALUES ('55', '1', '55', '胡辣汤55', '10', null, '');
INSERT INTO `cookbook` VALUES ('56', '1', '56', '胡辣汤56', '20', null, '');
INSERT INTO `cookbook` VALUES ('57', '1', '57', '胡辣汤57', '8', null, '');
INSERT INTO `cookbook` VALUES ('58', '1', '58', '胡辣汤58', '15', null, '');
INSERT INTO `cookbook` VALUES ('59', '1', '59', '胡辣汤59', '20', null, '');
INSERT INTO `cookbook` VALUES ('60', '1', '60', '胡辣汤60', '25', null, '');
INSERT INTO `cookbook` VALUES ('61', '1', '61', '胡辣汤61', '20', null, '');
INSERT INTO `cookbook` VALUES ('62', '1', '62', '胡辣汤62', '20', null, '');
INSERT INTO `cookbook` VALUES ('63', '1', '63', '胡辣汤63', '18', null, '');
INSERT INTO `cookbook` VALUES ('64', '1', '64', '胡辣汤64', '20', null, '');
INSERT INTO `cookbook` VALUES ('65', '1', '65', '胡辣汤65', '20', null, '');
INSERT INTO `cookbook` VALUES ('66', '1', '66', '胡辣汤66', '10', null, '');
INSERT INTO `cookbook` VALUES ('67', '1', '67', '胡辣汤67', '25', null, '');
INSERT INTO `cookbook` VALUES ('68', '1', '68', '胡辣汤68', '20', null, '');
INSERT INTO `cookbook` VALUES ('69', '1', '69', '胡辣汤69', '18', null, '');
INSERT INTO `cookbook` VALUES ('70', '1', '70', '胡辣汤70', '25', null, '');
INSERT INTO `cookbook` VALUES ('71', '1', '71', '胡辣汤71', '15', null, '');
INSERT INTO `cookbook` VALUES ('72', '1', '72', '胡辣汤72', '15', null, '');
INSERT INTO `cookbook` VALUES ('73', '1', '73', '胡辣汤73', '15', null, '');
INSERT INTO `cookbook` VALUES ('74', '1', '74', '胡辣汤74', '25', null, '');
INSERT INTO `cookbook` VALUES ('75', '1', '75', '胡辣汤75', '15', null, '');
INSERT INTO `cookbook` VALUES ('76', '1', '76', '胡辣汤76', '35', null, '');
INSERT INTO `cookbook` VALUES ('77', '1', '77', '胡辣汤77', '15', null, '');
INSERT INTO `cookbook` VALUES ('78', '1', '78', '胡辣汤78', '10', null, '');
INSERT INTO `cookbook` VALUES ('79', '1', '79', '胡辣汤79', '25', null, '');
INSERT INTO `cookbook` VALUES ('80', '1', '80', '胡辣汤80', '15', null, '');
INSERT INTO `cookbook` VALUES ('81', '1', '81', '胡辣汤81', '15', null, '');
INSERT INTO `cookbook` VALUES ('82', '1', '82', '胡辣汤82', '15', null, '');
INSERT INTO `cookbook` VALUES ('83', '1', '83', '胡辣汤83', '30', null, '');
INSERT INTO `cookbook` VALUES ('84', '1', '84', '胡辣汤84', '20', null, '');
INSERT INTO `cookbook` VALUES ('85', '1', '85', '胡辣汤85', '20', null, '');
INSERT INTO `cookbook` VALUES ('86', '1', '86', '胡辣汤86', '30', null, '');
INSERT INTO `cookbook` VALUES ('87', '1', '87', '胡辣汤87', '15', null, '');
INSERT INTO `cookbook` VALUES ('88', '1', '88', '胡辣汤88', '10', null, '');
INSERT INTO `cookbook` VALUES ('89', '1', '89', '胡辣汤89', '25', null, '');
INSERT INTO `cookbook` VALUES ('90', '1', '90', '胡辣汤90', '20', null, '');
INSERT INTO `cookbook` VALUES ('91', '1', '91', '胡辣汤91', '20', null, '');
INSERT INTO `cookbook` VALUES ('92', '1', '92', '胡辣汤92', '15', null, '');
INSERT INTO `cookbook` VALUES ('93', '1', '93', '胡辣汤93', '15', null, '');
INSERT INTO `cookbook` VALUES ('94', '1', '94', '胡辣汤94', '15', null, '');
INSERT INTO `cookbook` VALUES ('95', '1', '95', '胡辣汤95', '15', null, '');
INSERT INTO `cookbook` VALUES ('96', '1', '96', '胡辣汤96', '15', null, '');
INSERT INTO `cookbook` VALUES ('97', '1', '97', '胡辣汤97', '25', null, '');
INSERT INTO `cookbook` VALUES ('98', '1', '98', '胡辣汤98', '30', null, '');
INSERT INTO `cookbook` VALUES ('99', '1', '99', '胡辣汤99', '15', null, '');
INSERT INTO `cookbook` VALUES ('100', '1', '100', '胡辣汤100', '20', null, '');

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dept
-- ----------------------------
INSERT INTO `dept` VALUES ('1', '部门1', '1', '0');
INSERT INTO `dept` VALUES ('2', '部门2', '1', '0');
INSERT INTO `dept` VALUES ('3', '部门11', '1', '1');

-- ----------------------------
-- Table structure for `device`
-- ----------------------------
DROP TABLE IF EXISTS `device`;
CREATE TABLE `device` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `deptId` int(11) DEFAULT NULL,
  `posParamGroupId` int(11) DEFAULT NULL,
  `deviceName` varchar(255) DEFAULT NULL,
  `deviceNum` int(11) DEFAULT NULL,
  `deviceType` int(11) DEFAULT '0' COMMENT '1读卡器,2点餐机,3水控,4手持机',
  `enable` int(11) DEFAULT NULL,
  `sn` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of device
-- ----------------------------
INSERT INTO `device` VALUES ('1', '1', '1', null, '读卡机', '12345678', '8', '0', '4159A96E838E4DF5BDECD4E2D8E940F1');
INSERT INTO `device` VALUES ('2', '1', '1', '1', '点餐机1', '1', '2', '1', '01010101010101010101010101010101');
INSERT INTO `device` VALUES ('3', '1', '1', '1', '点餐机2', '2', '2', '1', '02020202020202020202020202020202');
INSERT INTO `device` VALUES ('4', '1', '1', '1', '水控10', '3', '3', '1', '03030303030303030303030303030303');
INSERT INTO `device` VALUES ('5', '1', '1', '1', '水控2', '4', '3', '1', '04040404040404040404040404040404');
INSERT INTO `device` VALUES ('7', '1', '1', '1', '点餐机7', '7', '2', '1', '22625A386F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('8', '1', '1', '1', '点餐机8', '8', '2', '1', '229D3EB46F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('9', '1', '1', '1', '点餐机9', '9', '2', '1', '22C376E36F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('10', '1', '1', '1', '点餐机10', '10', '2', '1', '22E689476F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('11', '1', '1', '3', '点餐机11', '11', '3', '0', '23080C2D6F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('12', '1', '1', '1', '点餐机12', '12', '2', '1', '232C507C6F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('13', '1', '1', '1', '点餐机13', '13', '2', '1', '234CB6FF6F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('14', '1', '1', '1', '点餐机14', '14', '2', '1', '239293FC6F2711E5AA1500E04C828A81');
INSERT INTO `device` VALUES ('15', '1', '1', '1', '点餐机15', '15', '2', '1', '239293FC6F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('16', '1', '1', '1', '点餐机16', '16', '2', '1', '23B4C7DE6F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('17', '1', '1', '1', '点餐机17', '17', '2', '1', '23D80F8B6F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('18', '1', '1', '1', '点餐机18', '18', '2', '1', '23F851026F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('19', '1', '1', '1', '点餐机19', '19', '2', '1', '241B76B26F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('20', '1', '1', '1', '点餐机20', '20', '2', '1', '243E3E0F6F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('21', '1', '1', '1', '点餐机21', '21', '2', '1', '2462699E6F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('22', '1', '1', '1', '点餐机22', '22', '2', '1', '248AE2E66F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('23', '1', '1', '1', '点餐机23', '23', '2', '1', '24AE818D6F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('24', '1', '1', '1', '点餐机24', '24', '2', '1', '24D079886F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('25', '1', '1', '1', '点餐机25', '25', '2', '1', '24F96CDC6F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('26', '1', '1', '1', '点餐机26', '26', '2', '1', '251DC4286F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('27', '1', '1', '1', '点餐机27', '27', '2', '1', '25421BF16F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('28', '1', '1', '1', '点餐机28', '28', '2', '1', '2566D36E6F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('29', '1', '1', '1', '点餐机29', '29', '2', '1', '258BC7FD6F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('30', '1', '1', '1', '点餐机30', '30', '2', '1', '25B7ED7C6F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('31', '1', '1', '1', '点餐机31', '31', '2', '1', '25DD26CE6F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('32', '1', '1', '1', '点餐机32', '32', '2', '1', '25FFBE446F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('33', '1', '1', '1', '点餐机33', '33', '2', '1', '26221EA06F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('34', '1', '1', '1', '点餐机34', '34', '2', '1', '264B1FEF6F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('35', '1', '1', '1', '点餐机35', '35', '2', '1', '2674E5B76F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('36', '1', '1', '1', '点餐机36', '36', '2', '1', '2698EDD36F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('37', '1', '1', '1', '点餐机37', '37', '2', '1', '26C153396F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('38', '1', '1', '1', '点餐机38', '38', '2', '1', '26EE7CD96F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('39', '1', '1', '1', '点餐机39', '39', '2', '1', '2715548B6F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('40', '1', '1', '1', '点餐机40', '40', '2', '1', '273772AD6F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('41', '1', '1', '1', '点餐机41', '41', '2', '1', '2757282D6F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('42', '1', '1', '1', '点餐机42', '42', '2', '1', '327FB7E36F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('43', '1', '1', '1', '点餐机43', '43', '2', '1', '32B0ED556F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('44', '1', '1', '1', '点餐机44', '44', '2', '1', '32D783426F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('45', '1', '1', '1', '点餐机45', '4005', '2', '1', '32FDD8216F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('46', '1', '1', '1', '点餐机46', '46', '2', '1', '332239BD6F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('47', '1', '1', '1', '点餐机47', '47', '2', '1', '3349D7A76F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('48', '1', '1', '1', '点餐机48', '48', '2', '1', '336D05936F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('49', '1', '1', '1', '点餐机49', '49', '2', '1', '3398045A6F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('50', '1', '1', '1', '点餐机50', '50', '2', '1', '33D76A4D6F2711E5AA1500E04C828A8D');
INSERT INTO `device` VALUES ('52', '1', '3', '1', '水控10', '30000', '3', '1', '03030303030303030303030303030300');

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
  `giveCash` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of discount
-- ----------------------------
INSERT INTO `discount` VALUES ('4', '1', '0', '100', '200', '0');
INSERT INTO `discount` VALUES ('5', '1', '1', '100', '100', '0');
INSERT INTO `discount` VALUES ('6', '1', '2', '100', '0', '0');
INSERT INTO `discount` VALUES ('7', '1', '3', '100', '0', '0');
INSERT INTO `discount` VALUES ('8', '1', '4', '100', '0', '0');
INSERT INTO `discount` VALUES ('9', '1', '5', '100', '0', '0');
INSERT INTO `discount` VALUES ('10', '1', '6', '100', '0', '0');
INSERT INTO `discount` VALUES ('11', '1', '7', '100', '1', '0');
INSERT INTO `discount` VALUES ('12', '1', '8', '100', '0', '0');
INSERT INTO `discount` VALUES ('13', '1', '9', '100', '0', '0');
INSERT INTO `discount` VALUES ('14', '1', '10', '100', '0', '0');
INSERT INTO `discount` VALUES ('15', '1', '11', '100', '0', '0');
INSERT INTO `discount` VALUES ('16', '1', '12', '100', '0', '0');
INSERT INTO `discount` VALUES ('17', '1', '13', '100', '0', '0');
INSERT INTO `discount` VALUES ('18', '1', '14', '100', '0', '0');
INSERT INTO `discount` VALUES ('19', '1', '15', '100', '0', '0');

-- ----------------------------
-- Table structure for `discountbase`
-- ----------------------------
DROP TABLE IF EXISTS `discountbase`;
CREATE TABLE `discountbase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discountType` int(255) DEFAULT NULL,
  `rate` int(11) DEFAULT NULL,
  `subsidy` int(11) DEFAULT NULL,
  `giveCash` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of discountbase
-- ----------------------------
INSERT INTO `discountbase` VALUES ('1', '0', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('2', '1', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('3', '2', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('4', '3', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('5', '4', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('6', '5', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('7', '6', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('8', '7', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('9', '8', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('10', '9', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('11', '10', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('12', '11', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('13', '12', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('14', '13', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('15', '14', '100', '0', '0');
INSERT INTO `discountbase` VALUES ('16', '15', '100', '0', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of entranceguard
-- ----------------------------
INSERT INTO `entranceguard` VALUES ('1', '1', '10', '0', '1', '1', '2', '000000');

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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of meal
-- ----------------------------
INSERT INTO `meal` VALUES ('18', '1', '早餐', '06:30:00', '10:30:00', '1');
INSERT INTO `meal` VALUES ('19', '1', '午餐', '10:30:01', '15:30:00', '0');
INSERT INTO `meal` VALUES ('20', '1', '晚餐', '15:30:01', '18:30:00', '0');
INSERT INTO `meal` VALUES ('21', '1', '夜宵', '18:30:01', '20:30:00', '0');
INSERT INTO `meal` VALUES ('22', '1', '加班一', '20:30:01', '22:30:00', '0');
INSERT INTO `meal` VALUES ('23', '1', '加班二', '22:00:01', '23:59:59', '10');

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
INSERT INTO `mealbase` VALUES ('1', '早餐', '06:30:00', '10:30:00', '0');
INSERT INTO `mealbase` VALUES ('2', '午餐', '10:30:01', '15:30:00', '0');
INSERT INTO `mealbase` VALUES ('3', '晚餐', '15:30:01', '18:30:00', '0');
INSERT INTO `mealbase` VALUES ('4', '夜宵', '18:30:01', '20:30:00', '0');
INSERT INTO `mealbase` VALUES ('5', '加班一', '20:30:01', '22:30:00', '0');
INSERT INTO `mealbase` VALUES ('6', '加班二', '22:00:01', '23:59:59', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of multiwaterrategroup
-- ----------------------------
INSERT INTO `multiwaterrategroup` VALUES ('1', null, null, '97', '2', '0', '0', '100', '0', '0', '0', '100', '0', '0', '0', '100', '0', '0', '0', '100', '0', '00:00', '8888', '3', '0', '0', '0', '0', '0', '1');
INSERT INTO `multiwaterrategroup` VALUES ('2', '1', '一控多', '73', '2', '0', '0', '100', '0', '0', '0', '100', '0', '0', '0', '100', '0', '0', '0', '100', '0', '00:00', '8888', '3', '0', '0', '0', '0', '0', '1');
INSERT INTO `multiwaterrategroup` VALUES ('3', '1', '一控多', '97', '2', '0', '0', '100', '0', '0', '0', '100', '0', '0', '0', '100', '0', '0', '0', '100', '0', null, '8888', '3', '0', '0', '0', '0', '0', '1');

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
INSERT INTO `ordertime` VALUES ('1', '1', '早餐', '06:00', '08:30', '111', '');
INSERT INTO `ordertime` VALUES ('2', '1', '中餐', '11:30', '14:00', null, '');
INSERT INTO `ordertime` VALUES ('3', '1', '晚餐', '17:00', '19:00', null, '');
INSERT INTO `ordertime` VALUES ('4', '1', '夜宵', '19:01', '20:30', null, '');
INSERT INTO `ordertime` VALUES ('5', '1', '加班1', '20:31', '23:59', '', '');
INSERT INTO `ordertime` VALUES ('6', '1', '加班2', '00:00', '00:00', '', '');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of posparamgroup
-- ----------------------------
INSERT INTO `posparamgroup` VALUES ('1', '1', '消费机参数组1', '1', '1', '1', '1', '1', '1', '1', '3');
INSERT INTO `posparamgroup` VALUES ('3', '1', '消费机参数组2', '0', '0', '1', '1', '1', '1', '1', '3');

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
INSERT INTO `singbon` VALUES ('1', 'c66fc61212bbc6ed', 'c66fc61212bbc6ed');

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
  `status` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of subsidy
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sysuser
-- ----------------------------
INSERT INTO `sysuser` VALUES ('13', '1', 'c66fc61212bbc6ed', 'a9e28c83699391f8', '0', null);
INSERT INTO `sysuser` VALUES ('21', '1', 'ab27a17b4ce6c685', 'a9e28c83699391f8', '1', null);

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `deptId` int(11) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `shortName` varchar(255) DEFAULT NULL,
  `userNO` varchar(255) DEFAULT NULL,
  `cardID` varchar(255) DEFAULT NULL,
  `cardNO` int(255) DEFAULT NULL,
  `cardSN` varchar(255) DEFAULT NULL,
  `cardSeq` int(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '0未发卡、241正常、243挂失、244注销卡，其他都是异常卡',
  `sex` int(11) DEFAULT NULL,
  `cardTypeId` int(11) DEFAULT NULL,
  `cardFunc` int(11) DEFAULT NULL,
  `cardIdentity` int(11) DEFAULT NULL,
  `beginDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `invalidDate` date DEFAULT NULL,
  `cardMakeDate` date DEFAULT NULL,
  `consumePwd` varchar(255) DEFAULT NULL,
  `identityPwd` varchar(255) DEFAULT NULL,
  `totalFare` int(11) DEFAULT '0',
  `oddFare` int(11) DEFAULT '0',
  `lastConsumeTime` datetime DEFAULT NULL,
  `daySumFare` int(11) DEFAULT '0',
  `opCount` int(11) DEFAULT '0',
  `subsidyOddFare` float DEFAULT '0',
  `lastSubsidyConsumeTime` datetime DEFAULT NULL,
  `subsidydaySum` int(11) DEFAULT '0',
  `subsidyOpCount` int(11) DEFAULT '0',
  `subsidyVersion` int(11) DEFAULT '0',
  `subsidyInvalidDate` date DEFAULT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('9', '1', '1', '001', '001', '001', '123456789012345678', '1', '7025f025', '1', '241', '0', '0', '0', '1', '2015-11-02', null, '2015-11-30', '2015-11-05', '8888', '8888', '100000', '100000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('10', '1', '1', '002', '002', '002', '123456789012345678', '2', '90d24626', '1', '241', '0', '0', '0', '1', '2015-11-02', null, '2015-11-30', '2015-11-05', '8888', '8888', '100000', '100000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('11', '1', '1', '003', '003', '003', '123456789012345678', '3', 'a48a2a41', '1', '241', '0', '0', '0', '1', '2015-11-02', null, '2015-11-30', '2015-11-05', '8888', '8888', '100000', '100000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('12', '1', '1', '004', '004', '004', '123456789012345678', '4', 'd4841941', '1', '241', '0', '0', '0', '1', '2015-11-02', null, '2015-11-30', '2015-11-05', '8888', '8888', '100000', '100000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('13', '1', '1', '005', '005', '005', '123456789012345678', '5', '0c4d582f', '1', '241', '0', '0', '0', '1', '2015-11-02', null, '2015-11-30', '2015-11-05', '8888', '8888', '100000', '100000', null, '0', '1', '0', null, '0', '0', '0', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userdept
-- ----------------------------
INSERT INTO `userdept` VALUES ('1', '部门1', '1', '0', '1');
INSERT INTO `userdept` VALUES ('2', '部门2', '1', '0', '1');
INSERT INTO `userdept` VALUES ('3', '部门3', '1', '0', '1');
INSERT INTO `userdept` VALUES ('4', '部门11', '1', '1', '1');
INSERT INTO `userdept` VALUES ('5', '部门12', '1', '1', '1');
INSERT INTO `userdept` VALUES ('6', '部门13', '1', '1', '1');
INSERT INTO `userdept` VALUES ('7', '部门111', '1', '4', '1');
INSERT INTO `userdept` VALUES ('8', '部门112', '1', '4', '1');
INSERT INTO `userdept` VALUES ('9', '部门1121', '1', '8', '1');
INSERT INTO `userdept` VALUES ('10', '部门31', '1', '3', '1');
INSERT INTO `userdept` VALUES ('11', '部门311', '1', '10', '1');
INSERT INTO `userdept` VALUES ('12', '部门312', '1', '10', '1');
INSERT INTO `userdept` VALUES ('13', '部门3111', '1', '11', '1');

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
  `waterPrecision` int(11) DEFAULT NULL,
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of waterrategroup
-- ----------------------------
INSERT INTO `waterrategroup` VALUES ('3', '1', '111', '97', '0', '1', '2', '0', '0', '100', '1', '0', ',,', '0', '0', '100', '00:00', '00:00', ',,', '0', '0', '100', '00:00', '00:00', ',,', '0', '0', '100', '00:00', '00:00', ',,', '0', '0', '0', '8888', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1');
INSERT INTO `waterrategroup` VALUES ('4', '1', '1112', '97', '0', '1', '2', '0', '0', '100', '1', '0', ',,', '0', '0', '100', '00:00', '00:00', ',,', '0', '0', '100', '00:00', '00:00', ',,', '0', '0', '100', '00:00', '00:00', ',,', '0', '0', '0', '8888', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1');

-- ----------------------------
-- Table structure for `waterrategroupbase`
-- ----------------------------
DROP TABLE IF EXISTS `waterrategroupbase`;
CREATE TABLE `waterrategroupbase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `consumeType` int(11) DEFAULT NULL,
  `goWaterType` int(11) DEFAULT NULL,
  `stopWaterType` int(11) DEFAULT NULL,
  `waterPrecision` int(11) DEFAULT NULL,
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of waterrategroupbase
-- ----------------------------
INSERT INTO `waterrategroupbase` VALUES ('1', '97', '0', '1', '2', '0', '0', '100', '0', '0', null, '0', '0', '100', '00:00', '00:00', '', '0', '0', '100', '00:00', '00:00', null, '0', '0', '100', '00:00', '00:00', null, '0', '0', '0', '8888', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1');

-- ----------------------------
-- Procedure structure for `delInitData`
-- ----------------------------
DROP PROCEDURE IF EXISTS `delInitData`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delInitData`()
BEGIN

delete from batch where companyId not in (select id from company);
delete from cardloss where companyId not in (select id from company);
delete from cardparam where companyId not in (select id from company);
delete from consume where companyId not in (select id from company);
delete from consumeparam where companyId not in (select id from company);
delete from cookbook where companyId not in (select id from company);
delete from dept where companyId not in (select id from company);
delete from device where companyId not in (select id from company);
delete from devicegroup where companyId not in (select id from company);
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

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `insertConsumeRecord`
-- ----------------------------
DROP PROCEDURE IF EXISTS `insertConsumeRecord`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertConsumeRecord`(IN `ccompanyId` int,IN `cuserId` int,IN `ccardNO` int,IN `ccardSeq` int,IN `cdeviceId` int,IN `csumFare` int,IN `coddFare` int,IN `csubsidyOddFare` int,IN `cdiscountFare` int,IN `copFare` int,IN `csubsidyOpFare` int,IN `cmealId` int,IN `copTime` datetime,IN `copCount` int,IN `csubsidyOpCount` int,IN `crecordNO` int,IN `cconsumeType` int,IN `ccookbookCode` int,IN `ccookbookNum` int,OUT `cresult` int,OUT `cuserNO` varchar(50),OUT `cusername` varchar(50),OUT `ccookbookName` varchar(50))
BEGIN
					/*#companyId,mode=IN,jdbcType=INTEGER},
        	#{userId,mode=IN,jdbcType=INTEGER},
        	#{cardSeq,mode=IN,jdbcType=INTEGER},
        	#{devcieId,mode=IN,jdbcType=INTEGER},
        	#{sumFare,mode=IN,jdbcType=INTEGER},
        	#{oddFare,mode=IN,jdbcType=INTEGER},
        	#{subsidyOddFare,mode=IN,jdbcType=INTEGER},
        	#{discountFare,mode=IN,jdbcType=INTEGER},
        	#{opFare,mode=IN,jdbcType=INTEGER},
        	#{subsidyOpFare,mode=IN,jdbcType=INTEGER},
        	#{opTime,mode=IN,jdbcType=java.util.Date},
        	#{opCount,mode=IN,jdbcType=INTEGER},
        	#{subsidyOpCount,mode=IN,jdbcType=INTEGER},
        	#{recordNO,mode=IN,jdbcType=INTEGER},
        	#{recordType,mode=IN,jdbcType=INTEGER},
        	#{cookbookCode,mode=IN,jdbcType=INTEGER},
        	#{cookbookNum,mode=IN,jdbcType=INTEGER},
        	#{result, mode=OUT, jdbcType=INTEGER}
        	#{userNO, mode=OUT, jdbcType=INTEGER}#Routine body goes here...*/	 
		DECLARE EXIT HANDLER FOR SQLEXCEPTION set cresult=0;
		set cresult=1;
		insert into consumerecord (companyId,userId,cardNO,cardSeq,deviceId,sumFare,oddFare,subsidyOddFare,discountFare,opFare,subsidyOpFare,mealId,opTime,collectTime,opCount,subsidyOpCount,recordNO,consumeType,cookbookCode,cookbookNum)
		values (ccompanyId,cuserId,ccardNO,ccardSeq,cdeviceId,csumFare,coddFare,csubsidyOddFare,cdiscountFare,copFare,csubsidyOpFare,cmealId,copTime,NOW(),copCount,csubsidyOpCount,crecordNO,cconsumeType,ccookbookCode,ccookbookNum);
		select userNO,username into cuserNO,cusername from user where userId=cuserId;

		if ccookbookCode is not null
		then
			select cookbookName into ccookbookName from cookbook where companyId=ccompanyId and cookbookCode=ccookbookCode;
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
	insert into authgroup(companyId,groupName,roles) select cId,groupName,roles from authgroupbase;
	insert into sysUser (companyId,loginName,loginPwd) values(cId,'c66fc61212bbc6ed','a9e28c83699391f8');
	insert into authgroupuser(operId,groupId) select (select operId from sysUser where companyId=cId),(select id from authgroup where companyId=cId and groupName='管理员');
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
