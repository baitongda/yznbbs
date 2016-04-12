<?php
namespace Home\Model;
use Think\Model;

class ReplyModel extends Model {
    /* 用户模型自动验证 */
	protected $_validate = array(
		/* 验证回复 */
        array('content','require','内容不得为空！',self::MUST_VALIDATE), //默认情况下用正则进行验证
        array('topics_id','require','回复参数错误！',self::MUST_VALIDATE), //默认情况下用正则进行验证
	);
    
     /* 回复模型自动完成 */
	protected $_auto = array(
        array('uid', 'is_login', self::MODEL_INSERT, 'function'),
        array('add_time', NOW_TIME, self::MODEL_INSERT),
        // array('content','aite',self::MUST_VALIDATE,'callback'), //@功能
        //array('content', 'htmlspecialchars', self::MODEL_BOTH, 'function'),
	);
    
    /**
     * @会员功能
     * @param  integer $uid 用户ID
     * @return boolean      ture-登录成功，false-登录失败
     */
    public function aite($content,$id,$tid){
        //@会员功能
         $pattern = "/@([^@^\\s^:]{1,})([\\s\\:\\,\\;]{0,1})/";
	     preg_match_all ( $pattern, $content, $matches );
		 $matches [1] = array_unique($matches [1]);
         if(empty($matches [1])){
             $res =M('Topics')->where(array('id'=>$tid))->getField('uid');
             if($res!==$id){//判断回帖人不是自己
                /* 更新回帖信息 */
                $data = array(
                   'uid'       => $res,
                   'type'      => 1,
                   'tid'       => $tid,
                   'nid'       => $id,
                   'add_time'  =>time(),
                );
                M('Notifications')->add($data);
                M('Member')->where(array('id'=>$res))->setInc('notifi',1); //未读提醒加1
             }
         }    
	     foreach ( $matches [1] as $u ) {
		   if ($u){
			$res =M('Member')->where(array('username'=>$u))->getField('id');
					if (!empty($res) & $res!==$id) {
						$search [] = '@'.$u;
                        $replace [] = '<a target="_blank" href="/User/index/id/'.$res.'" >@' . $u . '</a>';
                        /*@提醒
                        *type类型说明 1：回复 2：@ 3：收藏 4：关注 
                        */                     
                        $data = array(
                            'uid'       => $res,
                            'type'      => 2,
                            'tid'       => $tid,
                            'nid'       => $id,
                            'add_time'  =>time(),
                        );
                        M('Notifications')->add($data);
                        M('Member')->where(array('id'=>$res))->setInc('notifi',1); //未读提醒加1
                        
					}
			}        
		}
			return str_replace( @$search, @$replace, $content);
           
      }
    
    /**
     * 添加回复
     * @param  integer $uid 用户ID
     * @return boolean      ture-登录成功，false-登录失败
     */
    public function _add(){
        if(!($data = $this->create())){
            return false;
        }else{
            $data['content']=$this->aite($data['content'],$data['uid'],$data['topics_id']);//@功能
            if($data['uid']==0){
                $this->error = '非法参数，用户签名不正确！';
                return false;
            }
            $id = $this->add($data); //添加基础内容
            if(!$id){
                $this->error = '回复错误！';
                return false;
            }else{
                /*回复会更新帖子回复数.回复时间*/
                $where['id']=$data['topics_id'];
                $map['reply_count'] = array('exp','reply_count+1');// 用户回复数加1
                $map['reply_time']=time();
                $map['cid']=$data['uid'];
                M('Topics')->where($where)->setField($map); // 用户的积分加1
                
                
                //记录行为
                action_log('replay', 'reply',$id,$data['uid']);
                
            }
        }
        return $data;
    }
    
    
    
    
    
    
}