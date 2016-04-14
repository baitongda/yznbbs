<?php
namespace Home\Model;
use Think\Model;

class FavouriteModel extends Model {
    /**
     * 查询是否收藏
     * @param  integer   $id   你要收藏帖子id
     * @return boolean   null为未收藏
     **/
    public function is_favorite($id=0){
        $uid=is_login();
        $res='';
        if($uid){
          $user_fav = $this ->where(array('uid' =>$uid))->find();
                if($user_fav && $user_fav['content']){
                    if(strpos(' ,'.$user_fav['content'].',', ','.$id.',') ){
                        $res = '1';
                    }
                }
        }
        return $res;
    }
}