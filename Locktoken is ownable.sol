// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.7;

import "github.com/Dechachron/IBEP20-Interface/blob/main/IBEP20.sol";
import "github.com/Dechachron/Abstract/blob/main/abstract.sol";
import "github.com/Dechachron/Ownable/blob/main/Ownable.sol";
import "github.com/Dechachron/Library-SafeMath/blob/main/Library%20safemath.sol";
import "github.com/Dechachron/context-IBEP20-IBEP20Metadata/blob/main/context-ibep20-ibep20metadata.sol";
import "github.com/Dechachron/Dividend/blob/main/Dividend.sol";
import "github.com/Dechachron/IterableMapping/blob/main/IterableMapping.sol";
import "github.com/Dechachron/uniswap-router-Interface/blob/main/Uniswap%20liquidity%20router.sol";

contract LockToken is Ownable {
    bool public isOpen = false;
    mapping(address => bool) private _whiteList;
    modifier open(address from, address to) {
        require(isOpen || _whiteList[from] || _whiteList[to], "Not Open");
        _;
    }

    constructor() {
        _whiteList[msg.sender] = true;
        _whiteList[address(this)] = true;
    }

    function includeToWhiteList(address[] memory _users) external onlyOwner {
        for(uint8 i = 0; i < _users.length; i++) {
            _whiteList[_users[i]] = true;
        }
    }
}
