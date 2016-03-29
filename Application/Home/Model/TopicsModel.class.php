<?php
namespace Home\Model;
use Think\Model;

class TopicsModel extends Model {
     /* 文章模型自动验证 */
	protected $_validate = array(
		/* 验证文章 */
        array('title','require','标题不得为空！',self::MUST_VALIDATE),
        array('title', '6,80', '标题长度不能少于60字符，超过80字符', self::MUST_VALIDATE, 'length', self::MODEL_BOTH),
        array('content','require','内容不得为空！',self::MUST_VALIDATE),      
	);
    
    /* 自动完成规则 */
    protected $_auto = array(
        array('uid', 'is_login', self::MODEL_BOTH, 'function'),
        array('add_time', NOW_TIME, self::MODEL_INSERT),
        array('reply_time', NOW_TIME, self::MODEL_INSERT),
        array('updata_time', NOW_TIME, self::MODEL_UPDATE),
    );
    
    /**
	 * 获取详情页数据
	 * @param  integer $id 文档ID
	 * @return array       详细数据
	 */
	public function detail($id){
		/* 获取基础数据 */
        $map['id'] = $where['topics_id']= $id;
        $Topics    = $this->where($map)->find();
        if(!$Topics){
            $this->error = '主题不存在或已删除！';
			return false;
        }
        $Reply['reply']     = M('Reply')->where($where)->select();
        return array_merge($Topics, $Reply);
	}
    
    public function _save(){
        /* 获取数据对象 */
        $data = $this->create($data);
        if(empty($data)){
            return false;
        }
        if($data['uid']==0){
            $this->error = '非法参数，用户签名不正确！';
            return false;
        }
        $status = $this->save($data); //更新基础内容
        if(false === $status){
             $this->error = '编辑帖子出错！';
             return false;
        }
        return $status;
    }
    
    public function _add(){
        /* 获取数据对象 */
        $data = $this->create($data,Model::MODEL_INSERT);
        if(empty($data)){
            return false;
        }
        if($data['uid']==0){
            $this->error = '非法参数，用户签名不正确！';
            return false;
        }
        if(empty($data['nid'])){
            $this->error = '板块不得为空！';
             return false;
        }
        $data['tags']=$this->get_tag_auto($data['title'],$data['content']);
        $status = $this->add($data); //添加基础内容
        if(!$status){
           $this->error = '发帖失败！';
           return false;
        }
        return $status;
    }
    
    //TAG分词自动获取
	protected function get_tag_auto($title,$content){
		$data = $this->sb_get_contents('http://keyword.discuz.com/related_kw.html?ics=utf-8&ocs=utf-8&title='.rawurlencode($title).'&content='.rawurlencode(mb_substr($content,0,500)));
		if($data) {
			$parser = xml_parser_create();
			xml_parser_set_option($parser, XML_OPTION_CASE_FOLDING, 0);
			xml_parser_set_option($parser, XML_OPTION_SKIP_WHITE, 1);
			xml_parse_into_struct($parser, $data, $values, $index);
			xml_parser_free($parser);
			$kws = array();
			foreach($values as $valuearray) {
				if($valuearray['tag'] == 'kw') {
					if(strlen($valuearray['value']) > 3){
						$kws[] = trim($valuearray['value']);
					}
				}elseif($valuearray['tag'] == 'ekw'){
					$kws[] = trim($valuearray['value']);
				}
			}
			return implode(',',$kws);
		}
		return false;
	}
    
    // 获取远程
	protected function sb_get_contents($url,$timeout=100,$referer=''){
		if(function_exists('curl_init')){
			$ch = curl_init();
			curl_setopt ($ch, CURLOPT_URL, $url);
			curl_setopt ($ch, CURLOPT_HEADER, 0);
			curl_setopt($ch, CURLOPT_TIMEOUT, $timeout);
			curl_setopt ($ch, CURLOPT_RETURNTRANSFER, 1); 
			curl_setopt ($ch, CURLOPT_CONNECTTIMEOUT,$timeout);
			if($referer){
				curl_setopt ($ch, CURLOPT_REFERER, $referer);
			}		
			$content = curl_exec($ch);
			curl_close($ch);
			if($content){
				return $content;
			}		
		}
		$ctx = stream_context_create(array('http'=>array('timeout'=>$timeout)));
		$content = @file_get_contents($url, 0, $ctx);
		if($content){
			return $content;
		}
		return false;
	}
    
    

}