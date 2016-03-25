<?php
return array(
	//'配置项'=>'配置值'
    'DEFAULT_THEME'    =>    'default',//前台模板
    
    /* 用户相关设置 */
    'USER_MAX_CACHE'     => 1000, //最大缓存用户数
    
    //加载自定义标签
	'TAGLIB_PRE_LOAD'=>'Common\\LibTag\\Article',//预加载的tag
	'TAGLIB_BUILD_IN' => 'cx', //内置标签
);