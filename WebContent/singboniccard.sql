/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : singboniccard

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2015-08-29 08:11:29
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of batch
-- ----------------------------
INSERT INTO `batch` VALUES ('1', '11112', '2015-05-28 00:00:00', '2015-08-28 00:00:00', '2015-10-31 00:00:00', '1');
INSERT INTO `batch` VALUES ('2', '112', '2015-05-28 00:00:00', '2015-08-29 00:00:00', '2015-10-31 00:00:00', '1');
INSERT INTO `batch` VALUES ('3', '33341', '2015-05-28 00:00:00', '2015-05-29 00:00:00', '2015-05-30 00:00:00', '1');
INSERT INTO `batch` VALUES ('4', '11222', '2015-05-28 00:00:00', '2015-05-29 00:00:00', '2015-10-28 00:00:00', '1');
INSERT INTO `batch` VALUES ('5', '111', '2015-05-28 00:00:00', '2015-05-29 00:00:00', '2015-05-30 00:00:00', '1');
INSERT INTO `batch` VALUES ('6', '33341', '2015-05-07 00:00:00', '2015-05-29 00:00:00', '2015-05-30 00:00:00', '1');
INSERT INTO `batch` VALUES ('7', '11222', '2015-05-28 00:00:00', '2015-05-29 00:00:00', '2015-06-16 00:00:00', '1');
INSERT INTO `batch` VALUES ('8', '11222去去去', '2015-05-28 00:00:00', '2015-05-29 00:00:00', null, '1');
INSERT INTO `batch` VALUES ('9', '112222222', '2015-05-28 00:00:00', '2015-05-29 00:00:00', '2015-06-17 00:00:00', '1');
INSERT INTO `batch` VALUES ('10', '1122222223', '2015-05-28 00:00:00', '2015-05-29 00:00:00', '2015-06-17 00:00:00', '1');
INSERT INTO `batch` VALUES ('11', '批次n1', '2015-05-28 00:00:00', '2015-05-29 00:00:00', '2015-06-17 00:00:00', '1');
INSERT INTO `batch` VALUES ('12', 'fdf', '2015-07-02 00:00:00', '2015-07-08 00:00:00', '2015-07-22 00:00:00', '1');
INSERT INTO `batch` VALUES ('13', '112221233', '2015-05-28 00:00:00', '2015-05-29 00:00:00', '2015-10-28 00:00:00', '1');
INSERT INTO `batch` VALUES ('14', '0731', '2015-05-28 00:00:00', '2015-08-28 00:00:00', '2015-10-31 00:00:00', '1');
INSERT INTO `batch` VALUES ('15', 'sdssfsdf', '2015-05-07 00:00:00', '2015-05-29 00:00:00', null, '1');

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of company
-- ----------------------------
INSERT INTO `company` VALUES ('1', '1', '0312', '0371', '1');

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
-- Table structure for `consumeparam`
-- ----------------------------
DROP TABLE IF EXISTS `consumeparam`;
CREATE TABLE `consumeparam` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `cardMinFare` int(11) DEFAULT NULL,
  `cardMinFareCardTypes` varchar(16) DEFAULT NULL,
  `dayLimitFare` int(11) DEFAULT NULL,
  `dayLimitFareCardTypes` varchar(16) DEFAULT NULL,
  `timeLimitFare` int(11) DEFAULT NULL,
  `timeLimitFareCardTypes` varchar(16) DEFAULT NULL,
  `consumeType` int(11) DEFAULT NULL COMMENT '补助钱包、大钱包、先补助后大钱包',
  `userPwd` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of consumeparam
-- ----------------------------
INSERT INTO `consumeparam` VALUES ('1', '1', '0', ',,', '0', ',,', '0', ',,', '2', '88888');

-- ----------------------------
-- Table structure for `consumeparambase`
-- ----------------------------
DROP TABLE IF EXISTS `consumeparambase`;
CREATE TABLE `consumeparambase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cardMinFare` int(11) DEFAULT NULL,
  `cardMinFareCardTypes` varchar(16) DEFAULT NULL,
  `dayLimitFare` int(11) DEFAULT NULL,
  `dayLimitFareCardTypes` varchar(16) DEFAULT NULL,
  `timeLimitFare` int(11) DEFAULT NULL,
  `timeLimitFareCardTypes` varchar(16) DEFAULT NULL,
  `consumeType` int(11) DEFAULT NULL COMMENT '补助钱包、大钱包、先补助后大钱包',
  `userPwd` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of consumeparambase
-- ----------------------------
INSERT INTO `consumeparambase` VALUES ('1', '0', ',,', '0', ',,', '0', ',,', '2', '88888');

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
  `isEnable` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cookbook
-- ----------------------------
INSERT INTO `cookbook` VALUES ('20', '1', '1', '22', '11', '111', '');
INSERT INTO `cookbook` VALUES ('21', '1', '2', '酸辣3', '22', '33', '');
INSERT INTO `cookbook` VALUES ('22', '1', '3', '酸辣土豆丝', '15', '', '\0');

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dept
-- ----------------------------
INSERT INTO `dept` VALUES ('10', '营业部门1', '1', '0');
INSERT INTO `dept` VALUES ('13', '营业部门2', '1', '0');
INSERT INTO `dept` VALUES ('14', '营业部门3', '1', '13');

-- ----------------------------
-- Table structure for `device`
-- ----------------------------
DROP TABLE IF EXISTS `device`;
CREATE TABLE `device` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `groupId` int(11) DEFAULT NULL,
  `operId` int(11) DEFAULT NULL,
  `deviceName` varchar(255) DEFAULT NULL,
  `deviceNum` int(11) DEFAULT NULL,
  `deviceType` int(11) DEFAULT '0' COMMENT '1读卡器,2点餐机,3水控,4手持机',
  `enable` int(11) DEFAULT NULL,
  `sn` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of device
-- ----------------------------
INSERT INTO `device` VALUES ('1', '1', '1', '1', '读卡机1', '12345678', '0', '1', '4159a96e838e4df5bdecd4e2d8e940f1');
INSERT INTO `device` VALUES ('2', '1', '1', null, '读卡机2', '12345679', '0', '1', '2974e70c3c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('3', '1', '1', null, '读卡机3', '12345680', '0', '1', '2974fddc3c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('4', '1', '1', null, '读卡机4', '12345681', '0', '1', '297501023c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('5', '1', '1', null, '读卡机5', '12345682', '0', '1', '297503ee3c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('6', '1', '1', null, '读卡机6', '12345683', '0', '1', '297506a23c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('7', '1', '1', null, '读卡机7', '12345684', '0', '1', '297509423c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('8', '1', '1', null, '读卡机8', '12345685', '0', '1', '29750bf63c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('9', '1', '1', null, '读卡机9', '12345686', '0', '1', '2981e3d23c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('10', '1', '1', null, '读卡机10', '12345687', '0', '1', '2981e5303c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('11', '1', '1', null, '读卡机11', '12345688', '0', '1', '2981e62f3c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('12', '1', '1', null, '读卡机12', '12345689', '0', '1', '2981e71a3c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('13', '1', '1', null, '读卡机13', '12345690', '0', '1', '2981e8463c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('14', '1', '1', null, '读卡机14', '12345691', '0', '1', '2981e9393c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('15', '1', '1', null, '读卡机15', '12345692', '0', '1', '2981ea1a3c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('16', '1', '1', null, '读卡机16', '12345693', '0', '1', '2981eb013c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('17', '1', '1', null, '读卡机17', '12345694', '0', '1', '2981ebed3c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('18', '1', '1', null, '读卡机18', '12345695', '0', '1', '2981ed023c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('19', '1', '1', null, '读卡机19', '12345696', '0', '1', '2981edf23c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('20', '1', '1', null, '读卡机20', '12345697', '0', '1', '2981eeda3c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('21', '1', '1', null, '读卡机21', '12345698', '0', '1', '2981efbd3c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('22', '1', '1', null, '读卡机22', '12345699', '0', '1', '2981f0a53c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('23', '1', '1', null, '读卡机23', '12345700', '0', '1', '2981f1893c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('24', '1', '1', null, '读卡机24', '12345701', '0', '1', '2981f26d3c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('25', '1', '1', null, '读卡机25', '12345702', '0', '1', '2981f3c33c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('26', '1', '2', null, '读卡机26', '12345703', '0', '1', '2981f4ff3c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('27', '1', '2', null, '读卡机27', '12345704', '0', '1', '2981f61f3c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('28', '1', '2', null, '读卡机28', '12345705', '0', '1', '2981f75b3c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('29', '1', '2', null, '读卡机29', '12345706', '0', '1', '2981f84a3c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('30', '1', '2', null, '读卡机30', '12345707', '0', '1', '2981f92e3c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('31', '1', '2', null, '读卡机31', '12345708', '0', '1', '2981fa1a3c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('32', '1', '2', null, '读卡机32', '12345709', '0', '1', '2981fb013c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('33', '1', '2', null, '读卡机33', '12345710', '0', '1', '2981fbe23c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('34', '1', '2', null, '读卡机34', '12345711', '0', '1', '2981fcc93c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('35', '1', '2', null, '读卡机35', '12345712', '0', '1', '2981fdad3c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('36', '1', '2', null, '读卡机36', '12345713', '0', '1', '2981fe8a3c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('37', '1', '2', null, '读卡机37', '12345714', '0', '1', '2981ff973c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('38', '1', '2', null, '读卡机38', '12345715', '0', '1', '2982007b3c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('39', '1', '2', null, '读卡机39', '12345716', '0', '1', '298201633c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('40', '1', '2', null, '读卡机40', '12345717', '0', '1', '298202403c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('41', '1', '2', null, '读卡机41', '12345718', '0', '1', '298203203c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('42', '1', '2', null, '读卡机42', '12345719', '0', '1', '298204083c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('43', '1', '2', null, '读卡机43', '12345720', '0', '1', '298204eb3c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('44', '1', '2', null, '读卡机44', '12345721', '0', '1', '298205d33c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('45', '1', '2', null, '读卡机45', '12345722', '0', '1', '298206b73c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('46', '1', '2', null, '读卡机46', '12345723', '0', '1', '2982079b3c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('47', '1', '2', null, '读卡机47', '12345724', '0', '1', '2982087f3c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('48', '1', '2', null, '读卡机48', '12345725', '0', '1', '298209633c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('49', '1', '2', null, '读卡机49', '12345726', '0', '1', '29820a473c9e11e5839fd4bed9804c01');
INSERT INTO `device` VALUES ('50', '1', '2', null, '读卡机50', '12345727', '0', '1', '29820b2f3c9e11e5839fd4bed9804c01');

-- ----------------------------
-- Table structure for `devicegroup`
-- ----------------------------
DROP TABLE IF EXISTS `devicegroup`;
CREATE TABLE `devicegroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `groupName` varchar(255) DEFAULT NULL,
  `groupType` int(11) DEFAULT '0' COMMENT '1读卡器,2点餐机,3水控,4手持机',
  `operId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of devicegroup
-- ----------------------------
INSERT INTO `devicegroup` VALUES ('1', '1', '东校区', '0', '1');
INSERT INTO `devicegroup` VALUES ('2', '1', '西校区', '0', '1');

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
INSERT INTO `discount` VALUES ('7', '1', '3', '1', '0', '12');
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of meal
-- ----------------------------
INSERT INTO `meal` VALUES ('18', '1', '早餐', '06:30:00', '10:30:00', '1');
INSERT INTO `meal` VALUES ('19', '1', '午餐', '10:30:01', '15:30:00', '0');
INSERT INTO `meal` VALUES ('20', '1', '晚餐', '15:30:01', '18:30:00', '0');
INSERT INTO `meal` VALUES ('21', '1', '夜宵', '18:30:01', '20:30:00', '0');
INSERT INTO `meal` VALUES ('22', '1', '加班一', '20:30:01', '22:30:00', '0');
INSERT INTO `meal` VALUES ('23', '1', '加班二', '22:00:01', '23:59:59', '10');
INSERT INTO `meal` VALUES ('24', '2', '早餐', '06:30:00', '10:30:00', '0');
INSERT INTO `meal` VALUES ('25', '2', '午餐', '10:30:01', '15:30:00', '0');
INSERT INTO `meal` VALUES ('26', '2', '晚餐', '15:30:01', '18:30:00', '0');
INSERT INTO `meal` VALUES ('27', '2', '夜宵', '18:30:01', '20:30:00', '0');
INSERT INTO `meal` VALUES ('28', '2', '加班一', '20:30:01', '22:30:00', '0');
INSERT INTO `meal` VALUES ('29', '2', '加班二', '22:00:01', '23:59:59', '0');

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
-- Table structure for `param`
-- ----------------------------
DROP TABLE IF EXISTS `param`;
CREATE TABLE `param` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `paramName` varchar(255) DEFAULT NULL,
  `paramValue` varchar(255) DEFAULT NULL,
  `displayName` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `isEnable` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of param
-- ----------------------------

-- ----------------------------
-- Table structure for `parambase`
-- ----------------------------
DROP TABLE IF EXISTS `parambase`;
CREATE TABLE `parambase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `paramName` varchar(255) DEFAULT NULL,
  `paramValue` varchar(255) DEFAULT NULL,
  `displayName` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of parambase
-- ----------------------------
INSERT INTO `parambase` VALUES ('1', '1', 'KDJ', '10', '卡底金额', '卡上保留的最少金额 0为不限制');
INSERT INTO `parambase` VALUES ('2', '1', 'XFCXE', '36', '消费次限额', '当次消费限额最大1000，为0时不限制');
INSERT INTO `parambase` VALUES ('3', '1', 'XFRXE', '200', '日消费限额', '当日消费限额最大10000，为0时不限制');
INSERT INTO `parambase` VALUES ('4', '1', 'prioritySubsidy', '0', '优先消费补助', '0是优先消费补助，1优先消费大钱包');
INSERT INTO `parambase` VALUES ('5', '1', 'IsCard', '0', '参数判断标准', '0代表以POS为参数标准，1以卡为准');
INSERT INTO `parambase` VALUES ('6', '1', 'IsOne', '0', '领取补助存放钱包', '指定补助存款发放钱包：0代表大钱包1代表补助钱包 ');
INSERT INTO `parambase` VALUES ('7', '1', 'IsGrantReg', '0', '授权注册有效期', '是否授权开始注册有效期0授权1未授权');
INSERT INTO `parambase` VALUES ('8', '1', 'SubsidyTimeENd', '10', '补助发放的结束时间', '补助发放的结束时间 10 代表10号之前');
INSERT INTO `parambase` VALUES ('9', '1', 'ISXC', '0', '启用限次消费', '启用限次,模式0代表不启用,1代表起用');
INSERT INTO `parambase` VALUES ('10', '1', 'Brate', '40', '通讯波特率', '通讯波特率，可以设置：10,20,40,50,100,250,500');
INSERT INTO `parambase` VALUES ('11', '2', 'Watermodule ', '93', '水控模式', '水控消费模式：93余额模式:73时间模式:33流量模式');
INSERT INTO `parambase` VALUES ('12', '2', 'XFRXE', '200', '日消费限额', '当日消费限额,单位：元；最大值【65535】');
INSERT INTO `parambase` VALUES ('13', '2', 'KDJ', '10', '卡底金额', '卡上保留的最少金额，单位：元；最大值【255】');
INSERT INTO `parambase` VALUES ('14', '2', 'XFCXE', '36', '消费次限额', '当次消费限额，单位：元；最大值【65535】');
INSERT INTO `parambase` VALUES ('15', '2', 'SKPrice', '10/5', '水控费率', '【费率5】费率:10/5 代表5秒扣除10分钱:单位：分，时间和金额最大值各：【65535】');
INSERT INTO `parambase` VALUES ('16', '2', 'SKpulse', '10/5', '流量模式扣费', '【费率5】费率:10/5 代表每隔5个脉冲扣除10分钱');
INSERT INTO `parambase` VALUES ('17', '2', 'SKStopWater', '0', '拿卡是否停水', '水控拿卡是否停水:1停水 0不停水');
INSERT INTO `parambase` VALUES ('18', '2', 'IScard', '0', '参数判断标准', '是以卡的参数为准,还是以POS的参数为准 0 POS,1卡');
INSERT INTO `parambase` VALUES ('19', '2', 'SKSZPWD', '0000', '水控设置密码', '水控设置操作密码，设置4位密码');
INSERT INTO `parambase` VALUES ('20', '2', 'prioritySubsidy', '0', '优先消费补助', '0是优先消费补助，1优先消费大钱包');
INSERT INTO `parambase` VALUES ('21', '2', 'SKOpenWater', '0', '刷卡流水模式', '0代表刷卡就开始流水，1代表刷卡需要按键才流水');
INSERT INTO `parambase` VALUES ('22', '2', 'IsuseMoreRate', '0', '是否启用最低消费', '【费率1】是否启用最低消费设置，0代表不启用，1代表启用');
INSERT INTO `parambase` VALUES ('23', '2', 'MoreRateOneTime', '50', '最低消费的周期', '【费率1】最低消费的周期即一次消费的总时间，单位：分钟，最大1000分钟');
INSERT INTO `parambase` VALUES ('24', '2', 'FisrtXFRate', '500', '最低消费金额', '【费率1】最低消费的金额,单位：分，最大60000分');
INSERT INTO `parambase` VALUES ('25', '2', 'Brate', '40', '通讯波特率', '通讯波特率，可以设置：10,20,40,50,100,250,500');
INSERT INTO `parambase` VALUES ('26', '2', 'ZDXFCRCZ', '0', '最低消费次日重置', '【费率1】最低消费次日重置(1、启用；0、不启用)');
INSERT INTO `parambase` VALUES ('27', '2', 'SJDSKXC', '0', '是否启用时间段限次', '时间段刷卡限次【餐别限次】(1、启用；0、不启用)');
INSERT INTO `parambase` VALUES ('28', '2', 'SFQYHC', '0', '是否启用宏冲', '是否启用宏冲；(1、启用；0、不启用)');
INSERT INTO `parambase` VALUES ('29', '3', 'NOCARDZXSXF', '0', '无卡注销手续费', '无卡注销手续费（无卡注销卡时收取的手续费）');
INSERT INTO `parambase` VALUES ('30', '3', 'KHF', '0', '开户费', '开户费（发行新卡时收取的开户手续费）');
INSERT INTO `parambase` VALUES ('31', '3', 'KHKCB', '0', '开户卡成本费', '开户卡成本费（发行新卡时收取的卡成本费）');
INSERT INTO `parambase` VALUES ('32', '3', 'GSF', '0', '挂失费', '挂失费（挂失卡操作时收取的手续费）');
INSERT INTO `parambase` VALUES ('33', '3', 'JGF', '0', '解挂费', '解挂费（解挂卡操作时收取的手续费）');
INSERT INTO `parambase` VALUES ('34', '3', 'BKF', '0', '补卡费', '补卡费（补卡操作时收取的手续费）');
INSERT INTO `parambase` VALUES ('35', '3', 'BKKCB', '0', '补卡卡成本费', '补卡卡成本费（补卡操作时收取的卡成本费）');
INSERT INTO `parambase` VALUES ('36', '3', 'YFJE', '0', '预付金额', '预付金额（发卡同时往卡上存取的固定金额）');
INSERT INTO `parambase` VALUES ('37', '3', 'XFXE', '0', '消费限额', '消费限额');
INSERT INTO `parambase` VALUES ('38', '3', 'dayconsumlimit', '0', '日消费限额', '日消费限额');
INSERT INTO `parambase` VALUES ('39', '3', 'timeconsumlimit', '0', '次消费限额', '次消费限额');
INSERT INTO `parambase` VALUES ('40', '3', 'cardbasecash', '0', '卡底金', '卡底金（当卡值等于小于卡底金时将不能继续消费）');
INSERT INTO `parambase` VALUES ('41', '3', 'CONSUMEPSW', '888888', '消费密码', '消费密码');
INSERT INTO `parambase` VALUES ('42', '3', 'QUERYPWD', '8888', '查询密码', '查询密码');
INSERT INTO `parambase` VALUES ('43', '3', 'KYJ', '0', '卡押金', '卡押金(在存款操作中，向卡中存入的押金)');
INSERT INTO `parambase` VALUES ('44', '4', 'Watermodule ', '93', '水控模式', '水控消费模式：93余额模式:73时间模式:33流量模式');
INSERT INTO `parambase` VALUES ('45', '4', 'SKpulse1', '10/5', '1#水龙头流量模式扣费', '费率:10/5 代表每隔5个脉冲扣除10分钱: ');
INSERT INTO `parambase` VALUES ('46', '4', 'SKSZPWD', '0000', '水控设置密码2', '水控设置操作密码，设置4位密码');
INSERT INTO `parambase` VALUES ('47', '4', 'SKPrice1', '10/5', '1#水龙头水控费率', '费率:10/5 代表5秒扣除10分钱:单位分 ');
INSERT INTO `parambase` VALUES ('48', '4', 'SKPrice2', '10/5', '2#水龙头水控费率', '费率:10/5 代表5秒扣除10分钱:单位分 ');
INSERT INTO `parambase` VALUES ('49', '4', 'SKpulse2', '10/5', '2#水龙头流量模式扣费', '费率:10/5 代表每隔5个脉冲扣除10分钱: ');
INSERT INTO `parambase` VALUES ('50', '4', 'Brate', '40', '通讯波特率', '通讯波特率，可以设置：10,20,40,50,100,250,500');
INSERT INTO `parambase` VALUES ('51', '4', 'prioritySubsidy', '0', '优先消费补助', '0是优先消费补助，1优先消费大钱包');
INSERT INTO `parambase` VALUES ('52', '4', 'SKpulse3', '10/5', '3#水龙头流量模式扣费', '费率:10/5 代表每隔5个脉冲扣除10分钱: ');
INSERT INTO `parambase` VALUES ('53', '4', 'SKPrice3', '10/5', '3#水龙头水控费率', '费率:10/5 代表5秒扣除10分钱:单位分 ');
INSERT INTO `parambase` VALUES ('54', '4', 'SKpulse4', '10/5', '4#流量模式扣费', '费率:10/5 代表每隔5个脉冲扣除10分钱: ');
INSERT INTO `parambase` VALUES ('55', '4', 'SKPrice4', '10/5', '4#水龙头水控费率', '费率:10/5 代表5秒扣除10分钱:单位分 ');
INSERT INTO `parambase` VALUES ('56', '4', 'IsChange', '0', '启用找零', '启用找零,1代表启用，0代表禁止');
INSERT INTO `parambase` VALUES ('57', '4', 'ISuse', '1,1,1,1', '启用水龙头', '启用水龙头的个数，4个1代表4个都启用，0禁止从左到右代表第1、2、3、4个水龙头');
INSERT INTO `parambase` VALUES ('58', '5', 'opendoortime', '10', '开门延时', '开门延时时间默认10S');
INSERT INTO `parambase` VALUES ('59', '5', 'isusepwd', '1', '刷卡模式', '刷卡模式：1启用密码、0不启用');
INSERT INTO `parambase` VALUES ('60', '5', 'isonline', '1', '联机认证', '联机认证1启用、0不启用');
INSERT INTO `parambase` VALUES ('61', '5', 'recordConver', '0', '记录模式', '刷卡记录是否覆盖，0覆盖、1不覆盖');
INSERT INTO `parambase` VALUES ('62', '5', 'Isusegrant', '1', '授权验证模式', '是否启用授权名单验证：1启用、0不启用');
INSERT INTO `parambase` VALUES ('63', '5', 'doorstate', '1', '门正常状态', '门正常状态1正常0常开2常闭');
INSERT INTO `parambase` VALUES ('64', '5', 'ForcePwd', '123456', '操作密码', '操作密码6位');
INSERT INTO `parambase` VALUES ('65', '6', 'KDJ', '10', '卡底金额', '卡上保留的最少金额 0为不限制');
INSERT INTO `parambase` VALUES ('66', '6', 'XFCXE', '36', '消费次限额', '当次消费限额最大1000，为0时不限制');
INSERT INTO `parambase` VALUES ('67', '6', 'XFRXE', '200', '日消费限额', '当日消费限额最大10000，为0时不限制');
INSERT INTO `parambase` VALUES ('68', '6', 'prioritySubsidy', '0', '优先消费补助', '0是优先消费补助，1优先消费大钱包');
INSERT INTO `parambase` VALUES ('69', '6', 'IsCard', '0', '参数判断标准', '0代表以POS为参数标准，1以卡为准');
INSERT INTO `parambase` VALUES ('70', '6', 'IsOne', '0', '领取补助存放钱包', '指定补助存款发放钱包：0代表大钱包1代表补助钱包 ');
INSERT INTO `parambase` VALUES ('71', '6', 'IsGrantReg', '0', '授权注册有效期', '是否授权开始注册有效期0授权1未授权');
INSERT INTO `parambase` VALUES ('72', '6', 'SubsidyTimeENd', '10', '补助发放的结束时间', '补助发放的结束时间 10 代表10号之前');
INSERT INTO `parambase` VALUES ('73', '6', 'ISXC', '0', '启用限次消费', '启用限次,模式0代表不启用,1代表起用');
INSERT INTO `parambase` VALUES ('74', '6', 'Brate', '40', '通讯波特率6', '通讯波特率，可以设置：10,20,40,50,100,250,500');
INSERT INTO `parambase` VALUES ('75', '6', 'time1', '06:00-08:30', '订餐时间段1', '早餐');
INSERT INTO `parambase` VALUES ('76', '6', 'time2', '11:30-14:00', '订餐时间段2', '中餐');
INSERT INTO `parambase` VALUES ('77', '6', 'time3', '17:00-19:00', '订餐时间段3', '晚餐');
INSERT INTO `parambase` VALUES ('78', '6', 'time4', '19:01-20:30', '订餐时间段4', '夜宵');
INSERT INTO `parambase` VALUES ('79', '6', 'time5', '20:31-00:00', '订餐时间段5', '加班1');
INSERT INTO `parambase` VALUES ('80', '6', 'time6', '00:00-00:00', '订餐时间段6', '加班2');
INSERT INTO `parambase` VALUES ('81', '6', 'time7', '00:00-00:00', '订餐时间段7', '加班3');
INSERT INTO `parambase` VALUES ('82', '6', 'time8', '00:00-00:00', '订餐时间段8', '加班4');
INSERT INTO `parambase` VALUES ('83', '6', 'time9', '00:00-00:00', '订餐时间段9', '加班5');
INSERT INTO `parambase` VALUES ('84', '6', 'time10', '00:00-00:00', '订餐时间段10', '加班6');
INSERT INTO `parambase` VALUES ('85', '6', 'time11', '00:00-00:00', '订餐时间段11', '加班7');
INSERT INTO `parambase` VALUES ('86', '6', 'time12', '00:00-00:00', '订餐时间段12', '加班8');
INSERT INTO `parambase` VALUES ('87', '8', 'ISAUTH', '1', '启用授权', '是否启用授权0未授权1授权');

-- ----------------------------
-- Table structure for `paramgroup`
-- ----------------------------
DROP TABLE IF EXISTS `paramgroup`;
CREATE TABLE `paramgroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NOT NULL,
  `groupName` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of paramgroup
-- ----------------------------

-- ----------------------------
-- Table structure for `paramgroupbase`
-- ----------------------------
DROP TABLE IF EXISTS `paramgroupbase`;
CREATE TABLE `paramgroupbase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupName` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of paramgroupbase
-- ----------------------------
INSERT INTO `paramgroupbase` VALUES ('1', '消费POS参数组', '');
INSERT INTO `paramgroupbase` VALUES ('2', '水控参数组', '');
INSERT INTO `paramgroupbase` VALUES ('3', '制卡参数组', '');
INSERT INTO `paramgroupbase` VALUES ('4', '一控多参数组', '');
INSERT INTO `paramgroupbase` VALUES ('5', '门禁参数', '');
INSERT INTO `paramgroupbase` VALUES ('6', '点餐POS参数组', '');

-- ----------------------------
-- Table structure for `sysuser`
-- ----------------------------
DROP TABLE IF EXISTS `sysuser`;
CREATE TABLE `sysuser` (
  `operId` int(11) NOT NULL AUTO_INCREMENT,
  `operName` varchar(255) DEFAULT NULL,
  `loginName` varchar(255) DEFAULT NULL,
  `loginPwd` varchar(255) DEFAULT NULL,
  `superAdmin` varchar(255) DEFAULT NULL,
  `userType` int(11) DEFAULT NULL COMMENT '1管理员,2出纳员',
  `cardSN` varchar(255) DEFAULT NULL,
  `cardNO` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `deviceId` int(11) DEFAULT NULL,
  `enabled` int(11) DEFAULT NULL,
  `invalidDate` datetime DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`operId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sysuser
-- ----------------------------
INSERT INTO `sysuser` VALUES ('1', null, '1', '1', null, '0', '', null, '1', '1', '1', null, '0');
INSERT INTO `sysuser` VALUES ('2', '222', '2', '2', null, '1', 'a48a2a41', '13', '1', '1', '1', '2015-10-31 00:00:00', '2');

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
) ENGINE=InnoDB AUTO_INCREMENT=611 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '1', '10', '1', '1', '1', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('2', '1', '10', '2', '2', '2', '1', '91', '', '1', '1', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '0', '0', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('3', '1', '10', '3', '3', '3', '1', '90', '', '1', '1', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('4', '1', '10', '4', '4', '4', '1', '92', '', '2', '1', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('5', '1', '10', '5', '5', '5', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('6', '1', '10', '6', '6', '6', '1', '94', '24fa5a41', '2', '1', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('7', '1', '10', '7', '7', '7', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('8', '1', '10', '8', '8', '8', '1', '93', '', '1', '1', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('9', '1', '10', '9', '9', '9', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('10', '1', '10', '10', '10', '10', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('11', '1', '10', '11', '11', '11', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('12', '1', '10', '12', '12', '12', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('13', '1', '10', '13', '13', '13', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('14', '1', '10', '14', '14', '14', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('15', '1', '10', '15', '15', '15', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('16', '1', '10', '16', '16', '16', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('17', '1', '10', '17', '17', '17', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('18', '1', '10', '18', '18', '18', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('19', '1', '10', '19', '19', '19', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('20', '1', '10', '20', '20', '20', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('21', '1', '10', '21', '21', '21', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('22', '1', '10', '22', '22', '22', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('23', '1', '10', '23', '23', '23', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('24', '1', '10', '24', '24', '24', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('25', '1', '10', '25', '25', '25', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('26', '1', '10', '26', '26', '26', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('27', '1', '10', '27', '27', '27', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('28', '1', '10', '28', '28', '28', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('29', '1', '10', '29', '29', '29', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('30', '1', '10', '30', '30', '30', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('31', '1', '10', '31', '31', '31', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('32', '1', '10', '32', '32', '32', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('33', '1', '10', '33', '33', '33', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('34', '1', '10', '34', '34', '34', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('35', '1', '10', '35', '35', '35', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('36', '1', '10', '36', '36', '36', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('37', '1', '10', '37', '37', '37', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('38', '1', '10', '38', '38', '38', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('39', '1', '10', '39', '39', '39', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('40', '1', '10', '40', '40', '40', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('41', '1', '10', '41', '41', '41', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('42', '1', '10', '42', '42', '42', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('43', '1', '10', '43', '43', '43', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('44', '1', '10', '44', '44', '44', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('45', '1', '10', '45', '45', '45', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('46', '1', '10', '46', '46', '46', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('47', '1', '10', '47', '47', '47', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('48', '1', '14', '001', '001', '001', '123456789012345678', '87', null, '1', '1', '0', '0', '0', '1', '2015-05-28', null, '2018-07-01', '2015-07-22', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('49', '1', '10', '49', '49', '49', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('50', '1', '10', '50', '50', '50', '1', '90', null, '1', '1', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '136900', '12300', null, '0', '1', '124600', null, '0', '2', '9', null);
INSERT INTO `user` VALUES ('51', '1', '10', '51', '51', '51', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('52', '1', '10', '52', '52', '52', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('53', '1', '10', '53', '53', '53', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('54', '1', '10', '003', '003', '003', '123456789012345678', '88', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-23', '888888', '8888', '101000', '101000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('55', '1', '10', '005', '005', '005', '123456789012345678', '89', null, '1', '1', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-24', '888888', '8888', '49200', '0', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('56', '1', '10', '006', '006', '006', '123456789012345678', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('57', '1', '10', '57', '57', '57', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('58', '1', '10', '58', '58', '58', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('59', '1', '10', '59', '59', '59', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('60', '1', '10', '60', '60', '60', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('61', '1', '10', '61', '61', '61', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('62', '1', '10', '62', '62', '62', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('63', '1', '10', '63', '63', '63', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('64', '1', '10', '64', '64', '64', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('65', '1', '10', '65', '65', '65', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('66', '1', '10', '66', '66', '66', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('67', '1', '10', '67', '67', '67', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('68', '1', '10', '68', '68', '68', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('69', '1', '10', '69', '69', '69', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('70', '1', '10', '70', '70', '70', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('71', '1', '10', '71', '71', '71', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('72', '1', '10', '72', '72', '72', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('73', '1', '10', '73', '73', '73', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('74', '1', '10', '74', '74', '74', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('75', '1', '10', '75', '75', '75', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('76', '1', '10', '76', '76', '76', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('77', '1', '10', '77', '77', '77', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('78', '1', '10', '78', '78', '78', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('79', '1', '10', '79', '79', '79', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('80', '1', '10', '80', '80', '80', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('81', '1', '10', '81', '81', '81', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('82', '1', '10', '82', '82', '82', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('83', '1', '10', '83', '83', '83', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('84', '1', '10', '84', '84', '84', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('85', '1', '10', '85', '85', '85', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('86', '1', '10', '86', '86', '86', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('87', '1', '10', '87', '87', '87', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('88', '1', '10', '88', '88', '88', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('89', '1', '10', '89', '89', '89', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('90', '1', '10', '90', '90', '90', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('91', '1', '10', '91', '91', '91', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('92', '1', '10', '92', '92', '92', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('93', '1', '10', '93', '93', '93', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('94', '1', '10', '94', '94', '94', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('95', '1', '10', '95', '95', '95', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('96', '1', '10', '96', '96', '96', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('97', '1', '10', '97', '97', '97', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('98', '1', '10', '98', '98', '98', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('99', '1', '10', '99', '99', '99', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('100', '1', '10', '100', '100', '100', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('101', '1', '10', '101', '101', '101', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('102', '1', '10', '102', '102', '102', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('103', '1', '10', '103', '103', '103', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('104', '1', '10', '104', '104', '104', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('105', '1', '10', '105', '105', '105', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('106', '1', '10', '106', '106', '106', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('107', '1', '10', '107', '107', '107', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('108', '1', '10', '108', '108', '108', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('109', '1', '10', '109', '109', '109', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('110', '1', '10', '110', '110', '110', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('111', '1', '10', '111', '111', '111', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('112', '1', '10', '112', '112', '112', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('113', '1', '10', '113', '113', '113', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('114', '1', '10', '114', '114', '114', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('115', '1', '10', '115', '115', '115', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('116', '1', '10', '116', '116', '116', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('117', '1', '10', '117', '117', '117', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('118', '1', '10', '118', '118', '118', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('119', '1', '10', '119', '119', '119', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('120', '1', '10', '120', '120', '120', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('121', '1', '10', '121', '121', '121', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('122', '1', '10', '122', '122', '122', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('123', '1', '10', '123', '123', '123', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('124', '1', '10', '124', '124', '124', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('125', '1', '10', '125', '125', '125', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('126', '1', '10', '126', '126', '126', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('127', '1', '10', '127', '127', '127', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('128', '1', '10', '128', '128', '128', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('129', '1', '10', '129', '129', '129', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('130', '1', '10', '130', '130', '130', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('131', '1', '10', '131', '131', '131', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('132', '1', '10', '132', '132', '132', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('133', '1', '10', '133', '133', '133', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('134', '1', '10', '134', '134', '134', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('135', '1', '10', '135', '135', '135', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('136', '1', '10', '136', '136', '136', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('137', '1', '10', '137', '137', '137', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('138', '1', '10', '138', '138', '138', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('139', '1', '10', '139', '139', '139', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('140', '1', '10', '140', '140', '140', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('141', '1', '10', '141', '141', '141', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('142', '1', '10', '142', '142', '142', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('143', '1', '10', '143', '143', '143', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('144', '1', '10', '144', '144', '144', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('145', '1', '10', '145', '145', '145', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('146', '1', '10', '146', '146', '146', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('147', '1', '10', '147', '147', '147', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('148', '1', '10', '148', '148', '148', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('149', '1', '10', '149', '149', '149', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('150', '1', '10', '150', '150', '150', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('151', '1', '10', '151', '151', '151', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('152', '1', '10', '152', '152', '152', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('153', '1', '10', '153', '153', '153', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('154', '1', '10', '154', '154', '154', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('155', '1', '10', '155', '155', '155', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('156', '1', '10', '156', '156', '156', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('157', '1', '10', '157', '157', '157', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('158', '1', '10', '158', '158', '158', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('159', '1', '10', '159', '159', '159', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('160', '1', '10', '160', '160', '160', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('161', '1', '10', '161', '161', '161', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('162', '1', '10', '162', '162', '162', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('163', '1', '10', '163', '163', '163', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('164', '1', '10', '164', '164', '164', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('165', '1', '10', '165', '165', '165', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('166', '1', '10', '166', '166', '166', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('167', '1', '10', '167', '167', '167', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('168', '1', '10', '168', '168', '168', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('169', '1', '10', '169', '169', '169', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('170', '1', '10', '170', '170', '170', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('171', '1', '10', '171', '171', '171', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('172', '1', '10', '172', '172', '172', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('173', '1', '10', '173', '173', '173', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('174', '1', '10', '174', '174', '174', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('175', '1', '10', '175', '175', '175', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('176', '1', '10', '176', '176', '176', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('177', '1', '10', '177', '177', '177', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('178', '1', '10', '178', '178', '178', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('179', '1', '10', '179', '179', '179', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('180', '1', '10', '180', '180', '180', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('181', '1', '10', '181', '181', '181', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('182', '1', '10', '182', '182', '182', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('183', '1', '10', '183', '183', '183', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('184', '1', '10', '184', '184', '184', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('185', '1', '10', '185', '185', '185', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('186', '1', '10', '186', '186', '186', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('187', '1', '10', '187', '187', '187', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('188', '1', '10', '188', '188', '188', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('189', '1', '10', '189', '189', '189', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('190', '1', '10', '190', '190', '190', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('191', '1', '10', '191', '191', '191', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('192', '1', '10', '192', '192', '192', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('193', '1', '10', '193', '193', '193', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('194', '1', '10', '194', '194', '194', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('195', '1', '10', '195', '195', '195', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('196', '1', '10', '196', '196', '196', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('197', '1', '10', '197', '197', '197', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('198', '1', '10', '198', '198', '198', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('199', '1', '10', '199', '199', '199', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('200', '1', '10', '200', '200', '200', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('201', '1', '10', '201', '201', '201', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('202', '1', '10', '202', '202', '202', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('203', '1', '10', '203', '203', '203', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('204', '1', '10', '204', '204', '204', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('205', '1', '10', '205', '205', '205', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('206', '1', '10', '206', '206', '206', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('207', '1', '10', '207', '207', '207', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('208', '1', '10', '208', '208', '208', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('209', '1', '10', '209', '209', '209', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('210', '1', '10', '210', '210', '210', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('211', '1', '10', '211', '211', '211', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('212', '1', '10', '212', '212', '212', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('213', '1', '10', '213', '213', '213', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('214', '1', '10', '214', '214', '214', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('215', '1', '10', '215', '215', '215', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('216', '1', '10', '216', '216', '216', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('217', '1', '10', '217', '217', '217', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('218', '1', '10', '218', '218', '218', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('219', '1', '10', '219', '219', '219', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('220', '1', '10', '220', '220', '220', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('221', '1', '10', '221', '221', '221', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('222', '1', '10', '222', '222', '222', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('223', '1', '10', '223', '223', '223', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('224', '1', '10', '224', '224', '224', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('225', '1', '10', '225', '225', '225', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('226', '1', '10', '226', '226', '226', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('227', '1', '10', '227', '227', '227', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('228', '1', '10', '228', '228', '228', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('229', '1', '10', '229', '229', '229', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('230', '1', '10', '230', '230', '230', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('231', '1', '10', '231', '231', '231', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('232', '1', '10', '232', '232', '232', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('233', '1', '10', '233', '233', '233', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('234', '1', '10', '234', '234', '234', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('235', '1', '10', '235', '235', '235', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('236', '1', '10', '236', '236', '236', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('237', '1', '10', '237', '237', '237', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('238', '1', '10', '238', '238', '238', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('239', '1', '10', '239', '239', '239', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('240', '1', '10', '240', '240', '240', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('241', '1', '10', '241', '241', '241', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('242', '1', '10', '242', '242', '242', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('243', '1', '10', '243', '243', '243', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('244', '1', '10', '244', '244', '244', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('245', '1', '10', '245', '245', '245', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('246', '1', '10', '246', '246', '246', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('247', '1', '10', '247', '247', '247', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('248', '1', '10', '248', '248', '248', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('249', '1', '10', '249', '249', '249', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('250', '1', '10', '250', '250', '250', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('251', '1', '10', '251', '251', '251', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('252', '1', '10', '252', '252', '252', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('253', '1', '10', '253', '253', '253', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('254', '1', '10', '254', '254', '254', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('255', '1', '10', '255', '255', '255', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('256', '1', '10', '256', '256', '256', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('257', '1', '10', '257', '257', '257', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('258', '1', '10', '258', '258', '258', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('259', '1', '10', '259', '259', '259', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('260', '1', '10', '260', '260', '260', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('261', '1', '10', '261', '261', '261', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('262', '1', '10', '262', '262', '262', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('263', '1', '10', '263', '263', '263', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('264', '1', '10', '264', '264', '264', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('265', '1', '10', '265', '265', '265', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('266', '1', '10', '266', '266', '266', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('267', '1', '10', '267', '267', '267', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('268', '1', '10', '268', '268', '268', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('269', '1', '10', '269', '269', '269', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('270', '1', '10', '270', '270', '270', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('271', '1', '10', '271', '271', '271', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('272', '1', '10', '272', '272', '272', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('273', '1', '10', '273', '273', '273', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('274', '1', '10', '274', '274', '274', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('275', '1', '10', '275', '275', '275', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('276', '1', '10', '276', '276', '276', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('277', '1', '10', '277', '277', '277', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('278', '1', '10', '278', '278', '278', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('279', '1', '10', '279', '279', '279', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('280', '1', '10', '280', '280', '280', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('281', '1', '10', '281', '281', '281', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('282', '1', '10', '282', '282', '282', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('283', '1', '10', '283', '283', '283', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('284', '1', '10', '284', '284', '284', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('285', '1', '10', '285', '285', '285', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('286', '1', '10', '286', '286', '286', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('287', '1', '10', '287', '287', '287', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('288', '1', '10', '288', '288', '288', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('289', '1', '10', '289', '289', '289', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('290', '1', '10', '290', '290', '290', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('291', '1', '10', '291', '291', '291', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('292', '1', '10', '292', '292', '292', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('293', '1', '10', '293', '293', '293', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('294', '1', '10', '294', '294', '294', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('295', '1', '10', '295', '295', '295', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('296', '1', '10', '296', '296', '296', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('297', '1', '10', '297', '297', '297', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('298', '1', '10', '298', '298', '298', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('299', '1', '10', '299', '299', '299', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('300', '1', '10', '300', '300', '300', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('301', '1', '10', '301', '301', '301', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('302', '1', '10', '302', '302', '302', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('303', '1', '10', '303', '303', '303', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('304', '1', '10', '304', '304', '304', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('305', '1', '10', '305', '305', '305', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('306', '1', '10', '306', '306', '306', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('307', '1', '10', '307', '307', '307', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('308', '1', '10', '308', '308', '308', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('309', '1', '10', '309', '309', '309', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('310', '1', '10', '310', '310', '310', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('311', '1', '10', '311', '311', '311', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('312', '1', '10', '312', '312', '312', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('313', '1', '10', '313', '313', '313', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('314', '1', '10', '314', '314', '314', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('315', '1', '10', '315', '315', '315', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('316', '1', '10', '316', '316', '316', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('317', '1', '10', '317', '317', '317', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('318', '1', '10', '318', '318', '318', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('319', '1', '10', '319', '319', '319', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('320', '1', '10', '320', '320', '320', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('321', '1', '10', '321', '321', '321', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('322', '1', '10', '322', '322', '322', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('323', '1', '10', '323', '323', '323', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('324', '1', '10', '324', '324', '324', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('325', '1', '10', '325', '325', '325', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('326', '1', '10', '326', '326', '326', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('327', '1', '10', '327', '327', '327', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('328', '1', '10', '328', '328', '328', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('329', '1', '10', '329', '329', '329', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('330', '1', '10', '330', '330', '330', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('331', '1', '10', '331', '331', '331', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('332', '1', '10', '332', '332', '332', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('333', '1', '10', '333', '333', '333', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('334', '1', '10', '334', '334', '334', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('335', '1', '10', '335', '335', '335', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('336', '1', '10', '336', '336', '336', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('337', '1', '10', '337', '337', '337', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('338', '1', '10', '338', '338', '338', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('339', '1', '10', '339', '339', '339', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('340', '1', '10', '340', '340', '340', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('341', '1', '10', '341', '341', '341', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('342', '1', '10', '342', '342', '342', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('343', '1', '10', '343', '343', '343', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('344', '1', '10', '344', '344', '344', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('345', '1', '10', '345', '345', '345', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('346', '1', '10', '346', '346', '346', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('347', '1', '10', '347', '347', '347', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('348', '1', '10', '348', '348', '348', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('349', '1', '10', '349', '349', '349', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('350', '1', '10', '350', '350', '350', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('351', '1', '10', '351', '351', '351', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('352', '1', '10', '352', '352', '352', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('353', '1', '10', '353', '353', '353', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('354', '1', '10', '354', '354', '354', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('355', '1', '10', '355', '355', '355', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('356', '1', '10', '356', '356', '356', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('357', '1', '10', '357', '357', '357', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('358', '1', '10', '358', '358', '358', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('359', '1', '10', '359', '359', '359', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('360', '1', '10', '360', '360', '360', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('361', '1', '10', '361', '361', '361', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('362', '1', '10', '362', '362', '362', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('363', '1', '10', '363', '363', '363', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('364', '1', '10', '364', '364', '364', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('365', '1', '10', '365', '365', '365', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('366', '1', '10', '366', '366', '366', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('367', '1', '10', '367', '367', '367', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('368', '1', '10', '368', '368', '368', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('369', '1', '10', '369', '369', '369', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('370', '1', '10', '370', '370', '370', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('371', '1', '10', '371', '371', '371', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('372', '1', '10', '372', '372', '372', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('373', '1', '10', '373', '373', '373', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('374', '1', '10', '374', '374', '374', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('375', '1', '10', '375', '375', '375', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('376', '1', '10', '376', '376', '376', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('377', '1', '10', '377', '377', '377', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('378', '1', '10', '378', '378', '378', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('379', '1', '10', '379', '379', '379', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('380', '1', '10', '380', '380', '380', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('381', '1', '10', '381', '381', '381', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('382', '1', '10', '382', '382', '382', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('383', '1', '10', '383', '383', '383', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('384', '1', '10', '384', '384', '384', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('385', '1', '10', '385', '385', '385', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('386', '1', '10', '386', '386', '386', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('387', '1', '10', '387', '387', '387', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('388', '1', '10', '388', '388', '388', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('389', '1', '10', '389', '389', '389', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('390', '1', '10', '390', '390', '390', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('391', '1', '10', '391', '391', '391', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('392', '1', '10', '392', '392', '392', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('393', '1', '10', '393', '393', '393', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('394', '1', '10', '394', '394', '394', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('395', '1', '10', '395', '395', '395', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('396', '1', '10', '396', '396', '396', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('397', '1', '10', '397', '397', '397', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('398', '1', '10', '398', '398', '398', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('399', '1', '10', '399', '399', '399', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('400', '1', '10', '400', '400', '400', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('401', '1', '10', '401', '401', '401', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('402', '1', '10', '402', '402', '402', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('403', '1', '10', '403', '403', '403', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('404', '1', '10', '404', '404', '404', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('405', '1', '10', '405', '405', '405', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('406', '1', '10', '406', '406', '406', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('407', '1', '10', '407', '407', '407', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('408', '1', '10', '408', '408', '408', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('409', '1', '10', '409', '409', '409', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('410', '1', '10', '410', '410', '410', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('411', '1', '10', '411', '411', '411', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('412', '1', '10', '412', '412', '412', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('413', '1', '10', '413', '413', '413', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('414', '1', '10', '414', '414', '414', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('415', '1', '10', '415', '415', '415', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('416', '1', '10', '416', '416', '416', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('417', '1', '10', '417', '417', '417', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('418', '1', '10', '418', '418', '418', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('419', '1', '10', '419', '419', '419', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('420', '1', '10', '420', '420', '420', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('421', '1', '10', '421', '421', '421', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('422', '1', '10', '422', '422', '422', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('423', '1', '10', '423', '423', '423', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('424', '1', '10', '424', '424', '424', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('425', '1', '10', '425', '425', '425', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('426', '1', '10', '426', '426', '426', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('427', '1', '10', '427', '427', '427', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('428', '1', '10', '428', '428', '428', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('429', '1', '10', '429', '429', '429', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('430', '1', '10', '430', '430', '430', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('431', '1', '10', '431', '431', '431', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('432', '1', '10', '432', '432', '432', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('433', '1', '10', '433', '433', '433', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('434', '1', '10', '434', '434', '434', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('435', '1', '10', '435', '435', '435', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('436', '1', '10', '436', '436', '436', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('437', '1', '10', '437', '437', '437', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('438', '1', '10', '438', '438', '438', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('439', '1', '10', '439', '439', '439', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('440', '1', '10', '440', '440', '440', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('441', '1', '10', '441', '441', '441', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('442', '1', '10', '442', '442', '442', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('443', '1', '10', '443', '443', '443', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('444', '1', '10', '444', '444', '444', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('445', '1', '10', '445', '445', '445', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('446', '1', '10', '446', '446', '446', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('447', '1', '10', '447', '447', '447', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('448', '1', '10', '448', '448', '448', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('449', '1', '10', '449', '449', '449', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('450', '1', '10', '450', '450', '450', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('451', '1', '10', '451', '451', '451', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('452', '1', '10', '452', '452', '452', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('453', '1', '10', '453', '453', '453', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('454', '1', '10', '454', '454', '454', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('455', '1', '10', '455', '455', '455', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('456', '1', '10', '456', '456', '456', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('457', '1', '10', '457', '457', '457', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('458', '1', '10', '458', '458', '458', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('459', '1', '10', '459', '459', '459', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('460', '1', '10', '460', '460', '460', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('461', '1', '10', '461', '461', '461', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('462', '1', '10', '462', '462', '462', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('463', '1', '10', '463', '463', '463', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('464', '1', '10', '464', '464', '464', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('465', '1', '10', '465', '465', '465', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('466', '1', '10', '466', '466', '466', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('467', '1', '10', '467', '467', '467', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('468', '1', '10', '468', '468', '468', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('469', '1', '10', '469', '469', '469', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('470', '1', '10', '470', '470', '470', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('471', '1', '10', '471', '471', '471', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('472', '1', '10', '472', '472', '472', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('473', '1', '10', '473', '473', '473', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('474', '1', '10', '474', '474', '474', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('475', '1', '10', '475', '475', '475', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('476', '1', '10', '476', '476', '476', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('477', '1', '10', '477', '477', '477', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('478', '1', '10', '478', '478', '478', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('479', '1', '10', '479', '479', '479', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('480', '1', '10', '480', '480', '480', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('481', '1', '10', '481', '481', '481', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('482', '1', '10', '482', '482', '482', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('483', '1', '10', '483', '483', '483', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('484', '1', '10', '484', '484', '484', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('485', '1', '10', '485', '485', '485', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('486', '1', '10', '486', '486', '486', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('487', '1', '10', '487', '487', '487', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('488', '1', '10', '488', '488', '488', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('489', '1', '10', '489', '489', '489', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('490', '1', '10', '490', '490', '490', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('491', '1', '10', '491', '491', '491', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('492', '1', '10', '492', '492', '492', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('493', '1', '10', '493', '493', '493', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('494', '1', '10', '494', '494', '494', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('495', '1', '10', '495', '495', '495', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('496', '1', '10', '496', '496', '496', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('497', '1', '10', '497', '497', '497', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('498', '1', '10', '498', '498', '498', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('499', '1', '10', '499', '499', '499', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('500', '1', '10', '500', '500', '500', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('501', '1', '10', '501', '501', '501', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('502', '1', '10', '502', '502', '502', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('503', '1', '10', '503', '503', '503', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('504', '1', '10', '504', '504', '504', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('505', '1', '10', '505', '505', '505', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('506', '1', '10', '506', '506', '506', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('507', '1', '10', '507', '507', '507', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('508', '1', '10', '508', '508', '508', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('509', '1', '10', '509', '509', '509', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('510', '1', '10', '510', '510', '510', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('511', '1', '10', '511', '511', '511', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('512', '1', '10', '512', '512', '512', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('513', '1', '10', '513', '513', '513', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('514', '1', '10', '514', '514', '514', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('515', '1', '10', '515', '515', '515', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('516', '1', '10', '516', '516', '516', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('517', '1', '10', '517', '517', '517', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('518', '1', '10', '518', '518', '518', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('519', '1', '10', '519', '519', '519', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('520', '1', '10', '520', '520', '520', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('521', '1', '10', '521', '521', '521', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('522', '1', '10', '522', '522', '522', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('523', '1', '10', '523', '523', '523', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('524', '1', '10', '524', '524', '524', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('525', '1', '10', '525', '525', '525', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('526', '1', '10', '526', '526', '526', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('527', '1', '10', '527', '527', '527', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('528', '1', '10', '528', '528', '528', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('529', '1', '10', '529', '529', '529', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('530', '1', '10', '530', '530', '530', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('531', '1', '10', '531', '531', '531', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('532', '1', '10', '532', '532', '532', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('533', '1', '10', '533', '533', '533', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('534', '1', '10', '534', '534', '534', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('535', '1', '10', '535', '535', '535', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('536', '1', '10', '536', '536', '536', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('537', '1', '10', '537', '537', '537', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('538', '1', '10', '538', '538', '538', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('539', '1', '10', '539', '539', '539', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('540', '1', '10', '540', '540', '540', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('541', '1', '10', '541', '541', '541', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('542', '1', '10', '542', '542', '542', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('543', '1', '10', '543', '543', '543', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('544', '1', '10', '544', '544', '544', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('545', '1', '10', '545', '545', '545', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('546', '1', '10', '546', '546', '546', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('547', '1', '10', '547', '547', '547', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('548', '1', '10', '548', '548', '548', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('549', '1', '10', '549', '549', '549', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('550', '1', '10', '550', '550', '550', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('551', '1', '10', '551', '551', '551', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('552', '1', '10', '552', '552', '552', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('553', '1', '10', '553', '553', '553', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('554', '1', '10', '554', '554', '554', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('555', '1', '10', '555', '555', '555', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('556', '1', '10', '556', '556', '556', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('557', '1', '10', '557', '557', '557', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('558', '1', '10', '558', '558', '558', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('559', '1', '10', '559', '559', '559', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('560', '1', '10', '560', '560', '560', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('561', '1', '10', '561', '561', '561', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('562', '1', '10', '562', '562', '562', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('563', '1', '10', '563', '563', '563', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('564', '1', '10', '564', '564', '564', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('565', '1', '10', '565', '565', '565', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('566', '1', '10', '566', '566', '566', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('567', '1', '10', '567', '567', '567', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('568', '1', '10', '568', '568', '568', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('569', '1', '10', '569', '569', '569', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('570', '1', '10', '570', '570', '570', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('571', '1', '10', '571', '571', '571', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('572', '1', '10', '572', '572', '572', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('573', '1', '10', '573', '573', '573', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('574', '1', '10', '574', '574', '574', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('575', '1', '10', '575', '575', '575', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('576', '1', '10', '576', '576', '576', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('577', '1', '10', '577', '577', '577', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('578', '1', '10', '578', '578', '578', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('579', '1', '10', '579', '579', '579', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('580', '1', '10', '580', '580', '580', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('581', '1', '10', '581', '581', '581', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('582', '1', '10', '582', '582', '582', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('583', '1', '10', '583', '583', '583', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('584', '1', '10', '584', '584', '584', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('585', '1', '10', '585', '585', '585', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('586', '1', '10', '586', '586', '586', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('587', '1', '10', '587', '587', '587', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('588', '1', '10', '588', '588', '588', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('589', '1', '10', '589', '589', '589', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('590', '1', '10', '590', '590', '590', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('591', '1', '10', '591', '591', '591', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('592', '1', '10', '592', '592', '592', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('593', '1', '10', '593', '593', '593', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('594', '1', '10', '594', '594', '594', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('595', '1', '10', '595', '595', '595', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('596', '1', '10', '596', '596', '596', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('597', '1', '10', '597', '597', '597', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('598', '1', '10', '598', '598', '598', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('599', '1', '10', '599', '599', '599', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('600', '1', '10', '600', '600', '600', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('601', '1', '10', '601', '601', '601', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('602', '1', '10', '602', '602', '602', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('603', '1', '10', '603', '603', '603', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('604', '1', '10', '604', '604', '604', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('605', '1', '10', '605', '605', '605', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('606', '1', '10', '606', '606', '606', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('607', '1', '10', '607', '607', '607', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('608', '1', '10', '608', '608', '608', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('609', '1', '10', '609', '609', '609', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);
INSERT INTO `user` VALUES ('610', '1', '10', '610', '610', '610', '1', '90', null, '1', '2', '0', '0', '0', '1', '2015-05-28', null, '2015-08-28', '2015-07-25', '888888', '8888', '1000', '1000', null, '0', '1', '0', null, '0', '0', '0', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userdept
-- ----------------------------
INSERT INTO `userdept` VALUES ('10', '第二部门', '1', '0', '1');
INSERT INTO `userdept` VALUES ('13', '第四部门', '1', '0', '2');
INSERT INTO `userdept` VALUES ('14', '第四部门', '1', '13', '1');
INSERT INTO `userdept` VALUES ('15', '第四部门', '1', '13', '1');
INSERT INTO `userdept` VALUES ('17', '111', '1', '0', '1');
INSERT INTO `userdept` VALUES ('18', '放松放松地方', '1', '0', '1');
INSERT INTO `userdept` VALUES ('19', '11', '1', '0', '1');
INSERT INTO `userdept` VALUES ('20', '放松放松地方', '1', '18', '1');
INSERT INTO `userdept` VALUES ('21', '22', '1', '18', '1');
INSERT INTO `userdept` VALUES ('22', '3333', '1', '17', '1');

-- ----------------------------
-- Table structure for `waterrate`
-- ----------------------------
DROP TABLE IF EXISTS `waterrate`;
CREATE TABLE `waterrate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `waterRateName` varchar(255) DEFAULT NULL,
  `beginTime` varchar(8) DEFAULT NULL,
  `endTime` varchar(8) DEFAULT NULL,
  `rate1` int(11) DEFAULT NULL,
  `rate2` int(11) DEFAULT NULL,
  `authCard` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of waterrate
-- ----------------------------
INSERT INTO `waterrate` VALUES ('25', '1', '费率2', '07:30', '09:30', '0', '1', '1110001000000001');
INSERT INTO `waterrate` VALUES ('26', '1', '费率3', '09:30', '12:30', '0', '0', '0000000100010000');
INSERT INTO `waterrate` VALUES ('27', '1', '费率4', '12:00', '14:31', '0', '0', '0000000100010000');

-- ----------------------------
-- Table structure for `waterratebase`
-- ----------------------------
DROP TABLE IF EXISTS `waterratebase`;
CREATE TABLE `waterratebase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `waterRateName` varchar(255) DEFAULT NULL,
  `beginTime` varchar(8) DEFAULT NULL,
  `endTime` varchar(8) DEFAULT NULL,
  `rate1` int(11) DEFAULT NULL,
  `rate2` int(11) DEFAULT NULL,
  `authCard` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of waterratebase
-- ----------------------------
INSERT INTO `waterratebase` VALUES ('1', '费率2', '07:30', '09:30', '0', '0', '0000000000000000');
INSERT INTO `waterratebase` VALUES ('2', '费率3', '09:30', '12:30', '0', '0', '0000000000000000');
INSERT INTO `waterratebase` VALUES ('3', '费率4', '12:00', '14:31', '0', '0', '0000000000000000');
