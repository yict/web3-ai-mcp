// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract DemoContract {
    // empty contract
}

contract Selector{
    // event 返回msg.data
    event Log(bytes data);
    event SelectorEvent(bytes4);

    // Struct User
    struct User {
        uint256 uid;
        bytes name;
    }

    // Enum School
    enum School { SCHOOL1, SCHOOL2, SCHOOL3 }

    // 输入参数 to: 0x2c44b726ADF1963cA47Af88B284C06f30380fC78
    function mint(address /*to*/) external{
        emit Log(msg.data);
    } 

    // 输出selector
    // "mint(address)"： 0x6a627842
    function mintSelector() external pure returns(bytes4 mSelector){
        return bytes4(keccak256("mint(address)"));
    }

    // 无参数selector
    // 输入： 无
    // nonParamSelector() ： 0x03817936
    function nonParamSelector() external returns(bytes4 selectorWithNonParam){
        emit SelectorEvent(this.nonParamSelector.selector);
        return bytes4(keccak256("nonParamSelector()"));
    }

    // elementary（基础）类型参数selector
    // 输入：param1: 1，param2: 0
    // elementaryParamSelector(uint256,bool) : 0x3ec37834
    function elementaryParamSelector(uint256 param1, bool param2) external returns(bytes4 selectorWithElementaryParam){
        emit SelectorEvent(this.elementaryParamSelector.selector);
        return bytes4(keccak256("elementaryParamSelector(uint256,bool)"));
    }

    // fixed size（固定长度）类型参数selector
    // 输入： param1: [1,2,3]
    // fixedSizeParamSelector(uint256[3]) : 0xead6b8bd
    function fixedSizeParamSelector(uint256[3] memory param1) external returns(bytes4 selectorWithFixedSizeParam){
        emit SelectorEvent(this.fixedSizeParamSelector.selector);
        return bytes4(keccak256("fixedSizeParamSelector(uint256[3])"));
    }

    // non-fixed size（可变长度）类型参数selector
    // 输入： param1: [1,2,3]， param2: "abc"
    // nonFixedSizeParamSelector(uint256[],string) : 0xf0ca01de
    function nonFixedSizeParamSelector(uint256[] memory param1,string memory param2) external returns(bytes4 selectorWithNonFixedSizeParam){
        emit SelectorEvent(this.nonFixedSizeParamSelector.selector);
        return bytes4(keccak256("nonFixedSizeParamSelector(uint256[],string)"));
    }

    // mapping（映射）类型参数selector
    // 输入：demo: 0x9D7f74d0C41E726EC95884E0e97Fa6129e3b5E99， user: [1, "0xa0b1"], count: [1,2,3], mySchool: 1
    // mappingParamSelector(address,(uint256,bytes),uint256[],uint8) : 0xe355b0ce
    function mappingParamSelector(DemoContract demo, User memory user, uint256[] memory count, School mySchool) external returns(bytes4 selectorWithMappingParam){
        emit SelectorEvent(this.mappingParamSelector.selector);
        return bytes4(keccak256("mappingParamSelector(address,(uint256,bytes),uint256[],uint8)"));
    }

    // 使用selector来调用函数
    function callWithSignature() external{
        // 初始化uint256数组
        uint256[] memory param1 = new uint256[](3);
        param1[0] = 1;
        param1[1] = 2;
        param1[2] = 3;

        // 初始化struct
        User memory user;
        user.uid = 1;
        user.name = "0xa0b1";

        // 利用abi.encodeWithSelector将函数的selector和参数打包编码
        // 调用nonParamSelector函数
        (bool success0, bytes memory data0) = address(this).call(abi.encodeWithSelector(0x03817936));
        // 调用elementaryParamSelector函数
        (bool success1, bytes memory data1) = address(this).call(abi.encodeWithSelector(0x3ec37834, 1, 0));
        // 调用fixedSizeParamSelector函数
        (bool success2, bytes memory data2) = address(this).call(abi.encodeWithSelector(0xead6b8bd, [1,2,3]));
        // 调用nonFixedSizeParamSelector函数
        (bool success3, bytes memory data3) = address(this).call(abi.encodeWithSelector(0xf0ca01de, param1, "abc"));
        // 调用mappingParamSelector函数
        (bool success4, bytes memory data4) = address(this).call(abi.encodeWithSelector(0xe355b0ce, 0x9D7f74d0C41E726EC95884E0e97Fa6129e3b5E99, user, param1, 1));
        require(success0 && success1 && success2 && success3 && success4);
    }
}