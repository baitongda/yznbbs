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
class TopicsController extends HomeController {
    /*帖子主页*/
    public function index($id){
        $Topics= D('Topics')->detail($id);
        if(!$Topics){
			$this->error( D('Topics')->getError());
		}
        
        // 判断是不是已被收藏
	    $Topics['in_favorites']=D('Favourite')->is_favorite($id);
        
        $this ->assign('topics',$Topics);//列表
        $this ->display(); 
    }
    
    /* 发布帖子 */
    public function add(){
        _login_state();
        $res=D('Node')->detail();
        if(IS_POST){
          $res = D('Topics')->update();
          if(!$res){
            $this->error(D('Topics')->getError());
          }else{
            $this->success('发布成功',U('Topics/index?id='.$res));
          }
        }else{
          $this ->assign('node',$res);//列表   
          $this ->display(); 
        }
    }
    
    /* 编辑帖子 */
    public function edit($id){
        _login_state();
        $map['id'] = $id;
        $Topics = M('Topics') ->where($map)->find();
        if($Topics['uid']!==is_login()){
            $this ->error("你无权编辑其他用户帖子");
        }
        if(IS_POST){
          $res = D('Topics') ->update();
          if(!$res){
            $this ->error(D('Topics') ->getError());
          }else{
            $this ->success('编辑成功',U('Topics/index?id='.$id));
          }
        }else{
          $this ->assign('topics',$Topics);//列表
          $this ->display();   
        }
    }

}