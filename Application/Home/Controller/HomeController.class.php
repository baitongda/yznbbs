<?php
// +----------------------------------------------------------------------
// | YznBBS [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016 http://yznbbs.applinzi.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: 御宅男 <530765310@.qq.com> <http://yznbbs.applinzi.com>
// +----------------------------------------------------------------------

namespace Home\Controller;
use Think\Controller;

/**
 * 前台公共控制器
 * 为防止多分组Controller名称冲突，公共Controller名称统一使用分组名称
 */
class HomeController extends Controller {

    /**
     * 前台控制器初始化
     */
    protected function _initialize(){
        $id=is_login();
        if($id){
           $user_info= M('Member')->field(array('password','content'),true)->find($id);
            // dump($user_info);
           $this->assign('user_info',$user_info);//列表
        }
        
        
    }
	/* 空操作，用于输出404页面 */
	public function _empty(){
		header("HTTP/1.0 404 Not Found");//使HTTP返回404状态码 
        $this->display("Public:404"); 
	}
   
}