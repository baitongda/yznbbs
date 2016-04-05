<?php
namespace Home\Model;
use Think\Model;

class NodeModel extends Model {
    /**
	 * 获取节点数据
	 * @param  integer $id 文档ID
	 * @return array       详细数据
	 */
	public function detail($type='list'){
		/* 获取基础数据 */   
        $map['pid']  = array('neq',0);
        switch ($type){
           case "list":
           $res=$this->where($map)->select();
           return $res; 
           break;
            
           case "hot":
           $res=$this->where($map)->cache('cache_hot_node',600)->limit(10)->select();
           return $res;
            break;
        }
   }
   

}