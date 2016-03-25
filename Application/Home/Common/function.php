<?php
/**
 * 前台公共库文件
 * 主要定义前台公共函数库
 */

/**
 * 检测验证码
 * @param  integer $id 验证码ID
 * @return boolean     检测结果
 */
function check_verify($code, $id = ''){
	$verify = new \Think\Verify();
	return $verify->check($code, $id);
}

/**
 * 获取文档标题
 * @param int $cover_id
 * @param string $field
 * @return 完整的数据  或者  指定的$field字段值
 */
function get_title($title_id, $field = null){
    if(empty($title_id)){
        return false;
    }
    $res = M('Topics')->where(array('id'=>$title_id))->field('title')->find();
    return $res['title'];
}

/**
 * 设置灌水时间和ID
 * @param  integer $id 用户ID
 * @return string       用户名
 */
function set_spam($id = 0){
    $list=strtotime("+60 seconds");
    S('sys_active_spam_u'.$id,$list,60);
}

/**
 * 查询灌水时间
 * @param  integer $id 用户ID
 * @return string       用户名
 */
function get_spam($id = 0){
    $spam_time=S('sys_active_spam_u'.$id);
    if(!empty($spam_time)){ //已缓存，直接使用
         $differ=($spam_time-time())%60;
         return $differ; 
    }
    return false;
}

/** 
 *禁止已登录会员进入登陆和注册页面 
 */  
function _log_reg_state(){
   if(isset($_SESSION['user_auth']['username']) || !empty($_SESSION['user_auth']['username'])){
       redirect(U("Index/index"));
   }
};

/** 
 *禁止未登录会员进入发布页面
 */  
function _login_state(){
   if(!isset($_SESSION['user_auth']['username']) || empty($_SESSION['user_auth']['username'])){
       redirect(U("Index/index"));
   }
};