<?php
namespace Home\Widget;
use Think\Controller;

class HotTopicsWidget extends Controller {
    
    public function index(){
        $Topics = M("Topics") ->order('reply_count desc')->cache('hot_reply') ->limit(5)->select();
        $this ->assign('list',$Topics);
        $this->display('Public:rightbar_hot_topics');
    }
}