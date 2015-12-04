<?php
namespace Home\Widget;
use Think\Controller;

class MenuWidget extends Controller{
    
    public function menu(){
       
 //使用xy_type表
        $data = M('type');
        $list = $data -> field("id,typeName,parentId,path,concat(path,'-',id) as bpath") -> order('bpath') -> select();

        foreach($list as $key=>$value){
            $list[$key]['count'] = count(explode('-',$value['bpath']));
        }

        //将二级分类信息放到$list1数组中
        foreach($list as $key=>$value){
            if($list[$key]['count']==3)
            $list1[] = $value;
        }

        //将三级分类信息放到$list2数组中
        foreach($list as $key=>$value){
            if($list[$key]['count']==4)
            $list2[] = $value;
        }

        $this -> assign('list',$list);
        $this -> assign('list1',$list1);
        $this -> assign('list2',$list2);
        $this -> display('Menu:menu');
    }
        
}
