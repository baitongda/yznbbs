<?php
namespace Home\Widget;
use Think\Controller;
/**
 * 热门帖子widget控制器（在主页右边）
 * 时效性不高 可以用缓存存储
 */
class HotTopicsWidget extends Controller {
    
    public function index(){
        $Topics = M("Topics") ->order('reply_count desc')->cache('hot_reply') ->limit(5)->select();
        $this ->assign('list',$Topics);
        $this->display('Public:rightbar_hot_topics');
    }
}