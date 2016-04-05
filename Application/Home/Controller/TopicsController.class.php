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
 * 话题控制器
 * 包括发布帖子，帖子编辑，帖子内容页
 */
class TopicsController extends AuthController {
    /*帖子主页*/
    public function index($id){
        $id = I('get.id','','intval');
        if(empty($id)){
            $this->error('参数不能为空！');
        }
        
        $Topics= D('Topics')->detail($id);
        
        if(!$Topics){
            $this->error( D('Topics')->getError());
        }
        if(!empty($Topics['tags'])){
            $Topics['tags']= explode(',',$Topics['tags']);
        }
        
        // 判断是不是已被收藏
        $Topics['in_favorites']=D('Favourite')->is_favorite($id);
        
        $this ->assign('topics',$Topics);//列表
        $this ->display(); 
    }
    
    /* 发布帖子 */
    public function add(){
        _login_state();
        $res['list']=D('Node')->detail('list');
        $res['hot']=D('Node')->detail('hot');
        
        if(IS_POST){
          $res = D('Topics')->_add();
          if(!$res){
             $this->error(D('Topics')->getError());
          }else{
             $this->success('发布成功',U('Topics/index?id='.$res));
          }
        }else{
          $this ->assign('node',$res); 
          $this ->display(); 
        }
    }
    

    /* 编辑帖子 */
    public function edit($id){
        _login_state();
        $id = I('get.id','','intval');
        if(empty($id)){
            $this->error('参数不能为空！');
        }

        $Topics = M('Topics') ->where(array('id' =>$id))->find();
        
        if($this ->is_user($Topics['uid'])){ 
           if(IS_POST){
               $res = D('Topics') ->_save($id);
               if(!$res){
                  $this ->error(D('Topics') ->getError());
               }else{
                  $this ->success('编辑成功',U('Topics/index?id='.$id));
               }
           }else{
               $this ->assign('topics',$Topics);
               $this ->display();    
           }
        }else{
           $this ->error("你无权编辑帖子");
        }  
    }
    
    /* 移动帖子 */
    public function move($id){
        _login_state();
        $id = I('get.id','','intval');
        if(empty($id)){
            $this->error('参数不能为空！');
        }

        $Topics = M('Topics') ->where(array('id' =>$id))->find();
        
        if($this ->is_user($Topics['uid'])){ 
           if(IS_POST){
               $res = D('Topics') ->_move($id);
               if(!$res){
                  $this ->error(D('Topics') ->getError());
               }else{
                  $this ->success('编辑成功',U('Topics/index?id='.$id));
               }
           }else{
               $res['list']=D('Node')->detail('list');
               
               $this ->assign('topics',$Topics);
               $this ->assign('node',$res); 
               $this ->display();    
           }
        }else{
           $this ->error("你无权编辑帖子");
        }  
    }
    

}