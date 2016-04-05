<?php
namespace Home\Widget;
use Think\Controller;

class NodeCssWidget extends Controller {
    
    public function index($node){
        $css = M("Node") ->where(array('id' =>$node))->field('css')->cache('node_css_s'.$node)->find();
        echo '<style type="text/css">'.$css['css'].'</style>';
    }
}