<?php
namespace Home\Controller;
use Think\Controller;

class OrderController extends Controller{
    
    //生成订单，并清空购物车
    public function index(){

       $cartTable = M('cart');
       $orderTable = M('order');
       $goodsTable = M('goods');

       $map['buyerId'] =  $_SESSION['user']['id'];

       $cartData = $cartTable -> where($map) -> select();

       if($cartData){
           $goodsIdString = '';
           foreach ($cartData as $k=>$v) {
               $goodsIdString .= $v['goodsId'].',';
           }
           $goodsIdString = rtrim($goodsIdString,',');
           $map1['goodsId'] = array('in',$goodsIdString);
           $goodsData = $goodsTable -> where($map1) -> select();

           foreach ($goodsData as $k=>$v) {

               $data['userId'] = $_SESSION['user']['id'];
               $data['orderTime'] = time();
               $data['goodsName'] = $goodsData[$k]['goodsName'];
               $data['goodsId'] = $goodsData[$k]['goodsId'];
               $data['goodsPrice'] = $goodsData[$k]['price'];
               $data['amount'] = $cartData[$k]['amount'];
               $data['orderPrice'] = $cartData[$k]['amount'] * $goodsData[$k]['price'];

               if($orderDataInsert = $orderTable -> create($data)){
                   if($orderDataInsert = $orderTable -> add()){
                       $mapp['buyerId'] = $_SESSION['user']['id'];
                       $cartTable -> where($mapp)-> delete();       
                   } 
               }

           }
       }

       $mappp['userId'] = $_SESSION['user']['id'];
       $orderData = $orderTable -> where($mappp) -> select();

       $this -> assign('orderData',$orderData);
       $this -> assign('amount',0);
       $this -> display(); 
    }

    //获取购物车里商品数量,并保存到购物车表里
    public function getAmount(){

        $cartTable = M('cart');
        $arr = explode('|',$_GET['string']);
        foreach ($arr as $k=>$v) {
            $a = explode('+',$v);
            $goods[$k]['goodsId'] = $a[0];
            $goods[$k]['amount'] = $a[1];
        }

        $count = 0;
        foreach($goods as $k=>$v){
            $condition['goodsId'] = $v['goodsId'];
            $dat['amount'] = $v['amount'];
            if($cartTable -> where($condition) -> save($dat)){
                $count++;
            }
        }

        $this -> ajaxReturn($count);
    }


    //直接购买
    public function toOrder(){
        $orderModel = M('order');
        $goodsModel = M('goods');

        $map['userId'] = $_SESSION['user']['id'];
        $map['goodsId'] = $_GET['goodsId'];
        $map['orderTime'] = time();
        $goodsData = $goodsModel -> where("goodsId={$_GET['goodsId']}") -> select();
        $map['goodsName'] = $goodsData[0]['goodsName'];
        $map['goodsPrice'] = $goodsData[0]['price'];
        $map['orderPrice'] = $goodsData[0]['price'];
        $map['amount'] = 1;

        if($orderModel -> create($map)){
            if($orderModel -> add()){
               $this -> redirect("Order/index"); 
               $this -> ajaxReturn('1');
            }else{ $this -> ajaxReturn('0'); }
        }else{ $this -> ajaxReturn('0'); }
    }

    //订单删除
    public function orderDel(){

        $orderTable = M('order');
        $orderDel = $orderTable -> where($_GET) -> delete();
        if($orderDel){
            $this -> ajaxReturn(1);
        }else{
            $this -> ajaxReturn(0);
        }
    }

    //提交订单
    public function commit(){

        $orderTable = M('order');
        $orderIds = explode(',',$_GET['orderIds']);
        if(count($orderIds)>1){
            array_pop($orderIds);
            $_SESSION['orderIds'] = $orderIds;
            $orderIds = rtrim($_GET['orderIds'],',');   
            $map['orderId'] = array('in',$orderIds);
            $orderData = $orderTable -> where($map) -> select();
            $totalPrice = 0;
            foreach ($orderData as $k=>$v) {
                $totalPrice += $v['amount'] * $v['goodsPrice'];
            }
        }else{
            $_SESSION['orderId'] = $_GET['orderIds'];
            $map['orderId'] = $_GET['orderIds'];
            $orderData = $orderTable -> where($map) -> select();
            $totalPrice = $orderData[0]['amount'] * $orderData[0]['goodsPrice'];
        }
        $_SESSION['totalPrice'] = $totalPrice;
        $this -> assign("orderMoney",$totalPrice);
        $this -> assign("username",$_SESSION['user']['username']);
        $this -> display();
    }



    public function commitSuccess(){

        //验证用户支付密码是否正确
        if(md5($_POST['password'])==$_SESSION['user']['password']){
            $userTable = M('user');
            $orderTable = M('order');
            $string = 'id='.$_SESSION['user']['id'];
            $accountOpt = $userTable -> where($string) -> setDec('account',$_SESSION['totalPrice']);
            unset($_SESSION['totalMoney']);

            //如果支付成功，则更改订单状态，和商品状态
            if($accountOpt){
                if(isset($_SESSION['orderIds'])){
                    foreach ($_SESSION['orderIds'] as $k=>$v) {
                        $data['orderId'] = $v;
                        $data['status'] = '1';
                        if($orderTable -> create($data)){
                            if($orderTable -> save()){
                            }else{
                                $this -> error("支付失败!");
                                exit;
                            }
                        }else{
                            $this -> error("支付失败!");
                                exit;
                        }
                    }
                    unset($_SESSION['orderIds']);
                    $this -> redirect("order/index");
                    exit;
                }else if(isset($_SESSION['orderId'])){
                    $data['orderId'] = $_SESSION['orderId'];
                    $data['status'] = '1';
                    if($orderTable -> create($data)){
                        if($orderTable -> save()){
                            unset($_SESSION['orderId']);
                            $this -> redirect("order/index");
                            exit;
                        }else{
                            $this -> error("支付失败!");
                            exit;
                        }
                    }else{
                        $this -> error("支付失败!");
                        exit;
                    }
                } 
            }
        }else{
            $this -> error('用户密码出错！');
        } 
    }
}
