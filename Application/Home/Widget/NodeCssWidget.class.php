<?php
namespace Home\Widget;
use Think\Controller;
/**
 * 节点css的widget控制器
 * 时效性不高 可以用缓存存储
 */
class NodeCssWidget extends Controller {
    
    public function index($node){
        $css = M("Node") ->where(array('id' =>$node))->field('css')->cache('node_css_s'.$node)->find();
        echo '<style type="text/css">'.$css['css'].'</style>';
    }
}