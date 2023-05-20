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

 Date: 20/05/2023 09:41:37
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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

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
  `parent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目父级',
  `status` enum('打开','关闭','暂停') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目状态',
  `userInfo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目组成员',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '项目简介',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`name`) USING BTREE,
  INDEX `projectInfo_parent_projectInfo_name`(`parent`) USING BTREE,
  CONSTRAINT `projectInfo_parent_projectInfo_name` FOREIGN KEY (`parent`) REFERENCES `projectInfo` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of projectInfo
-- ----------------------------
INSERT INTO `projectInfo` VALUES (1, '第一个项目名称', NULL, '打开', '1,2,3', '项目一简介1');
INSERT INTO `projectInfo` VALUES (2, '第二个项目名称', NULL, '打开', '1,2,3', '项目二简介');
INSERT INTO `projectInfo` VALUES (3, '第二个项目子项目一', '第二个项目名称', '暂停', '1,2', '项目二子项目一简介');
INSERT INTO `projectInfo` VALUES (4, '第二个项目子项目二', '第二个项目名称', '关闭', '1,3', '项目二子项目二简介');
INSERT INTO `projectInfo` VALUES (5, '项目测试', '第一个项目名称', '打开', NULL, '123');
INSERT INTO `projectInfo` VALUES (6, '项目测试2', '第二个项目名称', '关闭', NULL, '1');
INSERT INTO `projectInfo` VALUES (7, '项目测试3', '第一个项目名称', '暂停', NULL, '12');
INSERT INTO `projectInfo` VALUES (8, '11', '第二个项目名称', '打开', NULL, '23');
INSERT INTO `projectInfo` VALUES (9, '3', '第二个项目名称', '打开', NULL, '3');
INSERT INTO `projectInfo` VALUES (10, '项目1', '第一个项目名称', '打开', '2', '4');

-- ----------------------------
-- Table structure for roleInfo
-- ----------------------------
DROP TABLE IF EXISTS `roleInfo`;
CREATE TABLE `roleInfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  `routerInfo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '路由权限',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '角色描述',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of roleInfo
-- ----------------------------
INSERT INTO `roleInfo` VALUES (1, 'admin', '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16', NULL);
INSERT INTO `roleInfo` VALUES (2, 'user', '1,2,3,4,5,6,7,8,9,10,11,13,14,15', NULL);
INSERT INTO `roleInfo` VALUES (3, 'staff', '1,2', NULL);

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
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `ROUTERINFO_PATH`(`path`) USING BTREE COMMENT '唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of routerInfo
-- ----------------------------
INSERT INTO `routerInfo` VALUES (1, 'login', './User/Login', '/user/login', NULL, '登录页');
INSERT INTO `routerInfo` VALUES (2, 'welcome', './Welcome', '/welcome', 'home', '欢迎页');
INSERT INTO `routerInfo` VALUES (4, 'project', './Project', '/project/list', 'project', '项目列表页');
INSERT INTO `routerInfo` VALUES (5, 'task', './Task', '/task/list', 'task', '任务列表页');
INSERT INTO `routerInfo` VALUES (6, NULL, './Task/components/TaskDetail.tsx', '/task/list/detail', 'task', '任务详情页');
INSERT INTO `routerInfo` VALUES (7, 'wiki', './Wiki', '/wiki/list', 'wiki', 'wiki页');
INSERT INTO `routerInfo` VALUES (8, 'appointme', './Task/components/AppointMe.tsx', '/task/appointme', 'task', '分配给我');
INSERT INTO `routerInfo` VALUES (9, 'createdbyme', './Task/components/CreatedByMe.tsx', '/task/createdbyme', 'task', '由我创建');
INSERT INTO `routerInfo` VALUES (10, NULL, './Task/components/TaskDetail.tsx', '/task/createdbyme/detail', 'task', '由我创建详情页');
INSERT INTO `routerInfo` VALUES (11, NULL, './Task/components/TaskDetail.tsx', '/task/appointme/detail', 'task', '分配给我详情页');
INSERT INTO `routerInfo` VALUES (12, NULL, './User/Manager', '/userManagement/list', 'user', '用户管理页');
INSERT INTO `routerInfo` VALUES (13, NULL, './User/Personal', '/personal', 'user', '个人中心页');
INSERT INTO `routerInfo` VALUES (14, NULL, './Wiki/components/WikiDetail.tsx', '/wiki/list/detail', 'wiki', 'wiki详情页');
INSERT INTO `routerInfo` VALUES (15, NULL, './Project/components/ProjectDetail.tsx', '/project/list/detail', 'project', '项目详情页');
INSERT INTO `routerInfo` VALUES (16, NULL, './User/Add', '/user/add', 'user', '用户添加页');

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
  `createdBy` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `createdTime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `endTime` datetime NULL DEFAULT NULL COMMENT '结束日期',
  `appoint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '指定人',
  `project` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属项目',
  `taskUpdateInfo` int(11) NULL DEFAULT NULL COMMENT '更新表ID',
  `updateTime` datetime NULL DEFAULT NULL COMMENT '最新的更新时间',
  `estimatedTime` int(11) NULL DEFAULT NULL COMMENT '预估时间',
  `consumeTime` int(11) NULL DEFAULT NULL COMMENT '已耗时间',
  `leftTime` int(11) NULL DEFAULT NULL COMMENT '剩余时间',
  `detail` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '任务详情',
  `parent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '父级任务',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`name`) USING BTREE,
  INDEX `taskInfo_appoint_userinfo_name`(`appoint`) USING BTREE,
  INDEX `taskInfo_createdBy_userinfo_name`(`createdBy`) USING BTREE,
  INDEX `taskInfo_parent_taskInfo_name`(`parent`) USING BTREE,
  INDEX `taskInfo_project_projectInfo_name`(`project`) USING BTREE,
  CONSTRAINT `taskInfo_appoint_userinfo_name` FOREIGN KEY (`appoint`) REFERENCES `userInfo` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `taskInfo_createdBy_userinfo_name` FOREIGN KEY (`createdBy`) REFERENCES `userInfo` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `taskInfo_parent_taskInfo_name` FOREIGN KEY (`parent`) REFERENCES `taskInfo` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `taskInfo_project_projectInfo_name` FOREIGN KEY (`project`) REFERENCES `projectInfo` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of taskInfo
-- ----------------------------
INSERT INTO `taskInfo` VALUES (2, '第一条任务名称', 'BUG', '进行中', '高', 'root', '2023-03-02 21:46:35', '2023-04-09 20:03:26', 'test', '第一个项目名称', NULL, '2023-05-15 19:40:35', NULL, NULL, NULL, '任务详情', NULL);
INSERT INTO `taskInfo` VALUES (3, '第二条任务名称', '代码开发', '新建', '中', 'user', '2023-03-02 22:11:02', NULL, 'user', '第二个项目名称', NULL, '2023-03-02 15:40:12', NULL, NULL, NULL, NULL, '第一条任务名称');
INSERT INTO `taskInfo` VALUES (4, '第三条任务名称', 'BUG', '暂停中', '低', 'test', '2023-03-04 15:16:40', NULL, 'test', '第一个项目名称', NULL, '2023-03-01 15:40:16', NULL, NULL, NULL, NULL, '第二条任务名称');
INSERT INTO `taskInfo` VALUES (5, '第四条任务名称', '其他任务', '待办任务', '中', 'staff1', '2023-03-04 15:19:26', NULL, 'root', '第二个项目名称', NULL, '2023-03-03 15:40:19', NULL, NULL, NULL, NULL, '第五条任务名称');
INSERT INTO `taskInfo` VALUES (6, '第五条任务名称', 'BUG', '已完成', '高', 'staff2', '2023-03-19 12:31:18', NULL, 'user', '第二个项目子项目一', NULL, '2023-03-01 12:31:35', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `taskInfo` VALUES (7, '任务6', '会议', '新建', '中', 'root', '2023-03-19 15:25:00', NULL, 'user', '第二个项目子项目二', NULL, '2023-03-23 15:25:19', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `taskInfo` VALUES (8, '任务7', '代码开发', '进行中', '低', 'root', '2023-03-19 15:26:40', NULL, 'user', '第二个项目名称', NULL, '2023-03-19 15:26:56', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `taskInfo` VALUES (9, '任务8', 'BUG', '进行中', '中', 'test', '2023-03-19 15:54:22', '2023-04-05 00:00:00', 'root', '第一个项目名称', NULL, '2023-04-15 15:17:37', NULL, NULL, NULL, '<p>12</p>', '第三条任务名称');
INSERT INTO `taskInfo` VALUES (10, '任务9', '会议', '已关闭', '中', 'user', '2023-03-19 15:55:47', '2023-04-11 21:56:14', 'staff2', '第一个项目名称', NULL, '2023-04-15 09:27:43', NULL, NULL, NULL, '<p style=\"text-align:justify;\"><br/><strong><span style=\"font-size:24px\"><span style=\"letter-spacing:3px\">任务9详情</span></span></strong><br/><br/><br/><strong><span style=\"font-size:24px\"><span style=\"letter-spacing:3px\">熊皮哦</span></span></strong></p><p></p><p></p><p></p><pre><code><span style=\"font-size:24px\"><span style=\"letter-spacing:3px\">000</span></span></code></pre><p></p><p></p><p><span style=\"font-size:24px\"><span style=\"letter-spacing:3px\">9985</span></span></p><p></p><p></p><p></p><p><span style=\"font-size:24px\"><span style=\"letter-spacing:3px\">哦<a href=\"999\" target=\"\">你还</a></span></span><a href=\"999\" target=\"_blank\">999</a><span style=\"font-size:24px\"><span style=\"letter-spacing:3px\"><a href=\"999\" target=\"\">不</a>哦</span></span></p><p></p><p></p><p></p><p></p><p><span style=\"font-size:24px\"><span style=\"letter-spacing:3px\">0-9</span></span></p><hr/><p></p><ol><li>p</li><li>9</li><li>0</li></ol><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p>', NULL);
INSERT INTO `taskInfo` VALUES (11, '任务测试1', '会议', '进行中', '中', 'staff1', NULL, NULL, 'staff3', '第一个项目名称', NULL, '2023-05-14 19:47:16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `taskInfo` VALUES (12, '任务测试2', '会议', '进行中', '高', 'root', NULL, NULL, 'user', '第二个项目名称', NULL, '2023-05-14 19:34:18', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `taskInfo` VALUES (13, '任务测试3', '代码开发', '进行中', '中', 'root', NULL, NULL, 'user', '第二个项目名称', NULL, '2023-05-14 20:09:44', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `taskInfo` VALUES (14, '任务测试2', '代码开发', '进行中', '中', 'user', NULL, NULL, 'root', '第二个项目名称', NULL, '2023-05-14 20:09:35', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `taskInfo` VALUES (15, '任务测试4', '会议', '进行中', '高', NULL, NULL, NULL, NULL, '第二个项目名称', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `taskInfo` VALUES (16, '任务测试5', '环境搭建', '进行中', '高', NULL, NULL, NULL, NULL, '第一个项目名称', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `taskInfo` VALUES (17, '任务测试6', '文档编写', '进行中', '中', NULL, NULL, NULL, NULL, '第一个项目名称', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `taskInfo` VALUES (18, '任务测试7', 'BUG', '待办任务', '最高级', NULL, NULL, NULL, NULL, '第一个项目名称', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `taskInfo` VALUES (19, '测试刷新1', '会议', '已完成', '中', 'user', NULL, NULL, 'test', '第一个项目名称', NULL, '2023-05-16 19:14:06', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `taskInfo` VALUES (20, '刷新测试2', '代码开发', '已完成', '中', 'root', '2023-05-15 19:48:24', '2023-05-15 19:48:27', 'user', '第一个项目名称', 1, '2023-05-16 19:33:54', 1, 2, 3, '<p>任务详情</p>', '第一条任务名称');

-- ----------------------------
-- Table structure for taskupdateInfo
-- ----------------------------
DROP TABLE IF EXISTS `taskupdateInfo`;
CREATE TABLE `taskupdateInfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `updateBy` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `updateTime` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `taskUpdateInfo` int(11) NULL DEFAULT NULL COMMENT '后续更新的信息ID',
  `updateContent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '更新后的内容',
  `changeContent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '变更的内容',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `taskupdateInfo_updateBy_userInfo_name`(`updateBy`) USING BTREE,
  CONSTRAINT `taskupdateInfo_updateBy_userInfo_name` FOREIGN KEY (`updateBy`) REFERENCES `userInfo` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of taskupdateInfo
-- ----------------------------
INSERT INTO `taskupdateInfo` VALUES (1, 'root', '2023-03-01 22:05:03', NULL, '更改内容一', NULL);
INSERT INTO `taskupdateInfo` VALUES (2, 'user', '2023-03-04 15:05:33', NULL, '更改内容二', NULL);
INSERT INTO `taskupdateInfo` VALUES (3, 'test', '2023-03-02 22:05:55', NULL, '更改内容三', NULL);

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

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
  `roleInfo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '对应角色ID',
  `salt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '盐（用于加密）',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `job` enum('前端工程师','后端工程师','实习生') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '职位',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `USERINFO_NAME`(`name`) USING BTREE COMMENT '值唯一',
  INDEX `USERINFO_ROLEINFO_ROLEINFO`(`roleInfo`) USING BTREE,
  CONSTRAINT `userInfo_roleInfo_roleInfo_name` FOREIGN KEY (`roleInfo`) REFERENCES `roleInfo` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of userInfo
-- ----------------------------
INSERT INTO `userInfo` VALUES (1, 'admin', 'ant.design', 'root', 'http://thirdqq.qlogo.cn/g?b=oidb&k=lhlTrYajd0rnYuCtFZPzWw&s=40&t=1628724564', '123@qq.conmm', '123', 'admin', '1', '2023-04-22', '后端工程师');
INSERT INTO `userInfo` VALUES (2, 'user', 'ant.design', 'user', 'http://thirdqq.qlogo.cn/g?b=oidb&k=lhlTrYajd0rnYuCtFZPzWw&s=40&t=1628724564', '449', '456', 'user', NULL, '2023-04-06', '前端工程师');
INSERT INTO `userInfo` VALUES (3, 'test', 'ant.design', 'test', 'http://thirdqq.qlogo.cn/g?b=oidb&k=lhlTrYajd0rnYuCtFZPzWw&s=40&t=1628724564', NULL, NULL, 'staff', NULL, NULL, NULL);
INSERT INTO `userInfo` VALUES (4, 'staff1', 'staff', 'staff1', 'http://thirdqq.qlogo.cn/g?b=oidb&k=lhlTrYajd0rnYuCtFZPzWw&s=40&t=1628724564', NULL, NULL, 'staff', NULL, NULL, NULL);
INSERT INTO `userInfo` VALUES (5, 'staff2', 'staff', 'staff2', 'http://thirdqq.qlogo.cn/g?b=oidb&k=lhlTrYajd0rnYuCtFZPzWw&s=40&t=1628724564', NULL, NULL, 'staff', NULL, NULL, NULL);
INSERT INTO `userInfo` VALUES (6, 'staff3', 'staff', 'staff3', 'http://thirdqq.qlogo.cn/g?b=oidb&k=lhlTrYajd0rnYuCtFZPzWw&s=40&t=1628724564', NULL, NULL, 'admin', NULL, NULL, '实习生');
INSERT INTO `userInfo` VALUES (7, 'test2', '123456', 'test2name', 'http://thirdqq.qlogo.cn/g?b=oidb&k=lhlTrYajd0rnYuCtFZPzWw&s=40&t=1628724564', NULL, NULL, 'staff', NULL, NULL, '后端工程师');

-- ----------------------------
-- Table structure for wikiInfo
-- ----------------------------
DROP TABLE IF EXISTS `wikiInfo`;
CREATE TABLE `wikiInfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT 'HTML内容',
  `project` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属项目',
  `createdBy` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `createdTime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updateInfo` int(11) NULL DEFAULT NULL COMMENT '更新的信息ID',
  `updateTime` datetime NULL DEFAULT NULL COMMENT '最新的更新时间',
  `parent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '父级wiki',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `title`(`title`) USING BTREE,
  INDEX `wikiInfo_createdBy_userInfo_name`(`createdBy`) USING BTREE,
  INDEX `wikiInfo_parent_wikiInfo_title`(`parent`) USING BTREE,
  INDEX `wikiInfo_project_projectInfo_name`(`project`) USING BTREE,
  INDEX `wikiInfo_updateInfo_wikiupdateInfo_id`(`updateInfo`) USING BTREE,
  CONSTRAINT `wikiInfo_createdBy_userInfo_name` FOREIGN KEY (`createdBy`) REFERENCES `userInfo` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `wikiInfo_parent_wikiInfo_title` FOREIGN KEY (`parent`) REFERENCES `wikiInfo` (`title`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `wikiInfo_project_projectInfo_name` FOREIGN KEY (`project`) REFERENCES `projectInfo` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `wikiInfo_updateInfo_wikiupdateInfo_id` FOREIGN KEY (`updateInfo`) REFERENCES `wikiupdateInfo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wikiInfo
-- ----------------------------
INSERT INTO `wikiInfo` VALUES (1, '第一个wiki', '<h1><em>wiki HTML<strong> 内容一99954455</strong></em></h1><ul><li><em><strong>通天塔01</strong></em></li><li><em><strong>02</strong></em></li><li><em><strong>03</strong></em></li></ul><p><em><strong>发斯蒂芬斯蒂芬</strong></em></p><p></p><p style=\"text-align:justify;\" size=\"0\" _root=\"undefined\" __ownerID=\"undefined\" __hash=\"undefined\" __altered=\"false\"></p><p style=\"text-indent:2em;\" size=\"0\" _root=\"undefined\" __ownerID=\"undefined\" __hash=\"undefined\" __altered=\"false\"><em><strong>师德师风</strong></em></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p>', NULL, NULL, '2023-03-17 22:55:42', NULL, NULL, NULL);
INSERT INTO `wikiInfo` VALUES (2, '第二个wiki', '<p>wiki HTML 内容二456</p>', NULL, NULL, '2023-03-16 22:55:47', NULL, '2023-03-19 23:01:32', NULL);
INSERT INTO `wikiInfo` VALUES (3, '第三个wiki', 'wiki HTML 内容三', NULL, NULL, '2023-03-15 22:55:51', NULL, NULL, NULL);
INSERT INTO `wikiInfo` VALUES (4, '第四个wiki39', 'wiki HTML 内容四', NULL, NULL, '2023-03-18 22:55:55', NULL, '2023-03-18 23:01:28', NULL);
INSERT INTO `wikiInfo` VALUES (5, '第五个wiki119', '<p>wiki HTML 内容五00</p>', NULL, NULL, '2023-03-19 22:55:58', NULL, '2023-04-05 17:25:28', NULL);
INSERT INTO `wikiInfo` VALUES (6, '这是第6个wiki6', '<p style=\"text-align:justify;\" size=\"0\" _root=\"undefined\" __ownerid=\"undefined\" __hash=\"undefined\" __altered=\"false\"><strong><span style=\"color:#61a951\">第6个wiki</span></strong>💛</p><p></p><p><span style=\"font-size:72px\">我的字号是72</span></p><p>下标<sub>12</sub></p><p></p><p>上标<sup>12</sup></p><p></p><h1>标题1</h1><h2>标题2</h2><h5>标题5</h5><p><u>下划线</u></p><p><em>斜体</em></p><p><strong>加粗</strong></p>', NULL, NULL, '2023-03-20 22:56:02', 1, '2023-05-09 19:26:56', NULL);
INSERT INTO `wikiInfo` VALUES (7, 'wiki测试1', '<p>的生产方式额</p><p>255</p>', '第一个项目名称', NULL, NULL, 1, '2023-05-16 19:06:06', NULL);

-- ----------------------------
-- Table structure for wikiupdateInfo
-- ----------------------------
DROP TABLE IF EXISTS `wikiupdateInfo`;
CREATE TABLE `wikiupdateInfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `updateBy` int(11) NULL DEFAULT NULL COMMENT '更新人',
  `updateTime` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `wikiUpdateInfo` int(11) NULL DEFAULT NULL COMMENT '后续更新的信息ID',
  `updateContent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '更新后的内容',
  `changeContent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '变更的内容',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `WIKIUPDATEINFO_UPDATEBY_USERINFO`(`updateBy`) USING BTREE,
  INDEX `WIKIUPDATEINFO_WIKIUPDATEINFO_WIKIUPDATEINFO`(`wikiUpdateInfo`) USING BTREE,
  CONSTRAINT `WIKIUPDATEINFO_UPDATEBY_USERINFO` FOREIGN KEY (`updateBy`) REFERENCES `userInfo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `WIKIUPDATEINFO_WIKIUPDATEINFO_WIKIUPDATEINFO` FOREIGN KEY (`wikiUpdateInfo`) REFERENCES `wikiupdateInfo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wikiupdateInfo
-- ----------------------------
INSERT INTO `wikiupdateInfo` VALUES (1, 1, '2023-03-19 22:56:24', NULL, '更新内容一', '改变内容一');
INSERT INTO `wikiupdateInfo` VALUES (2, 2, '2023-03-18 22:57:03', NULL, '更新内容二', '改变内容二');
INSERT INTO `wikiupdateInfo` VALUES (3, 3, '2023-03-19 22:58:18', 2, '更新内容三', '改变内容三');
INSERT INTO `wikiupdateInfo` VALUES (4, 2, '2023-03-19 22:59:17', 3, '更新内容四', '改变内容四');
INSERT INTO `wikiupdateInfo` VALUES (5, 3, '2023-03-19 22:59:53', NULL, '更新内容五', '改变内容五');

SET FOREIGN_KEY_CHECKS = 1;
