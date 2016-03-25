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
 * 信息控制器
 * 包括主页显示文章
 */
class NotificationsController extends HomeController {
    public function index(){
        /*
        type类型说明 1：回复 2：@ 3：收藏 4：关注 
        */
        $where['id']=$map['uid']=is_login();
        $list=M('Notifications')->where($map)->limit(10)->order('add_time desc')->select();
        M('Member')->where($where)->field('notifi')->save(array('notifi'=>0));
        //dump($list);
        $this->assign('list',$list);//列表
        $this->display();
      
    }
}