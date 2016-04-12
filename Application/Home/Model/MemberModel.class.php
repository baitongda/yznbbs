<?php
namespace Home\Model;
use Think\Model;

class MemberModel extends Model {
    /* 用户模型自动验证 */
	protected $_validate = array(
		/* 验证用户名 */
        array('username','require','用户名不得为空！',self::MUST_VALIDATE,self::MODEL_INSERT), //默认情况下用正则进行验证
        array('username','2,16','账号长度不得小于2位，大于10位！',self::MUST_VALIDATE,'length',self::MODEL_INSERT), // 判断用户名长度
        array('username','','帐号名称已经被注册！',self::MUST_VALIDATE,'unique'), // 在新增的时候验证name字段是否唯一
        array('username','checkuser','账号禁止注册或含有敏感字符',self::MUST_VALIDATE,'callback',self::MODEL_INSERT), //自定义函数验证账号敏感字符

        
        /* 验证邮箱 */
        array('email','require','邮箱不得为空！',self::EXISTS_VALIDATE), //默认情况下用正则进行验证
		array('email', 'email', '邮箱格式不正确', self::EXISTS_VALIDATE), //邮箱格式不正确
        array('email','2,30','邮箱长度不合法！',self::EXISTS_VALIDATE,'length',self::MODEL_BOTH), // 判断用户名长度
		array('email', '', '邮箱已经被注册', self::EXISTS_VALIDATE, 'unique',self::MODEL_BOTH), //邮箱被占用
        
        /* 验证密码 */
		array('password', '6,30', '密码长度不合法', self::MUST_VALIDATE, 'length',self::MODEL_BOTH), //密码长度不合法
	);
    
    /* 用户模型自动完成 */
	protected $_auto = array(
        array('password','sha1',3,'function') , // 对password字段在新增和编辑的时候使md5函数处理
        array('reg_time', NOW_TIME, self::MODEL_INSERT),
        array('reg_ip', 'get_client_ip', self::MODEL_INSERT, 'function', 1),
        array('uniqid', '_uniqid', self::MODEL_INSERT, 'callback', 1),
	);
    

    /**
     * 个人信息修改
     * @param  integer $uid 用户ID
     * @return boolean      ture-登录成功，false-登录失败
     */
    public function _info($data=null){
        //重置自动验证
        $this->_validate = array();
        $this->_auto = array();
        if(!($data = $this->create())){
            return false;
        }else{
            $data['id']=is_login();
            $result=$this->field('email,bio,tagline,id')->save($data);
            return $result;
           
        }
    }
    
    /**
     * 密码验证
     * @param  integer $uid 用户ID
     * @return boolean      ture-登录成功，false-登录失败
     */
    public function _password($data=null){
        //重置自动验证
        $this->_validate = array(
           /* 验证密码 */
           array('password_current','require','当前密码不得为空！',self::MUST_VALIDATE), //默认情况下用正则进行验证
		   array('password', '6,30', '密码长度不合法', self::MUST_VALIDATE, 'length',self::MODEL_BOTH), //密码长度不合法
           array('repassword','password','确认密码不正确',0,'confirm'), // 验证确认密码是否和密码一致
           array('password_current','check_password','当前密码不正确！',self::MUST_VALIDATE,'callback'), //自定义函数验证账号敏感字符
        );
        $this->_auto = array(
           array('password','sha1',3,'function') , // 对password字段在新增和编辑的时候使md5函数处理
        );
        if(!($data = $this->create())){
            return false;
        }else{
           $data['id']=is_login();
           $result =$this->field('password,id')->save($data);
           return $result;
       }
    }
    
    
    /**
     * 用户主页
     * @param  integer $uid 用户ID
     * @return boolean      ture-登录成功，false-登录失败
     */
    public function main($id){
        $user['info']=$this->where(array('id' => $id))->find();
        if(!$user['info']){
            $this->error = '用户不存在或者被删除！';
            return false;
        }
        $user['topics'] = M('Topics')->where(array('uid' => $id))->order('is_top desc,reply_time desc') ->limit(10)->select();
        $field='t.id as t_id,t.uid,r.id as r_id,t.title,r.content,r.add_time';
        $user['reply']  = M('Reply')->alias('r')->join('LEFT JOIN yzn_topics t ON t.id = r.topics_id')->field($field)->where(array('r.uid' => $id))->limit(10)->select();
        return $user;
    }
    
    
    /**
     * 登录指定用户
     * @param  integer $uid 用户ID
     * @return boolean      ture-登录成功，false-登录失败
     */
    public function login($user){
        //重置自动验证
        $this->_validate = array(
           array('username','require','用户名不得为空！',self::MUST_VALIDATE), //默认情况下用正则进行验证
           array('username','2,16','账号长度不得小于2位，大于10位！',self::MUST_VALIDATE,'length',self::MODEL_INSERT), // 判断用户名长度
           array('username','checkuser','账号含有敏感字符',self::MUST_VALIDATE,'callback',self::MODEL_INSERT), //自定义函数验证账号敏感字符   
            
           /* 验证密码 */
		   array('password', '6,30', '密码长度不合法', self::MUST_VALIDATE, 'length',self::MODEL_BOTH), //密码长度不合法
        );
        $this->_auto = array(
        );
        if(!($data = $this->create())){
            return false;
        }else{
            $map['username'] = $data['username'];
            $user = $this->where($map)->field('username,id,password,uniqid')->find();
            if(sha1($data['password'])!==$user['password']){
                $this->error = '账号或密码不正确！';
                return false;
            }
        }
        
        /* 记录登录SESSION和COOKIES */
        $auth = array(
            'id'           => $user['id'],
            'username'     => $user['username'],
            'uniqid'       => $user['uniqid'],
        );
        session('user_auth', $auth,60*60*12);
        session('user_auth_sign', data_auth_sign($auth),60*60*12);
        return $data;
    }
    
    /**
     * 注销当前用户
     * @return void
     */
    public function logout(){
        session('user_auth', null);
    }
   
    /**
     * @param  [type]
     * @return [type]
     */
    protected function check_password($str){
        $map['id']=is_login();
        $map['password']=sha1($str);
        $res = $this->where($map)->field('id')->find();
        if($res){
           return true;
        };
        return false;
    }
    
    /**
     * @param  [type]
     * @return [type]
     */
    protected function _uniqid($str){
        return sha1(uniqid(rand(),ture));
    }
    
     /**
     * @param  [type]
     * @return [type]
     */
    protected function checkuser($str){
        //保留字过滤
        $denyName=C('USER_NAME_BAOLIU');
        if($denyName!=''){
            $denyName=explode(',',$denyName);
            foreach($denyName as $val){
                if(!is_bool(strpos($str,$val))){
                    return false;
                }
            }
        }
        
        //敏感字符过滤
        $_char_pattern='/[\x4E00-\x9FFF\w]{1,11}/'; 
        if(!preg_match($_char_pattern,$str)){
        return false;
        }; 
        return true;
    }
    
}