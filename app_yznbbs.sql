-- phpMyAdmin SQL Dump
-- version 3.3.8.1
-- http://www.phpmyadmin.net
--
-- 主机: w.rdc.sae.sina.com.cn:3307
-- 生成日期: 2016 年 03 月 30 日 15:33
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `yzn_config`
--

INSERT INTO `yzn_config` (`id`, `name`, `title`, `remark`, `value`, `sort`, `status`) VALUES
(1, 'WEB_SITE_TITLE', '网站标题', '网站标题前台显示标题', 'YznBBS论坛', 0, 1),
(2, 'WEB_SITE_DESCRIPTION', '网站描述', '网站搜索引擎描述', '御宅男工作室有多年的软件开发经验，专注于：软件制作，验证码识别，网站制作，采集工具，模拟操作，批量注册，群发软件，留言功能。', 0, 1),
(3, 'WEB_SITE_KEYWORD', '网站关键字', '网站搜索引擎关键字', 'YznBBS，轻论坛，Yzn论坛，御宅男论坛，御宅男工作室', 0, 1),
(4, 'WEB_SITE_CLOSE', '关闭站点', '站点关闭后其他用户不能访问，管理员可以正常访问', '1', 0, 1);

-- --------------------------------------------------------

--
-- 表的结构 `yzn_favourite`
--

CREATE TABLE IF NOT EXISTS `yzn_favourite` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
  `uid` mediumint(8) unsigned NOT NULL COMMENT '收藏人id',
  `content` mediumtext NOT NULL COMMENT '收藏内容',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- 转存表中的数据 `yzn_favourite`
--

INSERT INTO `yzn_favourite` (`id`, `uid`, `content`) VALUES
(7, 7, '26,25,15'),
(8, 2, '24,25,15');

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
  `notifi` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '提醒(非未读)',
  `unread_notifi` mediumint(8) unsigned NOT NULL COMMENT '未读提醒',
  `favourite` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数量',
  `reg_time` int(10) unsigned NOT NULL COMMENT '注册时间',
  `reg_ip` bigint(20) unsigned NOT NULL COMMENT '注册IP',
  `last_login_time` int(10) unsigned NOT NULL COMMENT '最后登录时间',
  `last_login_ip` bigint(20) unsigned NOT NULL COMMENT '最后登录IP',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- 转存表中的数据 `yzn_member`
--

INSERT INTO `yzn_member` (`id`, `uniqid`, `username`, `password`, `email`, `tagline`, `bio`, `notifi`, `unread_notifi`, `favourite`, `reg_time`, `reg_ip`, `last_login_time`, `last_login_ip`) VALUES
(2, '890ae7bd6c6e791463ff850291e3033d9de18a63', 'ken678', 'fcddf14938e6b150a10786d81d6aa0e36e787892', '530765310@qq.com', '美好时光总是很短暂的！！', '美好时光总是很短暂的！！', 1, 0, 3, 1458020135, 2059491498, 0, 0),
(6, '517c7d0ea1cc9fe8fc57aceafc005c77e709a29f', 'ken123', 'fcddf14938e6b150a10786d81d6aa0e36e787892', '695477967@qq.com', '', '', 0, 0, 0, 1458089927, 2059491498, 0, 0),
(7, '7707c456732f4e81b259133ffe061138ce806942', '御宅男', 'fcddf14938e6b150a10786d81d6aa0e36e787892', '530765312@qq.com', '御宅男工作室有多年的软件开发经验，专注于：软件制作，验证码识别，网站制作，采集工具，模拟操作，批量注册，群发软件，留言功能', '御宅男工作室有多年的软件开发经验，专注于：软件制作，验证码识别，网站制作，采集工具，模拟操作，批量注册，群发软件，留言功能', 2, 0, 3, 1458097833, 2059491498, 0, 0),
(8, 'dffa4c9da05ad2bb8b0db5b419b8553a58e88c7f', 'papi酱', 'fcddf14938e6b150a10786d81d6aa0e36e787892', '453654565@qq.com', '', '', 0, 0, 0, 1458553750, 986844098, 0, 0),
(9, '594faebd8910f22f26cc1f4b919dc6a46b95aa63', 'yacai', 'f7c3bc1d808e04732adf679965ccc34ca7ae3441', '358916139@qq.com', '', '', 0, 0, 0, 1458871528, 3074304924, 0, 0),
(10, '7b2169da6a71cc6694b25efc000b9c7f2af2ecde', 'ddsadsadsadsa', '41a5aa940b5725d048d8820d3285b480f76ed6f1', 'ddsadsadsadsa@qq.com', '', '', 0, 0, 0, 1459314305, 1879791341, 0, 0),
(11, '4011bae149f024e4bfb1b425ca0a0c79fa273750', 'ieage', '60fb03124a98e708925e26be32ee3ed0c792034e', 'lishanzaixian@163.com', '', '', 0, 0, 0, 1459321273, 2874713143, 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `yzn_node`
--

CREATE TABLE IF NOT EXISTS `yzn_node` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` mediumint(8) unsigned NOT NULL COMMENT '父节点',
  `title` char(10) NOT NULL COMMENT '标题',
  `description` tinytext NOT NULL COMMENT '描述',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `siatus` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0正常',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='节点' AUTO_INCREMENT=11 ;

--
-- 转存表中的数据 `yzn_node`
--

INSERT INTO `yzn_node` (`id`, `pid`, `title`, `description`, `sort`, `siatus`) VALUES
(1, 0, '讨论', '', 0, 0),
(2, 0, '下载', '', 0, 0),
(3, 0, '官方区', '', 0, 0),
(4, 1, '求助交流', '普通求助板块', 0, 0),
(5, 1, '技术分享', '技术方面求助板块', 0, 0),
(6, 2, '电子书', '发布各类电子书', 0, 0),
(7, 2, '软件', '发布各类免费软件', 0, 0),
(8, 3, '反馈', '用户举报，建议BUG反馈官方板块', 0, 0),
(9, 1, '综合讨论', '严禁发表低俗内容或广告帖。', 0, 0),
(10, 3, '程序发布', '官方程序发布板块', 0, 0);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=18 ;

--
-- 转存表中的数据 `yzn_notifications`
--

INSERT INTO `yzn_notifications` (`id`, `uid`, `nid`, `tid`, `type`, `add_time`) VALUES
(17, 2, 11, 72, 1, 1459321298),
(16, 7, 2, 26, 2, 1458812724),
(15, 2, 7, 26, 2, 1458812082),
(14, 7, 6, 26, 1, 1458811893);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=114 ;

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
(113, 72, 11, 'sgdfsdfgdf', 1459321298);

-- --------------------------------------------------------

--
-- 表的结构 `yzn_tags`
--

CREATE TABLE IF NOT EXISTS `yzn_tags` (
  `id` int(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(10) NOT NULL COMMENT '标签名',
  `count` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '次数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=22 ;

--
-- 转存表中的数据 `yzn_tags`
--

INSERT INTO `yzn_tags` (`id`, `title`, `count`) VALUES
(21, '标签', 1);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=86 ;

--
-- 转存表中的数据 `yzn_topics`
--

INSERT INTO `yzn_topics` (`id`, `uid`, `cid`, `nid`, `title`, `tags`, `content`, `reply_count`, `view`, `favourite`, `is_top`, `add_time`, `edit_time`, `reply_time`) VALUES
(15, 8, 2, 4, 'MarkDown语法测试', '', '## 大标题 ##\r\n### 小标题 ###\r\n\r\n*斜体文本* \r\n**粗体文本** \r\n***粗斜体文本*** \r\n\r\n文字链接 [链接名称](http://链接网址)\r\n网址链接 &lt;http://链接网址&gt;\r\n\r\n&gt; 引用文本前使用 [大于号+空格]\r\n&gt; 折行可以不加，新起一行都要加上哦\r\n\r\n&gt; 最外层引用\r\n&gt; &gt; 多一个 &gt; 嵌套一层引用\r\n&gt; &gt; &gt; 可以嵌套很多层\r\n\r\n&gt; - 这是引用里嵌套的一个列表\r\n&gt; - 还可以有子列表\r\n&gt;     * 子列表需要从 - 之后延后四个空格开始\r\n\r\n```\r\n代码块\r\n```\r\n\r\n---\r\n', 2, 0, 2, 0, 1458624693, 0, 1458631963),
(23, 2, 7, 4, '这里测试@功能', 'member', '@&lt;a href=&quot;/member/int64ago&quot;&gt;int64ago&lt;/a&gt;', 8, 0, 0, 0, 1458631986, 0, 1459238543),
(24, 2, 0, 4, '这里是回帖帖60秒限制测试', '', '这里是回帖60秒限制测试\r\n', 0, 0, 1, 0, 1458637635, 0, 1458637635),
(25, 2, 0, 10, '本论坛【测试源码】下载.', '下载地址,源码下载,服务器,管理员,图片', '#说明\r\n------\r\n采用最新TP3.2.3框架\r\n使用sae作为服务器\r\n注册地址http://t.cn/R4ppkMF\r\nhttp://2.yznbbs.applinzi.com/不在维护\r\n\r\n#目前功能：（未完全完善）\r\n-------\r\n发帖 回帖 编辑\r\n@功能\r\n未读提醒功能\r\n60秒回帖限制\r\nmarkdown语法支持\r\n会员基础信息修改（密码 签名等）\r\n节点支持\r\n主题收藏 \r\n自动标签分词（DZ分词服务）\r\n置顶\r\n标签页面\r\n\r\n#后期功能（）\r\n-------\r\n~~金币获取 发帖 回帖等方式~~\r\n~~关注用户~~\r\n~~管理后台~~\r\n~~附言~~\r\n~~赞 踩~~\r\n~~头像上传  附件上传  图片上传~~\r\n~~悬赏~~\r\n~~路由功能~~\r\n~~各类插件~~\r\n~~时间轴~~\r\n~~商城~~\r\n~~帖子置顶 隐藏~~\r\n~~节点查看 回复限制~~\r\n~~管理员 版主支持~~\r\n~~举报~~\r\n~~第三方登录~~\r\n~~排行榜~~\r\n~~等级制度~~\r\n.....\r\n\r\n#下载地址\r\n------\r\ngithub地址：https://github.com/ken678/yznbbs\r\n\r\n\r\n\r\n\r\n', 0, 0, 2, 1, 1458703742, 0, 1458703742),
(26, 7, 2, 10, '这里测试@功能', '', '这里测试@功能这里测试@功能这里测试@功能这里测试@功能这里测试@功能这里测试@功能这里测试@功能', 14, 0, 1, 0, 1458715486, 0, 1459159007),
(70, 2, 2, 4, '测试在线中文分词、关键词提取服务', '关键词,服务器,在线,中文,项目', '不同于使用自己的服务器进行分词，Discuz!在线中文分词服务是基于API返回分词结果的。在项目中，我们只需要一个函数即可方便地进行分词、关键词提取', 1, 0, 0, 0, 1459230799, 0, 1459232810),
(72, 2, 11, 10, 'YznBBS安装说明', '数据库,mysql,新建', '##sae安装使用教程##\r\n1.sae点击创建应用，使用php5.6\r\n2.代码管理 选择创建版本 并**上传代码包**\r\n3.初始化共享型mysql 新建yzb_bbs表 然后导入**app_yznbbs.sql**\r\n4.初始化**KVDB**和**Memcache**\r\n\r\n##本地安装使用教程##\r\n1.新建yzb_bbs表 然后导入**app_yznbbs.sql**\r\n2.修改config_db.php里面的数据库配置即可', 1, 0, 0, 1, 1459302598, 0, 1459321298),
(85, 2, 0, 10, '测试标签页面 点击帖子下方标签可进入 查看所属标题的帖子', '标签', '测试标签页面 点击帖子下方标签可进入 查看所属标题的帖子 ', 0, 0, 0, 0, 1459321629, 0, 1459321629);
