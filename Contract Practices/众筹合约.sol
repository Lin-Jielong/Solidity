// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// 众筹合约是一个募集资金的合约。类似水滴筹。早期的 ICO 就是类似业务。

// 需求分析
// 众筹合约分为两种角色：一是受益人，二是资助人
// 受益人: beneficiary => address         => address 类型
// 资助人: funders     => address:amount  => mapping 类型 或者 struct 类型

// 状态变量按照众筹的业务：
// 状态变量
//     1. 目标金额       fundingGoal
//     2. 当前募集数量   fundingAmount
//     3. 资助者列表     funders
//     4. 资助人数量     fundersKey

// 需要部署时传入的数据：
// 受益人
// 筹资目标数量


contract CrowdFunding {
    address public immutable beneficiary;   // 受益人
    uint256 public immutable fundingGoal;   // 筹资目标数量
    uint256 public fundingAmount;       // 当前的 金额
    mapping(address=>uint256) public funders;
    // 可迭代的映射
    mapping(address=>bool) private fundersInserted;
    address[] public fundersKey; // length
    // 不用自销毁方法，使用变量来控制
    bool public AVAILABLED = true; // 状态
    // 部署的时候，写入受益人+筹资目标数量
    constructor(address beneficiary_,uint256 goal_){
        beneficiary = beneficiary_;
        fundingGoal = goal_;
    }
    // 资助
    //      可用的时候才可以捐
    //      合约关闭之后，就不能在操作了
    function contribute() external payable{
        require(AVAILABLED,"CrowdFunding is closed");
        funders[msg.sender] += msg.value;
        fundingAmount += msg.value;
        // 1.检查
        if(!fundersInserted[msg.sender]){
            // 2.修改
            fundersInserted[msg.sender] = true;
            // 3.操作
            fundersKey.push(msg.sender);
        }
    }
    // 关闭
    function close() external returns(bool){
        // 1.检查
        if(fundingAmount<fundingGoal){
            return false;
        }
        uint256 amount = fundingAmount;
        // 2.修改
        fundingAmount = 0;
        AVAILABLED = false;
        // 3. 操作
        payable(beneficiary).transfer(amount);
        return true;
    }
    function fundersLenght() public view returns(uint256){
        return fundersKey.length;
    }
}