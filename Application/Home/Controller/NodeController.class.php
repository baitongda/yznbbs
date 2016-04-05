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
 * 板块文章控制器
 * 包括主页显示文章
 */
class NodeController extends HomeController {
    public function index($id){
         $id = $id ? $id : I('get.id', 0);
         /*获取当前节点的父节点*/
         $topcata = M('Node') ->where(array('id' => $id)) ->field('id,pid,title,description') ->find();
         $Topics =M("Topics") ->where(array('nid' =>$id)) ->order('is_top desc,reply_time desc') ->select();
            
         $this ->assign('topics',$Topics);
         $this ->assign('topcata',$topcata);
         $this ->display(); 
    }
}