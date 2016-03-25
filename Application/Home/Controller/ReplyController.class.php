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
 * 回复控制器
 * 包括回复内容显示
 */
class ReplyController extends HomeController {
    /*回复添加*/
    public function add(){
       if(IS_POST){
          $res = D('Reply')->_add();
          if(!$res){
            $this->error(D('Reply')->getError());
          }else{
            $this->success();
          }
       }
       
    }
}