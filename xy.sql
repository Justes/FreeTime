-- phpMyAdmin SQL Dump
-- version 3.5.2
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2015 年 12 月 04 日 08:02
-- 服务器版本: 5.5.25a
-- PHP 版本: 5.4.4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `xy`
--

-- --------------------------------------------------------

--
-- 表的结构 `xy_advert`
--

CREATE TABLE IF NOT EXISTS `xy_advert` (
  `adverId` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `startTime` char(20) NOT NULL DEFAULT '',
  `endTime` char(20) NOT NULL DEFAULT '',
  `url` varchar(50) NOT NULL DEFAULT '',
  `pic` varchar(50) NOT NULL DEFAULT '',
  `title` char(30) NOT NULL DEFAULT '',
  `status` enum('0','1') NOT NULL DEFAULT '0',
  PRIMARY KEY (`adverId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `xy_auth_group`
--

CREATE TABLE IF NOT EXISTS `xy_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` char(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `xy_auth_group`
--

INSERT INTO `xy_auth_group` (`id`, `title`, `status`, `rules`) VALUES
(3, '初级管理员', 1, '1,19'),
(4, '中级管理员', 1, '1,3,4,5,7,8,9,19'),
(5, '超级管理员', 1, '1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47');

-- --------------------------------------------------------

--
-- 表的结构 `xy_auth_group_access`
--

CREATE TABLE IF NOT EXISTS `xy_auth_group_access` (
  `uid` mediumint(8) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `xy_auth_group_access`
--

INSERT INTO `xy_auth_group_access` (`uid`, `group_id`) VALUES
(1, 3),
(1, 5),
(3, 4),
(4, 5),
(5, 4),
(6, 3),
(7, 5),
(9, 5);

-- --------------------------------------------------------

--
-- 表的结构 `xy_auth_rule`
--

CREATE TABLE IF NOT EXISTS `xy_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(80) NOT NULL DEFAULT '',
  `title` char(20) NOT NULL DEFAULT '',
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `condition` char(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=48 ;

--
-- 转存表中的数据 `xy_auth_rule`
--

INSERT INTO `xy_auth_rule` (`id`, `name`, `title`, `type`, `status`, `condition`) VALUES
(1, 'User/index', '查看用户', 1, 1, ''),
(3, 'User/add', '添加用户', 1, 1, ''),
(4, 'User/EditUserStatus', '更改账号状态', 1, 1, ''),
(5, 'User/UserDel', '将用户移入回收站', 1, 1, ''),
(6, 'User/UserMod', '更改用户信息', 1, 1, ''),
(7, 'Admin/index', '查看管理员信息', 1, 1, ''),
(8, 'Admin/add', '新增管理员', 1, 1, ''),
(9, 'Admin/mod', '更改管理员信息', 1, 1, ''),
(10, 'Admin/del', '删除管理员', 1, 1, ''),
(11, 'Block/index', '查看版块', 1, 1, ''),
(12, 'Block/add', '新增版块', 1, 1, ''),
(13, 'Block/del', '删除版块', 1, 1, ''),
(14, 'Block/mod', '编辑版块', 1, 1, ''),
(15, 'Block/edit', '更改版块状态', 1, 1, ''),
(16, 'Goods/GoodsOnsale', '查看商品', 1, 1, ''),
(17, 'Goods/GoodsOnSaleStatus', '更改商品状态', 1, 1, ''),
(18, 'Goods/GoodsOnSaleRecommend', '商品加推荐', 1, 1, ''),
(19, 'Index/index', '查看主页(必选)', 1, 1, ''),
(20, 'Auth/rule', '查看规则', 1, 1, ''),
(21, 'Auth/ruleAdd', '添加规则', 1, 1, ''),
(22, 'Auth/ruleMod', '修改规则', 1, 1, ''),
(23, 'Auth/ruleDel', '删除规则', 1, 1, ''),
(24, 'Auth/groupAdd', '增加用户组', 1, 1, ''),
(25, 'Auth/group', '查看用户组', 1, 1, ''),
(26, 'Auth/groupMod', '修改用户组', 1, 1, ''),
(27, 'Auth/groupDel', '删除用户组', 1, 1, ''),
(28, 'User/Useradd', '增加用户', 1, 1, ''),
(29, 'User/actUserMod', '更改用户', 1, 1, ''),
(30, 'Admin/addAction', '添加管理员', 1, 1, ''),
(31, 'Admin/modAction', '编辑管理员', 1, 1, ''),
(32, 'Block/actMod', '编辑版块', 1, 1, ''),
(33, 'Block/actAdd', '增加版块', 1, 1, ''),
(34, 'Comment/man', '管理评论', 1, 1, ''),
(35, 'Comment/del', '删除评论', 1, 1, ''),
(36, 'Goods/ManageOrderList', '订单管理', 1, 1, ''),
(37, 'Goods/orderDel', '删除订单', 1, 1, ''),
(38, 'Recycle/RecUsers', '查看回收站', 1, 1, ''),
(39, 'Recycle/recoveryUsers', '恢复用户', 1, 1, ''),
(40, 'Recycle/dropUsers', '删除用户', 1, 1, ''),
(41, 'WebManage/Links', '查看友情链接', 1, 1, ''),
(42, 'WebManage/add', '增加友情链接', 1, 1, ''),
(43, 'WebManage/mod', '修改友情链接', 1, 1, ''),
(44, 'WebManage/del', '删除友情链接', 1, 1, ''),
(45, 'Webmanage/Management', '网站管理', 1, 1, ''),
(46, 'WebManage/ppt', '查看幻灯片', 1, 1, ''),
(47, 'WebManage/modppt', '更改幻灯片', 1, 1, '');

-- --------------------------------------------------------

--
-- 表的结构 `xy_cart`
--

CREATE TABLE IF NOT EXISTS `xy_cart` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `buyerId` int(20) unsigned NOT NULL,
  `goodsId` int(20) unsigned NOT NULL,
  `amount` int(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=21 ;

--
-- 转存表中的数据 `xy_cart`
--

INSERT INTO `xy_cart` (`id`, `buyerId`, `goodsId`, `amount`) VALUES
(6, 13, 27, 1);

-- --------------------------------------------------------

--
-- 表的结构 `xy_comment`
--

CREATE TABLE IF NOT EXISTS `xy_comment` (
  `commentId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `buyerId` int(20) unsigned NOT NULL,
  `sellerId` int(20) unsigned NOT NULL,
  `goodsId` int(20) unsigned NOT NULL,
  `goodsPoint` int(2) unsigned NOT NULL DEFAULT '0',
  `content` text NOT NULL,
  `commentTime` char(30) NOT NULL DEFAULT '',
  `status` enum('1','0') NOT NULL DEFAULT '0',
  `buyer` varchar(255) NOT NULL,
  `goodsName` varchar(255) NOT NULL,
  `profile` char(255) NOT NULL DEFAULT 'default.png',
  PRIMARY KEY (`commentId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- 表的结构 `xy_configure`
--

CREATE TABLE IF NOT EXISTS `xy_configure` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(255) NOT NULL,
  `logo` char(255) NOT NULL DEFAULT 'default.jpg',
  `keywords` char(255) NOT NULL DEFAULT '',
  `description` char(255) NOT NULL DEFAULT '',
  `switch` enum('0','1') NOT NULL DEFAULT '1',
  `copyright` char(255) NOT NULL DEFAULT '',
  `record` char(255) NOT NULL DEFAULT '',
  `tip` char(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `xy_configure`
--

INSERT INTO `xy_configure` (`id`, `title`, `logo`, `keywords`, `description`, `switch`, `copyright`, `record`, `tip`) VALUES
(1, '闲鱼-上闲鱼闲置能换钱', 'Upload/2015-12-04/5661342f76675.jpg', '二手，跳骚，淘我喜欢', '闲鱼-把你的闲置用起来', '1', '2015-2016闲鱼版权所有', '23849238900', '有事请联系:root@godluck.com');

-- --------------------------------------------------------

--
-- 表的结构 `xy_consult`
--

CREATE TABLE IF NOT EXISTS `xy_consult` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(10) NOT NULL DEFAULT '0',
  `question` varchar(255) NOT NULL DEFAULT '',
  `answer` varchar(255) NOT NULL DEFAULT '',
  `goodsId` int(10) NOT NULL,
  `username` varchar(255) NOT NULL,
  `time` varchar(20) NOT NULL DEFAULT '0',
  `status` enum('1','0') NOT NULL DEFAULT '0',
  `goodsName` varchar(255) NOT NULL,
  `sellerId` int(10) NOT NULL,
  `profile` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `xy_consult`
--

INSERT INTO `xy_consult` (`id`, `userId`, `question`, `answer`, `goodsId`, `username`, `time`, `status`, `goodsName`, `sellerId`, `profile`) VALUES
(1, 14, '便宜点！', '', 6, 'godluck', '2015-12-04 11:51:41', '1', '三星galaxy S6', 1, '56610933f0169.png');

-- --------------------------------------------------------

--
-- 表的结构 `xy_goods`
--

CREATE TABLE IF NOT EXISTS `xy_goods` (
  `goodsId` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `goodsName` varchar(60) NOT NULL DEFAULT '',
  `typeId` int(20) NOT NULL DEFAULT '0',
  `typePath` char(30) NOT NULL DEFAULT '',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `preprice` decimal(10,2) NOT NULL DEFAULT '0.00',
  `old` char(32) NOT NULL DEFAULT '',
  `count` int(10) unsigned NOT NULL DEFAULT '0',
  `focus` int(10) unsigned NOT NULL DEFAULT '0',
  `sellerId` int(10) unsigned NOT NULL,
  `color` char(30) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `brand` char(20) NOT NULL DEFAULT '',
  `model` char(20) NOT NULL DEFAULT '',
  `postTime` char(20) NOT NULL DEFAULT '',
  `status` enum('0','1') NOT NULL DEFAULT '0',
  `username` char(32) NOT NULL DEFAULT '',
  `tel` char(20) NOT NULL DEFAULT '',
  `address` char(255) NOT NULL DEFAULT '',
  `recommend` enum('0','1') NOT NULL DEFAULT '0',
  `number` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`goodsId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=41 ;

--
-- 转存表中的数据 `xy_goods`
--

INSERT INTO `xy_goods` (`goodsId`, `goodsName`, `typeId`, `typePath`, `price`, `preprice`, `old`, `count`, `focus`, `sellerId`, `color`, `description`, `brand`, `model`, `postTime`, `status`, `username`, `tel`, `address`, `recommend`, `number`) VALUES
(1, '全新iPhone6s plus', 10, '0-1-6-10', 5500.00, 6000.00, '非全新', 0, 0, 1, '玫瑰金', '朋友送的，还未拆封，先到先得', '苹果', '6s plus 64G', '2015-12-01 09:21:19', '0', 'test11', '12345678900', '北京市昌平区', '1', 1),
(2, '衬衣买大了', 29, '0-2-25-29', 300.00, 500.00, '非全新', 0, 0, 2, '白色', '衬衣买大了！想要的拿走', '优衣库', 'L', '2015-12-01 10:25:12', '0', 'test22', '12738978934', '北京市海淀区', '0', 1),
(3, '毕业了，卖车', 39, '0-3-36-39', 500.00, 1000.00, '5成新', 0, 0, 2, '红色', '毕业了，没法带回家，卖车啦！', '宝马', '碟刹21变速', '2015-12-01 10:29:16', '0', 'test22', '123874979', '北京市昌平区', '0', 1),
(4, '大疆无人机', 42, '0-4-41-42', 1500.00, 2000.00, '8成新', 0, 0, 2, '黑色', '大疆无人机，监测，拍照，巡航，功能强大！', '大疆', '四旋翼', '2015-12-01 10:33:00', '0', 'test22', '12349898798', '北京市大兴区', '0', 1),
(5, '红楼梦', 46, '0-5-43-46', 100.00, 200.00, '7成新', 0, 0, 2, '紫色', '红楼梦是四大名著之一，绝对值得一看！', '机械工业出版社', 'A5', '2015-12-01 10:37:07', '0', 'test22', '12342322332', '北京市海淀区', '1', 1),
(6, '三星galaxy S6', 11, '0-1-6-11', 5000.00, 6000.00, '99新', 0, 0, 1, '银色', '99新三星S6，火速抢购！', '三星', '三星S6', '2015-12-01 12:35:33', '0', 'test11', '12312312332', '北京市昌平区', '0', 1),
(7, '华为P8', 12, '0-1-6-12', 1500.00, 3000.00, '8成新', 0, 0, 1, '银色', '换新机，出售华为P8', '华为', 'P8', '2015-12-01 12:37:35', '0', 'test11', '12345678900', '北京市昌平区', '1', 1),
(8, '小米4', 13, '0-1-6-13', 2000.00, 3000.00, '9成新', 0, 0, 1, '黑色', '米4出售啦！', '小米', '米4', '2015-12-01 12:39:41', '0', 'test11', '12345678900', '北京市昌平区', '1', 1),
(9, '佳能D6单反相机', 14, '0-1-7-14', 5000.00, 8000.00, '8成新', 0, 0, 1, '黑色', '单反送镜头，快来抢购吧！', '佳能', 'D6', '2015-12-01 12:48:52', '0', 'test11', '12345678900', '北京市昌平区', '0', 1),
(10, '数码相机', 15, '0-1-7-15', 400.00, 1000.00, '7成新', 0, 0, 1, '黑色', '换单反，售数码！', '佳能', 'IS4000', '2015-12-01 13:57:13', '0', 'test11', '12312312332', '北京市海淀区', '0', 1),
(11, '出售卡片机', 16, '0-1-7-16', 300.00, 800.00, '8成新', 0, 0, 1, '黑色', '出售卡片机，速速抢购！', '尼康', 'D6000', '2015-12-01 14:01:28', '0', 'test11', '12345678900', '北京市昌平区', '0', 1),
(12, '出售拍立得一枚', 17, '0-1-7-17', 400.00, 600.00, '9成新', 0, 0, 1, '白色', '出售拍立得，送相片纸！', '索尼', 'D8000', '2015-12-01 14:05:09', '0', 'test11', '12345678900', '北京市昌平区', '1', 1),
(13, 'iPad Pro', 18, '0-1-8-18', 4000.00, 4400.00, '全新', 0, 0, 1, '银色', '朋友送的，全新iPad Pro未拆封。', '苹果', '64G', '2015-12-01 14:08:58', '0', 'test11', '12345678900', '北京市昌平区', '1', 1),
(14, 'Surface Pro', 19, '0-1-8-19', 5000.00, 6000.00, '9成新', 0, 0, 1, '黑色', '换新机，苏菲Pro，速来抢购！', 'Surface', '128G', '2015-12-01 14:10:56', '0', 'test11', '12345678900', '北京市昌平区', '0', 1),
(15, '小米平板', 20, '0-1-8-20', 700.00, 1200.00, '8成新', 0, 0, 1, '黑色', '小米平板低价出售！', '小米', '64G', '2015-12-01 14:19:21', '0', 'test11', '12345678900', '北京市昌平区', '0', 1),
(16, '联想Z470', 21, '0-1-9-21', 3000.00, 4500.00, '非全新', 0, 0, 1, '棕色', '要换新电脑了，把这个低价出了。', '联想', 'Z470', '2015-12-01 14:21:05', '0', 'test11', '12345678900', '北京市海淀区', '1', 1),
(17, 'retina MacBook Pro', 22, '0-1-9-22', 12000.00, 17000.00, '8成新', 0, 0, 1, '银色', '果粉转软粉，友情价，先到先得', '苹果', 'Pro', '2015-12-01 14:23:14', '0', 'test11', '12345678900', '北京市海淀区', '0', 1),
(18, 'T恤', 30, '0-2-25-30', 100.00, 400.00, '非全新', 0, 0, 1, '白色', 'T恤没穿过几次，现在不想要了。', '耐克', 'L', '2015-12-01 14:25:51', '0', 'test11', '12345678900', '北京市海淀区', '0', 1),
(19, '出售羽绒服', 31, '0-2-25-31', 300.00, 1000.00, '非全新', 0, 0, 1, '红色', '天冷了，加件衣服吧！', '优衣库', 'L', '2015-12-01 14:27:57', '0', 'test11', '12345678900', '北京市海淀区', '1', 1),
(20, '自行车', 38, '0-3-36-38', 300.00, 1000.00, '非全新', 0, 0, 1, '白色', '带后座，带篮子，居家必备！', '捷安特', '家用', '2015-12-01 14:30:34', '0', 'test11', '12345678900', '北京市海淀区', '0', 1),
(21, '西游记', 46, '0-5-43-46', 50.00, 200.00, '非全新', 0, 0, 1, '黑色', '西游记，四大名著之一，值得一读！', '机械工业出版社', 'A5', '2015-12-01 14:33:10', '0', 'test11', '12345678900', '北京市海淀区', '0', 1),
(22, '深入理解计算机系统', 47, '0-5-44-47', 50.00, 120.00, '非全新', 0, 0, 1, '黑色', '深入理解计算机系统，非常好的一本计算机专业书，计算机专业人才必备。', '机械工业出版社', 'A5', '2015-12-01 14:36:59', '0', 'test11', '12345678900', '北京市昌平区', '0', 1),
(23, 'C++ primer', 47, '0-5-44-47', 40.00, 100.00, '非全新', 0, 0, 1, '白色', 'C++ 专业人才必备！', '机械工业出版社', 'A5', '2015-12-01 14:38:09', '1', 'test11', '12345678900', '北京市海淀区', '1', 1),
(24, '编译原理', 47, '0-5-44-47', 50.00, 130.00, '非全新', 0, 0, 1, '黑色', '编译原理，程序员必备！', '机械工业出版社', 'A5', '2015-12-01 14:37:30', '0', 'test11', '12345678900', '北京市海淀区', '0', 1),
(25, '诛仙', 48, '0-5-45-48', 30.00, 100.00, '非全新', 0, 0, 1, '蓝色', '诛仙，玄幻小说必读之一！', '机械工业出版社', 'A5', '2015-12-01 14:39:21', '0', 'test11', '12345678900', '北京市海淀区', '0', 1),
(26, '出售短裤', 34, '0-2-26-34', 200.00, 300.00, '全新', 0, 0, 1, '黑色', '换季啦！', '优衣库', '21', '2015-12-01 14:46:56', '0', 'test11', '12345678900', '北京市海淀区', '0', 1),
(27, '牛仔短裤', 32, '0-2-26-32', 200.00, 350.00, '99新', 0, 0, 1, '蓝色', '出售牛仔裤，就穿过一次。', '优衣库', '21', '2015-12-01 14:48:50', '0', 'test11', '12345678900', '北京市海淀区', '0', 1),
(28, '独轮车', 38, '0-3-36-38', 1200.00, 2000.00, '9成新', 0, 0, 1, '白色', '出售独轮车，永不堵车！', '捷安特', '独轮', '2015-12-01 14:50:52', '0', 'test11', '12345678900', '北京市海淀区', '0', 1),
(29, '便携式电车', 40, '0-3-37-40', 1500.00, 2000.00, '9成新', 0, 0, 1, '黑色', '便携式电车，畅通无阻', '飞鸽', '锂电池', '2015-12-01 14:53:33', '0', 'test11', '12345678900', '北京市海淀区', '0', 1),
(30, '大疆无人机', 42, '0-4-41-42', 2000.00, 3000.00, '非全新', 0, 0, 1, '白色', '专业航拍！', '大疆', '四旋翼', '2015-12-01 15:05:07', '0', 'test11', '12345678900', '北京市海淀区', '0', 1),
(31, '大疆无人机', 42, '0-4-41-42', 1800.00, 3000.00, '7成新', 0, 0, 1, '黑色', '大疆无人机，买不了吃亏，买不了上当。', '大疆', '四旋翼', '2015-12-01 15:09:22', '0', 'test11', '12345678900', '北京市海淀区', '0', 1),
(32, '大疆无人机', 42, '0-4-41-42', 2000.00, 3000.00, '8成新', 0, 0, 1, '白色', '大疆无人机，航拍神器！', '大疆', '四旋翼', '2015-12-01 15:11:34', '0', 'test11', '12345678900', '北京市海淀区', '0', 1),
(34, '三星NOTE4', 11, '0-1-6-11', 2800.00, 3500.00, '9成新', 0, 0, 1, '白色', '超值三星NOTE4！', '三星', 'NOTE4', '2015-12-03 13:40:06', '0', 'test11', '12345678900', '北京市海淀区', '0', 1),
(35, '华为P6', 12, '0-1-6-12', 500.00, 1000.00, '8成新', 0, 0, 1, '白色', '华为P6，良心推荐！', '华为', 'P6', '2015-12-03 13:48:29', '0', 'test11', '12345678900', '北京市海淀区', '0', 1),
(36, '华为P7', 12, '0-1-6-12', 1000.00, 2000.00, '8成新', 0, 0, 1, '黑色', '换新机，出售华为P7。', '华为', 'P7', '2015-12-03 13:50:06', '0', 'test11', '12345678900', '北京市海淀区', '0', 1),
(37, '华为荣耀', 12, '0-1-6-12', 600.00, 1200.00, '8成新', 0, 0, 1, '银色', '出售华为荣耀，速来抢购！', '华为', '荣耀', '2015-12-03 13:51:48', '0', 'test11', '12345678900', '北京市海淀区', '0', 1),
(38, '华为Mate7', 12, '0-1-6-12', 2000.00, 3000.00, '9成新', 0, 0, 1, '银色', '这么便宜的华为Mate7，你还在等什么！', '华为', 'Mate7', '2015-12-03 13:56:36', '0', 'test11', '12345678900', '北京市海淀区', '0', 1);

-- --------------------------------------------------------

--
-- 表的结构 `xy_goodspic`
--

CREATE TABLE IF NOT EXISTS `xy_goodspic` (
  `goodsId` int(10) unsigned NOT NULL,
  `goodsPic` char(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `xy_goodspic`
--

INSERT INTO `xy_goodspic` (`goodsId`, `goodsPic`) VALUES
(1, 'Upload/2015-12-01/565cf61007447.jpg'),
(1, 'Upload/2015-12-01/565cf610185b4.jpg'),
(1, 'Upload/2015-12-01/565cf61019501.jpg'),
(1, 'Upload/2015-12-01/565cf6101a3c5.jpg'),
(2, 'Upload/2015-12-01/565d050858d45.jpg'),
(2, 'Upload/2015-12-01/565d050859df6.jpg'),
(2, 'Upload/2015-12-01/565d05085adac.jpg'),
(2, 'Upload/2015-12-01/565d05085bc16.jpg'),
(3, 'Upload/2015-12-01/565d05fcb16ad.jpg'),
(3, 'Upload/2015-12-01/565d05fcb286b.jpg'),
(3, 'Upload/2015-12-01/565d05fcb3886.jpg'),
(3, 'Upload/2015-12-01/565d05fcb47d3.jpg'),
(4, 'Upload/2015-12-01/565d06dcd86e9.jpg'),
(4, 'Upload/2015-12-01/565d06dcd984a.jpg'),
(4, 'Upload/2015-12-01/565d06dcda775.jpg'),
(4, 'Upload/2015-12-01/565d06dcdb701.jpg'),
(5, 'Upload/2015-12-01/565d07d334c2a.jpg'),
(5, 'Upload/2015-12-01/565d07d335e67.jpg'),
(6, 'Upload/2015-12-01/565d2395e1a19.jpg'),
(6, 'Upload/2015-12-01/565d2395e914f.jpg'),
(6, 'Upload/2015-12-01/565d2395e9fbe.jpg'),
(6, 'Upload/2015-12-01/565d2395ead93.jpg'),
(7, 'Upload/2015-12-01/565d240f1c098.jpg'),
(7, 'Upload/2015-12-01/565d240f1d104.jpg'),
(7, 'Upload/2015-12-01/565d240f1dee0.jpg'),
(7, 'Upload/2015-12-01/565d240f1ed7f.jpg'),
(8, 'Upload/2015-12-01/565d248d8b468.jpg'),
(8, 'Upload/2015-12-01/565d248d8c614.jpg'),
(8, 'Upload/2015-12-01/565d248d8d6dd.jpg'),
(8, 'Upload/2015-12-01/565d248d8e72e.jpg'),
(9, 'Upload/2015-12-01/565d26b452e21.jpg'),
(9, 'Upload/2015-12-01/565d26b454075.jpg'),
(9, 'Upload/2015-12-01/565d26b455158.jpg'),
(9, 'Upload/2015-12-01/565d26b4560cd.jpg'),
(10, 'Upload/2015-12-01/565d36b909200.jpg'),
(10, 'Upload/2015-12-01/565d36b90a384.jpg'),
(10, 'Upload/2015-12-01/565d36b90b4b3.jpg'),
(10, 'Upload/2015-12-01/565d36b90c351.jpg'),
(11, 'Upload/2015-12-01/565d37b8ac4b3.jpg'),
(11, 'Upload/2015-12-01/565d37b8ad721.jpg'),
(11, 'Upload/2015-12-01/565d37b8ae5ef.jpg'),
(11, 'Upload/2015-12-01/565d37b8af48f.jpg'),
(11, 'Upload/2015-12-01/565d37b8b033f.jpg'),
(11, 'Upload/2015-12-01/565d37b8b1198.jpg'),
(11, 'Upload/2015-12-01/565d37b8b2058.jpg'),
(12, 'Upload/2015-12-01/565d3895a1700.jpg'),
(12, 'Upload/2015-12-01/565d3895a27d1.jpg'),
(12, 'Upload/2015-12-01/565d3895a37b0.jpg'),
(12, 'Upload/2015-12-01/565d3895a46c9.jpg'),
(12, 'Upload/2015-12-01/565d3895a55c3.jpg'),
(12, 'Upload/2015-12-01/565d3895a642a.jpg'),
(13, 'Upload/2015-12-01/565d397aa576f.jpg'),
(13, 'Upload/2015-12-01/565d397aa685e.jpg'),
(13, 'Upload/2015-12-01/565d397aa7705.jpg'),
(13, 'Upload/2015-12-01/565d397aa8544.jpg'),
(14, 'Upload/2015-12-01/565d39f0e1dc6.jpg'),
(14, 'Upload/2015-12-01/565d39f0e30bb.jpg'),
(14, 'Upload/2015-12-01/565d39f0e3f3a.jpg'),
(14, 'Upload/2015-12-01/565d39f0e4e43.jpg'),
(14, 'Upload/2015-12-01/565d39f0e5eb3.jpg'),
(14, 'Upload/2015-12-01/565d39f0e6d97.jpg'),
(15, 'Upload/2015-12-01/565d3be90b69b.jpg'),
(15, 'Upload/2015-12-01/565d3be90c900.jpg'),
(15, 'Upload/2015-12-01/565d3be90d83b.jpg'),
(15, 'Upload/2015-12-01/565d3be90e944.jpg'),
(16, 'Upload/2015-12-01/565d3c518085e.jpg'),
(16, 'Upload/2015-12-01/565d3c5181c21.jpg'),
(16, 'Upload/2015-12-01/565d3c5182c1d.jpg'),
(16, 'Upload/2015-12-01/565d3c5183b61.jpg'),
(16, 'Upload/2015-12-01/565d3c5184a18.jpg'),
(16, 'Upload/2015-12-01/565d3c5185874.jpg'),
(17, 'Upload/2015-12-01/565d3cd20f365.jpg'),
(17, 'Upload/2015-12-01/565d3cd210478.jpg'),
(17, 'Upload/2015-12-01/565d3cd211459.jpg'),
(17, 'Upload/2015-12-01/565d3cd2122bd.jpg'),
(17, 'Upload/2015-12-01/565d3cd213237.jpg'),
(18, 'Upload/2015-12-01/565d3d6f09cb4.jpg'),
(18, 'Upload/2015-12-01/565d3d6f0ad75.jpg'),
(18, 'Upload/2015-12-01/565d3d6f0be10.jpg'),
(18, 'Upload/2015-12-01/565d3d6f0ce13.jpg'),
(19, 'Upload/2015-12-01/565d3dede1d08.jpg'),
(19, 'Upload/2015-12-01/565d3dede2ec8.jpg'),
(19, 'Upload/2015-12-01/565d3dede3f3c.jpg'),
(19, 'Upload/2015-12-01/565d3dede4eec.jpg'),
(20, 'Upload/2015-12-01/565d3e8a10849.jpg'),
(20, 'Upload/2015-12-01/565d3e8a11b9d.jpg'),
(20, 'Upload/2015-12-01/565d3e8a12bc7.jpg'),
(20, 'Upload/2015-12-01/565d3e8a13ae2.jpg'),
(20, 'Upload/2015-12-01/565d3e8a148fc.jpg'),
(21, 'Upload/2015-12-01/565d3f267abd0.jpg'),
(22, 'Upload/2015-12-01/565d400b59089.jpg'),
(23, 'Upload/2015-12-01/565d40512a8c4.jpg'),
(24, 'Upload/2015-12-01/565d402af0db2.jpg'),
(25, 'Upload/2015-12-01/565d4099c400c.jpg'),
(26, 'Upload/2015-12-01/565d426100a52.jpg'),
(26, 'Upload/2015-12-01/565d426101eff.jpg'),
(26, 'Upload/2015-12-01/565d42610303b.jpg'),
(26, 'Upload/2015-12-01/565d426103f18.jpg'),
(27, 'Upload/2015-12-01/565d42d20d143.jpg'),
(28, 'Upload/2015-12-01/565d434cb3ac6.jpg'),
(29, 'Upload/2015-12-01/565d43ede0089.jpg'),
(29, 'Upload/2015-12-01/565d43ede150c.jpg'),
(29, 'Upload/2015-12-01/565d43ede2398.jpg'),
(29, 'Upload/2015-12-01/565d43ede3258.jpg'),
(30, 'Upload/2015-12-01/565d46a3867cf.jpg'),
(30, 'Upload/2015-12-01/565d46a387967.jpg'),
(30, 'Upload/2015-12-01/565d46a38894f.jpg'),
(30, 'Upload/2015-12-01/565d46a3898f6.jpg'),
(30, 'Upload/2015-12-01/565d46a38a8c0.jpg'),
(31, 'Upload/2015-12-01/565d47a2c5fab.jpg'),
(31, 'Upload/2015-12-01/565d47a2c7478.jpg'),
(32, 'Upload/2015-12-01/565d4826c73d7.jpg'),
(32, 'Upload/2015-12-01/565d4826c8441.jpg'),
(32, 'Upload/2015-12-01/565d4826c9285.jpg'),
(34, 'Upload/2015-12-03/565fd5b68a0e4.jpg'),
(34, 'Upload/2015-12-03/565fd5b68b038.jpg'),
(34, 'Upload/2015-12-03/565fd5b68be4f.jpg'),
(34, 'Upload/2015-12-03/565fd5b68caeb.jpg'),
(34, 'Upload/2015-12-03/565fd5b68d946.jpg'),
(35, 'Upload/2015-12-03/565fd7addfbbd.jpg'),
(35, 'Upload/2015-12-03/565fd7ade0daf.jpg'),
(35, 'Upload/2015-12-03/565fd7ade1cb4.jpg'),
(35, 'Upload/2015-12-03/565fd7ade2e18.jpg'),
(36, 'Upload/2015-12-03/565fd80e57021.jpg'),
(36, 'Upload/2015-12-03/565fd80e58178.jpg'),
(36, 'Upload/2015-12-03/565fd80e59185.jpg'),
(37, 'Upload/2015-12-03/565fd874e1fb5.jpg'),
(37, 'Upload/2015-12-03/565fd874e340e.jpg'),
(37, 'Upload/2015-12-03/565fd874e49d2.jpg'),
(38, 'Upload/2015-12-03/565fd994d9a75.jpg'),
(38, 'Upload/2015-12-03/565fd994daaac.jpg'),
(38, 'Upload/2015-12-03/565fd994db888.jpg');

-- --------------------------------------------------------

--
-- 表的结构 `xy_links`
--

CREATE TABLE IF NOT EXISTS `xy_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `linkName` char(255) NOT NULL DEFAULT '',
  `addr` char(255) NOT NULL DEFAULT '',
  `logo` char(255) NOT NULL DEFAULT '',
  `email` char(32) NOT NULL DEFAULT '',
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `addTime` char(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- 转存表中的数据 `xy_links`
--

INSERT INTO `xy_links` (`id`, `linkName`, `addr`, `logo`, `email`, `status`, `addTime`) VALUES
(1, '谷歌', 'http://www.google.com.hk', 'Upload/2015-12-01/565cf7ba76811.jpg', 'test@qq.com', '1', '2015-11-23 14:47:21'),
(3, '百度test', 'http://www.baidu.com', 'Upload/2015-12-01/565cf793439e8.jpg', 'test@qq.com', '1', '2015-11-23 14:47:20'),
(4, '腾讯QQ', 'http://www.qq.com/', 'Upload/2015-12-01/565cf7aaa7c9f.jpg', '123@qq.com', '1', '2015-11-23 14:55:03'),
(5, '阿里', 'http://www.alibaba.com', 'Upload/2015-12-01/565cf7c4260ce.jpg', '123321@qq.com', '1', '2015-11-23 14:58:32');

-- --------------------------------------------------------

--
-- 表的结构 `xy_manage`
--

CREATE TABLE IF NOT EXISTS `xy_manage` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` char(32) NOT NULL DEFAULT '',
  `password` char(32) NOT NULL DEFAULT '',
  `auth` enum('0','1','2') NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- 转存表中的数据 `xy_manage`
--

INSERT INTO `xy_manage` (`id`, `username`, `password`, `auth`) VALUES
(1, 'test', 'e10adc3949ba59abbe56e057f20f883e', '2'),
(2, 'root', 'e10adc3949ba59abbe56e057f20f883e', '2'),
(3, 'root1', '96e79218965eb72c92a549dd5a330112', '1'),
(4, 'opps', '1e4ed0a28a965ed6437fc7e3a9af913b', '2'),
(5, 'test1', '96e79218965eb72c92a549dd5a330112', '1'),
(6, 'test003', '96e79218965eb72c92a549dd5a330112', '0');

-- --------------------------------------------------------

--
-- 表的结构 `xy_order`
--

CREATE TABLE IF NOT EXISTS `xy_order` (
  `orderId` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(20) unsigned NOT NULL,
  `orderTime` char(30) NOT NULL DEFAULT '',
  `goodsName` char(20) NOT NULL DEFAULT '',
  `goodsId` int(20) unsigned NOT NULL,
  `goodsPrice` decimal(10,2) NOT NULL DEFAULT '0.00',
  `amount` int(5) unsigned NOT NULL DEFAULT '0',
  `orderPrice` decimal(10,2) NOT NULL DEFAULT '0.00',
  `status` enum('0','1') DEFAULT '0',
  PRIMARY KEY (`orderId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

--
-- 转存表中的数据 `xy_order`
--

INSERT INTO `xy_order` (`orderId`, `userId`, `orderTime`, `goodsName`, `goodsId`, `goodsPrice`, `amount`, `orderPrice`, `status`) VALUES
(1, 1, '1449116097', '华为P8', 7, 1500.00, 1, 1500.00, '0'),
(4, 13, '1449119630', '数码相机', 10, 400.00, 1, 400.00, '0'),
(12, 14, '1449199120', '华为Mate7', 38, 2000.00, 1, 2000.00, '1'),
(14, 14, '1449208484', '出售卡片机', 11, 300.00, 1, 300.00, '1'),
(15, 14, '1449208484', '联想Z470', 16, 3000.00, 1, 3000.00, '1'),
(16, 14, '1449208484', 'retina MacBook Pro', 17, 12000.00, 1, 12000.00, '1');

-- --------------------------------------------------------

--
-- 表的结构 `xy_ppt`
--

CREATE TABLE IF NOT EXISTS `xy_ppt` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `logo` char(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `xy_ppt`
--

INSERT INTO `xy_ppt` (`id`, `logo`) VALUES
(1, 'Upload/2015-12-04/5661341553748.jpg'),
(2, 'Upload/2015-12-01/565d006cd8c2b.jpg'),
(3, 'Upload/2015-12-01/565d0088760c9.jpg');

-- --------------------------------------------------------

--
-- 表的结构 `xy_question`
--

CREATE TABLE IF NOT EXISTS `xy_question` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(10) NOT NULL DEFAULT '0',
  `question` varchar(255) NOT NULL DEFAULT '',
  `answer` varchar(255) NOT NULL DEFAULT '',
  `goodsId` int(10) NOT NULL,
  `username` varchar(255) NOT NULL,
  `time` varchar(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=23 ;

--
-- 转存表中的数据 `xy_question`
--

INSERT INTO `xy_question` (`id`, `userId`, `question`, `answer`, `goodsId`, `username`, `time`) VALUES
(2, 14, 'godluck', '', 29, 'godluck1', '0'),
(3, 14, 'godluck', '', 29, 'godluck2', '0'),
(4, 14, 'godluck', '', 29, 'godluck3', '0'),
(5, 0, '1+1=?', '2', 0, 'test002', '0'),
(6, 0, '1+1=?', '2', 0, 'test002', '0'),
(7, 0, '1+1=?', '2', 0, 'test002', '0'),
(11, 0, '1', '1', 0, 'test111', '0'),
(12, 0, '2', '2', 0, 'test111', '0'),
(13, 0, '3', '3', 0, 'test111', '0'),
(14, 0, '1', '1', 0, 'test001', '0'),
(15, 0, '1', '1', 0, 'test001', '0'),
(16, 0, '1', '1', 0, 'test001', '0'),
(17, 0, '11', '11', 0, 'demo01', '0'),
(18, 0, '11', '11', 0, 'demo01', '0'),
(19, 0, '11', '11', 0, 'demo01', '0'),
(20, 0, '11', '11', 0, 'demo03', '0'),
(21, 0, '22', '22', 0, 'demo03', '0'),
(22, 0, '33', '33', 0, 'demo03', '0');

-- --------------------------------------------------------

--
-- 表的结构 `xy_type`
--

CREATE TABLE IF NOT EXISTS `xy_type` (
  `id` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `typeName` char(30) NOT NULL DEFAULT '',
  `parentId` int(20) NOT NULL DEFAULT '0',
  `path` varchar(30) NOT NULL DEFAULT '',
  `status` enum('0','1') DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=51 ;

--
-- 转存表中的数据 `xy_type`
--

INSERT INTO `xy_type` (`id`, `typeName`, `parentId`, `path`, `status`) VALUES
(1, '数码', 0, '0', '1'),
(2, '衣', 0, '0', '1'),
(3, '行', 0, '0', '1'),
(4, '玩', 0, '0', '1'),
(5, '书', 0, '0', '1'),
(6, '手机', 1, '0-1', '1'),
(7, '相机', 1, '0-1', '1'),
(8, '平板', 1, '0-1', '1'),
(9, '电脑', 1, '0-1', '1'),
(10, '苹果', 3, '0-3', '1'),
(11, '三星', 6, '0-1-6', '1'),
(12, '华为', 6, '0-1-6', '1'),
(13, '小米', 6, '0-1-6', '1'),
(14, '单反', 7, '0-1-7', '1'),
(15, '数码', 7, '0-1-7', '1'),
(16, '卡片机', 7, '0-1-7', '1'),
(17, '拍立得', 7, '0-1-7', '1'),
(18, 'iPad', 8, '0-1-8', '1'),
(19, 'Surface', 8, '0-1-8', '1'),
(20, '小米平板', 8, '0-1-8', '1'),
(21, 'Windows', 9, '0-1-9', '1'),
(22, 'Mac OS', 9, '0-1-9', '1'),
(23, 'Linux', 9, '0-1-9', '1'),
(24, 'Unix', 9, '0-1-9', '1'),
(25, '上衣', 2, '0-2', '1'),
(26, '裤子', 2, '0-2', '1'),
(27, '帽子', 2, '0-2', '1'),
(28, '鞋', 2, '0-2', '1'),
(29, '衬衣', 25, '0-2-25', '1'),
(30, 'T恤', 25, '0-2-25', '1'),
(31, '羽绒服', 25, '0-2-25', '1'),
(32, '牛仔裤', 26, '0-2-26', '1'),
(33, '西裤', 26, '0-2-26', '1'),
(34, '休闲裤', 26, '0-2-26', '1'),
(35, '运动裤', 26, '0-2-26', '1'),
(36, '自行车', 3, '0-3', '1'),
(37, '电动车', 3, '0-3', '1'),
(38, '休闲车', 36, '0-3-36', '1'),
(39, '户外车', 36, '0-3-36', '1'),
(40, '飞鸽牌', 37, '0-3-37', '1'),
(41, '飞行器', 4, '0-4', '1'),
(42, '大疆四旋翼', 41, '0-4-41', '1'),
(43, '文学类', 5, '0-5', '1'),
(44, '技术类', 5, '0-5', '1'),
(45, '小说', 5, '0-5', '1'),
(46, '古典名著', 43, '0-5-43', '1'),
(47, '计算机类', 44, '0-5-44', '1'),
(48, '玄幻', 45, '0-5-45', '1'),
(49, '武侠', 45, '0-5-45', '1');

-- --------------------------------------------------------

--
-- 表的结构 `xy_user`
--

CREATE TABLE IF NOT EXISTS `xy_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` char(32) NOT NULL DEFAULT '',
  `password` char(32) NOT NULL DEFAULT '',
  `nickname` char(32) NOT NULL DEFAULT '',
  `profile` varchar(30) NOT NULL DEFAULT 'default.png',
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `account` decimal(10,0) NOT NULL,
  `recycle` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=20 ;

--
-- 转存表中的数据 `xy_user`
--

INSERT INTO `xy_user` (`id`, `username`, `password`, `nickname`, `profile`, `status`, `account`, `recycle`) VALUES
(1, 'test11', 'e10adc3949ba59abbe56e057f20f883e', 'test11', '565da0c5d59f8.png', '1', -204600, '1'),
(2, 'test22', 'e10adc3949ba59abbe56e057f20f883e', 'test22', 'default.png', '1', 0, '1'),
(9, 'test001', '96e79218965eb72c92a549dd5a330112', 'test001', '565ee26367e20.jpg', '1', 0, '1'),
(12, 'test111', '96e79218965eb72c92a549dd5a330112', 'test111', '565f032d87b4d.jpg', '1', 0, '1'),
(13, 'test33', 'e10adc3949ba59abbe56e057f20f883e', 'test33', 'default.png', '1', 0, '1'),
(14, 'godluck', 'e10adc3949ba59abbe56e057f20f883e', 'godluck', '56610933f0169.png', '1', -52300, '1'),
(16, 'demo01', '96e79218965eb72c92a549dd5a330112', 'demo01', '566124f0b8902.jpg', '1', 0, '1'),
(17, 'demo02', 'e3ceb5881a0a1fdaad01296d7554868d', '', 'default.png', '0', 0, '1'),
(18, 'demo03', '1a100d2c0dab19c4430e7d73762b3423', 'demo03', '56612da61c993.jpg', '1', 0, '1'),
(19, 'demo04', 'e3ceb5881a0a1fdaad01296d7554868d', '', 'default.png', '0', 0, '1');

-- --------------------------------------------------------

--
-- 表的结构 `xy_userdetail`
--

CREATE TABLE IF NOT EXISTS `xy_userdetail` (
  `userId` int(10) unsigned NOT NULL DEFAULT '0',
  `sex` enum('0','1','2') NOT NULL DEFAULT '2',
  `info` text NOT NULL,
  `tel` char(15) NOT NULL DEFAULT '',
  `qq` char(15) NOT NULL DEFAULT '',
  `email` char(30) NOT NULL DEFAULT '',
  `regTime` char(30) NOT NULL DEFAULT '',
  `sign` char(50) NOT NULL DEFAULT '',
  `school` char(30) NOT NULL DEFAULT '',
  `class` char(30) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `xy_userdetail`
--

INSERT INTO `xy_userdetail` (`userId`, `sex`, `info`, `tel`, `qq`, `email`, `regTime`, `sign`, `school`, `class`) VALUES
(1, '2', '', '12345678900', '', 'test@qq.com', '', '', '', ''),
(2, '2', '', '19876543209', '', 'test22@qq.com', '', '', '', ''),
(9, '1', '', '11111111111', '', '1234@qq.com', '', '', '', ''),
(12, '1', '123', '12378467346', '', '1040597898@qq.com', '', '321', '123', ''),
(13, '2', '', '12312313131', '', 'test33@qq.com', '', '', '', ''),
(14, '2', '', '12328897219', '', 'godluck@qq.com', '', '', '', ''),
(16, '1', '111', '13199999999', '', '1234@qq.com', '', '111', '111', ''),
(18, '1', '111', '12378467346', '', '123@qq.com', '', '111', '111', '');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
