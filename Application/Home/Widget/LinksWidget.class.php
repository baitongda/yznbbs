<?php
namespace Home\Widget;
use Think\Controller;
/**
 * 友情链接
 * 时效性不高 可以用缓存存储
 */
class LinksWidget extends Controller {
    public function index(){
		$links = M("Links") ->where(array('status'=>1)) ->cache('links') ->select();
		$this ->assign('list',$links);
		$this ->display('Public:rightbar_links');
    }
}