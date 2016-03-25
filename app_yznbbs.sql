-- phpMyAdmin SQL Dump
-- version 3.3.8.1
-- http://www.phpmyadmin.net
--
-- 主机: w.rdc.sae.sina.com.cn:3307
-- 生成日期: 2016 年 03 月 23 日 16:43
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
-- 表的结构 `yzn_member`
--

CREATE TABLE IF NOT EXISTS `yzn_member` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `uniqid` char(40) NOT NULL COMMENT '唯一标识符',
  `username` char(16) NOT NULL COMMENT '账号',
  `password` char(40) NOT NULL COMMENT '密码',
  `email` char(32) NOT NULL COMMENT '邮箱',
  `tagline` tinytext NOT NULL COMMENT '签名',
  `bio` tinytext NOT NULL COMMENT '个人简介',
  `notifi` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '未读提醒',
  `reg_time` int(10) unsigned NOT NULL COMMENT '注册时间',
  `reg_ip` bigint(20) unsigned NOT NULL COMMENT '注册IP',
  `last_login_time` int(10) unsigned NOT NULL COMMENT '最后登录时间',
  `last_login_ip` bigint(20) unsigned NOT NULL COMMENT '最后登录IP',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- 转存表中的数据 `yzn_member`
--

INSERT INTO `yzn_member` (`id`, `uniqid`, `username`, `password`, `email`, `tagline`, `bio`, `notifi`, `reg_time`, `reg_ip`, `last_login_time`, `last_login_ip`) VALUES
(2, '890ae7bd6c6e791463ff850291e3033d9de18a63', 'ken678', 'fcddf14938e6b150a10786d81d6aa0e36e787892', '530765310@qq.com', '美好时光总是很短暂的！！', '美好时光总是很短暂的！！', 0, 1458020135, 2059491498, 0, 0),
(6, '517c7d0ea1cc9fe8fc57aceafc005c77e709a29f', 'ken123', 'fcddf14938e6b150a10786d81d6aa0e36e787892', '695477967@qq.com', '', '', 0, 1458089927, 2059491498, 0, 0),
(7, '7707c456732f4e81b259133ffe061138ce806942', '御宅男', 'fcddf14938e6b150a10786d81d6aa0e36e787892', '530765312@qq.com', '御宅男工作室有多年的软件开发经验，专注于：软件制作，验证码识别，网站制作，采集工具，模拟操作，批量注册，群发软件，留言功能', '御宅男工作室有多年的软件开发经验，专注于：软件制作，验证码识别，网站制作，采集工具，模拟操作，批量注册，群发软件，留言功能', 0, 1458097833, 2059491498, 0, 0),
(8, 'dffa4c9da05ad2bb8b0db5b419b8553a58e88c7f', 'papi酱', 'fcddf14938e6b150a10786d81d6aa0e36e787892', '453654565@qq.com', '', '', 0, 1458553750, 986844098, 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `yzn_node`
--

CREATE TABLE IF NOT EXISTS `yzn_node` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` mediumint(8) unsigned NOT NULL COMMENT '父节点',
  `title` char(10) NOT NULL COMMENT '标题',
  `sort` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `siatus` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0正常',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='节点' AUTO_INCREMENT=11 ;

--
-- 转存表中的数据 `yzn_node`
--

INSERT INTO `yzn_node` (`id`, `pid`, `title`, `sort`, `siatus`) VALUES
(1, 0, '讨论', 0, 0),
(2, 0, '下载', 0, 0),
(3, 0, '官方区', 0, 0),
(4, 1, '求助交流', 0, 0),
(5, 1, '技术分享', 0, 0),
(6, 2, '电子书', 0, 0),
(7, 2, '软件', 0, 0),
(8, 3, '反馈', 0, 0),
(9, 1, '综合讨论', 0, 0),
(10, 3, '程序发布', 0, 0);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- 转存表中的数据 `yzn_notifications`
--


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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=107 ;

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
(106, 26, 2, '在这里回复御宅男', 1458720237);

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
  `content` text NOT NULL COMMENT '内容',
  `reply_count` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '回复数量',
  `view` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `add_time` int(10) unsigned NOT NULL COMMENT '新增时间',
  `edit_time` int(10) unsigned NOT NULL COMMENT '修改时间',
  `reply_time` int(10) unsigned NOT NULL COMMENT '回复时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=27 ;

--
-- 转存表中的数据 `yzn_topics`
--

INSERT INTO `yzn_topics` (`id`, `uid`, `cid`, `nid`, `title`, `content`, `reply_count`, `view`, `add_time`, `edit_time`, `reply_time`) VALUES
(15, 8, 2, 4, 'MarkDown语法测试', '## 大标题 ##\r\n### 小标题 ###\r\n\r\n*斜体文本* \r\n**粗体文本** \r\n***粗斜体文本*** \r\n\r\n文字链接 [链接名称](http://链接网址)\r\n网址链接 &lt;http://链接网址&gt;\r\n\r\n&gt; 引用文本前使用 [大于号+空格]\r\n&gt; 折行可以不加，新起一行都要加上哦\r\n\r\n&gt; 最外层引用\r\n&gt; &gt; 多一个 &gt; 嵌套一层引用\r\n&gt; &gt; &gt; 可以嵌套很多层\r\n\r\n&gt; - 这是引用里嵌套的一个列表\r\n&gt; - 还可以有子列表\r\n&gt;     * 子列表需要从 - 之后延后四个空格开始\r\n\r\n```\r\n代码块\r\n```\r\n\r\n---\r\n', 2, 0, 1458624693, 0, 1458631963),
(23, 2, 2, 4, '这里测试@功能', '@&lt;a href=&quot;/member/int64ago&quot;&gt;int64ago&lt;/a&gt;', 7, 0, 1458631986, 0, 1458703554),
(24, 2, 0, 4, '这里是回帖帖60秒限制测试', '这里是回帖60秒限制测试', 0, 0, 1458637635, 0, 1458637635),
(25, 2, 0, 10, '本论坛源码下载', '#说明\r\n------\r\n采用最新TP3.2.3框架\r\n使用sae作为服务器\r\n注册地址http://t.cn/R4ppkMF\r\n\r\n#目前功能：（未完全完善）\r\n-------\r\n发帖 回帖 编辑\r\n@功能 未读提醒功能\r\n60秒回帖限制\r\nmarkdown语法支持\r\n会员基础信息修改（密码 签名等）\r\n节点支持\r\n\r\n#后期功能（）\r\n-------\r\n~~金币获取 发帖 回帖等方式~~\r\n~~主题收藏 关注~~\r\n~~管理后台~~\r\n~~附言~~\r\n~~赞 踩~~\r\n~~头像上传  附件上传  图片上传~~\r\n~~悬赏~~\r\n.....\r\n\r\n\r\n\r\n\r\n\r\n\r\n', 0, 0, 1458703742, 0, 1458703742),
(26, 7, 2, 8, '这里测试未读提醒~~~', '这里测试未读提醒~~~这里测试未读提醒~~~这里测试未读提醒~~~', 10, 0, 1458715486, 0, 1458720237);
