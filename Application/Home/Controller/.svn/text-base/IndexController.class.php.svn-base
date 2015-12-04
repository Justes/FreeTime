<?php
	/**
	 *		author : exp
	 *		email  : root@evilexp.me
	 */
namespace Home\Controller;
use Think\Controller;
class IndexController extends Controller {
    /**
     *  分配首页版块
     */
    public function index(){

        $goodsTypeTable = M('type');

        //获取最上层的分类
        $goodsType = $goodsTypeTable ->where('parentId=0') -> field('id,typeName,status,parentId') -> select();

        $this -> assign('goodsType',$goodsType);
        $this -> display();       
    }

    /**
     *  首页版块随机分配商品
     */
    public function getGoods(){

        $goodsPicTable = M('goodspic');

        
        //通过商品最上层分类id随机获取4种商品
        $goodsTable = M('goods');
        $string = "%0-{$_GET['pid']}%";
        $map['typePath'] = array('LIKE',$string);
        $map['status'] = '0';

        $data = $goodsTable -> field('goodsId,goodsName,price') -> where($map)-> order('rand()') -> limit(4) -> select();

        //将商品图片放入商品信息中
        foreach ($data as $k=>$v) {
        $goodsPic = $goodsPicTable -> where("goodsId={$v['goodsId']}")-> select();
            $data[$k]['pic'] = $goodsPic[0]['goodsPic'];
        }
        $this -> ajaxReturn($data);
    }


    /**
     *  首页站长推荐商品
     */
    function recommendGoods(){
        $recommendTable = M('goods');
        $recommendPicTable = M('goodspic');
        //判断商品是否在售
        $_GET['status'] = '0';
        $recommendGoods = $recommendTable -> where($_GET) -> select();

        foreach($recommendGoods as $k=>$v){
            $recommendPic = $recommendPicTable -> where("goodsId={$v['goodsId']}") -> select();
            $recommendGoods[$k]['pic'] = $recommendPic[0]['goodsPic'];
        }

        $this -> ajaxReturn($recommendGoods); 
    }


    /**
     *  加入购物车
     */
    public function addToCart(){
        $goodsCartTable = M('cart');

        $flag = false;
        $_GET['buyerId'] = $_SESSION['user']['id'];
        $goodsCart = $goodsCartTable -> where($_GET) -> select();
        $_GET['amount'] = 1;
        if(!$goodsCart){
            if($goodsCartTable->create($_GET)){
                if($goodsCartTable->add()){
                    $flag = true;
                }
            }
        }
        $this -> ajaxReturn($flag);
    }

	public function getppt() {
		$ppt = M("ppt");
		$datas = $ppt -> select();
		$this -> ajaxReturn($datas);
	}


    /*
     *  Ajax实时消息提醒
     */
    public function ajaxInfo(){
        $consultModel = M('consult');
        $commentModel = M('comment');
        $userId = $_SESSION['user']['id'];
        if($commentData = $commentModel -> where("sellerId={$userId} and status=1") -> select()){
            foreach ($commentData as $k=>$v) {
                $data['commentId'] = $v['commentId'];
                $data['status'] = '0';
                if($commentModel -> create($data)){
                    $commentModel -> save();
                }
            }
            $this -> ajaxReturn($commentData);
        }else{
            $this -> ajaxReturn('0');
        }
    }


    /*
     *  ajax头部搜索
     */
    public function soso(){
        $typeModel = M('type');
        $goodsModel = M('goods');

        $string = '%'.$_GET['find'].'%';
        $map['goodsName'] = array('LIKE',$string);
        $map1['typeName'] = array('LIKE',$string);
        $typeData = $typeModel -> where($map1) -> select();
        $goodsData = $goodsModel -> where($map) -> select();
        if($typeData){
            foreach ($typeData as $k=>$v) {
                if(strlen($v['path']) == 1){
                    $d['name'] = '主分类:'.$typeData[$k]['typeName'];
                    $d['href'] = U("List/index?ppid={$v['id']}",'','');
                    $data[] = $d;
                }
                if(strlen($v['path']) == 3){
                    $d['name'] = '二级分类:'.$typeData[$k]['typeName'];
                    $d['href'] = U("List/index?ppid={$v['parentId']}&pid={$v['id']}",'','');
                    $data[] = $d;
                }
                if(strlen($v['path']) == 5){
                    $path = explode('-',$v['path']);
                    $d['name'] = '品牌:'.$typeData[$k]['typeName'];
                    $d['href'] = U("List/index?ppid={$path[1]}&pid={$path[2]}&id={$v['id']}",'','');
                    $data[] = $d;
                }
            }
        }
        if($goodsData){
            foreach ($goodsData as $k=>$v) {
                $d['name'] = '商品:'.$v['goodsName'];
                $d['href'] = U("goods/index?goodsId={$v['goodsId']}",'','');
                $data[] = $d;
            }
        }
        $this -> ajaxReturn($data);
    }
}
