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
         $map = array('id' => $id);
         /*获取当前节点的父节点*/
         $topcata = array();
         $topcata = M('Node') ->where($map) ->field('id,pid,title,description') ->find();
        // dump($topcata);
        /*判断是否父节点*/
        if($topcata['pid']==="0"){
            $map = array('pid' => $topcata['id']);
            $childcata=M('Node') ->where($map) ->getField('id',true);//获取父节点下面的子节点

            $map = array('nid' => array('in',array_values($childcata)));
            $Topics =M("Topics") ->where($map) ->order('is_top desc,reply_time desc') ->select();
            $this ->assign('current',$topcata['id']);//列表
            $this ->assign('topics',$Topics);//列表
            $this ->display('Index:index');
        }else{
            $map = array('nid' => $id);
            $Topics =M("Topics") ->where($map) ->order('is_top desc,reply_time desc') ->select();
            $this ->assign('current',$topcata['id']);//列表
            $this ->assign('topics',$Topics);//列表
            $this ->assign('topcata',$topcata);//列表
            $this ->display('Node:index');
        }
        
       
      
    }
}