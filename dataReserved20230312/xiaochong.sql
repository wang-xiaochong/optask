/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 80022
 Source Schema         : xiaochong

 Target Server Type    : MySQL
 Target Server Version : 80022
 File Encoding         : 65001

 Date: 15/04/2023 17:04:40
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for person
-- ----------------------------
DROP TABLE IF EXISTS `person`;
CREATE TABLE `person`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `last_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of person
-- ----------------------------
INSERT INTO `person` VALUES (1, 'iii', 'ooo');
INSERT INTO `person` VALUES (2, 'tt', 'hh');
INSERT INTO `person` VALUES (3, '', '');

-- ----------------------------
-- Table structure for projectinfo
-- ----------------------------
DROP TABLE IF EXISTS `projectinfo`;
CREATE TABLE `projectinfo`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目名称',
  `parent` int NULL DEFAULT NULL COMMENT '项目父级',
  `status` enum('打开','关闭','暂停') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目状态',
  `userInfo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目组成员',
  `desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '项目简介',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `PROJECTINFO_PARENT_PROJECTINFO`(`parent` ASC) USING BTREE,
  CONSTRAINT `PROJECTINFO_PARENT_PROJECTINFO` FOREIGN KEY (`parent`) REFERENCES `projectinfo` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of projectinfo
-- ----------------------------
INSERT INTO `projectinfo` VALUES (1, '第一个项目名称', NULL, '打开', '1,2', '项目一简介');
INSERT INTO `projectinfo` VALUES (2, '第二个项目名称', NULL, '打开', '1,2,3', '项目二简介');
INSERT INTO `projectinfo` VALUES (3, '第二个项目子项目一', 2, '暂停', '1,2', '项目二子项目一简介');
INSERT INTO `projectinfo` VALUES (4, '第二个项目子项目二', 2, '关闭', '1,3', '项目二子项目二简介');

-- ----------------------------
-- Table structure for roleinfo
-- ----------------------------
DROP TABLE IF EXISTS `roleinfo`;
CREATE TABLE `roleinfo`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  `routerInfo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '路由权限',
  `desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '角色描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of roleinfo
-- ----------------------------
INSERT INTO `roleinfo` VALUES (1, 'admin', '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16', NULL);
INSERT INTO `roleinfo` VALUES (2, 'user', '1,2,3,4,5,6,7,8,9,10,11,13,14,15', NULL);
INSERT INTO `roleinfo` VALUES (3, 'staff', '1,2', NULL);

-- ----------------------------
-- Table structure for routerinfo
-- ----------------------------
DROP TABLE IF EXISTS `routerinfo`;
CREATE TABLE `routerinfo`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '前端对应界面入口路径',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '页面访问路径',
  `type` enum('project','wiki','task','user','home') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由所属类型（控制左侧菜单栏显示）',
  `desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `ROUTERINFO_PATH`(`path` ASC) USING BTREE COMMENT '唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of routerinfo
-- ----------------------------
INSERT INTO `routerinfo` VALUES (1, 'login', './User/Login', '/user/login', NULL, '登录页');
INSERT INTO `routerinfo` VALUES (2, 'welcome', './Welcome', '/welcome', 'home', '欢迎页');
INSERT INTO `routerinfo` VALUES (4, 'project', './Project', '/project/list', 'project', '项目列表页');
INSERT INTO `routerinfo` VALUES (5, 'task', './Task', '/task/list', 'task', '任务列表页');
INSERT INTO `routerinfo` VALUES (6, NULL, './Task/components/TaskDetail.tsx', '/task/list/detail', 'task', '任务详情页');
INSERT INTO `routerinfo` VALUES (7, 'wiki', './Wiki', '/wiki/list', 'wiki', 'wiki页');
INSERT INTO `routerinfo` VALUES (8, 'appointme', './Task/components/AppointMe.tsx', '/task/appointme', 'task', '分配给我');
INSERT INTO `routerinfo` VALUES (9, 'createdbyme', './Task/components/CreatedByMe.tsx', '/task/createdbyme', 'task', '由我创建');
INSERT INTO `routerinfo` VALUES (10, NULL, './Task/components/TaskDetail.tsx', '/task/createdbyme/detail', 'task', '由我创建详情页');
INSERT INTO `routerinfo` VALUES (11, NULL, './Task/components/TaskDetail.tsx', '/task/appointme/detail', 'task', '分配给我详情页');
INSERT INTO `routerinfo` VALUES (12, NULL, './User/Manager', '/userManagement/list', 'user', '用户管理页');
INSERT INTO `routerinfo` VALUES (13, NULL, './User/Personal', '/personal', 'user', '个人中心页');
INSERT INTO `routerinfo` VALUES (14, NULL, './Wiki/components/WikiDetail.tsx', '/wiki/list/detail', 'wiki', 'wiki详情页');
INSERT INTO `routerinfo` VALUES (15, NULL, './Project/components/ProjectDetail.tsx', '/project/list/detail', 'project', '项目详情页');
INSERT INTO `routerinfo` VALUES (16, NULL, './User/Add', '/user/add', 'user', '用户添加页');

-- ----------------------------
-- Table structure for taskinfo
-- ----------------------------
DROP TABLE IF EXISTS `taskinfo`;
CREATE TABLE `taskinfo`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '唯一识别、主键自增',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `type` enum('会议','代码开发','BUG','环境搭建','文档编写','其他任务') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务类型',
  `status` enum('新建','进行中','已完成','暂停中','待办任务','已关闭') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态',
  `leval` enum('高','中','低','最高级') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '优先级',
  `createdBy` int NULL DEFAULT NULL COMMENT '创建人',
  `createdTime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `endTime` datetime NULL DEFAULT NULL COMMENT '结束日期',
  `appoint` int NULL DEFAULT NULL COMMENT '指定人',
  `project` int NULL DEFAULT NULL COMMENT '所属项目',
  `taskUpdateInfo` int NULL DEFAULT NULL COMMENT '更新表ID',
  `updateTime` datetime NULL DEFAULT NULL COMMENT '最新的更新时间',
  `estimatedTime` int NULL DEFAULT NULL COMMENT '预估时间',
  `consumeTime` int NULL DEFAULT NULL COMMENT '已耗时间',
  `leftTime` int NULL DEFAULT NULL COMMENT '剩余时间',
  `detail` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '任务详情',
  `parent` int NULL DEFAULT NULL COMMENT '父级任务',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `TASKINFO_CREATEDBY_USERINFO`(`createdBy` ASC) USING BTREE,
  INDEX `TASKINFO_APPOINT_USERINFO`(`appoint` ASC) USING BTREE,
  INDEX `TASKINFO_PARENT_TASKINFO`(`parent` ASC) USING BTREE,
  INDEX `TASKINFO_PROJECT_PROJECTINFO`(`project` ASC) USING BTREE,
  INDEX `TASKINFO_TASKUPDATEINFO_TASKUPDATEINFO`(`taskUpdateInfo` ASC) USING BTREE,
  CONSTRAINT `TASKINFO_APPOINT_USERINFO` FOREIGN KEY (`appoint`) REFERENCES `userinfo` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `TASKINFO_CREATEDBY_USERINFO` FOREIGN KEY (`createdBy`) REFERENCES `userinfo` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `TASKINFO_PARENT_TASKINFO` FOREIGN KEY (`parent`) REFERENCES `taskinfo` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `TASKINFO_PROJECT_PROJECTINFO` FOREIGN KEY (`project`) REFERENCES `projectinfo` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `TASKINFO_TASKUPDATEINFO_TASKUPDATEINFO` FOREIGN KEY (`taskUpdateInfo`) REFERENCES `taskupdateinfo` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of taskinfo
-- ----------------------------
INSERT INTO `taskinfo` VALUES (2, '第一条任务名称', '会议', '新建', '高', 1, '2023-03-02 21:46:35', '2023-04-09 20:03:26', 1, 1, 1, '2023-03-04 15:40:08', 3, 2, 1, '任务详情', NULL);
INSERT INTO `taskinfo` VALUES (3, '第二条任务名称', '代码开发', '进行中', '中', 1, '2023-03-02 22:11:02', NULL, 2, 2, 2, '2023-03-02 15:40:12', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `taskinfo` VALUES (4, '第三条任务名称', 'BUG', '暂停中', '低', 2, '2023-03-04 15:16:40', NULL, 3, 3, 3, '2023-03-01 15:40:16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `taskinfo` VALUES (5, '第四条任务名称', '其他任务', '待办任务', '中', 3, '2023-03-04 15:19:26', NULL, 1, 2, 2, '2023-03-03 15:40:19', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `taskinfo` VALUES (6, '第五条任务名称', 'BUG', '已完成', '高', 2, '2023-03-19 12:31:18', NULL, 2, 1, 2, '2023-03-01 12:31:35', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `taskinfo` VALUES (7, '任务6', '会议', '新建', '中', 1, '2023-03-19 15:25:00', NULL, 3, 1, 2, '2023-03-23 15:25:19', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `taskinfo` VALUES (8, '任务7', '代码开发', '进行中', '低', 3, '2023-03-19 15:26:40', NULL, 3, 1, 2, '2023-03-19 15:26:56', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `taskinfo` VALUES (9, '任务8', 'BUG', '进行中', '中', 1, '2023-03-19 15:54:22', '2023-04-05 00:00:00', 1, 1, 2, '2023-04-15 15:17:37', 1, 2, 3, '<p>12</p>', NULL);
INSERT INTO `taskinfo` VALUES (10, '任务9', '会议', '已关闭', '中', 2, '2023-03-19 15:55:47', '2023-04-11 21:56:14', 1, 1, 1, '2023-04-15 09:27:43', 3, 2, 1, '<p style=\"text-align:justify;\"><br/><strong><span style=\"font-size:24px\"><span style=\"letter-spacing:3px\">任务9详情</span></span></strong><br/><br/><br/><strong><span style=\"font-size:24px\"><span style=\"letter-spacing:3px\">熊皮哦</span></span></strong></p><p></p><p></p><p></p><pre><code><span style=\"font-size:24px\"><span style=\"letter-spacing:3px\">000</span></span></code></pre><p></p><p></p><p><span style=\"font-size:24px\"><span style=\"letter-spacing:3px\">9985</span></span></p><p></p><p></p><p></p><p><span style=\"font-size:24px\"><span style=\"letter-spacing:3px\">哦<a href=\"999\" target=\"\">你还</a></span></span><a href=\"999\" target=\"_blank\">999</a><span style=\"font-size:24px\"><span style=\"letter-spacing:3px\"><a href=\"999\" target=\"\">不</a>哦</span></span></p><p></p><p></p><p></p><p></p><p><span style=\"font-size:24px\"><span style=\"letter-spacing:3px\">0-9</span></span></p><hr/><p></p><ol><li>p</li><li>9</li><li>0</li></ol><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p>', 2);

-- ----------------------------
-- Table structure for taskupdateinfo
-- ----------------------------
DROP TABLE IF EXISTS `taskupdateinfo`;
CREATE TABLE `taskupdateinfo`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `updateBy` int NULL DEFAULT NULL COMMENT '更新人',
  `updateTime` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `taskUpdateInfo` int NULL DEFAULT NULL COMMENT '后续更新的信息ID',
  `updateContent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '更新后的内容',
  `changeContent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '变更的内容',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `TASKUPDATEINFO_UPDATEBY_USERINFO`(`updateBy` ASC) USING BTREE,
  INDEX `TASKUPDATEINFO_TASKUPDATEINFO_TASKUPDATEINFO`(`taskUpdateInfo` ASC) USING BTREE,
  CONSTRAINT `TASKUPDATEINFO_TASKUPDATEINFO_TASKUPDATEINFO` FOREIGN KEY (`taskUpdateInfo`) REFERENCES `taskupdateinfo` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `TASKUPDATEINFO_UPDATEBY_USERINFO` FOREIGN KEY (`updateBy`) REFERENCES `userinfo` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of taskupdateinfo
-- ----------------------------
INSERT INTO `taskupdateinfo` VALUES (1, 1, '2023-03-01 22:05:03', NULL, '更改内容一', NULL);
INSERT INTO `taskupdateinfo` VALUES (2, 1, '2023-03-04 15:05:33', 1, '更改内容二', NULL);
INSERT INTO `taskupdateinfo` VALUES (3, 2, '2023-03-02 22:05:55', 2, '更改内容三', NULL);

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of test
-- ----------------------------

-- ----------------------------
-- Table structure for userinfo
-- ----------------------------
DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '唯一识别、主键自增',
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录账号',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录密码（加密）',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '电子邮件',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '电话',
  `roleInfo` int NOT NULL COMMENT '对应角色ID',
  `salt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '盐（用于加密）',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `job` enum('前端工程师','后端工程师','实习生') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '职位',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `USERINFO_NAME`(`name` ASC) USING BTREE COMMENT '值唯一',
  INDEX `USERINFO_ROLEINFO_ROLEINFO`(`roleInfo` ASC) USING BTREE,
  CONSTRAINT `USERINFO_ROLEINFO_ROLEINFO` FOREIGN KEY (`roleInfo`) REFERENCES `roleinfo` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of userinfo
-- ----------------------------
INSERT INTO `userinfo` VALUES (1, 'admin', 'ant.design', 'root', 'http://thirdqq.qlogo.cn/g?b=oidb&k=lhlTrYajd0rnYuCtFZPzWw&s=40&t=1628724564', '123@qq.conmm', '123', 1, '1', '2023-04-22', '后端工程师');
INSERT INTO `userinfo` VALUES (2, 'user', 'ant.design', 'user', '3', '449', '456', 2, NULL, '2023-04-06', '前端工程师');
INSERT INTO `userinfo` VALUES (3, 'test', 'ant.design', 'test', NULL, NULL, NULL, 2, NULL, NULL, NULL);
INSERT INTO `userinfo` VALUES (4, 'staff1', 'staff', 'staff1', NULL, NULL, NULL, 3, NULL, NULL, NULL);
INSERT INTO `userinfo` VALUES (5, 'staff2', 'staff', 'staff2', NULL, NULL, NULL, 3, NULL, NULL, NULL);
INSERT INTO `userinfo` VALUES (6, 'staff3', 'staff', 'staff3', NULL, NULL, NULL, 3, NULL, NULL, NULL);
INSERT INTO `userinfo` VALUES (7, 'test2', '123456', 'test2name', NULL, NULL, NULL, 1, NULL, NULL, '前端工程师');

-- ----------------------------
-- Table structure for wikiinfo
-- ----------------------------
DROP TABLE IF EXISTS `wikiinfo`;
CREATE TABLE `wikiinfo`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT 'HTML内容',
  `project` int NOT NULL COMMENT '所属项目',
  `createdBy` int NOT NULL COMMENT '创建人',
  `createdTime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updateInfo` int NULL DEFAULT NULL COMMENT '更新的信息ID',
  `updateTime` datetime NULL DEFAULT NULL COMMENT '最新的更新时间',
  `parent` int NULL DEFAULT NULL COMMENT '父级wiki',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `WIKIINFO_CREATEDBY_USERINFO`(`createdBy` ASC) USING BTREE,
  INDEX `WIKIINFO_PARENT_WIKIINFO`(`parent` ASC) USING BTREE,
  INDEX `WIKIINFO_PROJECT_PROJECTINFO`(`project` ASC) USING BTREE,
  INDEX `WIKIINFO_UPDATEINFO`(`updateInfo` ASC) USING BTREE,
  CONSTRAINT `WIKIINFO_CREATEDBY_USERINFO` FOREIGN KEY (`createdBy`) REFERENCES `userinfo` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `WIKIINFO_PARENT_WIKIINFO` FOREIGN KEY (`parent`) REFERENCES `wikiinfo` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `WIKIINFO_PROJECT_PROJECTINFO` FOREIGN KEY (`project`) REFERENCES `projectinfo` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `WIKIINFO_UPDATEINFO` FOREIGN KEY (`updateInfo`) REFERENCES `wikiupdateinfo` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wikiinfo
-- ----------------------------
INSERT INTO `wikiinfo` VALUES (1, '第一个wiki', '<h1><em>wiki HTML<strong> 内容一99954455</strong></em></h1><ul><li><em><strong>通天塔01</strong></em></li><li><em><strong>02</strong></em></li><li><em><strong>03</strong></em></li></ul><p><em><strong>发斯蒂芬斯蒂芬</strong></em></p><p></p><p style=\"text-align:justify;\" size=\"0\" _root=\"undefined\" __ownerID=\"undefined\" __hash=\"undefined\" __altered=\"false\"></p><p style=\"text-indent:2em;\" size=\"0\" _root=\"undefined\" __ownerID=\"undefined\" __hash=\"undefined\" __altered=\"false\"><em><strong>师德师风</strong></em></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p>', 1, 1, '2023-03-17 22:55:42', NULL, NULL, NULL);
INSERT INTO `wikiinfo` VALUES (2, '第二个wiki', '<p>wiki HTML 内容二456</p>', 2, 2, '2023-03-16 22:55:47', 2, '2023-03-19 23:01:32', NULL);
INSERT INTO `wikiinfo` VALUES (3, '第三个wiki', 'wiki HTML 内容三', 3, 3, '2023-03-15 22:55:51', NULL, NULL, NULL);
INSERT INTO `wikiinfo` VALUES (4, '第四个wiki39', 'wiki HTML 内容四', 4, 1, '2023-03-18 22:55:55', 5, '2023-03-18 23:01:28', 1);
INSERT INTO `wikiinfo` VALUES (5, '第五个wiki119', '<p>wiki HTML 内容五00</p>', 1, 2, '2023-03-19 22:55:58', 1, '2023-04-05 17:25:28', 2);
INSERT INTO `wikiinfo` VALUES (6, '第六个wiki1哦哦', '<p style=\"text-align:justify;\" size=\"0\" _root=\"undefined\" __ownerid=\"undefined\" __hash=\"undefined\" __altered=\"false\"><sup>wiki HTML 内容六88lll</sup></p><h1>hjlkm;,;&#x27;来来来</h1><p><span style=\"line-height:1.75\"><sub>09-9090-</sub><sup>89080</sup></span></p><p style=\"text-align:center;text-indent:2em;\"></p><p><span style=\"line-height:1.75\"><span style=\"text-decoration:line-through\">哦哦哦</span></span></p>', 2, 1, '2023-03-20 22:56:02', 1, '2023-04-14 20:01:36', 4);

-- ----------------------------
-- Table structure for wikiupdateinfo
-- ----------------------------
DROP TABLE IF EXISTS `wikiupdateinfo`;
CREATE TABLE `wikiupdateinfo`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `updateBy` int NULL DEFAULT NULL COMMENT '更新人',
  `updateTime` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `wikiUpdateInfo` int NULL DEFAULT NULL COMMENT '后续更新的信息ID',
  `updateContent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '更新后的内容',
  `changeContent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '变更的内容',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `WIKIUPDATEINFO_UPDATEBY_USERINFO`(`updateBy` ASC) USING BTREE,
  INDEX `WIKIUPDATEINFO_WIKIUPDATEINFO_WIKIUPDATEINFO`(`wikiUpdateInfo` ASC) USING BTREE,
  CONSTRAINT `WIKIUPDATEINFO_UPDATEBY_USERINFO` FOREIGN KEY (`updateBy`) REFERENCES `userinfo` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `WIKIUPDATEINFO_WIKIUPDATEINFO_WIKIUPDATEINFO` FOREIGN KEY (`wikiUpdateInfo`) REFERENCES `wikiupdateinfo` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wikiupdateinfo
-- ----------------------------
INSERT INTO `wikiupdateinfo` VALUES (1, 1, '2023-03-19 22:56:24', NULL, '更新内容一', '改变内容一');
INSERT INTO `wikiupdateinfo` VALUES (2, 2, '2023-03-18 22:57:03', NULL, '更新内容二', '改变内容二');
INSERT INTO `wikiupdateinfo` VALUES (3, 3, '2023-03-19 22:58:18', 2, '更新内容三', '改变内容三');
INSERT INTO `wikiupdateinfo` VALUES (4, 2, '2023-03-19 22:59:17', 3, '更新内容四', '改变内容四');
INSERT INTO `wikiupdateinfo` VALUES (5, 3, '2023-03-19 22:59:53', NULL, '更新内容五', '改变内容五');

SET FOREIGN_KEY_CHECKS = 1;
