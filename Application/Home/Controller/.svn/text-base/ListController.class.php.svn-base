<?php
namespace Home\Controller;
use Think\Controller;

class ListController extends Controller{
    
    //分类列表页面
    public function index(){

        $goodsModel = M('goods');
        $goodsPicModel = M('goodspic');
        $typeModel = M('type');

        if(isset($_GET['id'])){
            $map3['typeId'] = $_GET['id'];
            $map3['status'] = '0';
            $goodsData = $goodsModel -> where($map3) -> select();
            $typeName = $typeModel -> where("id={$_GET['id']}") -> select();
        }
        if(count($_GET) == 2){
            $string = '%'.$_GET['ppid'].'-'.$_GET['pid'].'%';
            $map['typePath'] = array('LIKE',$string);
            $map['status'] = '0';
            $goodsData = $goodsModel -> where($map) -> select();
            $typeName = $typeModel -> where("id={$_GET['pid']}") -> select();
        }
        if(count($_GET) == 1){
            $string = '%0-'.$_GET['ppid'].'%';

            $map1['typePath'] = array('LIKE',$string);
            $map1['status'] = '0';
            $goodsData = $goodsModel -> where($map1) -> select();
            $typeName = $typeModel -> where("id={$_GET['ppid']}") -> select();
        }

        if($goodsData){
            foreach($goodsData as $k=>$v){
                $map2['goodsId'] = $v['goodsId'];
                $goodsPic = $goodsPicModel -> where($map2) -> select();
                $goodsData[$k]['pic'] = $goodsPic[0]['goodsPic'];
            }
        }else{
            $goodsData = "nogoods";
        }
        $this -> assign('goodsData',$goodsData);
        $this -> assign('typeName',$typeName[0]['typeName']);
        $this -> display(); 
    }

    //分类列表通过Ajax获取数据
    public function getContent(){
        $goodsModel = M('goods');
        $goodsPicModel = M('goodspic');
        if(isset($_GET['id'])){
            $map['typeId'] = $_GET['id'];
            $map['status'] = '0';
            $goodsData = $goodsModel -> where($map) -> select();
            foreach ($goodsData as $k=>$v) {
                $map1['goodsId'] = $v['goodsId'];
                $goodsPic = $goodsPicModel -> where($map1) -> select();
                $goodsData[$k]['pic'] = $goodsPic[0]['goodsPic'];

            }
            $arr = explode('-',$goodsData[0]['typePath']);
            $this -> ajaxReturn($goodsData);
        }
        if(isset($_GET['pid'])){
            $string = '%'.$_GET['pid'].'%';
            $map2['typePath'] = array('LIKE',$string); 
            $map2['status'] = '0';
            $goodsData = $goodsModel -> where($map2) -> select();

            foreach ($goodsData as $k=>$v) {
                $map3['goodsId'] = $v['goodsId'];
                $goodsPic = $goodsPicModel -> where($map3) -> select();
                $goodsData[$k]['pic'] = $goodsPic[0]['goodsPic'];
            }
            $this -> ajaxReturn($goodsData);
        }
    }
}
