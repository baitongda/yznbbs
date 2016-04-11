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

function convert_money($money) {
    $money = (string)$money;
    $coppers = substr($money,-2) ? substr($money,-2) : 0;
    $silver = substr($money,-4,-2) ? substr($money,-4,-2) : 0;
    $glod = substr($money,0,-4) ? substr($money,0,-4) : 0;
    if($coppers == 0){
        $coppers = '0 <img src="//cdn.v2ex.com/static/img/bronze.png" alt="B" align="absmiddle" border="0"> ';   
    }else{
        $coppers =$coppers.' <img src="//cdn.v2ex.com/static/img/bronze.png" alt="B" align="absmiddle" border="0"> ';    
    }
     if($silver == 0){
        $silver = "";   
    }else{
        $silver= $silver.' <img src="//cdn.v2ex.com/static/img/silver.png" alt="S" align="absmiddle" border="0" style="padding-bottom: 2px;"> ';    
    }
     if($glod == 0){
        $glod = '';   
    }else{
        $glod = $glod.' <img src="//cdn.v2ex.com/static/img/gold.png" alt="G" align="absmiddle" border="0" style="padding-bottom: 2px;"> ';    
    }
    return "{$glod}{$silver}{$coppers}";
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
   if(is_login()!== 0){
       redirect(U("Index/index"));
   }
};

/** 
 *禁止未登录会员进入发布页面
 */  
function _login_state(){
   if(is_login() == 0){
       redirect(U("Index/index"));
   }
};

/** 
 *根据积分查询对应等级
 */
function getLevelByScore($score){
    $level = getLevelConfig();
    $level = array_reverse($level, true);
    foreach ($level as $key => $value) {
       if ($score >= $key) {
           return $value;
       }
    }
    
    //查询无结果，返回最高等级
    $keys = array_keys($level);
    $max_key = $keys[count($level) - 1];
    return $level[$max_key];

};

/** 
 *对等级进行数组转换
 */
function getLevelConfig(){
    $level=C('USER_LEVEL');
    if ($level == '') {
        return array(
            0 => 'Lv1 实习',
            50 => 'Lv2 试用',
            100 => 'Lv3 转正',
            200 => 'Lv4 助理',
            400 => 'Lv5 经理',
            800 => 'Lv6 董事',
            1600 => 'Lv7 董事长'
        );
    } else {
        $level = str_replace("\r", '', $level);
        $level = explode("\n", $level);
       foreach ($level as $v) {
                $temp = explode(':', $v);
                $result[$temp[0]] = $temp[1];
       }
       return $result;
   }

}

function getCurrentUserInfo($score){
    $data['current'] = getLevelByScore($score);//当前等级
    $level = getLevelConfig();//所有等级
    foreach ($level as $key => $value) {
          if($score > $key){
              $data['before_level_need']=$key;
          }
          if ($score <= $key) {
              $data['next'] = $value;
              $data['upgrade_require'] = $key;
              break;
          }
    }
    if (empty($data['next'])) {
        //查询无结果，返回最高等级
        $keys = array_keys($level);
        $max_key = $keys[count($level) - 1];
        $data['next'] = $level[$max_key];
    }
    $data['left'] =$data['upgrade_require']-$score;
    $data['percent']=number_format((1-$data['left']/($data['upgrade_require']-$data['before_level_need']))*100,1);
    return $data;



}