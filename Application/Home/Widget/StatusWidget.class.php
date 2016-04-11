<?php
namespace Home\Widget;
use Think\Controller;
/**
 * 社区状态widget控制器
 * 时效性不高 可以用缓存存储
 */
class StatusWidget extends Controller {
    public function index(){
        $count = S('forum_count');
        if (empty($count)) {
            $count['member'] = M('Member') ->count();
            $count['topics'] = M('Topics') ->count();
            $count['reply']  = M('Reply')  ->count();
            S('forum_count', $count, 60*5);
        }
        $this ->assign('count',$count);
        $this ->display('Public:rightbar_status');

    }
}