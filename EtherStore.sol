// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


contract EtherStore {

    uint256 public withdrawalLimit = 1 ether;
    mapping(address => uint256) public lastWithdrawTime;
    mapping(address => uint256) public balances;
    

    // 增加发件人的余额
    function depositFunds() public payable {
        balances[msg.sender] += msg.value;
    }
    
    // 允许发件人指定要提取的以太币数量。
    // 只有当请求的金额小于1以太币并且在上周没有进行过提取时，发件人才能提取。
    function withdrawFunds (uint256 _weiToWithdraw) public {
        require(balances[msg.sender] >= _weiToWithdraw);
        // limit the withdrawal
        require(_weiToWithdraw <= withdrawalLimit);
        // limit the time allowed to withdraw
        require(now >= lastWithdrawTime[msg.sender] + 1 weeks);  // 漏洞出现在这里
        require(msg.sender.call.value(_weiToWithdraw)());
        balances[msg.sender] -= _weiToWithdraw;
        lastWithdrawTime[msg.sender] = now;
    }
 }


