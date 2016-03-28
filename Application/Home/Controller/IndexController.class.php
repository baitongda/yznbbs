<?php
// +----------------------------------------------------------------------
// | YznBBS [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016 http://yznbbs.applinzi.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: 御宅男 <530765310@.qq.com> <http://yznbbs.applinzi.com>
// +----------------------------------------------------------------------
namespace Home\Controller;

class IndexController extends HomeController {
    /* 主页面 */
    public function index(){
        $Topics = M("Topics") ->order('reply_time desc') ->select();
        $this ->assign('topics',$Topics);
        $this ->display();
    }
    
}