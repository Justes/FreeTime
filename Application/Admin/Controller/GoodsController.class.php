<?php
namespace Admin\Controller;


class GoodsController extends PublicController{
	//查看商品	
    public function GoodsOnsale(){
        $goods = M("goods"); 
        $data = $goods ->order('typePath')-> select();
        foreach($data as $k => $v){
			//拆分字符串
           $path = explode("-",$v['typePath']); 
		   //dump($path);
           $type = M("type");    
           $map['id'] = $path[1];
           $map1['id'] = $path[2];
           $data1 = $type -> field('typeName') ->where($map) -> select();
           $data2 = $type -> field('typeName') ->where($map1) -> select();
           $goodsType[0] = $data1[0]['typeName'];
           $goodsType[1] = $data2[0]['typeName'];
		   //拆分字符串
           $data[$k]['goodsType'] = implode('-',$goodsType);
			
           $order = M("order");
           $map2['goodsId'] = $v['goodsId'];
           $data3 = $order -> field('amount') ->where($map2) -> select(); 
			//商品库存
           if($data3){
                $data[$k]['goodsLeft'] = $v['number'] - $data3[0]['amount'];
           }else{
                $data[$k]['goodsLeft'] = $v['number'];  
           }

           $goodsPic = M("goodspic");
           $map3['goodsId'] = $v['goodsId'];
           $data4 = $goodsPic -> field('goodsPic') -> where($map3) -> select();
           //只取商品图片的第一张
		   //dump($data4);
		   $data[$k]['goodsPic'] = $data4[0]['goodsPic'];

           $user = M("user");
           $map4['id'] = $v['sellerId'];
           $data5 = $user -> field('username') -> where($map4) -> select();
           $data[$k]['username'] = $data5[0]['username'];
		}
        $this -> assign("data",$data);
       
        $this -> display();
		
	}
	//更改商品状态
    public function GoodsOnSaleStatus(){

        if($_GET['status']){
            $_GET['status'] = '0'; 
        }else{
            $_GET['status'] = '1'; 
        }  
        if($_GET){
            
        $goods = M("goods"); 
        $data = $goods -> create($_GET);   

           if($data){
                
                $rows =  $goods -> save($data); 
                var_dump($rows);
                if($rows){
                    $this -> redirect("Goods/GoodsOnSale"); 
                }else{
                    $this ->error("更改失败",U("Goods/GoodsOnSale")); 
                }
            }
        
        } 
    
    }
	//商品加推荐
     public function GoodsOnSaleRecommend(){
        var_dump($_GET);
        if($_GET['recommend']){

            $_GET['recommend'] = '0'; 
        }else{
            $_GET['recommend'] = '1'; 
        }  
        if($_GET){
            
        $goods = M("goods"); 
        $data = $goods -> create($_GET);   
        var_dump($data);

           if($data){
                
                $rows =  $goods -> save($data); 
                var_dump($rows);
                if($rows){
                    $this -> redirect("Goods/GoodsOnSale"); 
                }else{
                    //$this ->error("更改失败",U("Goods/GoodsOnSale")); 
                }
            }
        
        } 

     } 
	 
	public function GoodsOnSaleDel(){
		 
		 
		 
		 
	}

    public function GoodsSold(){
       $this -> display();
    }
	
    
    /*
     *  订单管理
     */
    public function ManageOrderList(){
        $orderModel = M('order');
        $userModel = M('user');
        $goodsModel = M('goods');
        $orderData = $orderModel -> order('orderId desc') -> select();
        foreach ($orderData as $k=>$v) {
            $userBuy = $userModel -> where("id={$v['userId']}") -> select();
            $orderData[$k]['buyer'] = $userBuy[0]['username'];
            $goodsData = $goodsModel -> where("goodsId={$v['goodsId']}") -> select();
            $orderData[$k]['seller'] = $goodsData[0]['username'];
        }
        $this -> assign('orderData',$orderData);
        $this -> display();
    }


    /*
     *  删除订单
     */
    public function orderDel(){
        $orderModel = M('order');
        $orderId = $_GET['orderId'];
        if($orderModel -> delete($orderId)){
            $this -> redirect("Goods/ManageOrderList");
        }else{
            $this -> error("删除失败！");
        }
    }
	
}

