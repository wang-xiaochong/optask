/*
 Navicat Premium Data Transfer

 Source Server         : TXYun-S
 Source Server Type    : MySQL
 Source Server Version : 50740
 Source Host           : 43.138.81.135:3306
 Source Schema         : xiaochong

 Target Server Type    : MySQL
 Target Server Version : 50740
 File Encoding         : 65001

 Date: 27/03/2023 21:25:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for person
-- ----------------------------
DROP TABLE IF EXISTS `person`;
CREATE TABLE `person`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `last_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of person
-- ----------------------------
INSERT INTO `person` VALUES (1, 'iii', 'ooo');
INSERT INTO `person` VALUES (2, 'tt', 'hh');
INSERT INTO `person` VALUES (3, '', '');

-- ----------------------------
-- Table structure for projectInfo
-- ----------------------------
DROP TABLE IF EXISTS `projectInfo`;
CREATE TABLE `projectInfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目名称',
  `parent` int(11) NULL DEFAULT NULL COMMENT '项目父级',
  `status` enum('打开','关闭','暂停') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目状态',
  `userInfo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目组成员',
  `desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '项目简介',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `PROJECTINFO_PARENT_PROJECTINFO`(`parent`) USING BTREE,
  CONSTRAINT `PROJECTINFO_PARENT_PROJECTINFO` FOREIGN KEY (`parent`) REFERENCES `projectInfo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of projectInfo
-- ----------------------------
INSERT INTO `projectInfo` VALUES (1, '第一个项目名称', NULL, '打开', '1,2', '项目一简介');
INSERT INTO `projectInfo` VALUES (2, '第二个项目名称', NULL, '打开', '1,2,3', '项目二简介');
INSERT INTO `projectInfo` VALUES (3, '第二个项目子项目一', 2, '暂停', '1,2', '项目二子项目一简介');
INSERT INTO `projectInfo` VALUES (4, '第二个项目子项目二', 2, '关闭', '1,3', '项目二子项目二简介');

-- ----------------------------
-- Table structure for roleInfo
-- ----------------------------
DROP TABLE IF EXISTS `roleInfo`;
CREATE TABLE `roleInfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  `routerInfo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由权限',
  `desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '角色描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roleInfo
-- ----------------------------
INSERT INTO `roleInfo` VALUES (1, 'admin', '1,2,3', NULL);
INSERT INTO `roleInfo` VALUES (2, 'user', '1', NULL);

-- ----------------------------
-- Table structure for routerInfo
-- ----------------------------
DROP TABLE IF EXISTS `routerInfo`;
CREATE TABLE `routerInfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '前端对应界面入口路径',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '页面访问路径',
  `type` enum('project','wiki','task','user','home') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由所属类型（控制左侧菜单栏显示）',
  `desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `ROUTERINFO_PATH`(`path`) USING BTREE COMMENT '唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of routerInfo
-- ----------------------------
INSERT INTO `routerInfo` VALUES (1, 'login', './User/Login', '/user/login', NULL, '登录页');
INSERT INTO `routerInfo` VALUES (2, 'welcome', './Welcome', '/welcome', 'home', '欢迎页');
INSERT INTO `routerInfo` VALUES (4, 'project', './Project', '/project/list', 'project', '项目列表页');
INSERT INTO `routerInfo` VALUES (5, 'task', './Task', '/task/list', 'task', '任务列表页');
INSERT INTO `routerInfo` VALUES (6, NULL, './Task/components/TaskDetail.tsx', '/task/list/:id', 'task', '任务详情页');
INSERT INTO `routerInfo` VALUES (7, 'wiki', './Wiki', '/wiki/list', 'wiki', 'wiki页');
INSERT INTO `routerInfo` VALUES (8, 'appointme', './Task/components/AppointMe.tsx', '/task/appointme', 'task', '分配给我');
INSERT INTO `routerInfo` VALUES (9, 'createdbyme', './Task/components/CreatedByMe.tsx', '/task/createdbyme', 'task', '由我创建');
INSERT INTO `routerInfo` VALUES (10, NULL, './Task/components/TaskDetail.tsx', '/task/createdbyme/:id', 'task', '由我创建详情页');
INSERT INTO `routerInfo` VALUES (11, NULL, './Task/components/TaskDetail.tsx', '/task/appointme/:id', 'task', '分配给我详情页');
INSERT INTO `routerInfo` VALUES (12, NULL, './Task/components/TaskDetail.tsx', '/wiki/list?title=?&id=?', 'wiki', 'wiki详情页');

-- ----------------------------
-- Table structure for taskInfo
-- ----------------------------
DROP TABLE IF EXISTS `taskInfo`;
CREATE TABLE `taskInfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一识别、主键自增',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `type` enum('会议','代码开发','BUG','环境搭建','文档编写','其他任务') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务类型',
  `status` enum('新建','进行中','已完成','暂停中','待办任务','已关闭') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态',
  `leval` enum('高','中','低','最高级') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '优先级',
  `createdBy` int(255) NULL DEFAULT NULL COMMENT '创建人',
  `createdTime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `appoint` int(11) NULL DEFAULT NULL COMMENT '指定人',
  `project` int(11) NULL DEFAULT NULL COMMENT '所属项目',
  `taskUpdateInfo` int(11) NULL DEFAULT NULL COMMENT '更新表ID',
  `updateTime` datetime NULL DEFAULT NULL COMMENT '最新的更新时间',
  `estimatedTime` datetime NULL DEFAULT NULL COMMENT '预估时间',
  `consumeTime` datetime NULL DEFAULT NULL COMMENT '已耗时间',
  `leftTime` datetime NULL DEFAULT NULL COMMENT '剩余时间',
  `detail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务详情',
  `date` datetime NULL DEFAULT NULL COMMENT '日期',
  `parent` int(11) NULL DEFAULT NULL COMMENT '父级任务',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `TASKINFO_CREATEDBY_USERINFO`(`createdBy`) USING BTREE,
  INDEX `TASKINFO_APPOINT_USERINFO`(`appoint`) USING BTREE,
  INDEX `TASKINFO_PARENT_TASKINFO`(`parent`) USING BTREE,
  INDEX `TASKINFO_PROJECT_PROJECTINFO`(`project`) USING BTREE,
  INDEX `TASKINFO_TASKUPDATEINFO_TASKUPDATEINFO`(`taskUpdateInfo`) USING BTREE,
  CONSTRAINT `TASKINFO_APPOINT_USERINFO` FOREIGN KEY (`appoint`) REFERENCES `userInfo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `TASKINFO_CREATEDBY_USERINFO` FOREIGN KEY (`createdBy`) REFERENCES `userInfo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `TASKINFO_PARENT_TASKINFO` FOREIGN KEY (`parent`) REFERENCES `taskInfo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `TASKINFO_PROJECT_PROJECTINFO` FOREIGN KEY (`project`) REFERENCES `projectInfo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `TASKINFO_TASKUPDATEINFO_TASKUPDATEINFO` FOREIGN KEY (`taskUpdateInfo`) REFERENCES `taskUpdateInfo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of taskInfo
-- ----------------------------
INSERT INTO `taskInfo` VALUES (2, '第一条任务名称', '会议', '新建', '高', 1, '2023-03-02 21:46:35', 1, 1, 1, '2023-03-04 15:40:08', '2023-03-02 22:06:59', '2023-03-02 22:07:03', '2023-03-02 22:07:09', '任务详情', '2023-03-02 22:10:05', NULL);
INSERT INTO `taskInfo` VALUES (3, '第二条任务名称', '代码开发', '进行中', '中', 1, '2023-03-02 22:11:02', 2, 2, 2, '2023-03-02 15:40:12', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `taskInfo` VALUES (4, '第三条任务名称', 'BUG', '暂停中', '低', 2, '2023-03-04 15:16:40', 3, 3, 3, '2023-03-01 15:40:16', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `taskInfo` VALUES (5, '第四条任务名称', '其他任务', '待办任务', '中', 3, '2023-03-04 15:19:26', 1, 2, 2, '2023-03-03 15:40:19', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `taskInfo` VALUES (6, '第五条任务名称', 'BUG', '已完成', '高', 2, '2023-03-19 12:31:18', 2, 1, 2, '2023-03-01 12:31:35', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `taskInfo` VALUES (7, '任务6', '会议', '新建', '中', 1, '2023-03-19 15:25:00', 3, 1, 2, '2023-03-23 15:25:19', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `taskInfo` VALUES (8, '任务7', '代码开发', '进行中', '低', 3, '2023-03-19 15:26:40', 3, 1, 2, '2023-03-19 15:26:56', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `taskInfo` VALUES (9, '任务8', 'BUG', '进行中', '中', 1, '2023-03-19 15:54:22', 1, 1, 2, '2023-03-19 15:54:36', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `taskInfo` VALUES (10, '任务9', '会议', '已关闭', '低', 2, '2023-03-19 15:55:47', 1, 1, 1, '2023-03-19 15:55:58', NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for taskUpdateInfo
-- ----------------------------
DROP TABLE IF EXISTS `taskUpdateInfo`;
CREATE TABLE `taskUpdateInfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `updateBy` int(11) NULL DEFAULT NULL COMMENT '更新人',
  `updateTime` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `taskUpdateInfo` int(11) NULL DEFAULT NULL COMMENT '后续更新的信息ID',
  `updateContent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '更新后的内容',
  `changeContent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '变更的内容',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `TASKUPDATEINFO_UPDATEBY_USERINFO`(`updateBy`) USING BTREE,
  INDEX `TASKUPDATEINFO_TASKUPDATEINFO_TASKUPDATEINFO`(`taskUpdateInfo`) USING BTREE,
  CONSTRAINT `TASKUPDATEINFO_TASKUPDATEINFO_TASKUPDATEINFO` FOREIGN KEY (`taskUpdateInfo`) REFERENCES `taskUpdateInfo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `TASKUPDATEINFO_UPDATEBY_USERINFO` FOREIGN KEY (`updateBy`) REFERENCES `userInfo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of taskUpdateInfo
-- ----------------------------
INSERT INTO `taskUpdateInfo` VALUES (1, 1, '2023-03-01 22:05:03', NULL, '更改内容一', NULL);
INSERT INTO `taskUpdateInfo` VALUES (2, 1, '2023-03-04 15:05:33', 1, '更改内容二', NULL);
INSERT INTO `taskUpdateInfo` VALUES (3, 2, '2023-03-02 22:05:55', 2, '更改内容三', NULL);

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of test
-- ----------------------------

-- ----------------------------
-- Table structure for userInfo
-- ----------------------------
DROP TABLE IF EXISTS `userInfo`;
CREATE TABLE `userInfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一识别、主键自增',
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录账号',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录密码（加密）',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '电子邮件',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '电话',
  `roleInfo` int(7) NULL DEFAULT NULL COMMENT '对应角色ID',
  `salt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '盐（用于加密）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `USERINFO_NAME`(`name`) USING BTREE COMMENT '值唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of userInfo
-- ----------------------------
INSERT INTO `userInfo` VALUES (1, 'admin', 'ant.design', 'root', 'http://thirdqq.qlogo.cn/g?b=oidb&k=lhlTrYajd0rnYuCtFZPzWw&s=40&t=1628724564', NULL, NULL, 1, '1');
INSERT INTO `userInfo` VALUES (2, 'user', 'ant.design', 'user', '3', NULL, '456', 2, NULL);
INSERT INTO `userInfo` VALUES (3, 'test', 'ant.design', 'test', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for wikiInfo
-- ----------------------------
DROP TABLE IF EXISTS `wikiInfo`;
CREATE TABLE `wikiInfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT 'HTML内容',
  `project` int(11) NOT NULL COMMENT '所属项目',
  `createdBy` int(11) NOT NULL COMMENT '创建人',
  `createdTime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updateInfo` int(11) NULL DEFAULT NULL COMMENT '更新的信息ID',
  `updateTime` datetime NULL DEFAULT NULL COMMENT '最新的更新时间',
  `parent` int(11) NULL DEFAULT NULL COMMENT '父级wiki',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'wiki访问路径(/wiki?title=xxx&id=xxx)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `PATH_UNIQUE`(`path`) USING BTREE,
  INDEX `WIKIINFO_CREATEDBY_USERINFO`(`createdBy`) USING BTREE,
  INDEX `WIKIINFO_PARENT_WIKIINFO`(`parent`) USING BTREE,
  INDEX `WIKIINFO_PROJECT_PROJECTINFO`(`project`) USING BTREE,
  INDEX `WIKIINFO_UPDATEINFO`(`updateInfo`) USING BTREE,
  CONSTRAINT `WIKIINFO_CREATEDBY_USERINFO` FOREIGN KEY (`createdBy`) REFERENCES `userInfo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `WIKIINFO_PARENT_WIKIINFO` FOREIGN KEY (`parent`) REFERENCES `wikiInfo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `WIKIINFO_PROJECT_PROJECTINFO` FOREIGN KEY (`project`) REFERENCES `projectInfo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `WIKIINFO_UPDATEINFO` FOREIGN KEY (`updateInfo`) REFERENCES `wikiUpdateInfo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wikiInfo
-- ----------------------------
INSERT INTO `wikiInfo` VALUES (1, '第一个wiki', 'wiki HTML 内容一', 1, 1, '2023-03-17 22:55:42', NULL, NULL, NULL, NULL);
INSERT INTO `wikiInfo` VALUES (2, '第二个wiki', 'wiki HTML 内容二', 2, 2, '2023-03-16 22:55:47', 2, '2023-03-19 23:01:32', NULL, NULL);
INSERT INTO `wikiInfo` VALUES (3, '第三个wiki', 'wiki HTML 内容三', 3, 3, '2023-03-15 22:55:51', NULL, NULL, NULL, NULL);
INSERT INTO `wikiInfo` VALUES (4, '第四个wiki', 'wiki HTML 内容四', 4, 1, '2023-03-18 22:55:55', 5, '2023-03-18 23:01:28', 1, NULL);
INSERT INTO `wikiInfo` VALUES (5, '第五个wiki', 'wiki HTML 内容五', 1, 2, '2023-03-19 22:55:58', NULL, NULL, 2, NULL);
INSERT INTO `wikiInfo` VALUES (6, '第六个wiki', 'wiki HTML 内容六', 2, 1, '2023-03-20 22:56:02', 1, '2023-03-17 23:01:23', 4, NULL);

-- ----------------------------
-- Table structure for wikiUpdateInfo
-- ----------------------------
DROP TABLE IF EXISTS `wikiUpdateInfo`;
CREATE TABLE `wikiUpdateInfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `updateBy` int(11) NULL DEFAULT NULL COMMENT '更新人',
  `updateTime` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `wikiUpdateInfo` int(11) NULL DEFAULT NULL COMMENT '后续更新的信息ID',
  `updateContent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '更新后的内容',
  `changeContent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '变更的内容',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `WIKIUPDATEINFO_UPDATEBY_USERINFO`(`updateBy`) USING BTREE,
  INDEX `WIKIUPDATEINFO_WIKIUPDATEINFO_WIKIUPDATEINFO`(`wikiUpdateInfo`) USING BTREE,
  CONSTRAINT `WIKIUPDATEINFO_UPDATEBY_USERINFO` FOREIGN KEY (`updateBy`) REFERENCES `userInfo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `WIKIUPDATEINFO_WIKIUPDATEINFO_WIKIUPDATEINFO` FOREIGN KEY (`wikiUpdateInfo`) REFERENCES `wikiUpdateInfo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wikiUpdateInfo
-- ----------------------------
INSERT INTO `wikiUpdateInfo` VALUES (1, 1, '2023-03-19 22:56:24', NULL, '更新内容一', '改变内容一');
INSERT INTO `wikiUpdateInfo` VALUES (2, 2, '2023-03-18 22:57:03', NULL, '更新内容二', '改变内容二');
INSERT INTO `wikiUpdateInfo` VALUES (3, 3, '2023-03-19 22:58:18', 2, '更新内容三', '改变内容三');
INSERT INTO `wikiUpdateInfo` VALUES (4, 2, '2023-03-19 22:59:17', 3, '更新内容四', '改变内容四');
INSERT INTO `wikiUpdateInfo` VALUES (5, 3, '2023-03-19 22:59:53', NULL, '更新内容五', '改变内容五');

SET FOREIGN_KEY_CHECKS = 1;
