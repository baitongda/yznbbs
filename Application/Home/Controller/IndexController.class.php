<?php
namespace Home\Controller;

class IndexController extends HomeController {
    public function index(){
        $Topics=M("Topics")->order('reply_time desc')->select();
        $this->assign('topics',$Topics);//列表
        $this->display();
    }
    
}