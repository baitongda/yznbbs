<?php
// +----------------------------------------------------------------------
// | YznBBS [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016 http://yznbbs.applinzi.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: 御宅男 <530765310@.qq.com> <http://yznbbs.applinzi.com>
// +----------------------------------------------------------------------

namespace Home\Controller;
/**
 * 标签控制器
 * 
 */
class TagsController extends HomeController {
    public function index($show){
        $tag_title = urldecode(strip_tags($show));
        $Topics=D('Tags') ->get_tag_topics_list($tag_title);
        $this ->assign('topics',$Topics);//列表
        $this ->assign('tag_title',$tag_title);//列表
        $this ->display();
    }

}