<?php
/**
 * 系统公共库文件
 * 主要定义系统公共函数库
 */


/**
 * 头像获取 暂时用V2EX的
 * @param  array  $data 
 * @return string       
 */
function get_avatar($data,$size) {
    $sign =sha1($data);
    return "https://cdn.v2ex.co/gravatar/".$sign."?s=".$size."&d=retro";
}

/**
 * 数据签名认证
 * @param  array  $data 被认证的数据
 * @return string       签名
 * @author 麦当苗儿 <zuojiazi@vip.qq.com>
 */
function data_auth_sign($data) {
    //数据类型检测
    if(!is_array($data)){
        $data = (array)$data;
    }
    ksort($data); //排序
    $code = http_build_query($data); //url编码并生成query字符串
    $sign = sha1($code); //生成签名
    return $sign;
}


/**
 * 返回时间离当前时间差
 * @param int $time
 * @return string 返回XX小时前 XX天前 XX月前 XX年前
 */
function check_time($str){
      $nowtime = time();
      $cle =$nowtime-$str; //得出时间戳差值
      $y = floor($cle/3600/24/30/12);//年
	  $m = floor($cle/3600/24/30);//月
      $d = floor($cle/3600/24);//日
      $h = floor($cle/3600);  //小时
      $i = floor($cle/60);//分钟
	  $s = floor($cle);//秒
	  $_difArr=array($y,$m,$d,$h,$i,$s);
	  $_unitArr =array('年','个月','天','小时','分钟','秒');
	   for($i=0;$i<6;$i++){
           if($_difArr[$i]!=0){
		          return $_difArr[$i]." ".$_unitArr[$i];
           }
	   }
}

/**
 * markdown语法解析 sf官方
 * @param int $time
 * @return string 解析后的html
 */
function resolve_markdown($text){
     $parser = new \Think\Parser;
     $html = $parser->makeHtml($text);
     return $html;
}

/**
 * 时间戳格式化
 * @param int $time
 * @return string 完整的时间显示
 * @author huajie <banhuajie@163.com>
 */
function time_format($time = NULL,$format='Y-m-d H:i'){
    $time = $time === NULL ? NOW_TIME : intval($time);
    return date($format, $time);
}

/**
 * 检测用户是否登录
 * @return integer 0-未登录，大于0-当前登录用户ID
 * @author 麦当苗儿 <zuojiazi@vip.qq.com>
 */
function is_login(){
    $user = session('user_auth');
    if (empty($user)) {
        return 0;
    } else {
        return session('user_auth_sign') == data_auth_sign($user) ? $user['id'] : 0;
    }
}

/**
 * 根据ID获取板块名
 * @param  integer $id 用户ID
 * @return string       用户名
 */
function get_node($id = 0){
    static $list;
    /* 获取缓存数据 */
    if(empty($list)){
        $list = S('sys_active_node_list');
    }
    
    /* 查找板块信息 */
    $key = "n{$id}";
    if(isset($list[$key])){ //已缓存，直接使用
        $name = $list[$key];
    } else {
        $map['id'] = $id;
        $info = M("Node")->where($map)->field('title')->find();
        $name = $list[$key] = $info['title'];
        
        /* 缓存用户 */
       $count = count($list);
       $max   = C('USER_MAX_CACHE');
       while ($count-- > $max) {
           array_shift($list);
       }
       S('sys_active_node_list', $list);
    }
     return $name;
}


/**
 * 根据用户ID获取用户名
 * @param  integer $id 用户ID
 * @return string       用户名
 */
function get_username($id = 0){
    static $list;
    if(!($id && is_numeric($id))){ //为0获取当前登录用户名
        return session('user_auth.username');
    }
    
    /* 获取缓存数据 */
    if(empty($list)){
        $list = S('sys_active_user_list');
    }
    
    /* 查找用户信息 */
    $key = "u{$id}";
    if(isset($list[$key])){ //已缓存，直接使用
        $name = $list[$key];
    } else {
        $map['id'] = $id;
        $info = M("Member")->where($map)->field('username')->find();
        $name = $list[$key] = $info['username'];
        
        /* 缓存用户 */
       $count = count($list);
       $max   = C('USER_MAX_CACHE');
       while ($count-- > $max) {
           array_shift($list);
       }
       S('sys_active_user_list', $list);
    }
     return $name;
}