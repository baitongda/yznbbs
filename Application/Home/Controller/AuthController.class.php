<?php
namespace Home\Controller;

//权限认证
class AuthController extends HomeController {
    protected function __initialize(){
        _login_state();//未登录不得进去
	}
}