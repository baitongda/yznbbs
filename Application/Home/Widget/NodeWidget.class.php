<?php
namespace Home\Widget;
use Think\Controller;
/**
 * 节点widget控制器
 * 时效性不高 可以用缓存存储
 */
class NodeWidget extends Controller {
    public function index(){
        $node = M('Node')->field('css,description',true)->cache('home_node')->select();
        $list=getFormate($node);
        $this->assign('cata',$list);
        $this->display('Public:node');
    }
}