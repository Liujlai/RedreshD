//
//  BViewController.swift
//  RedreshD
//
//  Created by idea on 2018/8/22.
//  Copyright © 2018年 idea. All rights reserved.
//

import UIKit

class BViewController: UIViewController {
    
    var animator :UIDynamicAnimator!
    lazy var v: UIView = {
        return View.bg("#996699").pin(80,80).pin(.xy(80,80))
    }()
    lazy var vv: UIView = {
        return View.bg("#cc3366").pin(80,80).pin(.xy(240,240))
    }()
    lazy var vvv: UIView = {
        return View.bg("#0099cc").pin(80,80).pin(.xy(240,400)).radius(-1)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        animator =  UIDynamicAnimator(referenceView: self.view)
        view.bg("white").addSubviews(v,vv,vvv)
//        #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
    }
    
    /// 点击屏幕
    ///
    /// - Parameters:
    ///   - touches:
    ///   - event:
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        animator .removeAllBehaviors();
        addGravityBahaviorInView(v)
        addCollisionBehaviorInView(v, withBoundary: UIBezierPath(rect: view.bounds))

        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touche in touches {
            let touch = touche.location(in: self.view)
            addCaptureInView(vv, withPoint: touch)
        }
    }
    
    /// 重力行为
    ///
    /// - Parameter a: 要添加重力行为的视图
    func addGravityBahaviorInView(_ a:UIView){
        //        创建重力行为
        let gravity  = UIGravityBehavior()
        gravity.addItem(a);
        //        设置重力角度（默认角度.pi / 2）
        gravity.angle = 0
        //        设置重力大小 --->重力的加速度
        gravity.magnitude = 10.0
        /**
         设置重力向量值 --->设置重力的方向（是一个二维向量）
         重力方向说明: ---->
             给定坐标平面内的一个点。然后用原点（0，0）来连接它，就构成了一个向量。
             IOS中以左上角为坐标原点，向右x增加，向下Y越大。
         */
        gravity.gravityDirection = CGVector(dx: 1, dy: 1.0)
        //        将重力行为添加到仿真器中
        animator.addBehavior(gravity)
    }
    
    /// 碰撞行为
    ///
    /// - Parameters:
    ///   - a: 要添加碰撞行为的视图
    ///   - bezierpath: 设置碰撞边界
    func addCollisionBehaviorInView(_ a:UIView, withBoundary bezierpath:UIBezierPath){
        //        创建碰撞行为
        let collision = UICollisionBehavior(items: [a,vv,vvv]);
        //        设置边界
        collision.addBoundary(withIdentifier: "bezierpath" as NSCopying, for: bezierpath)
        //        将碰撞行为添加到仿真器中
        
        //让参照视图的边框成为碰撞检测的边界
        collision.translatesReferenceBoundsIntoBoundary=true;
        animator.addBehavior(collision)
    }
    
    /// 捕捉行为
    ///
    /// - Parameters:
    ///   - a: 要添加碰撞捕捉的视图
    ///   - point: 捕捉点
    func addCaptureInView(_ a:UIView ,withPoint point:CGPoint){
        //        创建捕捉行为
        let snap = UISnapBehavior(item: a, snapTo: point)
        //阻力系数（0~1）
        snap.damping = 1
        animator.addBehavior(snap)
    }
    
}
