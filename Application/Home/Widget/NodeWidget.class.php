<?php
namespace Home\Widget;
use Think\Controller;

class NodeWidget extends Controller {
    
    public function index($uid=0){
            $map['pid']=$uid;
            $where['pid'] = array('EQ',0);
        
            $N = M('Node');
            $cata_top['top']=$N ->where($where)->select();
            $topcata = $N ->where("id=$uid")->getField('pid');//判断父节点是否为0
            if($topcata!=0){
                $cat['pid']=$cur['id']=$topcata['pid'];
                $cata_bot['bot']=$N->where($cat)->select();
            }else{
                $cata_bot['bot']=$N->where($map)->select();
            }
        $cata = array_merge($cata_top, $cata_bot); //导航
                
        $this->assign('cata',$cata);
        $this->display('Public:node');
    }
}