<?php
namespace Home\Controller;
/**
 * 登录控制器
 * 包括
 */
class SigninController extends HomeController {
    public function index(){
        _log_reg_state();
        $this ->display();
      
    }
}