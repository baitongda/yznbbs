<?php
namespace Home\Model;
use Think\Model;

class TagsModel extends Model {
    /**
     * 根据关键词查询tag列表
     * @param  string $tag_title 关键词
     * @return [type] true-返回数据
     */
    public function get_tag_topics_list($tag_title=""){
        $tag['num'] = $this->where(array('title' =>$tag_title))->find();
        if($tag){
             $field='s.id,s.title,s.uid,s.cid,s.nid,s.reply_count,s.add_time,s.is_top';
             $tag['list']=$this->alias('t')
                      ->join('yzn_tags_relation r ON r.tag_id = t.id')
                      ->join('yzn_topics s ON  r.topics_id =s.id' )
                      ->where(array('t.id' => $tag['num']['id']))
                      ->field($field)
                      ->limit(10)->select();
            return $tag;
        } else {
            return false;
        }
    }
}