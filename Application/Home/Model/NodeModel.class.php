<?php
namespace Home\Model;
use Think\Model;

class NodeModel extends Model {
    /**
	 * 获取节点数据
	 * @param  integer $id 文档ID
	 * @return array       详细数据
	 */
	public function detail(){
		/* 获取基础数据 */
        $map['pid']  = array('neq',0);
        $res=$this->where($map)->select();
        return $res;

	}
    
   

}