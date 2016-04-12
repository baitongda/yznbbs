-- phpMyAdmin SQL Dump
-- version 3.3.8.1
-- http://www.phpmyadmin.net
--
-- 主机: w.rdc.sae.sina.com.cn:3307
-- 生成日期: 2016 年 04 月 12 日 15:38
-- 服务器版本: 5.6.23
-- PHP 版本: 5.3.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `app_yznbbs`
--

-- --------------------------------------------------------

--
-- 表的结构 `yzn_action`
--

CREATE TABLE IF NOT EXISTS `yzn_action` (
  `id` tinyint(2) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` char(30) NOT NULL COMMENT '行为标识',
  `title` char(50) NOT NULL COMMENT '行为说明',
  `remark` tinytext NOT NULL COMMENT '行为描述',
  `rule` text NOT NULL COMMENT '行为规则',
  `log` text NOT NULL COMMENT '规则日志',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `yzn_action`
--

INSERT INTO `yzn_action` (`id`, `name`, `title`, `remark`, `rule`, `log`, `status`) VALUES
(1, 'add_topics', '发布文章', '积分+5，每天上限5次', 'table:member|field:score|condition:id={$self}|rule:score+5|cycle:24|max:5', '[user|get_username]在[time|time_format]发布了帖子。', 1),
(2, 'replay', '评论', '积分+1，无限制', 'table:member|field:score|condition:id={$self}|rule:score+1', '[user|get_username]在[time|time_format]回复了帖子。', 1);

-- --------------------------------------------------------

--
-- 表的结构 `yzn_action_limit`
--

CREATE TABLE IF NOT EXISTS `yzn_action_limit` (
  `id` tinyint(2) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` char(30) NOT NULL COMMENT '行为标识',
  `title` char(50) NOT NULL COMMENT '行为说明',
  `frequency` int(3) unsigned NOT NULL DEFAULT '1' COMMENT '频率',
  `time_number` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `time_unit` varchar(10) NOT NULL COMMENT '时间单位',
  `message` text NOT NULL COMMENT '提示信息',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `yzn_action_limit`
--

INSERT INTO `yzn_action_limit` (`id`, `name`, `title`, `frequency`, `time_number`, `time_unit`, `message`, `status`) VALUES
(1, 'add_topics', '论坛添加贴子', 1, 1, 'minute', '操作太频繁！1分钟后再试~', 1),
(2, 'add_reply', '论坛评论贴子', 1, 30, 'second', '操作太频繁！30秒后再试~', 1);

-- --------------------------------------------------------

--
-- 表的结构 `yzn_action_log`
--

CREATE TABLE IF NOT EXISTS `yzn_action_log` (
  `id` int(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `action_id` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '行为id',
  `user_id` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `action_ip` bigint(20) unsigned NOT NULL COMMENT '执行ip',
  `model` varchar(10) NOT NULL COMMENT '触发行为表',
  `record_id` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '触发行为id',
  `remark` text NOT NULL COMMENT '日志备注',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=102 ;

--
-- 转存表中的数据 `yzn_action_log`
--

INSERT INTO `yzn_action_log` (`id`, `action_id`, `user_id`, `action_ip`, `model`, `record_id`, `remark`, `create_time`) VALUES
(63, 2, 7, 986844098, 'reply', 139, '御宅男在2016-04-06 11:13回复了帖子。', 1459912396),
(64, 1, 7, 986844098, 'topics', 129, '御宅男在2016-04-06 16:02发布了帖子。', 1459929728),
(62, 1, 2, 986844098, 'topics', 128, 'ken678在2016-04-06 09:04发布了帖子。', 1459904674),
(61, 2, 16, 3661467490, 'reply', 138, 'zboyit在2016-04-05 18:04回复了帖子。', 1459850688),
(60, 1, 7, 986844098, 'topics', 127, '御宅男在2016-04-05 17:21发布了帖子。', 1459848062),
(59, 1, 2, 1926789558, 'topics', 126, 'ken678在2016-04-04 12:57发布了帖子。', 1459745865),
(54, 1, 2, 1926789558, 'topics', 125, 'ken678在2016-04-04 11:02发布了帖子。', 1459738973),
(55, 2, 2, 1926789558, 'reply', 134, 'ken678在2016-04-04 11:37回复了帖子。', 1459741021),
(56, 2, 2, 1926789558, 'reply', 135, 'ken678在2016-04-04 12:24回复了帖子。', 1459743853),
(57, 2, 2, 1926789558, 'reply', 136, 'ken678在2016-04-04 12:25回复了帖子。', 1459743934),
(58, 2, 2, 1926789558, 'reply', 137, 'ken678在2016-04-04 12:30回复了帖子。', 1459744204),
(65, 1, 2, 986844098, 'topics', 130, 'ken678在2016-04-08 17:00发布了帖子。', 1460106034),
(66, 1, 2, 986844098, 'topics', 131, 'ken678在2016-04-08 17:43发布了帖子。', 1460108596),
(67, 1, 2, 986844098, 'topics', 132, 'ken678在2016-04-08 17:49发布了帖子。', 1460108966),
(68, 1, 2, 986844098, 'topics', 133, 'ken678在2016-04-11 15:51发布了帖子。', 1460361063),
(69, 1, 2, 986844098, 'topics', 134, 'ken678在2016-04-11 16:04发布了帖子。', 1460361849),
(70, 1, 2, 986844098, 'topics', 135, 'ken678在2016-04-11 16:07发布了帖子。', 1460362057),
(71, 1, 2, 986844098, 'topics', 136, 'ken678在2016-04-11 16:08发布了帖子。', 1460362120),
(72, 2, 2, 986844098, 'reply', 140, 'ken678在2016-04-11 17:16回复了帖子。', 1460366204),
(73, 2, 2, 986844098, 'reply', 141, 'ken678在2016-04-11 17:16回复了帖子。', 1460366207),
(74, 2, 7, 986844098, 'reply', 142, '御宅男在2016-04-11 17:19回复了帖子。', 1460366364),
(75, 2, 2, 986844098, 'reply', 143, 'ken678在2016-04-11 17:27回复了帖子。', 1460366824),
(76, 2, 2, 986844098, 'reply', 144, 'ken678在2016-04-11 17:29回复了帖子。', 1460366951),
(77, 2, 2, 986844098, 'reply', 145, 'ken678在2016-04-11 17:30回复了帖子。', 1460367051),
(78, 2, 2, 986844098, 'reply', 146, 'ken678在2016-04-11 17:32回复了帖子。', 1460367137),
(79, 2, 2, 986844098, 'reply', 147, 'ken678在2016-04-11 17:32回复了帖子。', 1460367178),
(80, 2, 2, 986844098, 'reply', 148, 'ken678在2016-04-11 17:33回复了帖子。', 1460367198),
(81, 2, 2, 986844098, 'reply', 149, 'ken678在2016-04-11 17:33回复了帖子。', 1460367211),
(82, 2, 2, 986844098, 'reply', 150, 'ken678在2016-04-11 17:34回复了帖子。', 1460367251),
(83, 2, 2, 986844098, 'reply', 151, 'ken678在2016-04-11 17:35回复了帖子。', 1460367317),
(84, 2, 2, 986844098, 'reply', 152, 'ken678在2016-04-11 17:35回复了帖子。', 1460367346),
(85, 2, 2, 986844098, 'reply', 153, 'ken678在2016-04-11 17:36回复了帖子。', 1460367364),
(86, 2, 2, 986844098, 'reply', 154, 'ken678在2016-04-11 17:38回复了帖子。', 1460367510),
(87, 2, 2, 986844098, 'reply', 155, 'ken678在2016-04-11 17:38回复了帖子。', 1460367538),
(88, 2, 2, 986844098, 'reply', 156, 'ken678在2016-04-11 17:39回复了帖子。', 1460367544),
(89, 2, 2, 986844098, 'reply', 157, 'ken678在2016-04-11 17:39回复了帖子。', 1460367577),
(90, 2, 2, 986844098, 'reply', 158, 'ken678在2016-04-11 17:40回复了帖子。', 1460367618),
(91, 2, 2, 986844098, 'reply', 159, 'ken678在2016-04-11 17:41回复了帖子。', 1460367660),
(92, 2, 2, 986844098, 'reply', 160, 'ken678在2016-04-11 17:43回复了帖子。', 1460367839),
(93, 2, 2, 986844098, 'reply', 161, 'ken678在2016-04-11 17:46回复了帖子。', 1460367979),
(94, 2, 2, 986844098, 'reply', 162, 'ken678在2016-04-11 17:46回复了帖子。', 1460367997),
(95, 2, 2, 986844098, 'reply', 163, 'ken678在2016-04-11 17:47回复了帖子。', 1460368039),
(96, 2, 2, 986844098, 'reply', 164, 'ken678在2016-04-11 17:49回复了帖子。', 1460368140),
(97, 2, 2, 986844098, 'reply', 165, 'ken678在2016-04-11 17:49回复了帖子。', 1460368164),
(98, 2, 2, 986844098, 'reply', 166, 'ken678在2016-04-11 17:49回复了帖子。', 1460368193),
(99, 2, 2, 986844098, 'reply', 167, 'ken678在2016-04-11 17:50回复了帖子。', 1460368230),
(100, 2, 2, 986844098, 'reply', 168, 'ken678在2016-04-11 17:51回复了帖子。', 1460368280),
(101, 2, 2, 986844098, 'reply', 169, 'ken678在2016-04-11 17:51回复了帖子。', 1460368310);

-- --------------------------------------------------------

--
-- 表的结构 `yzn_config`
--

CREATE TABLE IF NOT EXISTS `yzn_config` (
  `id` smallint(2) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(30) NOT NULL COMMENT '配置名称',
  `title` varchar(50) NOT NULL COMMENT '配置说明',
  `remark` text NOT NULL COMMENT '配置说明',
  `value` text NOT NULL COMMENT '配置值',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- 转存表中的数据 `yzn_config`
--

INSERT INTO `yzn_config` (`id`, `name`, `title`, `remark`, `value`, `sort`, `status`) VALUES
(1, 'WEB_SITE_TITLE', '网站标题', '网站标题前台显示标题', 'YznBBS论坛', 0, 1),
(2, 'WEB_SITE_DESCRIPTION', '网站描述', '网站搜索引擎描述', '御宅男工作室有多年的软件开发经验，专注于：软件制作，验证码识别，网站制作，采集工具，模拟操作，批量注册，群发软件，留言功能。', 0, 1),
(3, 'WEB_SITE_KEYWORD', '网站关键字', '网站搜索引擎关键字', 'YznBBS，轻论坛，Yzn论坛，御宅男论坛，御宅男工作室', 0, 1),
(4, 'WEB_SITE_CLOSE', '关闭站点', '站点关闭后其他用户不能访问，管理员可以正常访问', '1', 0, 1),
(5, 'USER_NAME_BAOLIU', '保留用户名和昵称', '禁止注册用户名和昵称，包含这些即无法注册,用" , "号隔开，用户只能是英文，下划线_，数字等', '管理员,测试,admin,垃圾', 0, 1),
(6, 'USER_LEVEL', '用户等级', '每行一条，名称和积分之间用冒号分隔', '0:Lv1 一介凡人\r\n10:Lv2 初闻仙道\r\n50:Lv3 筑基小成\r\n100:Lv4 结丹修士\r\n200:Lv5 元婴老怪\r\n400:Lv6 化神传说\r\n600:Lv7 炼神返虚\r\n800:Lv8 合体尊者\r\n1000:Lv9 九天大乘\r\n2000:Lv10 渡劫飞升\r\n3000:Lv11 玄天真灵\r\n6000:Lv12 真仙降临\r\n10000:Lv13 掌刑仙尊\r\n18000:Lv14 万域仙皇\r\n30000:Lv15 不灭金仙\r\n60000:Lv16 轮回道祖\r\n100000:Lv17 寿与天齐\r\n300000:Lv18 南柯一梦', 0, 1);

-- --------------------------------------------------------

--
-- 表的结构 `yzn_favourite`
--

CREATE TABLE IF NOT EXISTS `yzn_favourite` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
  `uid` mediumint(8) unsigned NOT NULL COMMENT '收藏人id',
  `content` mediumtext NOT NULL COMMENT '收藏内容',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- 转存表中的数据 `yzn_favourite`
--

INSERT INTO `yzn_favourite` (`id`, `uid`, `content`) VALUES
(7, 7, '127,26,25,15'),
(8, 2, '24,25,15'),
(9, 14, '93');

-- --------------------------------------------------------

--
-- 表的结构 `yzn_member`
--

CREATE TABLE IF NOT EXISTS `yzn_member` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `uniqid` char(40) NOT NULL COMMENT '唯一标识符',
  `username` char(16) NOT NULL COMMENT '账号',
  `password` char(40) NOT NULL COMMENT '密码',
  `email` char(32) NOT NULL COMMENT '邮箱',
  `score` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '积分',
  `currency` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '货币',
  `tagline` tinytext NOT NULL COMMENT '签名',
  `bio` tinytext NOT NULL COMMENT '个人简介',
  `notifi` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '提醒(非未读)',
  `unread_notifi` mediumint(8) unsigned NOT NULL COMMENT '未读提醒',
  `favourite` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数量',
  `reg_time` int(10) unsigned NOT NULL COMMENT '注册时间',
  `reg_ip` bigint(20) unsigned NOT NULL COMMENT '注册IP',
  `last_login_time` int(10) unsigned NOT NULL COMMENT '最后登录时间',
  `last_login_ip` bigint(20) unsigned NOT NULL COMMENT '最后登录IP',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=22 ;

--
-- 转存表中的数据 `yzn_member`
--

INSERT INTO `yzn_member` (`id`, `uniqid`, `username`, `password`, `email`, `score`, `currency`, `tagline`, `bio`, `notifi`, `unread_notifi`, `favourite`, `reg_time`, `reg_ip`, `last_login_time`, `last_login_ip`) VALUES
(2, '890ae7bd6c6e791463ff850291e3033d9de18a63', 'ken678', 'fcddf14938e6b150a10786d81d6aa0e36e787892', '530765310@qq.com', 564, 13, '美好时光总是很短暂的！！', '美好时光总是很短暂的！！', 7, 0, 3, 1458020135, 2059491498, 0, 0),
(6, '517c7d0ea1cc9fe8fc57aceafc005c77e709a29f', 'ken123', 'fcddf14938e6b150a10786d81d6aa0e36e787892', '695477967@qq.com', 0, 0, '', '', 0, 0, 0, 1458089927, 2059491498, 0, 0),
(7, '7707c456732f4e81b259133ffe061138ce806942', '御宅男', 'fcddf14938e6b150a10786d81d6aa0e36e787892', '530765312@qq.com', 7, 5, '御宅男工作室有多年的软件开发经验，专注于：软件制作，验证码识别，网站制作，采集工具，模拟操作，批量注册，群发软件，留言功能', '御宅男工作室有多年的软件开发经验，专注于：软件制作，验证码识别，网站制作，采集工具，模拟操作，批量注册，群发软件，留言功能', 2, 0, 4, 1458097833, 2059491498, 0, 0),
(8, 'dffa4c9da05ad2bb8b0db5b419b8553a58e88c7f', 'papi酱', 'fcddf14938e6b150a10786d81d6aa0e36e787892', '453654565@qq.com', 20, 50, '', '', 0, 0, 0, 1458553750, 986844098, 0, 0),
(9, '594faebd8910f22f26cc1f4b919dc6a46b95aa63', 'yacai', 'f7c3bc1d808e04732adf679965ccc34ca7ae3441', '358916139@qq.com', 0, 0, '', '', 0, 0, 0, 1458871528, 3074304924, 0, 0),
(10, '7b2169da6a71cc6694b25efc000b9c7f2af2ecde', 'ddsadsadsadsa', '41a5aa940b5725d048d8820d3285b480f76ed6f1', 'ddsadsadsadsa@qq.com', 0, 0, '', '', 0, 0, 0, 1459314305, 1879791341, 0, 0),
(11, '4011bae149f024e4bfb1b425ca0a0c79fa273750', 'ieage', '60fb03124a98e708925e26be32ee3ed0c792034e', 'lishanzaixian@163.com', 0, 0, '', '', 0, 0, 0, 1459321273, 2874713143, 0, 0),
(12, '9089e02e67d22551bbdfe378b88333b40a3f2de4', 'zbw7415604', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'werew@163.com', 0, 0, '', '', 0, 0, 0, 1459387949, 1032343538, 0, 0),
(13, '20e1fe142e27bf83f5b10efc52d28286c1b9154c', 'xfdwf', '03a8731ce4ba15480268511f28192283ac5ce34f', '450955816@qq.com', 0, 0, '', '', 1, 0, 0, 1459438899, 3701484934, 0, 0),
(14, 'e83410bf217619c438a4e2eee396b40c7e584de4', 'test', '3d4f2bf07dc1be38b20cd6e46949a1071f9d0e3d', 'seller@antvel.com', 0, 0, '', '', 1, 0, 0, 1459620119, 1885303481, 0, 0),
(15, 'ab2d47d489f6e622a1ea8938193110985572c4a7', 'xuefeng51go', '13a8d93f5527f73adda89896218f5f269ed0c43f', 'xuefeng51go@qq.com', 0, 0, '', '', 0, 0, 0, 1459689684, 3085554475, 0, 0),
(16, '0dae8a2c70a5656a4168b6f2a806364fa4f70ced', 'zboyit', 'afe4ee8f81f27be9730d8699e0bc23cded8a8a4a', 'zboyit@hotmail.com', 0, 1, '', '', 0, 0, 0, 1459850645, 3661467490, 0, 0),
(17, '05649a7748e94496a2501d2c25af0fd47f139f43', '11111111111', 'bc4a2ff7eea3cb492234d973b5d3d05669fe2f48', 'vvvhj@fsfsd.com', 0, 0, '', '', 0, 0, 0, 1459916731, 620462775, 0, 0),
(18, '89f86f4c64c4ae8669e8536d816eb771bf67bad2', 'goright', '970de950276e387a41bc3206c3d2c40779b9cd24', '810560740@qq.com', 0, 0, '', '', 0, 0, 0, 1459951665, 1932783264, 0, 0),
(19, '7d61693b704ceb972357be37f58c0c146acb81b2', 'Magic', '192b5d9305a0d8f6eda9fc3031e269d871ccf812', 'meilunzhi@gmail.com', 0, 0, '', '', 0, 0, 0, 1459959074, 2071564777, 0, 0),
(20, '51877d8d0a3356083954bd2ce7dda7d95ae68e1c', 'dilei4148', '601f1889667efaebb33b8c12572835da3f027f78', '188308685@qq.com', 0, 0, '', '', 0, 0, 0, 1460012358, 3062802797, 0, 0),
(21, 'bf002249e3642b518c5a06dc5d84f877cd633dfe', 'wangqiwen', 'e5b50f8a3c5dce3bcd7e2640c5666c17b6800d8d', 'wqw@flyminer.com', 0, 0, '', '', 0, 0, 0, 1460443960, 2033982335, 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `yzn_node`
--

CREATE TABLE IF NOT EXISTS `yzn_node` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` mediumint(8) unsigned NOT NULL COMMENT '父节点',
  `title` char(10) NOT NULL COMMENT '标题',
  `description` tinytext NOT NULL COMMENT '描述',
  `css` text COMMENT '样式',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `siatus` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0正常',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='节点' AUTO_INCREMENT=11 ;

--
-- 转存表中的数据 `yzn_node`
--

INSERT INTO `yzn_node` (`id`, `pid`, `title`, `description`, `css`, `sort`, `siatus`) VALUES
(1, 0, '讨论', '', '\r\n', 0, 0),
(2, 0, '下载', '', '0', 0, 0),
(3, 0, '官方区', '', '0', 0, 0),
(4, 1, '求助交流', '普通求助板块', '#Wrapper {\r\nbackground-image: url("http://static.v2ex.com/tiles/complex.jpg");\r\nbackground-repeat: repeat;\r\n}\r\n', 0, 0),
(5, 1, '技术分享', '技术方面求助板块', '#Wrapper {\r\nbackground-color: #666677;\r\nbackground-image: url("//www.v2ex.com/static/img/shadow.png"), url("//cdn.v2ex.com/assets/bgs/stardust.png");\r\nbackground-position: 0 0, 0 0;\r\nbackground-repeat: repeat-x, repeat;\r\n}\r\n', 0, 0),
(6, 2, '电子书', '发布各类电子书', '0', 0, 0),
(7, 2, '软件', '发布各类免费软件', '0', 0, 0),
(8, 3, '反馈', '用户举报，建议BUG反馈官方板块', '0', 0, 0),
(9, 1, '综合讨论', '严禁发表低俗内容或广告帖。', '#Wrapper {\r\nbackground-image: url("//www.v2ex.com/static/img/shadow_light.png"), url("//static.v2ex.com/tiles/random.jpg");\r\nbackground-repeat: repeat-x, repeat;\r\n}\r\n\r\n.box {\r\nborder: 1px solid #e2e2ff;\r\n}', 0, 0),
(10, 3, '程序发布', '官方程序发布板块', '#Wrapper {\r\nbackground-image: url("//www.v2ex.com/static/img/shadow_light.png"), url("//static.v2ex.com/tiles/random.jpg");\r\nbackground-repeat: repeat-x, repeat;\r\n}\r\n\r\n.box {\r\nborder: 1px solid #e2e2ff;\r\n}', 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `yzn_notifications`
--

CREATE TABLE IF NOT EXISTS `yzn_notifications` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `uid` mediumint(8) unsigned NOT NULL COMMENT '提醒人ID',
  `nid` mediumint(8) unsigned NOT NULL COMMENT '谁提醒ID',
  `tid` mediumint(8) unsigned NOT NULL COMMENT '@你回复你的帖子ID',
  `type` tinyint(2) unsigned NOT NULL COMMENT '提醒类型',
  `add_time` int(10) unsigned NOT NULL COMMENT '提醒时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=44 ;

--
-- 转存表中的数据 `yzn_notifications`
--

INSERT INTO `yzn_notifications` (`id`, `uid`, `nid`, `tid`, `type`, `add_time`) VALUES
(18, 2, 13, 72, 1, 1459440084),
(17, 2, 11, 72, 1, 1459321298),
(16, 7, 2, 26, 2, 1458812724),
(15, 2, 7, 26, 2, 1458812082),
(14, 7, 6, 26, 1, 1458811893),
(19, 2, 14, 93, 1, 1459620256),
(20, 2, 14, 93, 1, 1459620269),
(21, 14, 2, 97, 1, 1459651709),
(22, 13, 16, 72, 2, 1459850688),
(23, 2, 7, 93, 1, 1459912396),
(24, 7, 2, 129, 1, 1460366204),
(25, 7, 2, 129, 1, 1460366207),
(26, 2, 7, 135, 1, 1460366364),
(27, 7, 2, 129, 1, 1460366951),
(28, 7, 2, 129, 1, 1460367051),
(29, 7, 2, 129, 1, 1460367137),
(30, 7, 2, 129, 1, 1460367178),
(31, 7, 2, 129, 1, 1460367198),
(32, 7, 2, 129, 1, 1460367211),
(33, 7, 2, 129, 1, 1460367251),
(34, 7, 2, 129, 1, 1460367317),
(35, 7, 2, 129, 1, 1460367346),
(36, 7, 2, 129, 1, 1460367365),
(37, 7, 2, 129, 1, 1460367538),
(38, 7, 2, 129, 2, 1460368140),
(39, 7, 2, 129, 2, 1460368164),
(40, 7, 2, 129, 2, 1460368193),
(41, 7, 2, 129, 2, 1460368230),
(42, 7, 2, 129, 2, 1460368280),
(43, 7, 2, 129, 2, 1460368310);

-- --------------------------------------------------------

--
-- 表的结构 `yzn_reply`
--

CREATE TABLE IF NOT EXISTS `yzn_reply` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `topics_id` mediumint(8) unsigned NOT NULL COMMENT '所属帖子',
  `uid` mediumint(8) unsigned NOT NULL COMMENT '发布ID',
  `content` text NOT NULL COMMENT '内容',
  `add_time` int(10) unsigned NOT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=170 ;

--
-- 转存表中的数据 `yzn_reply`
--

INSERT INTO `yzn_reply` (`id`, `topics_id`, `uid`, `content`, `add_time`) VALUES
(98, 26, 2, '在这里回复御宅男', 1458716449),
(97, 26, 2, '<a target="_blank" href="/User/index/id/7" >@御宅男</a>', 1458716284),
(96, 23, 2, '@ken678 \r\n<a target="_blank" href="/User/index/id/7" >@御宅男</a> \r\n<a target="_blank" href="/User/index/id/6" >@ken123</a> \r\n<a target="_blank" href="/User/index/id/8" >@papi酱</a> ', 1458703554),
(95, 23, 2, '<a target="_blank" href="/User/index/id/7" >@御宅男</a> \r\n<a target="_blank" href="/User/index/id/6" >@ken123</a> \r\n@ken678 \r\n<a target="_blank" href="/User/index/id/8" >@papi酱</a> ', 1458637568),
(94, 23, 7, '<a target="_blank" href="/User/index/id/6" >@ken123</a> \r\n<a target="_blank" href="/User/index/id/2" >@ken678</a> \r\n<a target="_blank" href="/User/index/id/8" >@papi酱</a> \r\n@御宅男 ', 1458637529),
(93, 23, 6, '<a target="_blank" href="/User/index/id/2" >@ken678</a> \r\n<a target="_blank" href="/User/index/id/8" >@papi酱</a> ', 1458637495),
(92, 23, 2, '<a target="_blank" href="/User/index/id/8" >@papi酱</a> ', 1458637474),
(91, 23, 8, '<a target="_blank" href="/User/index/id/2" >@ken678</a>', 1458637453),
(90, 23, 8, '@ken678', 1458637352),
(66, 15, 6, '支持支出', 1458627263),
(65, 15, 8, '55555555', 1458626422),
(99, 26, 7, '在这里回复御宅男', 1458717002),
(100, 26, 2, '在这里回复御宅男', 1458717639),
(101, 26, 7, '在这里回复御宅男   自己回复自己无提醒', 1458717767),
(102, 26, 7, '<a target="_blank" href="/User/index/id/2" >@ken678</a> \r\n@御宅男 ', 1458717878),
(103, 26, 7, '@御宅男 \r\n<a target="_blank" href="/User/index/id/2" >@ken678</a> ', 1458718044),
(104, 26, 2, '<a target="_blank" href="/User/index/id/7" >@御宅男</a> \r\n@ken678 ', 1458718508),
(105, 26, 8, '<a target="_blank" href="/User/index/id/2" >@ken678</a> \r\n<a target="_blank" href="/User/index/id/7" >@御宅男</a> ', 1458720139),
(106, 26, 2, '在这里回复御宅男', 1458720237),
(107, 26, 6, '我来活肤御宅男', 1458811893),
(108, 26, 7, '<a target="_blank" href="/User/index/id/2" >@ken678</a> ', 1458812082),
(109, 26, 2, '<a target="_blank" href="/User/index/id/7" >@御宅男</a> ', 1458812724),
(110, 26, 2, '@ken678 ', 1459159007),
(111, 70, 2, '1111111111111111111111', 1459232810),
(112, 23, 7, '@sdasd', 1459238542),
(113, 72, 11, 'sgdfsdfgdf', 1459321298),
(114, 72, 13, 'asdfasdf', 1459440084),
(125, 93, 2, '这里测试回帖得铜币', 1459735643),
(124, 93, 2, '这里测试回帖得铜币', 1459735302),
(123, 97, 2, '这里是论坛', 1459651709),
(122, 93, 14, '还能得铜币？', 1459620256),
(137, 93, 2, '这里测试回帖得铜币   吆西  没清空kvdb所以没有铜币  现在有了', 1459744204),
(136, 93, 2, '这里测试回帖得铜币', 1459743934),
(135, 93, 2, '这里测试回帖得铜币', 1459743853),
(134, 93, 2, '这里测试回帖得铜币', 1459741021),
(133, 113, 2, 'ssssssssssssssssssssssssss', 1459737616),
(132, 93, 2, '这里测试回帖得铜币', 1459737122),
(138, 72, 16, '<a target="_blank" href="/User/index/id/13" >@xfdwf</a> hehe', 1459850688),
(139, 93, 7, '这里测试回帖得铜币', 1459912396),
(140, 129, 2, '111111111', 1460366204),
(141, 129, 2, '111111111111', 1460366207),
(142, 135, 7, '11111111111111', 1460366364),
(143, 135, 2, '222222222222222222222222', 1460366824),
(144, 129, 2, '1111111111111111111111', 1460366951),
(145, 129, 2, '44444444444444444444444', 1460367051),
(146, 129, 2, '11111111111111111', 1460367137),
(147, 129, 2, '1111111111111111111', 1460367178),
(148, 129, 2, '4444444444444444444444444444444', 1460367198),
(149, 129, 2, '6666666666666666666', 1460367211),
(150, 129, 2, '7777777777777777', 1460367251),
(151, 129, 2, '44444444444444444444444444', 1460367317),
(152, 129, 2, '4444444444444', 1460367346),
(153, 129, 2, '4444444444444444444', 1460367364),
(154, 129, 2, '@ken678 ', 1460367510),
(155, 129, 2, '4444444444', 1460367538),
(156, 129, 2, '@ken678 ', 1460367544),
(157, 129, 2, '@ken678 ', 1460367577),
(158, 129, 2, '@ken678 ', 1460367618),
(159, 129, 2, '@ken678 ', 1460367660),
(160, 129, 2, '@ken678 ', 1460367839),
(161, 129, 2, '@ken678 ', 1460367979),
(162, 129, 2, '@ken678 ', 1460367997),
(163, 129, 2, '@ken678 ', 1460368039),
(164, 129, 2, '<a target="_blank" href="/User/index/id/7" >@御宅男</a> ', 1460368140),
(165, 129, 2, '<a target="_blank" href="/User/index/id/7" >@御宅男</a> ', 1460368164),
(166, 129, 2, '<a target="_blank" href="/User/index/id/7" >@御宅男</a> ', 1460368193),
(167, 129, 2, '<a target="_blank" href="/User/index/id/7" >@御宅男</a> ', 1460368230),
(168, 129, 2, '<a target="_blank" href="/User/index/id/7" >@御宅男</a> ', 1460368280),
(169, 129, 2, '<a target="_blank" href="/User/index/id/7" >@御宅男</a> ', 1460368310);

-- --------------------------------------------------------

--
-- 表的结构 `yzn_tags`
--

CREATE TABLE IF NOT EXISTS `yzn_tags` (
  `id` int(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(10) NOT NULL COMMENT '标签名',
  `count` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '次数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=29 ;

--
-- 转存表中的数据 `yzn_tags`
--

INSERT INTO `yzn_tags` (`id`, `title`, `count`) VALUES
(25, 'forum', 1),
(24, '财富排行榜', 1),
(21, '标签', 1),
(26, '图片', 1),
(27, '信息', 1),
(28, '模型', 1);

-- --------------------------------------------------------

--
-- 表的结构 `yzn_tags_relation`
--

CREATE TABLE IF NOT EXISTS `yzn_tags_relation` (
  `tag_id` int(8) unsigned NOT NULL,
  `topics_id` int(8) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `yzn_tags_relation`
--

INSERT INTO `yzn_tags_relation` (`tag_id`, `topics_id`) VALUES
(28, 135),
(27, 129),
(26, 129),
(25, 129),
(24, 127),
(21, 85);

-- --------------------------------------------------------

--
-- 表的结构 `yzn_topics`
--

CREATE TABLE IF NOT EXISTS `yzn_topics` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `uid` mediumint(8) unsigned NOT NULL COMMENT '发表者ID',
  `cid` mediumint(8) unsigned NOT NULL COMMENT '最后回复者ID',
  `nid` mediumint(8) unsigned NOT NULL COMMENT '板块ID',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `tags` varchar(255) NOT NULL COMMENT '标签',
  `content` text NOT NULL COMMENT '内容',
  `reply_count` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '回复数量',
  `view` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `favourite` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数量',
  `is_top` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否置顶',
  `add_time` int(10) unsigned NOT NULL COMMENT '新增时间',
  `edit_time` int(10) unsigned NOT NULL COMMENT '修改时间',
  `reply_time` int(10) unsigned NOT NULL COMMENT '回复时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=137 ;

--
-- 转存表中的数据 `yzn_topics`
--

INSERT INTO `yzn_topics` (`id`, `uid`, `cid`, `nid`, `title`, `tags`, `content`, `reply_count`, `view`, `favourite`, `is_top`, `add_time`, `edit_time`, `reply_time`) VALUES
(15, 8, 2, 4, 'MarkDown语法测试', '', '## 大标题 ##\r\n### 小标题 ###\r\n\r\n*斜体文本* \r\n**粗体文本** \r\n***粗斜体文本*** \r\n\r\n文字链接 [链接名称](http://链接网址)\r\n网址链接 &lt;http://链接网址&gt;\r\n\r\n&gt; 引用文本前使用 [大于号+空格]\r\n&gt; 折行可以不加，新起一行都要加上哦\r\n\r\n&gt; 最外层引用\r\n&gt; &gt; 多一个 &gt; 嵌套一层引用\r\n&gt; &gt; &gt; 可以嵌套很多层\r\n\r\n&gt; - 这是引用里嵌套的一个列表\r\n&gt; - 还可以有子列表\r\n&gt;     * 子列表需要从 - 之后延后四个空格开始\r\n\r\n```\r\n代码块\r\n```\r\n\r\n---\r\n', 2, 0, 2, 0, 1458624693, 0, 1458631963),
(23, 2, 7, 4, '这里测试@功能', 'member', '@&lt;a href=&quot;/member/int64ago&quot;&gt;int64ago&lt;/a&gt;', 8, 0, 0, 0, 1458631986, 0, 1459238543),
(24, 2, 0, 4, '这里是回帖帖60秒限制测试', '', '这里是回帖60秒限制测试\r\n', 0, 0, 1, 0, 1458637635, 0, 1458637635),
(25, 2, 0, 10, '本论坛【测试源码】下载', '下载地址,源码下载,服务器,管理员,图片', '#说明\r\n------\r\n采用最新TP3.2.3框架\r\n使用sae作为服务器\r\n注册地址http://t.cn/R4ppkMF\r\nhttp://2.yznbbs.applinzi.com/不在维护\r\n后台暂时不做 因为暂时没有好看的后台（差不多前台稳定在做）\r\n\r\n#目前功能：（未完全完善）\r\n-------\r\n发帖 回帖 编辑 移动\r\n@功能\r\n未读提醒功能\r\n60秒回帖限制\r\nmarkdown语法支持\r\n会员基础信息修改（密码 签名等）\r\n节点支持\r\n主题收藏 \r\n自动标签分词（DZ分词服务）\r\n置顶\r\n标签页面\r\n每个节点页面加载不同背景\r\n金币获取 通过发帖 回帖等方式\r\n活跃度 积分 财富排行榜 \r\n用户头衔\r\n\r\n#后期功能（）\r\n-------\r\n~~关注用户~~\r\n~~管理后台~~\r\n~~附言~~\r\n~~赞 踩~~\r\n~~头像上传  附件上传  图片上传~~\r\n~~悬赏~~\r\n~~路由功能~~\r\n~~各类插件~~\r\n~~时间轴~~\r\n~~商城~~\r\n~~帖子置顶 隐藏~~\r\n~~节点查看 回复限制~~\r\n~~管理员 版主支持~~\r\n~~举报~~\r\n~~第三方登录~~\r\n~~等级制度~~\r\n~~友情链接~~\r\n~~热门标签~~\r\n.....\r\n\r\n#下载地址\r\n------\r\ngithub地址：https://github.com/ken678/yznbbs\r\n\r\n\r\n\r\n', 0, 0, 2, 1, 1458703742, 0, 1458703742),
(26, 7, 2, 10, '这里测试@功能', '', '这里测试@功能这里测试@功能这里测试@功能这里测试@功能这里测试@功能这里测试@功能这里测试@功能', 14, 0, 1, 0, 1458715486, 0, 1459159007),
(70, 2, 2, 4, '测试在线中文分词、关键词提取服务', '关键词,服务器,在线,中文,项目', '不同于使用自己的服务器进行分词，Discuz!在线中文分词服务是基于API返回分词结果的。在项目中，我们只需要一个函数即可方便地进行分词、关键词提取', 1, 0, 0, 0, 1459230799, 0, 1459232810),
(72, 2, 16, 10, 'YznBBS安装说明', '数据库,mysql,新建', '##sae安装使用教程##\r\n1.sae点击创建应用，使用php5.6\r\n2.代码管理 选择创建版本 并**上传代码包**\r\n3.初始化共享型mysql 新建yzb_bbs表 然后导入**app_yznbbs.sql**\r\n4.初始化**KVDB**和**Memcache**\r\n\r\n##本地安装使用教程##\r\n1.新建yzb_bbs表 然后导入**app_yznbbs.sql**\r\n2.修改config_db.php里面的数据库配置即可.', 3, 0, 0, 1, 1459302598, 0, 1459850688),
(86, 2, 0, 5, '页面美化测试 每个节点样式都不一样哦！！', '', '页面美化测试 每个节点样式都不一样哦！！', 0, 0, 0, 0, 1459329712, 0, 1459329712),
(93, 2, 7, 10, '测试发帖获取铜币功能', '', '每次发帖可以获得5铜币 每天上限为5次\r\n回帖可以获得1铜币 无次数限制\r\n并且增加获取铜币的详细报表\r\n\r\n后续增加更多的得铜币途径', 9, 0, 0, 0, 1459491838, 0, 1459912396),
(97, 14, 2, 4, '这是什么东东啊', '', '搞毛啊？', 1, 0, 0, 0, 1459620217, 0, 1459651709),
(135, 2, 2, 10, '新增发帖回帖限制表', '模型', '新增发帖回帖限制表\r\n行为模型 频率 时间 处罚\r\n\r\n发帖为1分钟 发一次 无处罚 \r\n回帖为30秒 发一次 无处罚\r\n', 2, 0, 0, 0, 1460362057, 0, 1460366825),
(129, 7, 2, 10, '新增等级进度条 可以显示很多信息', 'forum,图片,信息', '![图片名称](http://att.125.la/data/attachment/forum/201604/06/160002vlqzacaqkamthztl.png)', 28, 0, 0, 0, 1459929728, 0, 1460368310),
(127, 7, 0, 10, '新增财富排行榜 积分排行榜 更新度不高 使用全局静态缓存', '财富排行榜', 'http://yznbbs.applinzi.com/Top/rich.html\r\nhttp://yznbbs.applinzi.com/Top/score.html', 0, 0, 1, 0, 1459848062, 0, 1459848062),
(128, 2, 0, 10, '新增积分 用户头衔 铜币获取规则改为积分获取', '', '铜币发帖回帖不在获取 以后通过活动获取签到之类的方式获取\r\n积分可以通过发帖回帖等常规途径增长 \r\n\r\n会员头衔&amp;经验值对照表\r\n0                Lv1       一介凡人\r\n10              Lv2       初闻仙道\r\n50              Lv3       筑基小成\r\n100            Lv4       结丹修士\r\n200            Lv5       元婴老怪\r\n400            Lv6       化神传说\r\n600            Lv7       炼神返虚\r\n800            Lv8       合体尊者\r\n1000          Lv9       九天大乘\r\n2000          Lv10     渡劫飞升\r\n3000          Lv11     玄天真灵\r\n6000          Lv12     真仙降临\r\n10000        Lv13     掌刑仙尊\r\n18000        Lv14     万域仙皇\r\n30000        Lv15     不灭金仙\r\n60000        Lv16     轮回道祖\r\n100000      Lv17     寿与天齐\r\n300000      Lv18     南柯一梦', 0, 0, 0, 0, 1459904674, 0, 1459904674),
(85, 2, 0, 10, '测试标签页面 点击帖子下方标签可进入 查看所属标题的帖子', '标签', '测试标签页面 点击帖子下方标签可进入 查看所属标题的帖子 ', 0, 0, 0, 0, 1459321629, 0, 1459321629);
