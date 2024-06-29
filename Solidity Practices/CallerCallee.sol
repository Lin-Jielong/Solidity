// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.19;

contract Callee {
    event FunctionCalled(string);

    function foo() external payable {
        emit FunctionCalled("this is foo");
    }

    // 你可以注释掉 receive 函数来模拟它没有被定义
    // receive() external payable {
    //     emit FunctionCalled("this is receive");
    // }

    // 你可以注释掉 fallback 函数来模拟它没有被定义
    // fallback() external payable {
    //     emit FunctionCalled("this is fallback");
    // }
}

// Caller 合约
contract Caller {
    address payable callee;

    // 注意：记得在部署的时候给 Caller 合约转账一些 Wei，比如100
    // 因为在调用下面的函数时需要用到一些 Wei
    constructor() payable {
        callee = payable(address(new Callee()));
    }

    // 触发 receive 函数
    function transferReceive() external {
        callee.transfer(1);
    }

    // 触发 receive 函数
    function sendReceive() external {
        bool success = callee.send(1);
        require(success, "send failed");
    }

    // 触发 receive 函数
    function callReceive() external {
        (bool success, ) = callee.call{value: 1}("");
        require(success, "call failed");
    }

    // 触发 foo 函数
    function callFoo() external {
        (bool success, ) = callee.call{value: 1}(
            abi.encodeWithSignature("foo()")
        );
        require(success, "call failed");
    }

    // 触发 fallback 函数，因为 funcNotExist() 在 Callee 合约中不存在
    function callFallback() external {
        (bool success, ) = callee.call{value: 1}("");
        require(success, "call failed");
    }


}