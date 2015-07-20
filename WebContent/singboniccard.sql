/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : singboniccard

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2015-07-18 16:07:22
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of authgroup
-- ----------------------------
INSERT INTO `authgroup` VALUES ('1', '1', '管理员', null, null);
INSERT INTO `authgroup` VALUES ('2', '1', '出纳员', null, null);
INSERT INTO `authgroup` VALUES ('3', '1', '出纳员2', '', 'ROLE_SYSTEMSETTING,ROLE_BATCH,ROLE_BATCH_ADD,ROLE_ACCOUNTINGCENTER,');
INSERT INTO `authgroup` VALUES ('6', '1', '好', null, 'ROLE_SYSTEMSETTING,ROLE_SYSTEMPARAMETER,ROLE_BATCH,ROLE_BATCH_ADD,ROLE_BATCH_EDIT,ROLE_USERDEPT,ROLE_USERDEPT_ADD,ROLE_USERDEPT_EDIT,ROLE_USERDEPT_DEL,ROLE_DISCOUNT,ROLE_DISCOUNT_ADD,ROLE_DISCOUNT_EDIT,ROLE_DISCOUNT_DEL,');
INSERT INTO `authgroup` VALUES ('7', '1', '出纳员23', null, 'ffsff');
INSERT INTO `authgroup` VALUES ('8', '1', '出纳员234', null, 'ROLE_SYSTEMSETTING,ROLE_SYSTEMPARAMETER,ROLE_BATCH,ROLE_BATCH_ADD,ROLE_BATCH_EDIT,ROLE_USERDEPT,ROLE_USERDEPT_ADD,ROLE_USERDEPT_EDIT,ROLE_USERDEPT_DEL,ROLE_DISCOUNT,ROLE_DISCOUNT_ADD,ROLE_DISCOUNT_EDIT,ROLE_DISCOUNT_DEL,ROLE_CARDCENTER,ROLE_FUNCCARD,ROLE_CARDMANAGER,ROLE_ACCOUNTINGCENTER,');

-- ----------------------------
-- Table structure for `authusergroup`
-- ----------------------------
DROP TABLE IF EXISTS `authusergroup`;
CREATE TABLE `authusergroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `groupId` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of authusergroup
-- ----------------------------
INSERT INTO `authusergroup` VALUES ('1', '1', '1');
INSERT INTO `authusergroup` VALUES ('2', '1', '2');
INSERT INTO `authusergroup` VALUES ('3', '2', '3');
INSERT INTO `authusergroup` VALUES ('4', '1', '4');

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of batch
-- ----------------------------
INSERT INTO `batch` VALUES ('1', '1111', '2015-05-28 00:00:00', '2015-08-28 00:00:00', '2015-10-31 00:00:00', '1');
INSERT INTO `batch` VALUES ('2', '112', '2015-05-28 00:00:00', '2015-08-29 00:00:00', '2015-10-31 00:00:00', '1');
INSERT INTO `batch` VALUES ('3', '33341', '2015-05-28 00:00:00', '2015-05-29 00:00:00', '2015-05-30 00:00:00', '1');
INSERT INTO `batch` VALUES ('4', '11222', '2015-05-28 00:00:00', '2015-05-29 00:00:00', '2015-10-28 00:00:00', '1');
INSERT INTO `batch` VALUES ('5', '111', '2015-05-28 00:00:00', '2015-05-29 00:00:00', '2015-05-30 00:00:00', '1');
INSERT INTO `batch` VALUES ('6', '33341', '2015-05-07 00:00:00', '2015-05-29 00:00:00', '2015-05-30 00:00:00', '1');
INSERT INTO `batch` VALUES ('7', '11222', '2015-05-28 00:00:00', '2015-05-29 00:00:00', '2015-06-16 00:00:00', '1');
INSERT INTO `batch` VALUES ('8', '11222', '2015-05-28 00:00:00', '2015-05-29 00:00:00', '2015-06-16 00:00:00', '1');
INSERT INTO `batch` VALUES ('9', '112222222', '2015-05-28 00:00:00', '2015-05-29 00:00:00', '2015-06-17 00:00:00', '1');
INSERT INTO `batch` VALUES ('10', '1122222223', '2015-05-28 00:00:00', '2015-05-29 00:00:00', '2015-06-17 00:00:00', '1');
INSERT INTO `batch` VALUES ('11', '批次n1', '2015-05-28 00:00:00', '2015-05-29 00:00:00', '2015-06-17 00:00:00', '1');

-- ----------------------------
-- Table structure for `company`
-- ----------------------------
DROP TABLE IF EXISTS `company`;
CREATE TABLE `company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of company
-- ----------------------------
INSERT INTO `company` VALUES ('1', '1');

-- ----------------------------
-- Table structure for `consume`
-- ----------------------------
DROP TABLE IF EXISTS `consume`;
CREATE TABLE `consume` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `money` float DEFAULT NULL,
  `uploadTime` date DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_lb6mlnq6t18p7rmq1ydclckd8` (`company_id`),
  CONSTRAINT `FK_lb6mlnq6t18p7rmq1ydclckd8` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of consume
-- ----------------------------

-- ----------------------------
-- Table structure for `device`
-- ----------------------------
DROP TABLE IF EXISTS `device`;
CREATE TABLE `device` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `deviceName` varchar(255) DEFAULT NULL,
  `deviceNum` int(11) DEFAULT NULL,
  `deviceType` int(11) DEFAULT '0' COMMENT '1读卡器,2点餐机,3水控,4手持机',
  `enable` int(11) DEFAULT NULL,
  `sn` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of device
-- ----------------------------
INSERT INTO `device` VALUES ('1', '1', '1', '读卡器', '12345678', '0', '1', '4159a96e838e4df5bdecd4e2d8e940f1');

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
INSERT INTO `discount` VALUES ('4', '1', '0', '1', '0', '10');
INSERT INTO `discount` VALUES ('5', '1', '1', '1', '0', '100');
INSERT INTO `discount` VALUES ('6', '1', '2', '1', '0', '0');
INSERT INTO `discount` VALUES ('7', '1', '3', '9', '0', '200');
INSERT INTO `discount` VALUES ('8', '1', '4', '100', '0', '0');
INSERT INTO `discount` VALUES ('9', '1', '5', '1', '0', '1');
INSERT INTO `discount` VALUES ('10', '1', '6', '100', '0', '0');
INSERT INTO `discount` VALUES ('11', '1', '7', '1', '1', '20');
INSERT INTO `discount` VALUES ('12', '1', '8', '100', '0', '0');
INSERT INTO `discount` VALUES ('13', '1', '9', '100', '0', '0');
INSERT INTO `discount` VALUES ('14', '1', '10', '100', '0', '0');
INSERT INTO `discount` VALUES ('15', '1', '11', '100', '0', '0');
INSERT INTO `discount` VALUES ('16', '1', '12', '100', '0', '0');
INSERT INTO `discount` VALUES ('17', '1', '13', '100', '0', '0');
INSERT INTO `discount` VALUES ('18', '1', '14', '100', '0', '0');
INSERT INTO `discount` VALUES ('19', '1', '15', '100', '0', '0');

-- ----------------------------
-- Table structure for `sysuser`
-- ----------------------------
DROP TABLE IF EXISTS `sysuser`;
CREATE TABLE `sysuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loginName` varchar(255) DEFAULT NULL,
  `loginPwd` varchar(255) DEFAULT NULL,
  `superAdmin` varchar(255) DEFAULT NULL,
  `userType` int(11) DEFAULT '0' COMMENT '1管理员,2出纳员',
  `companyId` int(11) DEFAULT NULL,
  `deviceId` int(11) DEFAULT NULL,
  `enabled` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sysuser
-- ----------------------------
INSERT INTO `sysuser` VALUES ('1', '1', '1', null, '0', '1', '1', '1');
INSERT INTO `sysuser` VALUES ('2', '2', '2', null, '0', '1', '1', '1');

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
  `status` int(11) DEFAULT NULL,
  `sex` int(11) DEFAULT NULL,
  `cardType` int(11) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('48', '1', '14', '001', '001', '001', '123456789012345678', '77', 'fcec5d2f', '1', '1', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-14', '888888', '8888', '0', '0', null, '0', '0', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('49', '1', '13', '002', '002', '002', '123456789012345678', '78', 'a48a2a41', '1', '1', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-14', '888888', '8888', '0', '0', null, '0', '0', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('50', '1', '13', '004', '004', '004', '123456789012345678', '79', '90d24626', '1', '1', '1', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-14', '888888', '8888', '0', '0', null, '0', '0', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('51', '1', '10', '005', '005', '005', '123456789012345678', '75', '', '1', '0', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-14', '888888', '8888', '0', '0', null, '0', '0', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('52', '1', '14', '006', '006', '006', '123456789012345678', '80', '817878d6', '1', '1', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-14', '888888', '8888', '0', '0', null, '0', '0', '0', null, '0', '0', '0', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userdept
-- ----------------------------
INSERT INTO `userdept` VALUES ('10', '第二部门', '1', '0', '1');
INSERT INTO `userdept` VALUES ('13', '第四部门', '1', '0', '2');
INSERT INTO `userdept` VALUES ('14', '第四部门', '1', '13', '1');
