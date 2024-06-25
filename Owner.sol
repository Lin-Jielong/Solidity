// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

contract Owner {
    // 结构体, 包含了 owner 的地址和名字
    struct Identity {
        address addr;
        string name;
    }

    // 枚举
    enum State {
        HasOwner, 
        NoOwner
    }

    // 事件是一种特殊的函数，可以用来记录合约执行过程中发生的重要事件。可以认为事件就是 log。可以通过已连接的客户端访问这些事件。
    // 事件
    event OwnerSet(address indexed oldOwnerAddr, address indexed newOwnerAddr);  // 当 owner 被设置成新 owner 时触发
    event OwnerRemoved(address indexed oldOwnerAddr);  // 当 owner 被删除时触发

    // 函数修饰器可以被用来修饰函数行为。
    // 函数修饰器
    modifier isOwner() {
        require(msg.sender == owner.addr, "Caller is not owner");  // 只允许合约的 owner 调用被它修饰的函数。
        _;
    }

    // 状态变量是用于存储合约状态的变量。会被永久保存在区块链上，并且可以在合约执行期间被读写。
    // 状态变量
    Identity private owner;  // 表示合约的 owner
    State private state;  // 表示合约的当前状态

    // 函数可以被其他合约调用。
    // 下面的都是函数

    // 合约构造函数，在合约部署时自动执行。
    // 构造函数
    constructor(string memory name) {  // 它将当前调用者设置为 owner。
        owner.addr = msg.sender;
        owner.name = name;
        state = State.HasOwner;
        emit OwnerSet(address(0), addr);
    }

    // 普通函数
    function changeOwner(address addr, string calldata name) public isOwner {  // 修改 owner
        owner.addr = msg.sender;
        owner.name = name;
        emit OwnerSet(owner.addr, addr);
    }

    // 普通函数
    function removeOwner() public isOwner {  // 删除 owner
        emit OwnerRemoved(owner.addr);
        delete owner;
        state = State.NoOwner;
    }

    // 普通函数
    function getOwner() external view returns (address, string memory) {  // 返回 owner 的地址和名称
        return (owner.addr, owner.name);
    }

    // 普通函数
    function getState() external view returns (State) {  // 返回合约状态
        return state;
    }
}