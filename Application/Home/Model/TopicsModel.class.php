<?php
namespace Home\Model;
use Think\Model;

class TopicsModel extends Model {
     /* 文章模型自动验证 */
	protected $_validate = array(
		/* 验证文章 */
        array('title','require','标题不得为空！',self::MUST_VALIDATE), //默认情况下用正则进行验证
        array('title', '6,80', '标题长度不能少于60字符，超过80字符', self::MUST_VALIDATE, 'length', self::MODEL_BOTH),
        array('content','require','内容不得为空！',self::MUST_VALIDATE), //默认情况下用正则进行验证       
	);
    
    /* 自动完成规则 */
    protected $_auto = array(
        array('uid', 'is_login', self::MODEL_BOTH, 'function'),
        array('add_time', NOW_TIME, self::MODEL_INSERT),
        array('reply_time', NOW_TIME, self::MODEL_INSERT),
        array('updata_time', NOW_TIME, self::MODEL_UPDATE),
        //array('content', 'resolve_markdown', self::MODEL_BOTH, 'function'),
        //array('title', 'htmlspecialchars', self::MODEL_BOTH, 'function'),
        //array('content', 'htmlspecialchars', self::MODEL_BOTH, 'function'),
    );
    
    /**
	 * 获取详情页数据
	 * @param  integer $id 文档ID
	 * @return array       详细数据
	 */
	public function detail($id){
		/* 获取基础数据 */
        $map['id'] = $where['topics_id']= $id;
        $Topics    = $this->where($map)->find();
        if(!$Topics){
            $this->error = '主题不存在或已删除！';
			return false;
        }
        $Reply['reply']     = M('Reply')->where($where)->select();
        return array_merge($Topics, $Reply);
	}
    
    public function _save($id,$data = null){
        /* 获取数据对象 */
        $data = $this->create($data);
        if(empty($data)){
            return false;
        }
        if($data['uid']==0){
            $this->error = '非法参数，用户签名不正确！';
            return false;
        }
        $status = $this->save(); //更新基础内容
        if(false === $status){
             $this->error = '编辑帖子出错！';
             return false;
        }
        return $status;
    }
    
    public function _add($data = null){
        /* 获取数据对象 */
        $data = $this->create($data,Model::MODEL_INSERT);
        if(empty($data)){
            return false;
        }
        if($data['uid']==0){
            $this->error = '非法参数，用户签名不正确！';
            return false;
        }
        if(empty($data['nid'])){
            $this->error = '板块不得为空！';
             return false;
        }
        $status = $this->add(); //添加基础内容
        if(!$status){
           $this->error = '发帖失败！';
           return false;
        }
        return $status;
    }
    
    
    /**
     * 新增或更新一个文档
     * @param array  $data 手动传入的数据
     * @return boolean fasle 失败 ， int  成功 返回完整的数据
     * @author huajie <banhuajie@163.com>
     */
    /*public function update($data = null){

        $data = $this->create($data);
        if(empty($data)){
            return false;
        }
        if($data['uid']==0){
                $this->error = '非法参数，用户签名不正确！';
                return false;
        }

        if(empty($data['id'])&$data['id']!=0){ //新增数据
            if(empty($data['nid'])){
              $this->error = '板块不得为空！';
               return false;
            }
            $status = $this->add(); //添加基础内容
            if(!$status){
                $this->error = '发帖失败！';
                return false;
            }
        } else { //更新数据
            
            $status = $this->save(); //更新基础内容
            if(false === $status){
                $this->error = '编辑帖子出错！';
                return false;
            }
        }
        
        return $status;
      }*/

}