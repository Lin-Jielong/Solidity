// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SolidityDS {
    // uint 适用于不允许负值的场景，如总供应量
    uint256 public totalSupply;

    // 使用 address 数据类型存储以太坊地址，适用于用户钱包或合约地址
    address public owner;

    // 当存储可变长度的文本数据时用 string；当处理不需要字符编码的原始字节数据时用 bytes
    string public name;
    bytes32 public hash;

    // 数组用于存储相同类型的元素列表，适用于需要存储多个值的情况，如数字列表或状态记录。
    uint256[] public numbers;

    // mapping 用于创建键值对映射，常用于存储关联数据，如用户的余额。它在数据查找方面更高效。
    mapping(address => uint256) public balances;

    // struct 允许创建自定义的数据结构，包含多个不同类型的字段。适用于存储复杂数据。
    struct Person {
        string name;
        uint256 age;
    }

    // enum 用于定义一组命名常量，限制变量的取值范围，适用于有限选项的情况。
    enum Status { Pending, Shipped, Delivered }

    // 应选择高效的数据结构以减少存储和执行成本。
    // 例如，mapping 通常比数组更节省 Gas 成本，特别是在大规模数据查找时。

    // 根据合约的数据访问频率和类型选择数据结构。
    // 频繁变动的数据可能更适合使用 mapping，而静态数据或顺序访问的数据可能更适合使用数组。

    // 需要评估合约的功能需求，选择可以支持这些功能的数据结构。
    // 复杂合约可能需要使用多种数据结构，如结合使用 struct 和 mapping。

    // 如果事先知道数组的最大长度，并且这个长度不会变化，
    // 使用固定长度数组可以减少 Gas 的消耗。如果数组长度会动态变化，应选择动态长度数组。
    uint256[10] public fixedArray;
    uint256[] public dynamicArray;

    // mapping 用于快速查找更新键值对，适合用于账户余额等场景；
    // 而 array 适用于元素顺序重要或需要迭代处理的场景。
    mapping(address => uint256) public userBalance;
    address[] public userList;

    // 可以使用 struct 来定义表的列，
    // 然后使用 mapping 或数组来存储 struct 实例，模拟行的概念。
    strcut Employee {
        uint256 id;
        string name;
        uint256 departmentID;
    }

    // enum 限制变量的取值范围，减少非法值的输入，提高代码的可维护性和错误预防。
    enum State { Active, Inactive, Suspended }

    // 当处理不需要字符处理功能的纯二进制数据时，bytes 更节省空间和 gas 成本，
    // 因为它不涉及 UTF-8 编码处理。
    bytes public rawData;

    // 使用 uint256 来存储时间戳是最常见的方法，
    // 因为它可以直接与 Ethereum 虚拟机的时间函数兼容。
    uint256 public lastUpdated;

    // 当数据项逻辑上属于同一实体或需要一起处理时，应将它们封装在一个 struct 内部，
    // 以增加可读性和可维护性。
    struct DataItem {
        uint256 orderId;
        uint256 quantity;
        uint256 price;
        address purchaser;
    }

    // mapping 本身不支持迭代。如果需要迭代，可以维护一个单独的数组来存储所有键，
    // 然后通过这些键来访问 mapping。
    mapping(uint256 => uint256) public accounts;
    address[] public accountList;

    // 可以使用 mapping 将资产类型（如 ERC20 代币地址）映射到另一个 mapping，
    // 后者将用户地址映射到余额。
    mapping(address => mapping(address => uint256)) public balances;

    // 定义状态转换的函数中应包含状态验证逻辑，确保合约状态按预定流程转换。
    enum State { Init, Running, Ended }
    State public state = State.Init;
    function nextState() public {
        if (state == State.Init) {
            state = State.Running;
        } else if (state == State.Running) {
            state = State.Ended;
        }
    }

}

