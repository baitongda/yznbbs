<?php
// +----------------------------------------------------------------------
// | YznBBS [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016 http://yznbbs.applinzi.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: 御宅男 <530765310@.qq.com> <http://yznbbs.applinzi.com>
// +----------------------------------------------------------------------
namespace Home\Controller;
use Home\Controller\AuthController;

class FavouriteController extends AuthController {
    public function add($id){
        $uid=is_login();
        $res=M('favourite')->where(array('uid' =>$uid))->find();
        if($res){
            /*如果有收藏*/
            $arr = explode(",", $res['content']);
            if(!in_array($id, $arr)){
			    array_unshift($arr, $id);
                $content = implode(',', $arr);
                M('favourite' ) ->where(array('uid' =>$uid)) ->save(array('content' =>$content));
                M('Member') ->where(array('id' =>$uid)) ->setInc('favourite');
                M('Topics') ->where(array('id' =>$id)) ->setInc('favourite');
			}
        }else{
            /*如果有收藏 就新建*/
            $data=array(
                'uid' =>$uid,
                'content' =>$id
            );
            M('favourite' ) ->add($data);
            M('Member') ->where(array('id' =>$uid)) ->setInc('favourite');
            M('Topics') ->where(array('id' =>$id)) ->setInc('favourite');
        
        }
        $this->redirect('Topics/index', array('id' => $id));
    }
    
     public function del($id){
        $uid=is_login();
        $res=M('favourite')->where(array('uid' =>$uid))->find();
        $arr = explode(",", $res['content']);
        if(in_array($id, $arr)){
            foreach($arr as $k=>$v){
                if($v == $id){
                    unset($arr[$k]);
                    break;
                }
            }
            $content = implode(',', $arr);
            if(M('favourite' ) ->where(array('uid' =>$uid)) ->save(array('content' =>$content))){
               M('Member') ->where(array('id' =>$uid)) ->setDec('favourite');
               M('Topics') ->where(array('id' =>$id)) ->setDec('favourite');
               $this->redirect('Topics/index', array('id' => $id));
            }

       }
       unset($arr);
    }
    
    
    
    
    
}