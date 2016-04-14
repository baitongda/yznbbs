<?php
// +----------------------------------------------------------------------
// | YznBBS [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016 http://yznbbs.applinzi.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: 御宅男 <530765310@.qq.com> <http://yznbbs.applinzi.com>
// +----------------------------------------------------------------------
namespace Home\Controller;
use Org\ThinkOauth;
/**
 * 用户控制器
 * 包括个人主页
 */
class UserController extends HomeController {
    /*个人主页*/
    public function index($id){
        $User = D('Member') ->main($id);
        if(!$User){
			$this ->error( D('Member') ->getError());
		}
        
        // 判断是不是已关注
        $User['in_follow']=D('Follow')->is_follow($id);
        $this ->assign('user',$User);
        $this ->display(); 
    }
}