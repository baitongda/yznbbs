<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2013 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi.cn@gmail.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------
namespace Common\LibTag;
use Think\Template\TagLib;
/**
 * ThinkCMS 系文档模型标签库
 */
class Article extends TagLib{
     /***定义标签列表
	 * @var array
	 */
	protected $tags   =  array(
        //列表分页
		'page'     => array('attr' => 'listrow', 'close' => 0), 
        
        //文章列表
		'artlist'	=> array(
			'attr'	=> 'limit,where','type','order',
			'close'	=> 1,
		),
        
	);
    
    /* 列表数据分页 */
	public function _page($tag){
		$listrow = $tag['listrow'];
		$parse   = '<?php ';
		$parse  .= '$__PAGE__ = new \Think\Page(get_list_count(), ' . $listrow . ');';
		$parse  .= 'echo $__PAGE__->show();';
		$parse  .= ' ?>';
		return $parse;
	}
    
    /*获取标题*/
    public function _artlist($tag,$content) {
        $type    = $tag['type']; //要查询的数据表
        $where   = $tag['where']; //查询条件
        $order   = empty($tag['order'])? 'id DESC' : $tag['order'];
        $limit   = empty($tag['limit'])? '10' : $tag['limit'];
        
        $parse   = '<?php ';
        $parse  .= '$result = M("' . $type . '")->where("' . $where . '")->order("' . $order . '")->limit(' . $limit . ')->select();';
        $parse  .= 'foreach ($result as $vo):';
        $parse  .= '?>';
        $parse  .= $content;
        $parse  .= '<?php endforeach ?>';
        return $parse;    
    }
    

   
    
}