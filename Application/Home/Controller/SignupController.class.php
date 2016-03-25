<?php
namespace Home\Controller;
/**
 * 注册控制器
 * 包括
 */
class SignupController extends HomeController {
    public function index(){
        _log_reg_state();
        $this ->display();
      
    }
}