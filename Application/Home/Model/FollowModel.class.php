<?php
namespace Home\Model;
use Think\Model;

class FollowModel extends Model {
     /**
     * 查询是否关注
     * @param  integer   $id   你要关注id
     * @return boolean   null为未关注
     **/
    public function is_follow($id=0){
        $res = '';
        $uid = is_login();
        if($id == $uid) return 1;
        if($uid){
          $user_fol = $this ->where(array('uid' =>$uid))->find();
                if($user_fol && $user_fol['content']){
                    if(strpos(' ,'.$user_fol['content'].',', ','.$id.',') ){
                        $res = '1';
                    }
                }
        }
        return $res;
    }
}