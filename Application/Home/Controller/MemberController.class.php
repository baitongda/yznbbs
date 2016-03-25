<?php
// +----------------------------------------------------------------------
// | YznBBS [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016 http://yznbbs.applinzi.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: 御宅男 <530765310@.qq.com> <http://yznbbs.applinzi.com>
// +----------------------------------------------------------------------
namespace Home\Controller;

/**
 * 用户控制器
 * 包括用户中心，用户登录及注册
 */
class MemberController extends HomeController {
    /* 登录页面 */
    public function login($username = '', $password = ''){
        if(IS_POST){ //登录检测
            $res = D('Member')->login();
            if(!$res){
               $this ->error(D('Member') ->getError());
            }else{
               $this ->success('登录成功！',U('Index/index'));
            }          
        }

    }
    
      /* 注册页面 */
    public function register($username = '', $password = '', $email = '', $verify = ''){
        if(IS_POST){ //注册用户
          /* 检测验证码 */
		  if(!check_verify($verify)){
              $this ->error('验证码输入错误！');
		  }
          $Member = D('Member');
          if (!$data=$Member ->create()){
                $this ->error($Member ->getError());
          }else{
                $result =$Member ->add();
                if($result){
                    $this ->success('注册成功！',U('Signin/index'));
                }else{
                   $this->error($Member ->getError());
                }
          }
       }
    
    }
    
     /* 退出登录 */
	public function logout(){
       D('Member') ->logout();
       $this ->redirect('Index/index');
        
	}
    
     /* 验证码，用于登录和注册 */
	public function verify(){
		$verify = new \Think\Verify();
		$verify ->entry();
	}
}