<?php
namespace Home\Controller;


class AuthController extends HomeController {
    protected function __initialize(){
        
	}
    
    //判断是否是用户的帖子
    protected function is_user($uid){
        $suid = is_login();
        if($suid!='' && $suid!= 0 && $uid==$suid ){
			return TRUE;
		} else {
			return FALSE;
		}
	}
}