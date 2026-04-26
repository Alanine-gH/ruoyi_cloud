/*
 Navicat Premium Dump SQL

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 80027 (8.0.27)
 Source Host           : localhost:3306
 Source Schema         : ry-config

 Target Server Type    : MySQL
 Target Server Version : 80027 (8.0.27)
 File Encoding         : 65001

 Date: 26/04/2026 16:07:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for config_info
-- ----------------------------
DROP TABLE IF EXISTS `config_info`;
CREATE TABLE `config_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'group_id',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  `c_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'configuration description',
  `c_use` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'configuration usage',
  `effect` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '配置生效的描述',
  `type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '配置的类型',
  `c_schema` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT '配置的模式',
  `encrypted_data_key` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '密钥',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfo_datagrouptenant`(`data_id` ASC, `group_id` ASC, `tenant_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info
-- ----------------------------
INSERT INTO `config_info` VALUES (10, 'application-dev.yml', 'DEFAULT_GROUP', 'spring:\n  autoconfigure:\n    exclude: com.alibaba.druid.spring.boot3.autoconfigure.DruidDataSourceAutoConfigure\n\n# feign 配置\nfeign:\n  sentinel:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n      min-request-size: 8192\n    response:\n      enabled: true\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \'*\'\n', '7c15e6670696b957ea14279036f8023f', '2026-04-25 08:43:11', '2026-04-25 08:43:11', NULL, '0:0:0:0:0:0:0:1', '', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '通用配置', NULL, NULL, 'yaml', NULL, '');
INSERT INTO `config_info` VALUES (11, 'ruoyi-gateway-dev.yml', 'DEFAULT_GROUP', 'spring:\n  data:\n    redis:\n      host: localhost\n      port: 6379\n      password: \n  cloud:\n    gateway:\n      server:\n        webflux:\n          discovery:\n            locator:\n              lowerCaseServiceId: true\n              enabled: true\n          routes:\n            # 认证中心\n            - id: ruoyi-auth\n              uri: lb://ruoyi-auth\n              predicates:\n                - Path=/auth/**\n              filters:\n                # 验证码处理\n                - name: CacheRequestBody\n                  args:\n                    bodyClass: java.lang.String\n                - ValidateCodeFilter\n                - StripPrefix=1\n            # 代码生成\n            - id: ruoyi-gen\n              uri: lb://ruoyi-gen\n              predicates:\n                - Path=/code/**\n              filters:\n                - StripPrefix=1\n            # 定时任务\n            - id: ruoyi-job\n              uri: lb://ruoyi-job\n              predicates:\n                - Path=/schedule/**\n              filters:\n                - StripPrefix=1\n            # 系统模块\n            - id: ruoyi-system\n              uri: lb://ruoyi-system\n              predicates:\n                - Path=/system/**\n              filters:\n                - StripPrefix=1\n            # 监控模块\n            - id: ruoyi-monitor\n              uri: lb://ruoyi-monitor\n              predicates:\n                - Path=/monitor/**\n              filters:\n                - StripPrefix=0\n            # 文件服务\n            - id: ruoyi-file\n              uri: lb://ruoyi-file\n              predicates:\n                - Path=/file/**\n              filters:\n                - StripPrefix=1\n            # 图书借阅（sdmu）\n            - id: ruoyi-book\n              uri: lb://ruoyi-book\n              predicates:\n                - Path=/book/**\n              filters:\n                - StripPrefix=0\n# 安全配置\nsecurity:\n  # 验证码\n  captcha:\n    enabled: true\n    type: math\n  # 防止XSS攻击\n  xss:\n    enabled: true\n    excludeUrls:\n      - /system/notice\n\n  # 不校验白名单\n  ignore:\n    whites:\n      - /auth/logout\n      - /auth/login\n      - /auth/register\n      - /*/v2/api-docs\n      - /*/v3/api-docs\n      - /csrf\n      - /monitor/minio/**\n# springdoc配置\nspringdoc:\n  webjars:\n    # 访问前缀\n    prefix:', 'ba41e923504822766b3779edac82e19f', '2026-04-25 08:43:11', '2026-04-26 07:42:42', NULL, '0:0:0:0:0:0:0:1', '', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '网关模块', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (12, 'ruoyi-auth-dev.yml', 'DEFAULT_GROUP', 'spring:\n  data:\n    redis:\n      host: localhost\n      port: 6379\n      password: \n', '72565b1a725e013154ee57c8fd3045c4', '2026-04-25 08:43:11', '2026-04-25 08:43:11', NULL, '0:0:0:0:0:0:0:1', '', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '认证中心', NULL, NULL, 'yaml', NULL, '');
INSERT INTO `config_info` VALUES (13, 'ruoyi-monitor-dev.yml', 'DEFAULT_GROUP', '# spring\nspring:\n  security:\n    user:\n      name: ruoyi\n      password: 123456\n  boot:\n    admin:\n      ui:\n        title: 若依服务状态监控\n# Minio配置\nminio:\n  # 服务器地址\n  endpoint: http://localhost\n  # API端口\n  port: 9000\n  # 访问密钥\n  accessKey: minioadmin\n  # 秘密密钥\n  secretKey: minioadmin\n  # 是否开启安全连接（HTTPS）\n  secure: false\n  # 存储桶名称\n  bucketName: \"ruoyi\"\n  # 下载目录\n  downloadDir: \"/data/images\"', '241b4a34e69921a58b633936c32a9bf7', '2026-04-25 08:43:11', '2026-04-26 07:02:34', NULL, '0:0:0:0:0:0:0:1', '', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '监控中心', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (14, 'ruoyi-system-dev.yml', 'DEFAULT_GROUP', '# spring配置\nspring:\n  data:\n    redis:\n      host: localhost\n      port: 6379\n      password: \n  datasource:\n    druid:\n      stat-view-servlet:\n        enabled: true\n        loginUsername: ruoyi\n        loginPassword: 123456\n    dynamic:\n      druid:\n        initial-size: 5\n        min-idle: 5\n        maxActive: 20\n        maxWait: 60000\n        connectTimeout: 30000\n        socketTimeout: 60000\n        timeBetweenEvictionRunsMillis: 60000\n        minEvictableIdleTimeMillis: 300000\n        validationQuery: SELECT 1 FROM DUAL\n        testWhileIdle: true\n        testOnBorrow: false\n        testOnReturn: false\n        poolPreparedStatements: true\n        maxPoolPreparedStatementPerConnectionSize: 20\n        filters: stat,slf4j\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\n      datasource:\n          # 主库数据源\n          master:\n            driver-class-name: com.mysql.cj.jdbc.Driver\n            url: jdbc:mysql://localhost:3306/ruoyi_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n            username: root\n            password: 20060214\n          # 从库数据源\n          # slave:\n            # username: \n            # password: \n            # url: \n            # driver-class-name: \n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.ruoyi.system\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# springdoc配置\nspringdoc:\n  gatewayUrl: http://localhost:8080/${spring.application.name}\n  api-docs:\n    # 是否开启接口文档\n    enabled: true\n  info:\n    # 标题\n    title: \'系统模块接口文档\'\n    # 描述\n    description: \'系统模块接口描述\'\n    # 作者信息\n    contact:\n      name: RuoYi\n      url: https://ruoyi.vip\n', '5abb4d84a5f939879c29a0e31358b4ee', '2026-04-25 08:43:11', '2026-04-25 08:43:11', NULL, '0:0:0:0:0:0:0:1', '', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '系统模块', NULL, NULL, 'yaml', NULL, '');
INSERT INTO `config_info` VALUES (15, 'ruoyi-gen-dev.yml', 'DEFAULT_GROUP', '# spring配置\nspring:\n  data:\n    redis:\n      host: localhost\n      port: 6379\n      password: \n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://localhost:3306/ruoyi_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: 20060214\n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.ruoyi.gen.domain\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# springdoc配置\nspringdoc:\n  gatewayUrl: http://localhost:8080/${spring.application.name}\n  api-docs:\n    # 是否开启接口文档\n    enabled: true\n  info:\n    # 标题\n    title: \'代码生成接口文档\'\n    # 描述\n    description: \'代码生成接口描述\'\n    # 作者信息\n    contact:\n      name: RuoYi\n      url: https://ruoyi.vip\n\n# 代码生成\ngen:\n  # 作者\n  author: ruoyi\n  # 默认生成包路径 system 需改成自己的模块名称 如 system monitor tool\n  packageName: com.ruoyi.system\n  # 自动去除表前缀，默认是false\n  autoRemovePre: false\n  # 表前缀（生成类名不会包含表前缀，多个用逗号分隔）\n  tablePrefix: sys_\n  # 是否允许生成文件覆盖到本地（自定义路径），默认不允许\n  allowOverwrite: true', '4605111ea5b75412e5a815a43faa1d74', '2026-04-25 08:43:11', '2026-04-26 03:50:21', NULL, '0:0:0:0:0:0:0:1', '', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '代码生成', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (16, 'ruoyi-job-dev.yml', 'DEFAULT_GROUP', '# spring配置\nspring:\n  data:\n    redis:\n      host: localhost\n      port: 6379\n      password: \n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://localhost:3306/ruoyi_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: 20060214\n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.ruoyi.job.domain\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# springdoc配置\nspringdoc:\n  gatewayUrl: http://localhost:8080/${spring.application.name}\n  api-docs:\n    # 是否开启接口文档\n    enabled: true\n  info:\n    # 标题\n    title: \'定时任务接口文档\'\n    # 描述\n    description: \'定时任务接口描述\'\n    # 作者信息\n    contact:\n      name: RuoYi\n      url: https://ruoyi.vip\n', 'd4a7d9580590916ed07ab28486e2482f', '2026-04-25 08:43:11', '2026-04-25 08:43:11', NULL, '0:0:0:0:0:0:0:1', '', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '定时任务', NULL, NULL, 'yaml', NULL, '');
INSERT INTO `config_info` VALUES (17, 'ruoyi-file-dev.yml', 'DEFAULT_GROUP', '# 本地文件上传    \nfile:\n    domain: http://127.0.0.1:9300\n    path: D:/ruoyi/uploadPath\n    prefix: /statics\n\n# FastDFS配置\nfdfs:\n  domain: http://127.0.0.1\n  soTimeout: 3000\n  connectTimeout: 2000\n  trackerList: 127.0.0.1:22122\n\n# Minio配置\nminio:\n  url: http://127.0.0.1:9000\n  accessKey: minioadmin\n  secretKey: minioadmin\n  bucketName: ruoyi\n\n  # 防盗链配置\nreferer:\n  # 防盗链开关\n  enabled: false\n  # 允许的域名列表\n  allowed-domains: localhost,127.0.0.1,ruoyi.vip,www.ruoyi.vip\n', '096dc6eeb54660f7d188ede1d7eac1bc', '2026-04-25 08:43:11', '2026-04-25 09:00:02', NULL, '0:0:0:0:0:0:0:1', '', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '文件服务', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (18, 'sentinel-ruoyi-gateway', 'DEFAULT_GROUP', '[\r\n    {\r\n        \"resource\": \"ruoyi-auth\",\r\n        \"count\": 500,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"ruoyi-system\",\r\n        \"count\": 1000,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"ruoyi-gen\",\r\n        \"count\": 200,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"ruoyi-job\",\r\n        \"count\": 300,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    }\r\n]', '9f3a3069261598f74220bc47958ec252', '2026-04-25 08:43:11', '2026-04-25 08:43:11', NULL, '0:0:0:0:0:0:0:1', '', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '限流策略', NULL, NULL, 'json', NULL, '');
INSERT INTO `config_info` VALUES (19, 'ruoyi-book-dev.yml', 'DEFAULT_GROUP', '# spring配置\nspring:\n  data:\n    redis:\n      host: localhost\n      port: 6379\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://localhost:3306/ruoyi_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: 20060214\n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.ruoyi.book.domain\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\nminio:\n  # 服务器地址\n  endpoint: http://localhost\n  # API端口\n  port: 9000\n  # 访问密钥\n  accessKey: minioadmin\n  # 秘密密钥\n  secretKey: minioadmin\n  # 是否开启安全连接（HTTPS）\n  secure: false\n  # 存储桶名称\n  bucketName: \"ruoyi\"\n  # 下载目录\n  downloadDir: \"/data/images\"', 'bf05cf367589e5f851ad809be29604dd', '2026-04-26 06:22:37', '2026-04-26 07:09:49', NULL, '0:0:0:0:0:0:0:1', '', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '', '', '', 'yaml', '', '');

-- ----------------------------
-- Table structure for config_info_aggr
-- ----------------------------
DROP TABLE IF EXISTS `config_info_aggr`;
CREATE TABLE `config_info_aggr`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `datum_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'datum_id',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '内容',
  `gmt_modified` datetime NOT NULL COMMENT '修改时间',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfoaggr_datagrouptenantdatum`(`data_id` ASC, `group_id` ASC, `tenant_id` ASC, `datum_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '增加租户字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info_aggr
-- ----------------------------

-- ----------------------------
-- Table structure for config_info_beta
-- ----------------------------
DROP TABLE IF EXISTS `config_info_beta`;
CREATE TABLE `config_info_beta`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `beta_ips` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'betaIps',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  `encrypted_data_key` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '密钥',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfobeta_datagrouptenant`(`data_id` ASC, `group_id` ASC, `tenant_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_beta' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info_beta
-- ----------------------------

-- ----------------------------
-- Table structure for config_info_gray
-- ----------------------------
DROP TABLE IF EXISTS `config_info_gray`;
CREATE TABLE `config_info_gray`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'group_id',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'md5',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'src_user',
  `src_ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'src_ip',
  `gmt_create` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT 'gmt_create',
  `gmt_modified` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT 'gmt_modified',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'app_name',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'tenant_id',
  `gray_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'gray_name',
  `gray_rule` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'gray_rule',
  `encrypted_data_key` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'encrypted_data_key',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfogray_datagrouptenantgray`(`data_id` ASC, `group_id` ASC, `tenant_id` ASC, `gray_name` ASC) USING BTREE,
  INDEX `idx_dataid_gmt_modified`(`data_id` ASC, `gmt_modified` ASC) USING BTREE,
  INDEX `idx_gmt_modified`(`gmt_modified` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'config_info_gray' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info_gray
-- ----------------------------

-- ----------------------------
-- Table structure for config_info_tag
-- ----------------------------
DROP TABLE IF EXISTS `config_info_tag`;
CREATE TABLE `config_info_tag`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `tag_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfotag_datagrouptenanttag`(`data_id` ASC, `group_id` ASC, `tenant_id` ASC, `tag_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_tag' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info_tag
-- ----------------------------

-- ----------------------------
-- Table structure for config_tags_relation
-- ----------------------------
DROP TABLE IF EXISTS `config_tags_relation`;
CREATE TABLE `config_tags_relation`  (
  `id` bigint NOT NULL COMMENT 'id',
  `tag_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_name',
  `tag_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tag_type',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `nid` bigint NOT NULL AUTO_INCREMENT COMMENT 'nid, 自增长标识',
  PRIMARY KEY (`nid`) USING BTREE,
  UNIQUE INDEX `uk_configtagrelation_configidtag`(`id` ASC, `tag_name` ASC, `tag_type` ASC) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_tag_relation' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_tags_relation
-- ----------------------------

-- ----------------------------
-- Table structure for group_capacity
-- ----------------------------
DROP TABLE IF EXISTS `group_capacity`;
CREATE TABLE `group_capacity`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
  `quota` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
  `usage` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
  `max_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数，，0表示使用默认值',
  `max_aggr_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_group_id`(`group_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '集群、各Group容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of group_capacity
-- ----------------------------

-- ----------------------------
-- Table structure for his_config_info
-- ----------------------------
DROP TABLE IF EXISTS `his_config_info`;
CREATE TABLE `his_config_info`  (
  `id` bigint UNSIGNED NOT NULL COMMENT 'id',
  `nid` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'nid, 自增标识',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  `op_type` char(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'operation type',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  `encrypted_data_key` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '密钥',
  `publish_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT 'formal' COMMENT 'publish type gray or formal',
  `gray_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'gray name',
  `ext_info` longtext CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'ext info',
  PRIMARY KEY (`nid`) USING BTREE,
  INDEX `idx_gmt_create`(`gmt_create` ASC) USING BTREE,
  INDEX `idx_gmt_modified`(`gmt_modified` ASC) USING BTREE,
  INDEX `idx_did`(`data_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '多租户改造' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of his_config_info
-- ----------------------------
INSERT INTO `his_config_info` VALUES (5, 1, 'ruoyi-system-dev.yml', 'DEFAULT_GROUP', '', '# spring配置\nspring:\n  data:\n    redis:\n      host: localhost\n      port: 6379\n      password: \n  datasource:\n    druid:\n      stat-view-servlet:\n        enabled: true\n        loginUsername: ruoyi\n        loginPassword: 123456\n    dynamic:\n      druid:\n        initial-size: 5\n        min-idle: 5\n        maxActive: 20\n        maxWait: 60000\n        connectTimeout: 30000\n        socketTimeout: 60000\n        timeBetweenEvictionRunsMillis: 60000\n        minEvictableIdleTimeMillis: 300000\n        validationQuery: SELECT 1 FROM DUAL\n        testWhileIdle: true\n        testOnBorrow: false\n        testOnReturn: false\n        poolPreparedStatements: true\n        maxPoolPreparedStatementPerConnectionSize: 20\n        filters: stat,slf4j\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\n      datasource:\n          # 主库数据源\n          master:\n            driver-class-name: com.mysql.cj.jdbc.Driver\n            url: jdbc:mysql://localhost:3306/ry-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n            username: root\n            password: password\n          # 从库数据源\n          # slave:\n            # username: \n            # password: \n            # url: \n            # driver-class-name: \n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.ruoyi.system\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# springdoc配置\nspringdoc:\n  gatewayUrl: http://localhost:8080/${spring.application.name}\n  api-docs:\n    # 是否开启接口文档\n    enabled: true\n  info:\n    # 标题\n    title: \'系统模块接口文档\'\n    # 描述\n    description: \'系统模块接口描述\'\n    # 作者信息\n    contact:\n      name: RuoYi\n      url: https://ruoyi.vip\n', 'a79ae256018abb7f3bbaba923baeb6af', '2026-04-25 16:03:52', '2026-04-25 08:03:53', NULL, '0:0:0:0:0:0:0:1', 'U', '', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (6, 2, 'ruoyi-gen-dev.yml', 'DEFAULT_GROUP', '', '# spring配置\nspring:\n  data:\n    redis:\n      host: localhost\n      port: 6379\n      password: \n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://localhost:3306/ry-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: password\n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.ruoyi.gen.domain\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# springdoc配置\nspringdoc:\n  gatewayUrl: http://localhost:8080/${spring.application.name}\n  api-docs:\n    # 是否开启接口文档\n    enabled: true\n  info:\n    # 标题\n    title: \'代码生成接口文档\'\n    # 描述\n    description: \'代码生成接口描述\'\n    # 作者信息\n    contact:\n      name: RuoYi\n      url: https://ruoyi.vip\n\n# 代码生成\ngen:\n  # 作者\n  author: ruoyi\n  # 默认生成包路径 system 需改成自己的模块名称 如 system monitor tool\n  packageName: com.ruoyi.system\n  # 自动去除表前缀，默认是false\n  autoRemovePre: false\n  # 表前缀（生成类名不会包含表前缀，多个用逗号分隔）\n  tablePrefix: sys_\n  # 是否允许生成文件覆盖到本地（自定义路径），默认不允许\n  allowOverwrite: false', '669b20230daf5b2eddda1c87a1e755d7', '2026-04-25 16:04:30', '2026-04-25 08:04:31', NULL, '0:0:0:0:0:0:0:1', 'U', '', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (7, 3, 'ruoyi-job-dev.yml', 'DEFAULT_GROUP', '', '# spring配置\nspring:\n  data:\n    redis:\n      host: localhost\n      port: 6379\n      password: \n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://localhost:3306/ry-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: password\n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.ruoyi.job.domain\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# springdoc配置\nspringdoc:\n  gatewayUrl: http://localhost:8080/${spring.application.name}\n  api-docs:\n    # 是否开启接口文档\n    enabled: true\n  info:\n    # 标题\n    title: \'定时任务接口文档\'\n    # 描述\n    description: \'定时任务接口描述\'\n    # 作者信息\n    contact:\n      name: RuoYi\n      url: https://ruoyi.vip\n', '225445e638148dbcbadda8d9774ce3fd', '2026-04-25 16:04:52', '2026-04-25 08:04:52', NULL, '0:0:0:0:0:0:0:1', 'U', '', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (5, 4, 'ruoyi-system-dev.yml', 'DEFAULT_GROUP', '', '# spring配置\nspring:\n  data:\n    redis:\n      host: localhost\n      port: 6379\n      password: \n  datasource:\n    druid:\n      stat-view-servlet:\n        enabled: true\n        loginUsername: ruoyi_cloud\n        loginPassword: 20060214\n    dynamic:\n      druid:\n        initial-size: 5\n        min-idle: 5\n        maxActive: 20\n        maxWait: 60000\n        connectTimeout: 30000\n        socketTimeout: 60000\n        timeBetweenEvictionRunsMillis: 60000\n        minEvictableIdleTimeMillis: 300000\n        validationQuery: SELECT 1 FROM DUAL\n        testWhileIdle: true\n        testOnBorrow: false\n        testOnReturn: false\n        poolPreparedStatements: true\n        maxPoolPreparedStatementPerConnectionSize: 20\n        filters: stat,slf4j\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\n      datasource:\n          # 主库数据源\n          master:\n            driver-class-name: com.mysql.cj.jdbc.Driver\n            url: jdbc:mysql://localhost:3306/ry-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n            username: root\n            password: password\n          # 从库数据源\n          # slave:\n            # username: \n            # password: \n            # url: \n            # driver-class-name: \n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.ruoyi.system\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# springdoc配置\nspringdoc:\n  gatewayUrl: http://localhost:8080/${spring.application.name}\n  api-docs:\n    # 是否开启接口文档\n    enabled: true\n  info:\n    # 标题\n    title: \'系统模块接口文档\'\n    # 描述\n    description: \'系统模块接口描述\'\n    # 作者信息\n    contact:\n      name: RuoYi\n      url: https://ruoyi.vip\n', 'd9893d167ab9edd608353e936ec38ac2', '2026-04-25 16:22:36', '2026-04-25 08:22:36', NULL, '0:0:0:0:0:0:0:1', 'U', '', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (5, 5, 'ruoyi-system-dev.yml', 'DEFAULT_GROUP', '', '# spring配置\nspring:\n  data:\n    redis:\n      host: localhost\n      port: 6379\n      password: \n  datasource:\n    druid:\n      stat-view-servlet:\n        enabled: true\n        loginUsername: ruoyi\n        loginPassword: 123456\n    dynamic:\n      druid:\n        initial-size: 5\n        min-idle: 5\n        maxActive: 20\n        maxWait: 60000\n        connectTimeout: 30000\n        socketTimeout: 60000\n        timeBetweenEvictionRunsMillis: 60000\n        minEvictableIdleTimeMillis: 300000\n        validationQuery: SELECT 1 FROM DUAL\n        testWhileIdle: true\n        testOnBorrow: false\n        testOnReturn: false\n        poolPreparedStatements: true\n        maxPoolPreparedStatementPerConnectionSize: 20\n        filters: stat,slf4j\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\n      datasource:\n          # 主库数据源\n          master:\n            driver-class-name: com.mysql.cj.jdbc.Driver\n            url: jdbc:mysql://localhost:3306/ruoyi-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n            username: root\n            password: 20060214\n          # 从库数据源\n          # slave:\n            # username: \n            # password: \n            # url: \n            # driver-class-name: \n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.ruoyi.system\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# springdoc配置\nspringdoc:\n  gatewayUrl: http://localhost:8080/${spring.application.name}\n  api-docs:\n    # 是否开启接口文档\n    enabled: true\n  info:\n    # 标题\n    title: \'系统模块接口文档\'\n    # 描述\n    description: \'系统模块接口描述\'\n    # 作者信息\n    contact:\n      name: RuoYi\n      url: https://ruoyi.vip\n', 'b97d893f6f3e2cc90fbaf8cf6411c4d0', '2026-04-25 16:32:08', '2026-04-25 08:32:09', NULL, '0:0:0:0:0:0:0:1', 'U', '', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (6, 6, 'ruoyi-gen-dev.yml', 'DEFAULT_GROUP', '', '# spring配置\nspring:\n  data:\n    redis:\n      host: localhost\n      port: 6379\n      password: \n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://localhost:3306/ruoyi_-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: 20060214\n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.ruoyi.gen.domain\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# springdoc配置\nspringdoc:\n  gatewayUrl: http://localhost:8080/${spring.application.name}\n  api-docs:\n    # 是否开启接口文档\n    enabled: true\n  info:\n    # 标题\n    title: \'代码生成接口文档\'\n    # 描述\n    description: \'代码生成接口描述\'\n    # 作者信息\n    contact:\n      name: RuoYi\n      url: https://ruoyi.vip\n\n# 代码生成\ngen:\n  # 作者\n  author: ruoyi\n  # 默认生成包路径 system 需改成自己的模块名称 如 system monitor tool\n  packageName: com.ruoyi.system\n  # 自动去除表前缀，默认是false\n  autoRemovePre: false\n  # 表前缀（生成类名不会包含表前缀，多个用逗号分隔）\n  tablePrefix: sys_\n  # 是否允许生成文件覆盖到本地（自定义路径），默认不允许\n  allowOverwrite: false', '43193e49c1aebb0e0236838c0adb38e3', '2026-04-25 16:32:35', '2026-04-25 08:32:36', NULL, '0:0:0:0:0:0:0:1', 'U', '', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (7, 7, 'ruoyi-job-dev.yml', 'DEFAULT_GROUP', '', '# spring配置\nspring:\n  data:\n    redis:\n      host: localhost\n      port: 6379\n      password: \n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://localhost:3306/ruoyi_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: 20060214\n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.ruoyi.job.domain\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# springdoc配置\nspringdoc:\n  gatewayUrl: http://localhost:8080/${spring.application.name}\n  api-docs:\n    # 是否开启接口文档\n    enabled: true\n  info:\n    # 标题\n    title: \'定时任务接口文档\'\n    # 描述\n    description: \'定时任务接口描述\'\n    # 作者信息\n    contact:\n      name: RuoYi\n      url: https://ruoyi.vip\n', 'd4a7d9580590916ed07ab28486e2482f', '2026-04-25 16:32:55', '2026-04-25 08:32:56', NULL, '0:0:0:0:0:0:0:1', 'U', '', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (6, 8, 'ruoyi-gen-dev.yml', 'DEFAULT_GROUP', '', '# spring配置\nspring:\n  data:\n    redis:\n      host: localhost\n      port: 6379\n      password: \n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://localhost:3306/ruoyi_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: 20060214\n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.ruoyi.gen.domain\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# springdoc配置\nspringdoc:\n  gatewayUrl: http://localhost:8080/${spring.application.name}\n  api-docs:\n    # 是否开启接口文档\n    enabled: true\n  info:\n    # 标题\n    title: \'代码生成接口文档\'\n    # 描述\n    description: \'代码生成接口描述\'\n    # 作者信息\n    contact:\n      name: RuoYi\n      url: https://ruoyi.vip\n\n# 代码生成\ngen:\n  # 作者\n  author: ruoyi\n  # 默认生成包路径 system 需改成自己的模块名称 如 system monitor tool\n  packageName: com.ruoyi.system\n  # 自动去除表前缀，默认是false\n  autoRemovePre: false\n  # 表前缀（生成类名不会包含表前缀，多个用逗号分隔）\n  tablePrefix: sys_\n  # 是否允许生成文件覆盖到本地（自定义路径），默认不允许\n  allowOverwrite: false', 'd2e25bae29db96724b241669dd76fb2a', '2026-04-25 16:34:09', '2026-04-25 08:34:09', NULL, '0:0:0:0:0:0:0:1', 'U', '', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (0, 9, 'application-dev.yml', 'DEFAULT_GROUP', '', 'spring:\n  autoconfigure:\n    exclude: com.alibaba.druid.spring.boot3.autoconfigure.DruidDataSourceAutoConfigure\n\n# feign 配置\nfeign:\n  sentinel:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n      min-request-size: 8192\n    response:\n      enabled: true\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \'*\'\n', '7c15e6670696b957ea14279036f8023f', '2026-04-25 16:43:10', '2026-04-25 08:43:11', NULL, '0:0:0:0:0:0:0:1', 'I', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (0, 10, 'ruoyi-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\n  data:\n    redis:\n      host: localhost\n      port: 6379\n      password: \n  cloud:\n    gateway:\n      server:\n        webflux:\n          discovery:\n            locator:\n              lowerCaseServiceId: true\n              enabled: true\n          routes:\n            # 认证中心\n            - id: ruoyi-auth\n              uri: lb://ruoyi-auth\n              predicates:\n                - Path=/auth/**\n              filters:\n                # 验证码处理\n                - name: CacheRequestBody\n                  args:\n                    bodyClass: java.lang.String\n                - ValidateCodeFilter\n                - StripPrefix=1\n            # 代码生成\n            - id: ruoyi-gen\n              uri: lb://ruoyi-gen\n              predicates:\n                - Path=/code/**\n              filters:\n                - StripPrefix=1\n            # 定时任务\n            - id: ruoyi-job\n              uri: lb://ruoyi-job\n              predicates:\n                - Path=/schedule/**\n              filters:\n                - StripPrefix=1\n            # 系统模块\n            - id: ruoyi-system\n              uri: lb://ruoyi-system\n              predicates:\n                - Path=/system/**\n              filters:\n                - StripPrefix=1\n            # 文件服务\n            - id: ruoyi-file\n              uri: lb://ruoyi-file\n              predicates:\n                - Path=/file/**\n              filters:\n                - StripPrefix=1\n\n# 安全配置\nsecurity:\n  # 验证码\n  captcha:\n    enabled: true\n    type: math\n  # 防止XSS攻击\n  xss:\n    enabled: true\n    excludeUrls:\n      - /system/notice\n\n  # 不校验白名单\n  ignore:\n    whites:\n      - /auth/logout\n      - /auth/login\n      - /auth/register\n      - /*/v2/api-docs\n      - /*/v3/api-docs\n      - /csrf\n\n# springdoc配置\nspringdoc:\n  webjars:\n    # 访问前缀\n    prefix:\n', '963ed2db976e824318409819085512d1', '2026-04-25 16:43:10', '2026-04-25 08:43:11', NULL, '0:0:0:0:0:0:0:1', 'I', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (0, 11, 'ruoyi-auth-dev.yml', 'DEFAULT_GROUP', '', 'spring:\n  data:\n    redis:\n      host: localhost\n      port: 6379\n      password: \n', '72565b1a725e013154ee57c8fd3045c4', '2026-04-25 16:43:10', '2026-04-25 08:43:11', NULL, '0:0:0:0:0:0:0:1', 'I', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (0, 12, 'ruoyi-monitor-dev.yml', 'DEFAULT_GROUP', '', '# spring\nspring:\n  security:\n    user:\n      name: ruoyi\n      password: 123456\n  boot:\n    admin:\n      ui:\n        title: 若依服务状态监控\n', '6f122fd2bfb8d45f858e7d6529a9cd44', '2026-04-25 16:43:10', '2026-04-25 08:43:11', NULL, '0:0:0:0:0:0:0:1', 'I', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (0, 13, 'ruoyi-system-dev.yml', 'DEFAULT_GROUP', '', '# spring配置\nspring:\n  data:\n    redis:\n      host: localhost\n      port: 6379\n      password: \n  datasource:\n    druid:\n      stat-view-servlet:\n        enabled: true\n        loginUsername: ruoyi\n        loginPassword: 123456\n    dynamic:\n      druid:\n        initial-size: 5\n        min-idle: 5\n        maxActive: 20\n        maxWait: 60000\n        connectTimeout: 30000\n        socketTimeout: 60000\n        timeBetweenEvictionRunsMillis: 60000\n        minEvictableIdleTimeMillis: 300000\n        validationQuery: SELECT 1 FROM DUAL\n        testWhileIdle: true\n        testOnBorrow: false\n        testOnReturn: false\n        poolPreparedStatements: true\n        maxPoolPreparedStatementPerConnectionSize: 20\n        filters: stat,slf4j\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\n      datasource:\n          # 主库数据源\n          master:\n            driver-class-name: com.mysql.cj.jdbc.Driver\n            url: jdbc:mysql://localhost:3306/ruoyi_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n            username: root\n            password: 20060214\n          # 从库数据源\n          # slave:\n            # username: \n            # password: \n            # url: \n            # driver-class-name: \n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.ruoyi.system\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# springdoc配置\nspringdoc:\n  gatewayUrl: http://localhost:8080/${spring.application.name}\n  api-docs:\n    # 是否开启接口文档\n    enabled: true\n  info:\n    # 标题\n    title: \'系统模块接口文档\'\n    # 描述\n    description: \'系统模块接口描述\'\n    # 作者信息\n    contact:\n      name: RuoYi\n      url: https://ruoyi.vip\n', '5abb4d84a5f939879c29a0e31358b4ee', '2026-04-25 16:43:10', '2026-04-25 08:43:11', NULL, '0:0:0:0:0:0:0:1', 'I', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (0, 14, 'ruoyi-gen-dev.yml', 'DEFAULT_GROUP', '', '# spring配置\nspring:\n  data:\n    redis:\n      host: localhost\n      port: 6379\n      password: \n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://localhost:3306/ruoyi_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: 20060214\n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.ruoyi.gen.domain\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# springdoc配置\nspringdoc:\n  gatewayUrl: http://localhost:8080/${spring.application.name}\n  api-docs:\n    # 是否开启接口文档\n    enabled: true\n  info:\n    # 标题\n    title: \'代码生成接口文档\'\n    # 描述\n    description: \'代码生成接口描述\'\n    # 作者信息\n    contact:\n      name: RuoYi\n      url: https://ruoyi.vip\n\n# 代码生成\ngen:\n  # 作者\n  author: ruoyi\n  # 默认生成包路径 system 需改成自己的模块名称 如 system monitor tool\n  packageName: com.ruoyi.system\n  # 自动去除表前缀，默认是false\n  autoRemovePre: false\n  # 表前缀（生成类名不会包含表前缀，多个用逗号分隔）\n  tablePrefix: sys_\n  # 是否允许生成文件覆盖到本地（自定义路径），默认不允许\n  allowOverwrite: false', 'd2e25bae29db96724b241669dd76fb2a', '2026-04-25 16:43:10', '2026-04-25 08:43:11', NULL, '0:0:0:0:0:0:0:1', 'I', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (0, 15, 'ruoyi-job-dev.yml', 'DEFAULT_GROUP', '', '# spring配置\nspring:\n  data:\n    redis:\n      host: localhost\n      port: 6379\n      password: \n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://localhost:3306/ruoyi_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: 20060214\n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.ruoyi.job.domain\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# springdoc配置\nspringdoc:\n  gatewayUrl: http://localhost:8080/${spring.application.name}\n  api-docs:\n    # 是否开启接口文档\n    enabled: true\n  info:\n    # 标题\n    title: \'定时任务接口文档\'\n    # 描述\n    description: \'定时任务接口描述\'\n    # 作者信息\n    contact:\n      name: RuoYi\n      url: https://ruoyi.vip\n', 'd4a7d9580590916ed07ab28486e2482f', '2026-04-25 16:43:10', '2026-04-25 08:43:11', NULL, '0:0:0:0:0:0:0:1', 'I', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (0, 16, 'ruoyi-file-dev.yml', 'DEFAULT_GROUP', '', '# 本地文件上传    \nfile:\n    domain: http://127.0.0.1:9300\n    path: D:/ruoyi/uploadPath\n    prefix: /statics\n\n# FastDFS配置\nfdfs:\n  domain: http://127.0.0.1\n  soTimeout: 3000\n  connectTimeout: 2000\n  trackerList: 127.0.0.1:22122\n\n# Minio配置\nminio:\n  url: http://127.0.0.1:9000\n  accessKey: minioadmin\n  secretKey: minioadmin\n  bucketName: test\n\n  # 防盗链配置\nreferer:\n  # 防盗链开关\n  enabled: false\n  # 允许的域名列表\n  allowed-domains: localhost,127.0.0.1,ruoyi.vip,www.ruoyi.vip\n', '7c2b947798cbb9e3bd47412762aefd88', '2026-04-25 16:43:10', '2026-04-25 08:43:11', NULL, '0:0:0:0:0:0:0:1', 'I', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (0, 17, 'sentinel-ruoyi-gateway', 'DEFAULT_GROUP', '', '[\r\n    {\r\n        \"resource\": \"ruoyi-auth\",\r\n        \"count\": 500,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"ruoyi-system\",\r\n        \"count\": 1000,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"ruoyi-gen\",\r\n        \"count\": 200,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"ruoyi-job\",\r\n        \"count\": 300,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    }\r\n]', '9f3a3069261598f74220bc47958ec252', '2026-04-25 16:43:10', '2026-04-25 08:43:11', NULL, '0:0:0:0:0:0:0:1', 'I', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (17, 18, 'ruoyi-file-dev.yml', 'DEFAULT_GROUP', '', '# 本地文件上传    \nfile:\n    domain: http://127.0.0.1:9300\n    path: D:/ruoyi/uploadPath\n    prefix: /statics\n\n# FastDFS配置\nfdfs:\n  domain: http://127.0.0.1\n  soTimeout: 3000\n  connectTimeout: 2000\n  trackerList: 127.0.0.1:22122\n\n# Minio配置\nminio:\n  url: http://127.0.0.1:9000\n  accessKey: minioadmin\n  secretKey: minioadmin\n  bucketName: test\n\n  # 防盗链配置\nreferer:\n  # 防盗链开关\n  enabled: false\n  # 允许的域名列表\n  allowed-domains: localhost,127.0.0.1,ruoyi.vip,www.ruoyi.vip\n', '7c2b947798cbb9e3bd47412762aefd88', '2026-04-25 17:00:02', '2026-04-25 09:00:02', NULL, '0:0:0:0:0:0:0:1', 'U', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (11, 19, 'ruoyi-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\n  data:\n    redis:\n      host: localhost\n      port: 6379\n      password: \n  cloud:\n    gateway:\n      server:\n        webflux:\n          discovery:\n            locator:\n              lowerCaseServiceId: true\n              enabled: true\n          routes:\n            # 认证中心\n            - id: ruoyi-auth\n              uri: lb://ruoyi-auth\n              predicates:\n                - Path=/auth/**\n              filters:\n                # 验证码处理\n                - name: CacheRequestBody\n                  args:\n                    bodyClass: java.lang.String\n                - ValidateCodeFilter\n                - StripPrefix=1\n            # 代码生成\n            - id: ruoyi-gen\n              uri: lb://ruoyi-gen\n              predicates:\n                - Path=/code/**\n              filters:\n                - StripPrefix=1\n            # 定时任务\n            - id: ruoyi-job\n              uri: lb://ruoyi-job\n              predicates:\n                - Path=/schedule/**\n              filters:\n                - StripPrefix=1\n            # 系统模块\n            - id: ruoyi-system\n              uri: lb://ruoyi-system\n              predicates:\n                - Path=/system/**\n              filters:\n                - StripPrefix=1\n            # 文件服务\n            - id: ruoyi-file\n              uri: lb://ruoyi-file\n              predicates:\n                - Path=/file/**\n              filters:\n                - StripPrefix=1\n\n# 安全配置\nsecurity:\n  # 验证码\n  captcha:\n    enabled: true\n    type: math\n  # 防止XSS攻击\n  xss:\n    enabled: true\n    excludeUrls:\n      - /system/notice\n\n  # 不校验白名单\n  ignore:\n    whites:\n      - /auth/logout\n      - /auth/login\n      - /auth/register\n      - /*/v2/api-docs\n      - /*/v3/api-docs\n      - /csrf\n\n# springdoc配置\nspringdoc:\n  webjars:\n    # 访问前缀\n    prefix:\n', '963ed2db976e824318409819085512d1', '2026-04-26 00:24:34', '2026-04-25 16:24:34', NULL, '0:0:0:0:0:0:0:1', 'U', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (11, 20, 'ruoyi-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\n  data:\n    redis:\n      host: localhost\n      port: 6379\n      password: \n  cloud:\n    gateway:\n      server:\n        webflux:\n          discovery:\n            locator:\n              lowerCaseServiceId: true\n              enabled: true\n          routes:\n            # 认证中心\n            - id: ruoyi-auth\n              uri: lb://ruoyi-auth\n              predicates:\n                - Path=/auth/**\n              filters:\n                # 验证码处理\n                - name: CacheRequestBody\n                  args:\n                    bodyClass: java.lang.String\n                - ValidateCodeFilter\n                - StripPrefix=1\n            # 代码生成\n            - id: ruoyi-gen\n              uri: lb://ruoyi-gen\n              predicates:\n                - Path=/code/**\n              filters:\n                - StripPrefix=1\n            # 定时任务\n            - id: ruoyi-job\n              uri: lb://ruoyi-job\n              predicates:\n                - Path=/schedule/**\n              filters:\n                - StripPrefix=1\n            # 系统模块\n            - id: ruoyi-system\n              uri: lb://ruoyi-system\n              predicates:\n                - Path=/system/**\n              filters:\n                - StripPrefix=1\n            # 监控模块\n            - id: ruoyi-monitor\n              uri: lb://ruoyi-monitor\n              predicates:\n                - Path=/monitor/**\n              filters:\n                - StripPrefix=0\n            # 文件服务\n            - id: ruoyi-file\n              uri: lb://ruoyi-file\n              predicates:\n                - Path=/file/**\n              filters:\n                - StripPrefix=1\n\n# 安全配置\nsecurity:\n  # 验证码\n  captcha:\n    enabled: true\n    type: math\n  # 防止XSS攻击\n  xss:\n    enabled: true\n    excludeUrls:\n      - /system/notice\n\n  # 不校验白名单\n  ignore:\n    whites:\n      - /auth/logout\n      - /auth/login\n      - /auth/register\n      - /*/v2/api-docs\n      - /*/v3/api-docs\n      - /csrf\n\n# springdoc配置\nspringdoc:\n  webjars:\n    # 访问前缀\n    prefix:', 'fb3339f00555770b2a80c2192a750efd', '2026-04-26 00:29:50', '2026-04-25 16:29:50', NULL, '0:0:0:0:0:0:0:1', 'U', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (13, 21, 'ruoyi-monitor-dev.yml', 'DEFAULT_GROUP', '', '# spring\nspring:\n  security:\n    user:\n      name: ruoyi\n      password: 123456\n  boot:\n    admin:\n      ui:\n        title: 若依服务状态监控\n', '6f122fd2bfb8d45f858e7d6529a9cd44', '2026-04-26 10:33:19', '2026-04-26 02:33:19', NULL, '0:0:0:0:0:0:0:1', 'U', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (13, 22, 'ruoyi-monitor-dev.yml', 'DEFAULT_GROUP', '', '# spring\nspring:\n  security:\n    user:\n      name: ruoyi\n      password: 123456\n  boot:\n    admin:\n      ui:\n        title: 若依服务状态监控\nminio:\n  endpoint: http://localhost\n  port: 9000\n  accessKey: minioadmin\n  secretKey: minioadmin\n  secure: false\n  bucketName: \"ruoyi\"\n  downloadDir: \"/data/images\"', '897e91d9134a7dcb95807250c3d65b11', '2026-04-26 10:39:44', '2026-04-26 02:39:44', NULL, '0:0:0:0:0:0:0:1', 'U', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (11, 23, 'ruoyi-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\n  data:\n    redis:\n      host: localhost\n      port: 6379\n      password: \n  cloud:\n    gateway:\n      server:\n        webflux:\n          discovery:\n            locator:\n              lowerCaseServiceId: true\n              enabled: true\n          routes:\n            # 认证中心\n            - id: ruoyi-auth\n              uri: lb://ruoyi-auth\n              predicates:\n                - Path=/auth/**\n              filters:\n                # 验证码处理\n                - name: CacheRequestBody\n                  args:\n                    bodyClass: java.lang.String\n                - ValidateCodeFilter\n                - StripPrefix=1\n            # 代码生成\n            - id: ruoyi-gen\n              uri: lb://ruoyi-gen\n              predicates:\n                - Path=/code/**\n              filters:\n                - StripPrefix=1\n            # 定时任务\n            - id: ruoyi-job\n              uri: lb://ruoyi-job\n              predicates:\n                - Path=/schedule/**\n              filters:\n                - StripPrefix=1\n            # 系统模块\n            - id: ruoyi-system\n              uri: lb://ruoyi-system\n              predicates:\n                - Path=/system/**\n              filters:\n                - StripPrefix=1\n            # 监控模块\n            - id: ruoyi-monitor\n              uri: lb://ruoyi-monitor\n              predicates:\n                - Path=/monitor/**\n              filters:\n                - StripPrefix=0\n            # 文件服务\n            - id: ruoyi-file\n              uri: lb://ruoyi-file\n              predicates:\n                - Path=/file/**\n              filters:\n                - StripPrefix=1\n\n# 安全配置\nsecurity:\n  # 验证码\n  captcha:\n    enabled: true\n    type: math\n  # 防止XSS攻击\n  xss:\n    enabled: true\n    excludeUrls:\n      - /system/notice\n\n  # 不校验白名单\n  ignore:\n    whites:\n      - /auth/logout\n      - /auth/login\n      - /auth/register\n      - /*/v2/api-docs\n      - /*/v3/api-docs\n      - /csrf\n\n# springdoc配置\nspringdoc:\n  webjars:\n    # 访问前缀\n    prefix:', 'fb3339f00555770b2a80c2192a750efd', '2026-04-26 10:44:50', '2026-04-26 02:44:51', NULL, '0:0:0:0:0:0:0:1', 'U', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (15, 24, 'ruoyi-gen-dev.yml', 'DEFAULT_GROUP', '', '# spring配置\nspring:\n  data:\n    redis:\n      host: localhost\n      port: 6379\n      password: \n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://localhost:3306/ruoyi_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: 20060214\n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.ruoyi.gen.domain\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# springdoc配置\nspringdoc:\n  gatewayUrl: http://localhost:8080/${spring.application.name}\n  api-docs:\n    # 是否开启接口文档\n    enabled: true\n  info:\n    # 标题\n    title: \'代码生成接口文档\'\n    # 描述\n    description: \'代码生成接口描述\'\n    # 作者信息\n    contact:\n      name: RuoYi\n      url: https://ruoyi.vip\n\n# 代码生成\ngen:\n  # 作者\n  author: ruoyi\n  # 默认生成包路径 system 需改成自己的模块名称 如 system monitor tool\n  packageName: com.ruoyi.system\n  # 自动去除表前缀，默认是false\n  autoRemovePre: false\n  # 表前缀（生成类名不会包含表前缀，多个用逗号分隔）\n  tablePrefix: sys_\n  # 是否允许生成文件覆盖到本地（自定义路径），默认不允许\n  allowOverwrite: false', 'd2e25bae29db96724b241669dd76fb2a', '2026-04-26 11:50:21', '2026-04-26 03:50:21', NULL, '0:0:0:0:0:0:0:1', 'U', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (0, 25, 'ruoyi-book-dev.yml', 'DEFAULT_GROUP', '', 'cbc', 'ccb241b4014cfb8a2ba0da0a943ac9ff', '2026-04-26 14:22:37', '2026-04-26 06:22:37', NULL, '0:0:0:0:0:0:0:1', 'I', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (19, 26, 'ruoyi-book-dev.yml', 'DEFAULT_GROUP', '', 'cbc', 'ccb241b4014cfb8a2ba0da0a943ac9ff', '2026-04-26 14:22:54', '2026-04-26 06:22:55', NULL, '0:0:0:0:0:0:0:1', 'U', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (19, 27, 'ruoyi-book-dev.yml', 'DEFAULT_GROUP', '', 'cbc', 'ccb241b4014cfb8a2ba0da0a943ac9ff', '2026-04-26 14:34:22', '2026-04-26 06:34:23', NULL, '0:0:0:0:0:0:0:1', 'U', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (19, 28, 'ruoyi-book-dev.yml', 'DEFAULT_GROUP', '', '# spring配置\nspring:\n  data:\n    redis:\n      host: localhost\n      port: 6379\n      password: \n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://localhost:3306/ruoyi_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: 20060214\n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.ruoyi.book.domain\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# springdoc配置\nspringdoc:\n  gatewayUrl: http://localhost:8080/${spring.application.name}\n  api-docs:\n    # 是否开启接口文档\n    enabled: true\n  info:\n    # 标题\n    title: \'定时任务接口文档\'\n    # 描述\n    description: \'定时任务接口描述\'\n    # 作者信息\n    contact:\n      name: RuoYi\n      url: https://ruoyi.vip\n', 'db111e748c4b2a46460d3812200af023', '2026-04-26 15:02:15', '2026-04-26 07:02:15', NULL, '0:0:0:0:0:0:0:1', 'U', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (13, 29, 'ruoyi-monitor-dev.yml', 'DEFAULT_GROUP', '', '# spring\nspring:\n  security:\n    user:\n      name: ruoyi\n      password: 123456\n  boot:\n    admin:\n      ui:\n        title: 若依服务状态监控\n# Minio配置\nminio:\n  url: http://127.0.0.1:9000\n  accessKey: minioadmin\n  secretKey: minioadmin\n  secure: false\n  bucketName: \"ruoyi\"\n  downloadDir: \"/data/images\"', '266609a0d2f1b94add33e63a7c629f38', '2026-04-26 15:02:33', '2026-04-26 07:02:34', NULL, '0:0:0:0:0:0:0:1', 'U', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (19, 30, 'ruoyi-book-dev.yml', 'DEFAULT_GROUP', '', '# spring配置\nspring:\n  data:\n    redis:\n      host: localhost\n      port: 6379\n      password: \n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://localhost:3306/ruoyi_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: 20060214\n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.ruoyi.book.domain\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# springdoc配置\nspringdoc:\n  gatewayUrl: http://localhost:8080/${spring.application.name}\n  api-docs:\n    # 是否开启接口文档\n    enabled: true\n  info:\n    # 标题\n    title: \'定时任务接口文档\'\n    # 描述\n    description: \'定时任务接口描述\'\n    # 作者信息\n    contact:\n      name: RuoYi\n      url: https://ruoyi.vip\nminio:\n  # 服务器地址\n  endpoint: http://localhost\n  # API端口\n  port: 9000\n  # 访问密钥\n  accessKey: minioadmin\n  # 秘密密钥\n  secretKey: minioadmin\n  # 是否开启安全连接（HTTPS）\n  secure: false\n  # 存储桶名称\n  bucketName: \"ruoyi\"\n  # 下载目录\n  downloadDir: \"/data/images\"', '4d9c7d3fc449ca0b4f2e3961df9539e5', '2026-04-26 15:09:48', '2026-04-26 07:09:49', NULL, '0:0:0:0:0:0:0:1', 'U', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (11, 31, 'ruoyi-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\n  data:\n    redis:\n      host: localhost\n      port: 6379\n      password: \n  cloud:\n    gateway:\n      server:\n        webflux:\n          discovery:\n            locator:\n              lowerCaseServiceId: true\n              enabled: true\n          routes:\n            # 认证中心\n            - id: ruoyi-auth\n              uri: lb://ruoyi-auth\n              predicates:\n                - Path=/auth/**\n              filters:\n                # 验证码处理\n                - name: CacheRequestBody\n                  args:\n                    bodyClass: java.lang.String\n                - ValidateCodeFilter\n                - StripPrefix=1\n            # 代码生成\n            - id: ruoyi-gen\n              uri: lb://ruoyi-gen\n              predicates:\n                - Path=/code/**\n              filters:\n                - StripPrefix=1\n            # 定时任务\n            - id: ruoyi-job\n              uri: lb://ruoyi-job\n              predicates:\n                - Path=/schedule/**\n              filters:\n                - StripPrefix=1\n            # 系统模块\n            - id: ruoyi-system\n              uri: lb://ruoyi-system\n              predicates:\n                - Path=/system/**\n              filters:\n                - StripPrefix=1\n            # 监控模块\n            - id: ruoyi-monitor\n              uri: lb://ruoyi-monitor\n              predicates:\n                - Path=/monitor/**\n              filters:\n                - StripPrefix=0\n            # 文件服务\n            - id: ruoyi-file\n              uri: lb://ruoyi-file\n              predicates:\n                - Path=/file/**\n              filters:\n                - StripPrefix=1\n\n# 安全配置\nsecurity:\n  # 验证码\n  captcha:\n    enabled: true\n    type: math\n  # 防止XSS攻击\n  xss:\n    enabled: true\n    excludeUrls:\n      - /system/notice\n\n  # 不校验白名单\n  ignore:\n    whites:\n      - /auth/logout\n      - /auth/login\n      - /auth/register\n      - /*/v2/api-docs\n      - /*/v3/api-docs\n      - /csrf\n      - /monitor/minio/**\n# springdoc配置\nspringdoc:\n  webjars:\n    # 访问前缀\n    prefix:', '65effafb8ecf827c49e6436d1fd79374', '2026-04-26 15:35:22', '2026-04-26 07:35:22', NULL, '0:0:0:0:0:0:0:1', 'U', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '', 'formal', NULL, NULL);
INSERT INTO `his_config_info` VALUES (11, 32, 'ruoyi-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\n  data:\n    redis:\n      host: localhost\n      port: 6379\n      password: \n  cloud:\n    gateway:\n      server:\n        webflux:\n          discovery:\n            locator:\n              lowerCaseServiceId: true\n              enabled: true\n          routes:\n            # 认证中心\n            - id: ruoyi-auth\n              uri: lb://ruoyi-auth\n              predicates:\n                - Path=/auth/**\n              filters:\n                # 验证码处理\n                - name: CacheRequestBody\n                  args:\n                    bodyClass: java.lang.String\n                - ValidateCodeFilter\n                - StripPrefix=1\n            # 代码生成\n            - id: ruoyi-gen\n              uri: lb://ruoyi-gen\n              predicates:\n                - Path=/code/**\n              filters:\n                - StripPrefix=1\n            # 定时任务\n            - id: ruoyi-job\n              uri: lb://ruoyi-job\n              predicates:\n                - Path=/schedule/**\n              filters:\n                - StripPrefix=1\n            # 系统模块\n            - id: ruoyi-system\n              uri: lb://ruoyi-system\n              predicates:\n                - Path=/system/**\n              filters:\n                - StripPrefix=1\n            # 监控模块\n            - id: ruoyi-monitor\n              uri: lb://ruoyi-monitor\n              predicates:\n                - Path=/monitor/**\n              filters:\n                - StripPrefix=0\n            # 文件服务\n            - id: ruoyi-file\n              uri: lb://ruoyi-file\n              predicates:\n                - Path=/file/**\n              filters:\n                - StripPrefix=1\n            # 图书借阅（sdmu）\n            - id: ruoyi-book\n              uri: lb://ruoyi-book\n              predicates:\n                - Path=/book/**\n              filters:\n                - StripPrefix=1\n# 安全配置\nsecurity:\n  # 验证码\n  captcha:\n    enabled: true\n    type: math\n  # 防止XSS攻击\n  xss:\n    enabled: true\n    excludeUrls:\n      - /system/notice\n\n  # 不校验白名单\n  ignore:\n    whites:\n      - /auth/logout\n      - /auth/login\n      - /auth/register\n      - /*/v2/api-docs\n      - /*/v3/api-docs\n      - /csrf\n      - /monitor/minio/**\n# springdoc配置\nspringdoc:\n  webjars:\n    # 访问前缀\n    prefix:', '6cb6ed2dd56efbbe3f9e4ee17d44e0da', '2026-04-26 15:42:41', '2026-04-26 07:42:42', NULL, '0:0:0:0:0:0:0:1', 'U', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', '', 'formal', NULL, NULL);

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'role',
  `resource` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'resource',
  `action` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'action',
  UNIQUE INDEX `uk_role_permission`(`role` ASC, `resource` ASC, `action` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permissions
-- ----------------------------

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'username',
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'role',
  UNIQUE INDEX `idx_user_role`(`username` ASC, `role` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('nacos', 'ROLE_ADMIN');

-- ----------------------------
-- Table structure for tenant_capacity
-- ----------------------------
DROP TABLE IF EXISTS `tenant_capacity`;
CREATE TABLE `tenant_capacity`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Tenant ID',
  `quota` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
  `usage` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
  `max_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数',
  `max_aggr_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tenant_id`(`tenant_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '租户容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_capacity
-- ----------------------------

-- ----------------------------
-- Table structure for tenant_info
-- ----------------------------
DROP TABLE IF EXISTS `tenant_info`;
CREATE TABLE `tenant_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `kp` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'kp',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `tenant_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_name',
  `tenant_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tenant_desc',
  `create_source` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'create_source',
  `gmt_create` bigint NOT NULL COMMENT '创建时间',
  `gmt_modified` bigint NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tenant_info_kptenantid`(`kp` ASC, `tenant_id` ASC) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'tenant_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_info
-- ----------------------------
INSERT INTO `tenant_info` VALUES (1, '1', '7d149f83-f5f3-499b-96b5-fd7050fbfeae', 'ruoyi_cloud', 'ry-cloud', 'nacos', 1777105583812, 1777105583812);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'username',
  `password` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'password',
  `enabled` tinyint(1) NOT NULL COMMENT 'enabled',
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('nacos', '$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu', 1);

SET FOREIGN_KEY_CHECKS = 1;
