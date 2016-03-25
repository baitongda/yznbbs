<?php
namespace Home\Model;
use Think\Model;

class FavouriteModel extends Model {
     /**
     * 查询是否收藏
     * @param  integer $uid 用户ID
     * @return boolean      ture-登录成功，false-登录失败
     */
    public function is_favorite($id){
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