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
 * 个人收藏关注控制器
 * 为防止多分组Controller名称冲突，公共Controller名称统一使用分组名称
 */
class MyController extends AuthController {
    public function topics(){
        $id=is_login();
        $res=M('favourite')->where(array('uid' =>$id))->find();
        $ids = explode(',', $res['content']);
        if($ids){
          $Topics = M("Topics") ->where(array('id' =>array('in',$ids))) ->order('reply_time desc') ->select();
          $this ->assign('topics',$Topics);//列表
        }
        $this ->display();
    }

}