<?php
namespace Home\Widget;
use Think\Controller;

class CategoryWidget extends Controller {
	public function getCate() {
        $typeModel = M('type');
        $goodsModel = M('goods');

        $string = implode(',',$_GET);
        $map['id'] = array('in',$string);
        $typeData = $typeModel -> where($map) -> select();

        $string = 'parentId='.$_GET['ppid'];

        $childTypeData = $typeModel -> where($string) -> select();

        $string = '';
        foreach ($childTypeData as $k=>$v) {
            $string .= $v['id'].',';
        }
        $string = rtrim($string,',');
        $map1['parentId'] = array('in',$string);

        $cchildTypeData = $typeModel -> where($map1) -> select();
        foreach ($cchildTypeData as $k=>$v) {
            $map2['status'] = '0'; 
            $map2['typeId'] = $v['id'];
            $count = $goodsModel -> where($map2) -> count();
            $cchildTypeData[$k]['count'] = $count;
        }



        $this -> assign('typeName',$typeData[0]['typeName']);
        $this -> assign('childTypeData',$childTypeData);
        $this -> assign('cchildTypeData',$cchildTypeData);
		$this -> display("Category:getCate");
	}
}
