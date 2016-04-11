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
 * 排行榜控制器
 * 包括主页显示文章
 */
class TopController extends HomeController {
    public function rich(){
       $list = M('Member') ->field('uniqid,password',true) ->order('currency desc')->cache('top_rich',60*60*12)->limit(10)->select();
       if(empty(S('top_rich_time'))){
           S('top_rich_time',date("y-m-d h:i:s",time()),60*60*12);
       }
       $now_time=S('top_rich_time');
       
       $this ->assign('list',$list);
       $this ->assign('now_time',$now_time);
       $this ->display();  
    }
    
     public function score(){
       $list = M('Member') ->field('uniqid,password',true) ->order('score desc')->cache('top_score',60*60)->limit(10)->select();
       if(empty(S('top_rich_time'))){
           S('top_rich_time',date("y-m-d h:i:s",time()),60*60);
       }
       $now_time=S('top_rich_time');
         
       $this ->assign('list',$list);
       $this ->assign('now_time',$now_time);
       $this ->display();  
    }
}