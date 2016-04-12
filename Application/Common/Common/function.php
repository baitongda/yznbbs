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

/**
 * 调用系统的API接口方法（静态方法）
 * api('User/getName','id=5'); 调用公共模块的User接口的getName方法
 * api('Admin/User/getName','id=5');  调用Admin模块的User接口
 * @param  string  $name 格式 [模块名]/接口名/方法名
 * @param  array|string  $vars 参数
 */
function api($name,$vars=array()){
    $array     = explode('/',$name);
    $method    = array_pop($array);
    $classname = array_pop($array);
    $module    = $array? array_pop($array) : 'Common';
    $callback  = $module.'\\Api\\'.$classname.'Api::'.$method;
    if(is_string($vars)) {
        parse_str($vars,$vars);
    }
    return call_user_func_array($callback,$vars);
}

/**
 * 记录行为日志，并执行该行为的规则
 * @param string $action 行为标识
 * @param string $model 触发行为的模型名
 * @param int $record_id 触发行为的记录id
 * @param int $user_id 执行行为的用户id
 * @return boolean
 * @author huajie <banhuajie@163.com>
 */
function action_log($action = null, $model = null, $record_id = null, $user_id = null){
    //参数检查
    if(empty($action) || empty($model) || empty($record_id)){
        return '参数不能为空';
    }
    if(empty($user_id)){
        $user_id = is_login();
    }
    //查询行为,判断是否执行
    $action_info = M('Action')->getByName($action);
    if($action_info['status'] != 1){
        return '该行为被禁用或删除';
    }
    
    //插入行为日志
    $data['action_id']      =   $action_info['id'];
    $data['user_id']        =   $user_id;
    $data['action_ip']      =   ip2long(get_client_ip());
    $data['model']          =   $model;
    $data['record_id']      =   $record_id;
    $data['create_time']    =   NOW_TIME;

    //解析日志规则,生成日志备注
    if(!empty($action_info['log'])){
        if(preg_match_all('/\[(\S+?)\]/', $action_info['log'], $match)){
            $log['user']    =   $user_id;
            $log['record']  =   $record_id;
            $log['model']   =   $model;
            $log['time']    =   NOW_TIME;
            $log['data']    =   array('user'=>$user_id,'model'=>$model,'record'=>$record_id,'time'=>NOW_TIME);
            foreach ($match[1] as $value){
                $param = explode('|', $value);
                if(isset($param[1])){
                    $replace[] = call_user_func($param[1],$log[$param[0]]);//user|get_username
                }else{
                    $replace[] = $log[$param[0]];
                }
            }
            $data['remark'] =   str_replace($match[0], $replace, $action_info['log']);
        }else{
            $data['remark'] =   $action_info['log'];
        }
    }else{
        //未定义日志规则，记录操作url
        $data['remark']     =   '操作url：'.$_SERVER['REQUEST_URI'];
    }

    M('ActionLog')->add($data);
    
    if(!empty($action_info['rule'])){
        //解析行为
        $rules = parse_action($action, $user_id);

        //执行行为
        $res = execute_action($rules, $action_info['id'], $user_id);
        
    }

}

/**
 * 解析行为规则
 * 规则定义  table:$table|field:$field|condition:$condition|rule:$rule[|cycle:$cycle|max:$max][;......]
 * 规则字段解释：table->要操作的数据表，不需要加表前缀；
 *              field->要操作的字段；
 *              condition->操作的条件，目前支持字符串，默认变量{$self}为执行行为的用户
 *              rule->对字段进行的具体操作，目前支持四则混合运算，如：1+score*2/2-3
 *              cycle->执行周期，单位（小时），表示$cycle小时内最多执行$max次
 *              max->单个周期内的最大执行次数（$cycle和$max必须同时定义，否则无效）
 * 单个行为后可加 ； 连接其他规则
 * @param string $action 行为id或者name
 * @param int $self 替换规则里的变量为执行用户的id
 * @return boolean|array: false解析出错 ， 成功返回规则数组
 * @author huajie <banhuajie@163.com>
 */
function parse_action($action , $self){
    if(empty($action)){
        return false;
    }

    //参数支持id或者name
    if(is_numeric($action)){
        $map = array('id'=>$action);
    }else{
        $map = array('name'=>$action);
    }

    //查询行为信息
    $info = M('Action')->where($map)->find();
    if(!$info || $info['status'] != 1){
        return false;
    }

    //解析规则:table:$table|field:$field|condition:$condition|rule:$rule[|cycle:$cycle|max:$max][;......]
    $rules = $info['rule'];
    $rules = str_replace('{$self}', $self, $rules);
    $rules = explode(';', $rules);
    $return = array();
    foreach ($rules as $key=>&$rule){
        $rule = explode('|', $rule);
        foreach ($rule as $k=>$fields){
            $field = empty($fields) ? array() : explode(':', $fields);
            if(!empty($field)){
                $return[$key][$field[0]] = $field[1];
            }
        }
        //cycle(检查周期)和max(周期内最大执行次数)必须同时存在，否则去掉这两个条件
        if(!array_key_exists('cycle', $return[$key]) || !array_key_exists('max', $return[$key])){
            unset($return[$key]['cycle'],$return[$key]['max']);
        }
    }

    return $return;
}

/**
 * 执行行为
 * @param array $rules 解析后的规则数组
 * @param int $action_id 行为id
 * @param array $user_id 执行的用户id
 * @return boolean false 失败 ， true 成功
 * @author huajie <banhuajie@163.com>
 */
function execute_action($rules = false, $action_id = null, $user_id = null){
    if(!$rules || empty($action_id) || empty($user_id)){
        return false;
    }
    $return = true;
    foreach ($rules as $rule){

        //检查执行周期
        if(!empty($rule['max'])){
            $map = array('action_id'=>$action_id, 'user_id'=>$user_id);
            $map['create_time'] = array('gt', NOW_TIME - intval($rule['cycle']) * 3600);
            $exec_count = M('ActionLog')->where($map)->count();
            if($exec_count > $rule['max']){
                continue;
            }
        }       

        //执行数据库操作
        $Model = M(ucfirst($rule['table']));
        $field = $rule['field'];
        $res = $Model->where($rule['condition'])->setField($field, array('exp', $rule['rule']));

        if(!$res){
            $return = false;
        }
    }
    return $return;
}

/**/
function getFormate($arr){
    $top = $child = array();
    foreach($arr as $val){
        if($val['pid'] == 0){
            $top[] = $val;
        }else{
            $child[ $val['pid'] ][] =    $val; 
        }
    }
    return array('top' => $top, 'child' => array_values($child) );
}

/**/
function check_action_limit($action = null, $model = null, $record_id = null, $user_id = null, $ip = false){
    $time = time();
    $map=array(
      'name'   =>$action,
      'status' =>1,
    );
    $limit = M('ActionLimit')->where($map)->find();
    $ago = get_time_ago($limit['time_unit'], $limit['time_number'], $time);
    
    $item['create_time'] = array('egt', $ago);
    $log = M('ActionLog')->where($item)->order('create_time desc')->select();
    $return = array();
    if (count($log) >= $limit['frequency']) {
        $return=array(
           'state' => false,
           'info'  => $limit['message']
        );
    }else{
       $return['state'] = true;
    }
    
    return $return;
}

function get_time_ago($type = 'second', $some = 1, $time = null){
    $time = empty($time) ? time() : $time;
    switch ($type) {
        case 'second':
            $result = $time - $some;
            break;
        case 'minute':
            $result = $time - $some * 60;
            break;
        case 'hour':
            $result = $time - $some * 60 * 60;
            break;
        case 'day':
            $result = strtotime('-' . $some . ' day', $time);
            break;
        case 'week':
            $result = strtotime('-' . ($some * 7) . ' day', $time);
            break;
        case 'month':
            $result = strtotime('-' . $some . ' month', $time);
            break;
        case 'year':
            $result = strtotime('-' . $some . ' year', $time);
            break;
        default:
            $result = $time - $some;
    }
    return $result;
}

