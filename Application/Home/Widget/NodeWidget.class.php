<?php
namespace Home\Widget;
use Think\Controller;

class NodeWidget extends Controller {
    
    public function index($uid=0){
        /*    $map['pid']=$uid;
            $N = M('Node');
            $cata_top['top']=$N ->where(array('pid' =>array('EQ',0)))->field('css,description',true)->select();
            $topcata = $N ->where(array('id' =>$uid))->getField('pid');//判断父节点是否为0

            if($topcata!=0){
                $cat['pid']=$cur['id']=$topcata['pid'];
                $cata_bot['bot']=$N->where($cat)->select();
            }else{
                $cata_bot['bot']=$N->where($map)->select();
            }
        $cata = array_merge($cata_top, $cata_bot); //导航  
        $this->assign('cata',$cata);
        $this->display('Public:node');*/
        $node = M('Node')->field('css,description',true)->select();
        $list=getFormate($node);
        
        //dump($list);
        $this->assign('cata',$list);
        $this->display('Public:node');
    }
}